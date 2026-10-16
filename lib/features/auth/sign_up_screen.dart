import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/language_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _identifierController = TextEditingController(); // بريد أو هاتف
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _acceptedTerms = false;
  bool _termsError = false; // نعرضو خطأ إذا ما وافقش على الشروط

  @override
  void dispose() {
    _nameController.dispose();
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().length < 2) {
      return context.l10n.nameRequired;
    }
    return null;
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
    FocusScope.of(context).unfocus();
    final formOk = _formKey.currentState!.validate();
    setState(() => _termsError = !_acceptedTerms);

    if (formOk && _acceptedTerms) {
      // مؤقت: إنشاء الحساب الحقيقي نربطوه مع الـ Backend في المرحلة 6
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Valid ✓ — real sign up comes with the backend (Phase 6)'),
        ),
      );
    }
  }

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.login);
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
            // الصف العلوي: سهم الرجوع في البداية، وزر اللغة في النهاية
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                0,
              ),
              child: Row(
                children: [
                  _CircleBackButton(onPressed: _goBack),
                  const Spacer(),
                  const LanguageButton(),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.lg),
                      Text(l10n.signUpTitle, style: textTheme.headlineLarge),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        l10n.signUpSubtitle,
                        style: textTheme.bodyMedium
                            ?.copyWith(color: AppColors.textMuted),
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      AppTextField(
                        label: l10n.fullNameLabel,
                        hint: l10n.fullNameHint,
                        controller: _nameController,
                        validator: _validateName,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppSpacing.md),
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
                        hint: l10n.passwordHintSignup,
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
                      const SizedBox(height: AppSpacing.md),

                      // مربع الموافقة على الشروط
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: _acceptedTerms,
                              activeColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              side: BorderSide(
                                color: _termsError
                                    ? AppColors.error
                                    : AppColors.primary,
                                width: 1.5,
                              ),
                              onChanged: (value) => setState(() {
                                _acceptedTerms = value ?? false;
                                if (_acceptedTerms) _termsError = false;
                              }),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                style: textTheme.bodyMedium,
                                children: [
                                  TextSpan(text: l10n.agreePrefix),
                                  TextSpan(
                                    text: l10n.termsAndPrivacy,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_termsError)
                        Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.sm),
                          child: Text(
                            l10n.mustAcceptTerms,
                            style: textTheme.bodyMedium
                                ?.copyWith(color: AppColors.error),
                          ),
                        ),
                      const SizedBox(height: AppSpacing.lg),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _submit,
                          child: Text(l10n.signUpButton),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ),
                ),
              ),
            ),

            // رابط تسجيل الدخول في الأسفل
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  Text(
                    l10n.haveAccount,
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

/// زر الرجوع الدائري الأبيض (كما في Figma).
class _CircleBackButton extends StatelessWidget {
  const _CircleBackButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.arrow_back_rounded,
            size: 20,
            color: AppColors.text,
          ),
        ),
      ),
    );
  }
}