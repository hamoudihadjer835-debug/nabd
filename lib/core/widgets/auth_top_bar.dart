import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_routes.dart';
import '../theme/app_dimens.dart';
import 'circle_back_button.dart';
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
          CircleBackButton(onPressed: () => _goBack(context)),
          const Spacer(),
          const LanguageButton(),
        ],
      ),
    );
  }
}