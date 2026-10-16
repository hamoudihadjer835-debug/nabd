import 'package:flutter/material.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/widgets/language_button.dart';
import 'data/mock_products.dart';
import 'widgets/product_card.dart';

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
            // زر اللغة في الأعلى
            const SliverToBoxAdapter(
              child: Padding(
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
            ),

            // عنوان القسم + "عرض الكل"
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    Text(l10n.featuredProducts, style: textTheme.titleLarge),
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