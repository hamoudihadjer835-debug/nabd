import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/auth_top_bar.dart';
import '../../core/widgets/icon_badge.dart';
import '../../core/utils/password_validation.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

   String? _validateNew(String? value) => validateNewPassword(
        context.l10n,
        value,
        emptyMessage: context.l10n.newPasswordRequired,
      );

  String? _validateConfirm(String? value) {
    if (value == null || value.isEmpty) return context.l10n.fieldRequired;
    // لازم تطابق كلمة السر الجديدة
    if (value != _newController.text) return context.l10n.passwordsDontMatch;
    return null;
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      // مؤقت: تغيير كلمة السر الحقيقي مع الـ Backend (المرحلة 6)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Valid ✓ — resetting the password comes with the backend (Phase 6)'),
        ),
      );
      // go (ماشي push): يمسح الشاشات السابقة، فنرجعو لـ Login من الأول
      context.go(AppRoutes.login);
    }
  }

  /// زر العين لإظهار وإخفاء كلمة السر.
  Widget _eyeButton({required bool obscure, required VoidCallback onTap}) {
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
                      const IconBadge(icon: Icons.lock_outline_rounded),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        l10n.resetTitle,
                        textAlign: TextAlign.center,
                        style: textTheme.headlineLarge,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        l10n.resetSubtitle,
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium
                            ?.copyWith(color: AppColors.textMuted),
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      AppTextField(
                        label: l10n.newPasswordLabel,
                        hint: l10n.passwordHintSignup,
                        controller: _newController,
                        validator: _validateNew,
                        obscureText: _obscureNew,
                        textInputAction: TextInputAction.next,
                        suffixIcon: _eyeButton(
                          obscure: _obscureNew,
                          onTap: () =>
                              setState(() => _obscureNew = !_obscureNew),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        label: l10n.confirmPasswordLabel,
                        hint: l10n.confirmPasswordHint,
                        controller: _confirmController,
                        validator: _validateConfirm,
                        obscureText: _obscureConfirm,
                        textInputAction: TextInputAction.done,
                        suffixIcon: _eyeButton(
                          obscure: _obscureConfirm,
                          onTap: () => setState(
                            () => _obscureConfirm = !_obscureConfirm,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _submit,
                          child: Text(l10n.resetButton),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}