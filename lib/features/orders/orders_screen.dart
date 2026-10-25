import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/utils/date_format.dart';
import '../../core/utils/price_format.dart';
import '../../core/widgets/status_message.dart';
import 'models/order.dart';
import 'orders_controller.dart';
import 'widgets/order_status_badge.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _showCurrent = true; // الحالية أو السابقة

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: ordersController,
          builder: (context, _) {
            final orders = ordersController.orders
                .where((o) => o.isCurrent == _showCurrent)
                .toList();

            return Column(
              children: [
                // العنوان
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.sm,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(l10n.myOrdersTitle,
                        style: textTheme.headlineLarge),
                  ),
                ),

                // حبتا التبديل: الحالية / السابقة
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Row(
                    children: [
                      _TabPill(
                        label: l10n.ordersCurrent,
                        selected: _showCurrent,
                        onTap: () => setState(() => _showCurrent = true),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _TabPill(
                        label: l10n.ordersPast,
                        selected: !_showCurrent,
                        onTap: () => setState(() => _showCurrent = false),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),

                // القائمة أو الحالة الفارغة
                Expanded(
                  child: orders.isEmpty
                      ? StatusMessage(
                          icon: Icons.inventory_2_outlined,
                          title: l10n.ordersEmptyTitle,
                          message: _showCurrent
                              ? l10n.ordersEmptyHint
                              : l10n.ordersPastEmptyHint,
                          buttonLabel:
                              _showCurrent ? l10n.browseProducts : null,
                          onPressed: _showCurrent
                              ? () => context.go(AppRoutes.home)
                              : null,
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          itemCount: orders.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: AppSpacing.sm),
                          itemBuilder: (context, index) =>
                              _OrderCard(order: orders[index]),
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

/// حبة تبديل (Pill): بنفسجية إذا مختارة.
class _TabPill extends StatelessWidget {
  const _TabPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: selected ? AppColors.primary : Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: StadiumBorder(
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.primaryLight,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : AppColors.text,
            ),
          ),
        ),
      ),
    );
  }
}

/// بطاقة طلب: رقم + تاريخ + شارة، صور مصغرة + عدد، إجمالي + تفاصيل.
class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Material(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.cardBorder,
        side: const BorderSide(color: AppColors.primaryLight),
      ),
      child: InkWell(
        onTap: () => context.push(AppRoutes.orderDetails(order.id)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              // الصف 1: الرقم والتاريخ + الشارة
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#${order.number}',
                        textDirection: TextDirection.ltr,
                        style: textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        formatDate(order.createdAt, locale),
                        style: textTheme.bodyMedium
                            ?.copyWith(color: AppColors.textMuted),
                      ),
                    ],
                  ),
                  const Spacer(),
                  OrderStatusBadge(status: order.status),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // الصف 2: صور مصغرة (3 كحد أقصى) + عدد المنتجات
              Row(
                children: [
                  for (final _ in order.lines.take(3))
                    Container(
                      width: 36,
                      height: 36,
                      margin: const EdgeInsetsDirectional.only(end: 6),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.monitor_heart_outlined,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ),
                  const Spacer(),
                  Text(
                    l10n.cartItemsCount(order.lines.length),
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Divider(height: 1, color: AppColors.primaryLight),
              ),

              // الصف 3: الإجمالي + رابط التفاصيل
              Row(
                children: [
                  Text(
                    l10n.total,
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColors.textMuted),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    formatPrice(context, order.total),
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    l10n.detailsAction,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  Icon(
                    isRtl
                        ? Icons.chevron_left_rounded
                        : Icons.chevron_right_rounded,
                    size: 20,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}