import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/auth_top_bar.dart';
import '../../core/widgets/icon_badge.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController(); // بريد أو هاتف

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  String? _validateIdentifier(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return context.l10n.fieldRequired;
    if (!Validators.isEmailOrPhone(v)) return context.l10n.invalidEmailOrPhone;
    return null;
  }

    void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      // نمرّرو البريد/الهاتف لشاشة الرمز باش تعرضو مخفي جزئيا
      context.push(
        AppRoutes.verifyCode,
        extra: _identifierController.text.trim(),
      );
    }
  }

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: AppSpacing.xl),
                      const IconBadge(icon: Icons.mail_outline_rounded),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        l10n.forgotPassword,
                        textAlign: TextAlign.center,
                        style: textTheme.headlineLarge,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        l10n.forgotSubtitle,
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium
                            ?.copyWith(color: AppColors.textMuted),
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      AppTextField(
                        label: l10n.emailOrPhoneLabel,
                        hint: l10n.emailOrPhoneHint,
                        controller: _identifierController,
                        validator: _validateIdentifier,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _submit,
                          child: Text(l10n.sendCodeButton),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ),
                ),
              ),
            ),

            // رابط العودة لتسجيل الدخول
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  Text(
                    l10n.rememberedPassword,
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColors.textMuted),
                  ),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.login),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 32),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle: textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    child: Text(l10n.loginLink),
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