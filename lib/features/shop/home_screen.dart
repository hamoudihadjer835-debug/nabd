import 'package:flutter/material.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import 'data/mock_products.dart';
import 'widgets/product_card.dart';
import 'widgets/search_field.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // الجزء العلوي: بحث + أقسام + بانر + عنوان المنتجات
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                  0,
                ),
                child: Column(
                  children: [
                    SearchField(),
                    const SizedBox(height: AppSpacing.lg),
                    const _CategoriesRow(),
                    const SizedBox(height: AppSpacing.lg),
                    const _PromoBanner(),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        Text(l10n.featuredProducts,
                            style: textTheme.titleLarge),
                        const Spacer(),
                        TextButton(
                          onPressed: () {}, // نربطوها بشاشة المنتجات لاحقا
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                          ),
                          child: Text(l10n.viewAll),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                ),
              ),
            ),

            // شبكة المنتجات: عمودين
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.md,
              ),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisExtent: 250, // ارتفاع ثابت لكل بطاقة
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      ProductCard(product: mockProducts[index]),
                  childCount: mockProducts.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// صف الأقسام: 4 دوائر بأيقونة واسم.
class _CategoriesRow extends StatelessWidget {
  const _CategoriesRow();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Row(
      children: [
        _CategoryItem(
          icon: Icons.monitor_heart_outlined,
          label: l10n.catMeasure,
        ),
        _CategoryItem(
          icon: Icons.medical_services_outlined,
          label: l10n.catExam,
        ),
        _CategoryItem(icon: Icons.healing_outlined, label: l10n.catWounds),
        _CategoryItem(
          icon: Icons.inventory_2_outlined,
          label: l10n.catSupplies,
        ),
      ],
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    // Expanded: كل قسم ياخذ ربع العرض
    return Expanded(
      child: InkWell(
        onTap: () {}, // نربطوها بشاشة المنتجات لاحقا
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryLight),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

/// بانر العروض: خلفية بنفسجية، دائرتان للزينة، نص، وزر نعناعي.
class _PromoBanner extends StatelessWidget {
  const _PromoBanner();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias, // يقص الدوائر لي تخرج من حدود البانر
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // الدوائر الزخرفية في نهاية البانر (يسار في العربية)
          const PositionedDirectional(
            end: -30,
            bottom: -40,
            child: _Circle(size: 130, color: Color(0x26FFFFFF)),
          ),
          const PositionedDirectional(
            end: 24,
            bottom: -16,
            child: _Circle(size: 56, color: AppColors.accentMint),
          ),

          // النص والزر في بداية البانر
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 100, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.promoTitle,
                  style: textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.promoSubtitle,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                ElevatedButton(
                  onPressed: () {}, // نربطوها بالعروض لاحقا
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentMint,
                    foregroundColor: AppColors.text, // نص غامق على النعناعي
                    minimumSize: const Size(0, 36),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    textStyle: textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  child: Text(l10n.promoButton),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}