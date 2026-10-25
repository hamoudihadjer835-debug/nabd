import 'package:flutter/material.dart';

import '../localization/l10n_extension.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../utils/price_format.dart';

/// بطاقة الملخص: المجموع الفرعي + التوصيل + الإجمالي.
class PriceSummary extends StatelessWidget {
  const PriceSummary({
    super.key,
    required this.subtotal,
    required this.delivery,
    required this.total,
  });

  final int subtotal;
  final int delivery;
  final int total;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.cardBorder,
        border: Border.all(color: AppColors.primaryLight),
      ),
      child: Column(
        children: [
          _Row(label: l10n.subtotal, value: formatPrice(context, subtotal)),
          const SizedBox(height: AppSpacing.sm),
          _Row(label: l10n.deliveryFee, value: formatPrice(context, delivery)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Divider(height: 1, color: AppColors.primaryLight),
          ),
          _Row(
            label: l10n.total,
            value: formatPrice(context, total),
            bold: true,
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value, this.bold = false});

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Text(
          label,
          style: bold
              ? textTheme.titleLarge
              : textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
        ),
        const Spacer(),
        Text(
          value,
          style: bold
              ? textTheme.titleLarge?.copyWith(color: AppColors.primary)
              : textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}