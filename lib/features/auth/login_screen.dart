import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/language_button.dart';
import '../../core/widgets/nabd_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController(); // بريد أو هاتف
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateIdentifier(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return context.l10n.fieldRequired;
    if (!Validators.isEmailOrPhone(v)) return context.l10n.invalidEmailOrPhone;
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return context.l10n.fieldRequired;
    if (value.length < 6) return context.l10n.passwordTooShort;
    return null;
  }

    void _submit() {
    FocusScope.of(context).unfocus(); // نسكرو الكيبورد
    if (_formKey.currentState!.validate()) {
      // مؤقت: الدخول الحقيقي مع الـ Backend (المرحلة 6)،
      // دابا ننتقلو للتطبيق الرئيسي باش نجربو الشريط السفلي
      context.go(AppRoutes.home);
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
            // زر اللغة في الأعلى
            const Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                0,
              ),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: LanguageButton(),
              ),
            ),

            // المحتوى (قابل للتمرير حتى لا يغطيه الكيبورد)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: AppSpacing.md),
                      const NabdLogo(size: 64),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        l10n.loginTitle,
                        textAlign: TextAlign.center,
                        style: textTheme.headlineLarge,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        l10n.loginSubtitle,
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
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        label: l10n.passwordLabel,
                        hint: '••••••••',
                        controller: _passwordController,
                        validator: _validatePassword,
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.done,
                        suffixIcon: IconButton(
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      // رابط "نسيت كلمة السر؟" ← شاشة Forgot Password
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: TextButton(
                          onPressed: () =>
                              context.push(AppRoutes.forgotPassword),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 32),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            textStyle: textTheme.bodyMedium,
                          ),
                          child: Text(l10n.forgotPassword),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _submit,
                          child: Text(l10n.loginButton),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ),
                ),
              ),
            ),

            // رابط إنشاء حساب في أسفل الشاشة ← شاشة Sign Up
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  Text(
                    l10n.noAccount,
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColors.textMuted),
                  ),
                  TextButton(
                    onPressed: () => context.push(AppRoutes.signUp),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 32),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle: textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    child: Text(l10n.signUpLink),
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