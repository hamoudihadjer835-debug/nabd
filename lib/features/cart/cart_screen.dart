import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/utils/price_format.dart';
import '../../core/widgets/status_message.dart';
import 'cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        // ListenableBuilder: يعيد رسم الشاشة كل ما السلة تتبدل
        child: ListenableBuilder(
          listenable: cartController,
          builder: (context, _) {
            final items = cartController.items;

            return Column(
              children: [
                // العنوان + عدد العناصر
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.sm,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(l10n.tabCart, style: textTheme.headlineLarge),
                      const Spacer(),
                      if (items.isNotEmpty)
                        Text(
                          l10n.cartItemsCount(cartController.lineCount),
                          style: textTheme.bodyMedium
                              ?.copyWith(color: AppColors.textMuted),
                        ),
                    ],
                  ),
                ),

                // المنتجات (تتحرك) أو الحالة الفارغة
                Expanded(
                  child: items.isEmpty
                      ? StatusMessage(
                          icon: Icons.shopping_cart_outlined,
                          title: l10n.cartEmptyTitle,
                          message: l10n.cartEmptyHint,
                          buttonLabel: l10n.browseProducts,
                          onPressed: () => context.go(AppRoutes.home),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          itemCount: items.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: AppSpacing.sm),
                          itemBuilder: (context, index) =>
                              _CartItemCard(item: items[index]),
                        ),
                ),

                // الملخص والزر مثبتين في الأسفل
                if (items.isNotEmpty) const _Summary(),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// بطاقة منتج في السلة.
class _CartItemCard extends StatelessWidget {
  const _CartItemCard({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final product = item.product;
    final locale = Localizations.localeOf(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.cardBorder,
        boxShadow: const [
          BoxShadow(
            color: Color(0x145B4BDB),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصورة المصغرة
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: product.imageAsset != null
                ? Image.asset(product.imageAsset!, fit: BoxFit.contain)
                : const Icon(
                    Icons.monitor_heart_outlined,
                    size: 32,
                    color: AppColors.primary,
                  ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الاسم + زر الحذف
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.name.of(locale),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    InkWell(
                      onTap: () => cartController.remove(product.id),
                      customBorder: const CircleBorder(),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          size: 20,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),

                // السعر (سطر كامل) + التحكم في الكمية
                Row(
                  children: [
                    Text(
                      formatPrice(context, item.lineTotal),
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const Spacer(),
                    _QuantityControl(item: item),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// أزرار الكمية: − 2 +  (من اليسار لليمين دايما، كما في Figma).
class _QuantityControl extends StatelessWidget {
  const _QuantityControl({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final id = item.product.id;
    final canDecrease = item.quantity > 1;
    final canIncrease = item.quantity < item.product.stockQuantity;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _RoundButton(
            icon: Icons.remove_rounded,
            filled: false,
            onTap: canDecrease ? () => cartController.decrease(id) : null,
          ),
          SizedBox(
            width: 36,
            child: Text(
              '${item.quantity}',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          _RoundButton(
            icon: Icons.add_rounded,
            filled: true,
            onTap: canIncrease ? () => cartController.increase(id) : null,
          ),
        ],
      ),
    );
  }
}

/// زر دائري صغير: بنفسجي (+) أو أبيض بحدود (−). إذا onTap فارغ يكون باهت.
class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.icon,
    required this.filled,
    required this.onTap,
  });

  final IconData icon;
  final bool filled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;

    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: Material(
        color: filled ? AppColors.primary : Colors.white,
        shape: CircleBorder(
          side: filled
              ? BorderSide.none
              : const BorderSide(color: AppColors.primaryLight),
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox(
            width: 28,
            height: 28,
            child: Icon(
              icon,
              size: 18,
              color: filled ? Colors.white : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}

/// الملخص (المجموع الفرعي، التوصيل، الإجمالي) + زر المتابعة.
class _Summary extends StatelessWidget {
  const _Summary();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppRadius.cardBorder,
              border: Border.all(color: AppColors.primaryLight),
            ),
            child: Column(
              children: [
                _SummaryRow(
                  label: l10n.subtotal,
                  value: formatPrice(context, cartController.subtotal),
                ),
                const SizedBox(height: AppSpacing.sm),
                _SummaryRow(
                  label: l10n.deliveryFee,
                  value: formatPrice(context, cartController.delivery),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Divider(height: 1, color: AppColors.primaryLight),
                ),
                _SummaryRow(
                  label: l10n.total,
                  value: formatPrice(context, cartController.total),
                  bold: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => context.push(AppRoutes.checkout),
              child: Text(l10n.proceedToPayment),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.bold = false,
  });

  final String label;
  final String value;
  final bool bold; // سطر الإجمالي: أكبر وأغمق

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
