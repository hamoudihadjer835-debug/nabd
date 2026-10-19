import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/utils/password_rules.dart';
import '../../core/utils/password_validation.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/circle_back_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // مؤقت فقط للتجربة: في الحقيقة الخادم هو لي يتحقق من كلمة السر الحالية.
  static const String _mockCurrentPassword = 'Nabd1234';

  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  /// خطأ جاي من الخادم (كلمة السر الحالية غير صحيحة).
  String? _currentError;

  /// زر الحفظ يتفعل فقط إذا كل الشروط تحققت.
  bool get _canSubmit =>
      !_isLoading &&
      _currentController.text.isNotEmpty &&
      PasswordRules.isValid(_newController.text) &&
      _newController.text != _currentController.text &&
      _confirmController.text == _newController.text;

  @override
  void initState() {
    super.initState();
    // نعيدو الرسم مع كل حرف: الشروط والقوة وحالة الزر
    _currentController.addListener(_refresh);
    _newController.addListener(_refresh);
    _confirmController.addListener(_refresh);
  }

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _refresh() => setState(() {});

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.profile);
    }
  }

  // ---------- التحقق ----------
  String? _validateCurrent(String? value) {
    if (value == null || value.isEmpty) return context.l10n.fieldRequired;
    return _currentError; // الخطأ القادم من الخادم (إن وجد)
  }

  String? _validateNew(String? value) => validateNewPassword(
        context.l10n,
        value,
        emptyMessage: context.l10n.newPasswordRequired,
        current: _currentController.text,
      );

  String? _validateConfirm(String? value) {
    if (value == null || value.isEmpty) return context.l10n.fieldRequired;
    if (value != _newController.text) return context.l10n.passwordsDontMatch;
    return null;
  }

  // ---------- الإرسال ----------
  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final l10n = context.l10n;
    setState(() => _isLoading = true);

    try {
      // مؤقت: نحاكيو طلب للخادم (ثانية وحدة)
      await Future<void>.delayed(const Duration(seconds: 1));
      if (!mounted) return;

      final isCurrentCorrect = _currentController.text == _mockCurrentPassword;

      if (!isCurrentCorrect) {
        // الخطأ يظهر تحت حقل كلمة السر الحالية
        setState(() {
          _isLoading = false;
          _currentError = l10n.currentPasswordWrong;
        });
        _formKey.currentState!.validate();
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(l10n.passwordChanged)));
      _goBack();
    } catch (_) {
      // خطأ عام: رسالة بلا أي تفصيل تقني
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(l10n.genericError)));
    }
  }

  Widget _eye(bool obscure, VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: AppColors.textMuted,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final newPassword = _newController.text;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // السهم + العنوان
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  CircleBackButton(onPressed: _goBack),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      l10n.changePassword,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.headlineLarge,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Form(
                  key: _formKey,
                  // الأخطاء تظهر بعد ما المستخدم يتفاعل مع الحقل
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1) كلمة السر الحالية
                      AppTextField(
                        label: l10n.currentPasswordLabel,
                        hint: '••••••••',
                        controller: _currentController,
                        validator: _validateCurrent,
                        obscureText: _obscureCurrent,
                        enabled: !_isLoading,
                        ltrInput: true,
                        textInputAction: TextInputAction.next,
                        // أي تعديل يمسح خطأ الخادم
                        onChanged: (_) {
                          if (_currentError != null) {
                            setState(() => _currentError = null);
                          }
                        },
                        suffixIcon: _eye(
                          _obscureCurrent,
                          () => setState(
                            () => _obscureCurrent = !_obscureCurrent,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: TextButton(
                          onPressed: _isLoading
                              ? null
                              : () => context.push(AppRoutes.forgotPassword),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 32),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            textStyle: textTheme.bodyMedium,
                          ),
                          child: Text(l10n.forgotCurrentPassword),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // 2) كلمة السر الجديدة + القوة + الشروط
                      AppTextField(
                        label: l10n.newPasswordLabel,
                        hint: l10n.passwordHintSignup,
                        controller: _newController,
                        validator: _validateNew,
                        obscureText: _obscureNew,
                        enabled: !_isLoading,
                        ltrInput: true,
                        textInputAction: TextInputAction.next,
                        suffixIcon: _eye(
                          _obscureNew,
                          () => setState(() => _obscureNew = !_obscureNew),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _StrengthMeter(password: newPassword),
                      const SizedBox(height: AppSpacing.sm),
                      _RuleRow(
                        met: PasswordRules.hasMinLength(newPassword),
                        label: l10n.ruleMinLength,
                      ),
                      _RuleRow(
                        met: PasswordRules.hasLetter(newPassword),
                        label: l10n.ruleLetter,
                      ),
                      _RuleRow(
                        met: PasswordRules.hasDigit(newPassword),
                        label: l10n.ruleDigit,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // 3) تأكيد كلمة السر الجديدة
                      AppTextField(
                        label: l10n.confirmNewPasswordLabel,
                        hint: l10n.confirmPasswordHint,
                        controller: _confirmController,
                        validator: _validateConfirm,
                        obscureText: _obscureConfirm,
                        enabled: !_isLoading,
                        ltrInput: true,
                        textInputAction: TextInputAction.done,
                        suffixIcon: _eye(
                          _obscureConfirm,
                          () => setState(
                            () => _obscureConfirm = !_obscureConfirm,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ),
                ),
              ),
            ),

            // زر الحفظ الثابت: معطل حتى تتحقق الشروط، وبدوار أثناء الإرسال
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.md,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x145B4BDB),
                    blurRadius: 16,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _canSubmit ? _submit : null,
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : Text(l10n.save),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// شريط قوة كلمة السر: 3 مقاطع تتلون حسب المستوى + اسم المستوى.
class _StrengthMeter extends StatelessWidget {
  const _StrengthMeter({required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final strength = PasswordRules.strengthOf(password);

    // عدد المقاطع الملونة + اللون + الاسم
    final int level;
    final Color color;
    final String label;
    switch (strength) {
      case PasswordStrength.none:
        level = 0;
        color = AppColors.primaryLight;
        label = '';
      case PasswordStrength.weak:
        level = 1;
        color = AppColors.error;
        label = l10n.strengthWeak;
      case PasswordStrength.medium:
        level = 2;
        color = AppColors.warning;
        label = l10n.strengthMedium;
      case PasswordStrength.strong:
        level = 3;
        color = AppColors.success;
        label = l10n.strengthStrong;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (var i = 0; i < 3; i++) ...[
              if (i > 0) const SizedBox(width: 6),
              Expanded(
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: i < level ? color : AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Text(
              l10n.passwordStrengthLabel,
              style:
                  textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
            ),
            const Spacer(),
            // الاسم بلون النص (مش ملون) باش يبقى مقروء، واللون في الشريط
            Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// شرط واحد: ✓ أخضر إذا تحقق، ودائرة فارغة إذا لا.
class _RuleRow extends StatelessWidget {
  const _RuleRow({required this.met, required this.label});

  final bool met;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = met ? AppColors.success : AppColors.textMuted;

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Icon(
            met ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
            size: 18,
            color: color,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(label, style: textTheme.bodyMedium?.copyWith(color: color)),
        ],
      ),
    );
  }
}