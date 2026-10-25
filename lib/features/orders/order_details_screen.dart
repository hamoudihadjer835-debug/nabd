import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/utils/date_format.dart';
import '../../core/utils/price_format.dart';
import '../../core/widgets/circle_back_button.dart';
import '../../core/widgets/price_summary.dart';
import '../../core/widgets/status_message.dart';
import '../addresses/addresses_controller.dart';
import 'models/order.dart';
import 'orders_controller.dart';
import 'widgets/order_status_badge.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.orderId});

  final String orderId;

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.orders);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);
    final order = ordersController.byId(orderId);

    // طلب غير موجود (عنوان غلط): حالة خطأ بدل ما يتعطل التطبيق
    if (order == null) {
      return Scaffold(
        body: SafeArea(
          child: StatusMessage(
            icon: Icons.warning_amber_rounded,
            isError: true,
            title: l10n.errorTitle,
            message: l10n.errorMessage,
            buttonLabel: l10n.myOrdersTitle,
            onPressed: () => context.go(AppRoutes.orders),
          ),
        ),
      );
    }

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
                  Text(l10n.orderDetailsTitle, style: textTheme.headlineLarge),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // الرقم والتاريخ + الشارة
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#${order.number}',
                              textDirection: TextDirection.ltr,
                              style: textTheme.titleLarge,
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
                    const SizedBox(height: AppSpacing.lg),

                    // حالة الطلب (الخط الزمني) — ما نعرضوهوش للطلب الملغى
                    if (order.status != OrderStatus.cancelled) ...[
                      Text(l10n.orderStatusSection,
                          style: textTheme.titleLarge),
                      const SizedBox(height: AppSpacing.sm),
                      _Timeline(order: order),
                      const SizedBox(height: AppSpacing.lg),
                    ],

                    // المنتجات
                    Text(l10n.productsTitle, style: textTheme.titleLarge),
                    const SizedBox(height: AppSpacing.sm),
                    _LinesCard(order: order),
                    const SizedBox(height: AppSpacing.lg),

                    // عنوان التوصيل
                    Text(l10n.deliveryAddressTitle,
                        style: textTheme.titleLarge),
                    const SizedBox(height: AppSpacing.sm),
                    _AddressCard(order: order),
                    const SizedBox(height: AppSpacing.lg),

                    // الملخص
                    PriceSummary(
                      subtotal: order.subtotal,
                      delivery: order.deliveryFee,
                      total: order.total,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- الخط الزمني ----------

enum _StepState { done, current, pending }

class _Timeline extends StatelessWidget {
  const _Timeline({required this.order});

  final Order order;

  /// كم خطوة اكتملت (الخطوة الموالية هي "الحالية").
  int get _doneSteps {
    switch (order.status) {
      case OrderStatus.pendingConfirmation:
        return 0;
      case OrderStatus.preparing:
        return 1;
      case OrderStatus.shipped:
        return 2;
      case OrderStatus.delivered:
        return 4; // كل الخطوات اكتملت
      case OrderStatus.cancelled:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);

    final titles = [
      l10n.stepConfirmed,
      l10n.orderStatusPreparing,
      l10n.orderStatusShipped,
      l10n.orderStatusDelivered,
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.cardBorder,
        border: Border.all(color: AppColors.primaryLight),
      ),
      child: Column(
        children: [
          for (var i = 0; i < titles.length; i++)
            _TimelineRow(
              title: titles[i],
              // الوقت إذا وصلت الخطوة، وإلا "في انتظار التحديث"
              subtitle: order.stepTimes[i] != null
                  ? formatDateTime(order.stepTimes[i]!, locale)
                  : (i < _doneSteps ? null : l10n.awaitingUpdate),
              state: i < _doneSteps
                  ? _StepState.done
                  : (i == _doneSteps ? _StepState.current : _StepState.pending),
              isLast: i == titles.length - 1,
            ),
        ],
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.title,
    required this.subtitle,
    required this.state,
    required this.isLast,
  });

  final String title;
  final String? subtitle;
  final _StepState state;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // العمود: النقطة + الخط لي يربط بالنقطة الجاية
          SizedBox(
            width: 24,
            child: Column(
              children: [
                _Dot(state: state),
                if (!isLast)
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 2,
                        color: state == _StepState.done
                            ? AppColors.primary
                            : AppColors.primaryLight,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: state == _StepState.pending
                          ? AppColors.textMuted
                          : AppColors.text,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textMuted),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// نقطة الخطوة: ✓ مكتملة، حلقة للحالية، فارغة للباقي.
class _Dot extends StatelessWidget {
  const _Dot({required this.state});

  final _StepState state;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case _StepState.done:
        return Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_rounded, size: 16, color: Colors.white),
        );
      case _StepState.current:
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryLight, width: 5),
          ),
        );
      case _StepState.pending:
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryLight, width: 2),
          ),
        );
    }
  }
}

// ---------- المنتجات والعنوان ----------

class _LinesCard extends StatelessWidget {
  const _LinesCard({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.cardBorder,
        border: Border.all(color: AppColors.primaryLight),
      ),
      child: Column(
        children: [
          for (var i = 0; i < order.lines.length; i++) ...[
            if (i > 0) const Divider(height: 1, color: AppColors.primaryLight),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.monitor_heart_outlined,
                      size: 22,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.lines[i].product.name.of(locale),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l10n.quantityLabel(order.lines[i].quantity),
                          style: textTheme.bodyMedium
                              ?.copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    formatPrice(context, order.lines[i].total),
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.cardBorder,
        border: Border.all(color: AppColors.primaryLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            order.address.label.of(locale),
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            addressLine(order.address, locale),
            style: textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}