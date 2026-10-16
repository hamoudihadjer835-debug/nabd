import 'package:flutter/material.dart';

import '../localization/l10n_extension.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import 'icon_badge.dart';
import 'language_button.dart';

/// صفحة مؤقتة لتبويب لسا ما بنيناهش: أيقونة + اسم التبويب + "Coming soon".
class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconBadge(icon: icon),
                    const SizedBox(height: AppSpacing.lg),
                    Text(title, style: textTheme.headlineLarge),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      context.l10n.comingSoon,
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}