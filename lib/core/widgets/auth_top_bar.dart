import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import 'language_button.dart';

/// الشريط العلوي لشاشات الحساب: سهم الرجوع في البداية، وزر اللغة في النهاية.
class AuthTopBar extends StatelessWidget {
  const AuthTopBar({super.key});

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        0,
      ),
      child: Row(
        children: [
          _CircleBackButton(onPressed: () => _goBack(context)),
          const Spacer(),
          const LanguageButton(),
        ],
      ),
    );
  }
}

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