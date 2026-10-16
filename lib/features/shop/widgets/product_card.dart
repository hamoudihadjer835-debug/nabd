import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/localization/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../models/product.dart';

/// بطاقة منتج: شارة الحالة، قلب، صورة، اسم، سعر، وزر إضافة.
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAdd,
  });

  final Product product;
  final VoidCallback? onTap; // فتح تفاصيل المنتج (نربطوها لاحقا)
  final VoidCallback? onAdd; // إضافة للسلة (نربطوها لاحقا)

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);

    // نكتبو الأرقام بالإنجليزية (4,500) حتى في العربية، كما في Figma
    final priceText =
        '${NumberFormat.decimalPattern('en').format(product.price)} ${l10n.currency}';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.cardBorder,
        boxShadow: const [
          BoxShadow(
            color: Color(0x145B4BDB), // البنفسجي بشفافية 8%
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: AppRadius.cardBorder,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الصف العلوي: شارة الحالة + قلب
                Row(
                  children: [
                    _StatusBadge(status: product.status),
                    const Spacer(),
                    const Icon(
                      Icons.favorite_border_rounded,
                      size: 20,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),

                // مكان الصورة
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: product.imageAsset != null
                        ? Image.asset(product.imageAsset!, fit: BoxFit.contain)
                        : const Icon(
                            Icons.monitor_heart_outlined,
                            size: 44,
                            color: AppColors.primary,
                          ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),

                // الاسم (سطرين على الأكثر)
                Text(
                  product.name.of(locale),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.sm),

                // السعر + زر الإضافة
                Row(
                  children: [
                    Text(
                      priceText,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const Spacer(),
                    _AddButton(onTap: onAdd),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// شارة الحالة: خلفية بلون الحالة (خفيف) ونص غامق باش يبقى مقروء.
class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

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

/// زر "+" البنفسجي.
class _AddButton extends StatelessWidget {
  const _AddButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: const SizedBox(
          width: 32,
          height: 32,
          child: Icon(Icons.add_rounded, size: 20, color: Colors.white),
        ),
      ),
    );
  }
}