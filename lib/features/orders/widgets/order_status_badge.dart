import 'package:flutter/material.dart';

import '../../../core/localization/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../models/order.dart';

/// اسم الحالة بلغة التطبيق.
String orderStatusLabel(BuildContext context, OrderStatus status) {
  final l10n = context.l10n;
  switch (status) {
    case OrderStatus.pendingConfirmation:
      return l10n.orderStatusPending;
    case OrderStatus.preparing:
      return l10n.orderStatusPreparing;
    case OrderStatus.shipped:
      return l10n.orderStatusShipped;
    case OrderStatus.delivered:
      return l10n.orderStatusDelivered;
    case OrderStatus.cancelled:
      return l10n.orderStatusCancelled;
  }
}

/// شارة الحالة: خلفية ملونة ونص مقروء.
class OrderStatusBadge extends StatelessWidget {
  const OrderStatusBadge({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final Color background;
    final Color foreground;
    switch (status) {
      case OrderStatus.pendingConfirmation:
        background = AppColors.warning.withValues(alpha: 0.2);
        foreground = AppColors.text;
      case OrderStatus.preparing:
        background = AppColors.primaryLight;
        foreground = AppColors.primary;
      case OrderStatus.shipped:
        background = AppColors.primary;
        foreground = Colors.white;
      case OrderStatus.delivered:
        background = AppColors.success.withValues(alpha: 0.15);
        foreground = AppColors.text;
      case OrderStatus.cancelled:
        background = AppColors.error.withValues(alpha: 0.12);
        foreground = AppColors.text;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        orderStatusLabel(context, status),
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: foreground),
      ),
    );
  }
}