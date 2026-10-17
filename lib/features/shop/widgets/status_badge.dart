import 'package:flutter/material.dart';

import '../../../core/localization/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../models/product.dart';

/// شارة الحالة: خلفية بلون الحالة (خفيف) ونص غامق باش يبقى مقروء.
class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final ProductStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final String label;
    final Color color;
    switch (status) {
      case ProductStatus.available:
        label = l10n.statusAvailable;
        color = AppColors.accentMint;
      case ProductStatus.limited:
        label = l10n.statusLimited;
        color = AppColors.warning;
      case ProductStatus.outOfStock:
        label = l10n.statusOutOfStock;
        color = AppColors.error;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: AppColors.text),
      ),
    );
  }
}