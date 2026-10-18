import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/language_names.dart';
import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';

/// سطر في قائمة Profile.
class _MenuItem {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.value,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final String? value; // قيمة تظهر قبل السهم (مثلا اللغة الحالية)
  final bool danger; // تسجيل الخروج: أحمر وبلا سهم
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  /// شاشات ما بنيناهاش بعد: نعرضو رسالة "قريبًا".
  void _comingSoon(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(context.l10n.comingSoon)));
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final l10n = context.l10n;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(l10n.logoutConfirmTitle),
        content: Text(l10n.logoutConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.menuLogout),
          ),
        ],
      ),
    );

    // context.mounted: نتأكدو أن الشاشة مازالت مفتوحة بعد انتظار الجواب
    if (confirmed == true && context.mounted) {
      // مؤقت: مسح بيانات الحساب الحقيقي يتم مع الـ Backend
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;

    final items = [
      _MenuItem(
        icon: Icons.person_outline_rounded,
        label: l10n.menuMyData,
        onTap: () => _comingSoon(context),
      ),
      _MenuItem(
        icon: Icons.location_on_outlined,
        label: l10n.menuAddresses,
        onTap: () => _comingSoon(context),
      ),
      _MenuItem(
        icon: Icons.favorite_border_rounded,
        label: l10n.favoritesTitle,
        onTap: () => context.push(AppRoutes.favorites),
      ),
      _MenuItem(
        icon: Icons.notifications_none_rounded,
        label: l10n.menuNotifications,
        onTap: () => _comingSoon(context),
      ),
      _MenuItem(
        icon: Icons.language_rounded,
        label: l10n.menuLanguage,
        value: nativeLanguageName(languageCode),
        onTap: () => context.push(AppRoutes.language),
      ),
      _MenuItem(
        icon: Icons.help_outline_rounded,
        label: l10n.menuHelp,
        onTap: () => _comingSoon(context),
      ),
      _MenuItem(
        icon: Icons.logout_rounded,
        label: l10n.menuLogout,
        danger: true,
        onTap: () => _confirmLogout(context),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.tabProfile, style: textTheme.headlineLarge),
              const SizedBox(height: AppSpacing.md),
              const _UserCard(),
              const SizedBox(height: AppSpacing.md),
              _MenuCard(items: items),
            ],
          ),
        ),
      ),
    );
  }
}

/// بطاقة المستخدم: دائرة بأيقونة + الاسم + البريد (بيانات نائبة دابا).
class _UserCard extends StatelessWidget {
  const _UserCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.cardBorder,
        border: Border.all(color: AppColors.primaryLight),
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              size: 32,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.profileNamePlaceholder,
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'example@email.com',
                  textDirection: TextDirection.ltr,
                  style: textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// بطاقة القائمة: أسطر يفصل بينها خط رفيع.
class _MenuCard extends StatelessWidget {
  const _MenuCard({required this.items});

  final List<_MenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.cardBorder,
        side: const BorderSide(color: AppColors.primaryLight),
      ),
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const Divider(height: 1, color: AppColors.primaryLight),
            _MenuRow(item: items[i]),
          ],
        ],
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({required this.item});

  final _MenuItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final color = item.danger ? AppColors.error : AppColors.text;

    return InkWell(
      onTap: item.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 14,
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              size: 22,
              color: item.danger ? AppColors.error : AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                item.label,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
            if (item.value != null) ...[
              Text(
                item.value!,
                style:
                    textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
              ),
              const SizedBox(width: 4),
            ],
            if (!item.danger)
              Icon(
                isRtl
                    ? Icons.chevron_left_rounded
                    : Icons.chevron_right_rounded,
                color: AppColors.textMuted,
              ),
          ],
        ),
      ),
    );
  }
}