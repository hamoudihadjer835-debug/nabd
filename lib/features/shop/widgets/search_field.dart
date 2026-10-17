import 'package:flutter/material.dart';

import '../../../core/localization/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';

/// شريط البحث: أيقونة البحث في البداية، وأيقونة الفلتر في النهاية.
class SearchField extends StatelessWidget {
  const SearchField({super.key, this.onTap});

  final VoidCallback? onTap; // نربطوه بشاشة البحث لاحقا

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.cardBorder,
        side: const BorderSide(color: AppColors.primaryLight),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 14,
          ),
          child: Row(
            children: [
              const Icon(Icons.search_rounded, color: AppColors.textMuted),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  context.l10n.searchHint,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textMuted),
                ),
              ),
              const Icon(Icons.tune_rounded, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}