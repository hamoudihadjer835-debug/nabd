import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/utils/mask_utils.dart';
import '../../core/widgets/auth_top_bar.dart';
import '../../core/widgets/icon_badge.dart';

const int _codeLength = 6; // عدد خانات الرمز
const int _resendSeconds = 45; // مدة الانتظار قبل إعادة الإرسال

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key, required this.identifier});

  /// البريد أو الهاتف لي بعثنا له الرمز.
  final String identifier;

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final _codeController = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _timer;
  int _secondsLeft = _resendSeconds;
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    _codeController.addListener(_onChanged);
    _focusNode.addListener(_onChanged);
    _startTimer();
    // نفتحو الكيبورد مباشرة بعد ما تظهر الشاشة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _codeController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged() {
    setState(() {
      if (_codeController.text.length == _codeLength) _showError = false;
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = _resendSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() => _secondsLeft--);
      if (_secondsLeft <= 0) timer.cancel();
    });
  }

  void _resend() {
    _codeController.clear();
    _startTimer();
    setState(() => _showError = false);
    // مؤقت: الإرسال الحقيقي مع الـ Backend (المرحلة 6)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code sent again ✓ — real sending comes with the backend (Phase 6)'),
      ),
    );
  }

    void _confirm() {
    FocusScope.of(context).unfocus();
    if (_codeController.text.length < _codeLength) {
      setState(() => _showError = true);
      return;
    }
    // مؤقت: التحقق الحقيقي من الرمز مع الـ Backend (المرحلة 6)
    context.push(AppRoutes.resetPassword);
  }

  void _changeNumber() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.forgotPassword);
    }
  }

  String get _timeText =>
      '00:${_secondsLeft.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AuthTopBar(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.xl),
                    const IconBadge(icon: Icons.verified_user_outlined),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n.verifyTitle,
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.verifySubtitle,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 4),
                    // البريد/الهاتف المخفي: دايما من اليسار لليمين
                    Text(
                      maskIdentifier(widget.identifier),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    _OtpBoxes(
                      controller: _codeController,
                      focusNode: _focusNode,
                    ),
                    if (_showError)
                      Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.sm),
                        child: Text(
                          l10n.codeIncomplete,
                          style: textTheme.bodyMedium
                              ?.copyWith(color: AppColors.error),
                        ),
                      ),
                    const SizedBox(height: AppSpacing.lg),

                    // العد التنازلي، وبعدو زر إعادة الإرسال
                    if (_secondsLeft > 0)
                      Text(
                        '${l10n.resendIn} $_timeText',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium
                            ?.copyWith(color: AppColors.textMuted),
                      )
                    else
                      TextButton(
                        onPressed: _resend,
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          textStyle: textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        child: Text(l10n.resendCode),
                      ),
                    const SizedBox(height: AppSpacing.lg),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _confirm,
                        child: Text(l10n.confirmButton),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),

            // رابط تغيير الرقم
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  Text(
                    l10n.wrongNumber,
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColors.textMuted),
                  ),
                  TextButton(
                    onPressed: _changeNumber,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 32),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle: textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    child: Text(l10n.changeNumber),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// الخانات الست: حقل نص حقيقي شفاف فوقها، والخانات تعرض الأرقام لي كتبناها.
class _OtpBoxes extends StatelessWidget {
  const _OtpBoxes({required this.controller, required this.focusNode});

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final text = controller.text;
    final textTheme = Theme.of(context).textTheme;

    // الخانة النشطة: لي نكتبو فيها دابا (أو الأخيرة إذا الرمز كمل)
    final activeIndex = text.length < _codeLength ? text.length : _codeLength - 1;

    // الأرقام تبقى من اليسار لليمين حتى في العربية
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_codeLength, (index) {
              final hasChar = index < text.length;
              final isActive = focusNode.hasFocus && index == activeIndex;

              return Container(
                width: 44,
                height: 56,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.buttonBorder,
                  border: Border.all(
                    color: isActive ? AppColors.primary : AppColors.primaryLight,
                    width: isActive ? 1.5 : 1,
                  ),
                ),
                child: Text(
                  hasChar ? text[index] : '',
                  style: textTheme.headlineLarge,
                ),
              );
            }),
          ),

          // الحقل الحقيقي: شفاف وفوق الخانات، يستقبل الكتابة واللصق
          Positioned.fill(
            child: Opacity(
              opacity: 0,
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                keyboardType: TextInputType.number,
                maxLength: _codeLength,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                autofillHints: const [AutofillHints.oneTimeCode],
                enableInteractiveSelection: false,
                showCursor: false,
                decoration: const InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}