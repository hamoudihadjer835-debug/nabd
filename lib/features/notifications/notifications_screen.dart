import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/widgets/circle_back_button.dart';
import 'data/mock_notifications.dart';
import 'models/app_notification.dart';
import 'notifications_controller.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

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

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // السهم + العنوان
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  CircleBackButton(onPressed: () => _goBack(context)),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    context.l10n.menuNotifications,
                    style: textTheme.headlineLarge,
                  ),
                ],
              ),
            ),

            // القائمة: تتحدث كل ما إشعار يتعلم كمقروء
            Expanded(
              child: ListenableBuilder(
                listenable: notificationsController,
                builder: (context, _) {
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      0,
                      AppSpacing.md,
                      AppSpacing.md,
                    ),
                    itemCount: mockNotifications.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, index) => _NotificationCard(
                      notification: mockNotifications[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// أيقونة كل نوع إشعار.
IconData _iconFor(NotificationType type) {
  switch (type) {
    case NotificationType.shipped:
      return Icons.local_shipping_outlined;
    case NotificationType.preparing:
      return Icons.inventory_2_outlined;
    case NotificationType.confirmed:
      return Icons.check_circle_outline_rounded;
    case NotificationType.backInStock:
      return Icons.favorite_border_rounded;
    case NotificationType.addressSaved:
      return Icons.location_on_outlined;
    case NotificationType.welcome:
      return Icons.notifications_none_rounded;
  }
}

/// بطاقة إشعار: أيقونة + عنوان + نص + وقت، ونقطة نعناعية إذا غير مقروء.
class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.notification});

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);
    final isRead = notificationsController.isRead(notification.id);

    return Material(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.cardBorder,
        side: const BorderSide(color: AppColors.primaryLight),
      ),
      child: InkWell(
        onTap: () => notificationsController.markRead(notification.id),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الأيقونة في دائرة
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _iconFor(notification.type),
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // العنوان والنص والوقت
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title.of(locale),
                      // غير المقروء: عنوان أغمق
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: isRead ? FontWeight.w600 : FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      notification.body.of(locale),
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notification.timeLabel.of(locale),
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),

              // نقطة "غير مقروء"
              if (!isRead)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppColors.accentMint,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}