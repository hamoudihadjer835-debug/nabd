import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/widgets/circle_back_button.dart';
import 'data/mock_products.dart';
import 'models/product.dart';
import 'widgets/status_badge.dart';
import '../cart/cart_actions.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isFavorite = false; // مؤقت: القلب يتبدل في الشاشة فقط، والحفظ لاحقا

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);

    final product =
        mockProducts.where((p) => p.id == widget.productId).firstOrNull;

    // منتج غير موجود (عنوان غلط): نعرضو رسالة بدل ما يتعطل التطبيق
    if (product == null) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: CircleBackButton(onPressed: _goBack),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    l10n.productNotFound,
                    style: textTheme.bodyLarge
                        ?.copyWith(color: AppColors.textMuted),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final priceText =
        '${NumberFormat.decimalPattern('en').format(product.price)} ${l10n.currency}';
    final isOut = product.status == ProductStatus.outOfStock;

    // أسطر المواصفات (القيمة الفارغة تظهر "غير محدد")
    final specs = [
      _SpecRow(l10n.specManufacturer, product.manufacturer ?? l10n.notSpecified),
      _SpecRow(
        l10n.specIntendedUse,
        product.intendedUse?.of(locale) ?? l10n.notSpecified,
      ),
      _SpecRow(
        l10n.specCertifications,
        product.certification ?? l10n.notSpecified,
      ),
      _SpecRow(l10n.specSku, product.sku),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // المحتوى القابل للتمرير
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // الصورة + سهم الرجوع + القلب
                    Container(
                      height: 260,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x145B4BDB),
                            blurRadius: 16,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: product.imageAsset != null
                                ? Image.asset(
                                    product.imageAsset!,
                                    fit: BoxFit.contain,
                                  )
                                : const Icon(
                                    Icons.monitor_heart_outlined,
                                    size: 96,
                                    color: AppColors.primary,
                                  ),
                          ),
                          PositionedDirectional(
                            start: 12,
                            top: 12,
                            child: CircleBackButton(onPressed: _goBack),
                          ),
                          PositionedDirectional(
                            end: 12,
                            top: 12,
                            child: _FavoriteButton(
                              isFavorite: _isFavorite,
                              onPressed: () =>
                                  setState(() => _isFavorite = !_isFavorite),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // شارة الحالة + الكمية المتبقية
                    Row(
                      children: [
                        StatusBadge(status: product.status),
                        const SizedBox(width: AppSpacing.sm),
                        if (!isOut)
                          Text(
                            l10n.stockLeft(product.stockQuantity),
                            style: textTheme.bodyMedium
                                ?.copyWith(color: AppColors.textMuted),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // الاسم والسعر
                    Text(product.name.of(locale), style: textTheme.headlineLarge),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      priceText,
                      style: textTheme.headlineLarge
                          ?.copyWith(color: AppColors.primary),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // المواصفات
                    Text(l10n.specsTitle, style: textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(
                      l10n.specsSubtitle,
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textMuted),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _SpecsCard(rows: specs),
                  ],
                ),
              ),
            ),

            // زر الإضافة الثابت في الأسفل
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.md,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x145B4BDB),
                    blurRadius: 16,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                height: 52,
                child: ElevatedButton(
                  // null = الزر معطل (المنتج نفد)
                  onPressed: isOut ? null : () => addToCart(context, product),
                  child: Text(isOut ? l10n.statusOutOfStock : l10n.addToCart),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// سطر مواصفات: اسم الخاصية + قيمتها.
class _SpecRow {
  const _SpecRow(this.label, this.value);

  final String label;
  final String value;
}

/// بطاقة المواصفات: أسطر يفصل بينها خط رفيع.
class _SpecsCard extends StatelessWidget {
  const _SpecsCard({required this.rows});

  final List<_SpecRow> rows;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.cardBorder,
        border: Border.all(color: AppColors.primaryLight),
      ),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) const Divider(height: 1, color: AppColors.primaryLight),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 14,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      rows[i].label,
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textMuted),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    flex: 3,
                    child: Text(
                      rows[i].value,
                      textAlign: TextAlign.end,
                      style: textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// زر القلب الدائري (أبيض، ويتحول أحمر لما يكون في المفضلة).
class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.isFavorite, required this.onPressed});

  final bool isFavorite;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            isFavorite
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded,
            size: 20,
            color: isFavorite ? AppColors.error : AppColors.text,
          ),
        ),
      ),
    );
  }
}