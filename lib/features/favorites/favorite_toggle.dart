import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'favorites_controller.dart';

/// زر القلب: أحمر ممتلئ إذا المنتج في المفضلة، وإلا فارغ.
/// `circled` = داخل دائرة بيضاء (صفحة التفاصيل)، وإلا أيقونة صغيرة (البطاقات).
class FavoriteToggle extends StatelessWidget {
  const FavoriteToggle({
    super.key,
    required this.productId,
    this.iconSize = 20,
    this.circled = false,
  });

  final String productId;
  final double iconSize;
  final bool circled;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: favoritesController,
      builder: (context, _) {
        final isFav = favoritesController.isFavorite(productId);

        final icon = Icon(
          isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          size: iconSize,
          color: isFav
              ? AppColors.error
              : (circled ? AppColors.text : AppColors.textMuted),
        );

        void onTap() => favoritesController.toggle(productId);

        if (circled) {
          return Material(
            color: Colors.white,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onTap,
              child: Padding(padding: const EdgeInsets.all(10), child: icon),
            ),
          );
        }

        return InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Padding(padding: const EdgeInsets.all(4), child: icon),
        );
      },
    );
  }
}