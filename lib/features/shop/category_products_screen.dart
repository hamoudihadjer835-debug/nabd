import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/widgets/circle_back_button.dart';
import 'data/mock_categories.dart';
import 'data/mock_products.dart';
import 'models/product.dart';
import 'widgets/product_card.dart';

/// طرق ترتيب المنتجات.
enum ProductSort { none, priceLow, priceHigh }

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({super.key, required this.categoryId});

  final String categoryId;

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  ProductSort _sort = ProductSort.none;

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.categories);
    }
  }

  /// منتجات هذا القسم، مرتبة حسب الاختيار الحالي.
  List<Product> _visibleProducts() {
    final list =
        mockProducts.where((p) => p.categoryId == widget.categoryId).toList();
    switch (_sort) {
      case ProductSort.priceLow:
        list.sort((a, b) => a.price.compareTo(b.price));
      case ProductSort.priceHigh:
        list.sort((a, b) => b.price.compareTo(a.price));
      case ProductSort.none:
        break;
    }
    return list;
  }

  String _sortLabel(ProductSort sort) {
    final l10n = context.l10n;
    switch (sort) {
      case ProductSort.none:
        return l10n.sortDefault;
      case ProductSort.priceLow:
        return l10n.sortPriceLow;
      case ProductSort.priceHigh:
        return l10n.sortPriceHigh;
    }
  }

  IconData _sortIcon(ProductSort sort) {
    switch (sort) {
      case ProductSort.none:
        return Icons.sort_rounded;
      case ProductSort.priceLow:
        return Icons.arrow_upward_rounded;
      case ProductSort.priceHigh:
        return Icons.arrow_downward_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);

    final category =
        mockCategories.where((c) => c.id == widget.categoryId).firstOrNull;
    final products = _visibleProducts();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // الصف العلوي: سهم الرجوع + اسم القسم
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                  0,
                ),
                child: Row(
                  children: [
                    CircleBackButton(onPressed: _goBack),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        category?.name.of(locale) ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.headlineLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // زرا الترتيب والتصفية
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    // الترتيب: قائمة منسدلة تنزل تحت الزر مباشرة
                    PopupMenuButton<ProductSort>(
                      tooltip: '',
                      position: PopupMenuPosition.under,
                      offset: const Offset(0, 8),
                      color: Colors.white,
                      surfaceTintColor: Colors.transparent,
                      elevation: 8,
                      shadowColor: const Color(0x335B4BDB),
                      constraints: const BoxConstraints(minWidth: 240),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: AppColors.primaryLight),
                      ),
                      onSelected: (value) => setState(() => _sort = value),
                      itemBuilder: (context) => [
                        for (final option in ProductSort.values)
                          PopupMenuItem<ProductSort>(
                            value: option,
                            height: 48,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            child: _SortOptionRow(
                              label: _sortLabel(option),
                              icon: _sortIcon(option),
                              selected: option == _sort,
                            ),
                          ),
                      ],
                      child: _PillButton(
                        label: _sort == ProductSort.none
                            ? l10n.sortBy
                            : _sortLabel(_sort),
                        icon: Icons.keyboard_arrow_down_rounded,
                        active: _sort != ProductSort.none,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    // التصفية: نبنيوها لاحقا مع الـ Backend
                    _PillButton(
                      label: l10n.filterLabel,
                      icon: Icons.tune_rounded,
                    ),
                  ],
                ),
              ),
            ),

            // حالة فارغة، أو شبكة المنتجات
            if (products.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Text(
                      l10n.noProductsInCategory,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge
                          ?.copyWith(color: AppColors.textMuted),
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  0,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                sliver: SliverGrid(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisExtent: 250,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => ProductCard(product: products[index]),
                    childCount: products.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// سطر واحد داخل قائمة الترتيب: أيقونة + نص + علامة ✓ إذا كان مختارا.
class _SortOptionRow extends StatelessWidget {
  const _SortOptionRow({
    required this.label,
    required this.icon,
    required this.selected,
  });

  final String label;
  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        // الخيار المختار: خلفية بنفسجية فاتحة
        color: selected ? AppColors.primaryLight : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: selected ? AppColors.primary : AppColors.textMuted,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                color: selected ? AppColors.primary : AppColors.text,
              ),
            ),
          ),
          if (selected)
            const Icon(Icons.check_rounded, size: 20, color: AppColors.primary),
        ],
      ),
    );
  }
}

/// زر بشكل حبة (Pill): نص + أيقونة، شكل فقط.
/// الضغط يتكفل بيه من حواليه (مثلا PopupMenuButton).
class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.label,
    required this.icon,
    this.active = false,
  });

  final String label;
  final IconData icon;
  final bool active; // مفعّل: لون بنفسجي

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: active ? AppColors.primaryLight : Colors.white,
      shape: StadiumBorder(
        side: BorderSide(
          color: active ? AppColors.primary : AppColors.primaryLight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: active ? AppColors.primary : AppColors.text,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              icon,
              size: 18,
              color: active ? AppColors.primary : AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}