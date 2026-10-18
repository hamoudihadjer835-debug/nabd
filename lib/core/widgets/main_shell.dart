import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/cart/cart_controller.dart';
import '../localization/l10n_extension.dart';
import '../theme/app_colors.dart';

/// الهيكل الرئيسي للتطبيق: محتوى التبويب الحالي + الشريط السفلي (5 تبويبات).
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  /// يدير التبويبات (الفروع) ويحفظ حالة كل واحد.
  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      // الضغط على التبويب النشط يرجعنا لأول صفحة فيه
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  /// أيقونة السلة مع شارة فيها عدد المنتجات (تختفي إذا السلة فارغة).
  Widget _cartIcon(IconData icon, int count) {
    return Badge(
      isLabelVisible: count > 0,
      label: Text('$count'),
      backgroundColor: AppColors.accentMint,
      textColor: AppColors.text,
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 8,
          shadowColor: const Color(0x1A5B4BDB),
          indicatorColor: AppColors.primaryLight,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return textTheme.labelSmall?.copyWith(
              color: selected ? AppColors.primary : AppColors.textMuted,
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return IconThemeData(
              color: selected ? AppColors.primary : AppColors.textMuted,
            );
          }),
        ),
        // نسمعو للسلة باش الشارة تتحدث
        child: ListenableBuilder(
          listenable: cartController,
          builder: (context, _) {
            final count = cartController.lineCount;

            return NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _onTap,
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home_rounded),
                  label: l10n.tabHome,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.grid_view_outlined),
                  selectedIcon: const Icon(Icons.grid_view_rounded),
                  label: l10n.tabCategories,
                ),
                NavigationDestination(
                  icon: _cartIcon(Icons.shopping_cart_outlined, count),
                  selectedIcon: _cartIcon(Icons.shopping_cart_rounded, count),
                  label: l10n.tabCart,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.inventory_2_outlined),
                  selectedIcon: const Icon(Icons.inventory_2_rounded),
                  label: l10n.tabOrders,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.person_outline_rounded),
                  selectedIcon: const Icon(Icons.person_rounded),
                  label: l10n.tabProfile,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}