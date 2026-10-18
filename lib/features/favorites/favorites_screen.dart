import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/widgets/circle_back_button.dart';
import '../../core/widgets/icon_badge.dart';
import '../shop/data/mock_products.dart';
import '../shop/widgets/product_card.dart';
import 'favorites_controller.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        // نعيدو الرسم كل ما المفضلة تتبدل (مثلا كي نحيو قلب منتج)
        child: ListenableBuilder(
          listenable: favoritesController,
          builder: (context, _) {
            final products = mockProducts
                .where((p) => favoritesController.isFavorite(p.id))
                .toList();

            return Column(
              children: [
                // الصف العلوي: سهم + عنوان + عدد المنتجات
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                  ),
                  child: Row(
                    children: [
                      CircleBackButton(onPressed: () => _goBack(context)),
                      const SizedBox(width: AppSpacing.md),
                      Text(l10n.favoritesTitle, style: textTheme.headlineLarge),
                      const Spacer(),
                      if (products.isNotEmpty)
                        Text(
                          l10n.favoritesCount(products.length),
                          style: textTheme.bodyMedium
                              ?.copyWith(color: AppColors.textMuted),
                        ),
                    ],
                  ),
                ),

                Expanded(
                  child: products.isEmpty
                      ? const _EmptyFavorites()
                      : GridView.builder(
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.md,
                            0,
                            AppSpacing.md,
                            AppSpacing.md,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: AppSpacing.md,
                            crossAxisSpacing: AppSpacing.md,
                            mainAxisExtent: 250,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) =>
                              ProductCard(product: products[index]),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// المفضلة الفارغة: قلب + رسالة + زر لتصفح المنتجات.
class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const IconBadge(icon: Icons.favorite_border_rounded, size: 88),
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.favoritesEmptyTitle, style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.favoritesEmptyHint,
              textAlign: TextAlign.center,
              style:
                  textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: Text(l10n.browseProducts),
            ),
          ],
        ),
      ),
    );
  }
}