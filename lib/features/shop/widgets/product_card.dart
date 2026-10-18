import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/utils/price_format.dart';
import '../../cart/cart_actions.dart';
import '../../favorites/favorite_toggle.dart';
import '../models/product.dart';
import 'status_badge.dart';

/// بطاقة منتج: شارة الحالة، قلب، صورة، اسم، سعر، وزر إضافة.
/// الضغط على البطاقة يفتح التفاصيل، والضغط على + يضيف للسلة، والقلب للمفضلة.
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);

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
          onTap: () => context.push(AppRoutes.product(product.id)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الصف العلوي: شارة الحالة + قلب المفضلة
                Row(
                  children: [
                    StatusBadge(status: product.status),
                    const Spacer(),
                    FavoriteToggle(productId: product.id),
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
                      formatPrice(context, product.price),
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const Spacer(),
                    _AddButton(
                      // رمادي إذا المنتج نفد (كما في Figma)
                      enabled: product.status != ProductStatus.outOfStock,
                      onTap: () => addToCart(context, product),
                    ),
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

/// زر "+": بنفسجي، أو رمادي إذا المنتج نفد.
class _AddButton extends StatelessWidget {
  const _AddButton({required this.enabled, required this.onTap});

  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: enabled ? AppColors.primary : AppColors.textMuted,
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