import 'package:flutter/material.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/theme/app_dimens.dart';
import 'data/mock_categories.dart';
import 'widgets/category_card.dart';
import 'widgets/search_field.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_routes.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // العنوان + شريط البحث
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.tabCategories,
                      style: textTheme.headlineLarge,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const SearchField(),
                  ],
                ),
              ),
            ),

            // شبكة الأقسام: عمودين
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
                  mainAxisExtent: 130, // ارتفاع ثابت لكل بطاقة
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final category = mockCategories[index];
                    return CategoryCard(
                      category: category,
                      onTap: () =>
                          context.push(AppRoutes.categoryProducts(category.id)),
                    );
                  },
                  childCount: mockCategories.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}