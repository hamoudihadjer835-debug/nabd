import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/utils/price_format.dart';
import '../../core/widgets/choice_card.dart';
import '../../core/widgets/circle_back_button.dart';
import '../../core/widgets/status_message.dart';
import '../addresses/addresses_controller.dart';
import '../cart/cart_controller.dart';
import '../orders/orders_controller.dart';
import 'checkout_controller.dart';
import 'data/mock_checkout_options.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.cart);
    }
  }

  /// نؤكدو الطلب: ننشئوه، نفرغو السلة، ونروحو لشاشة التأكيد.
  void _confirm(BuildContext context) {
    final address = addressesController.defaultAddress;
    if (address == null || cartController.isEmpty) return;

    final order = ordersController.place(
      items: cartController.items,
      address: address,
      delivery: checkoutController.selectedDelivery,
      payment: checkoutController.selectedPayment,
      subtotal: cartController.subtotal,
      deliveryFee: cartController.delivery,
    );

    // go (ماشي push): نمسحو شاشة Checkout، باش الرجوع ما يرجعش لها
    context.go(AppRoutes.orderConfirmation(order.id));
    cartController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);

    return Scaffold(
      body: SafeArea(
        // نسمعو للسلة والعناوين والاختيارات في نفس الوقت
        child: ListenableBuilder(
          listenable: Listenable.merge([
            cartController,
            addressesController,
            checkoutController,
          ]),
          builder: (context, _) {
            final address = addressesController.defaultAddress;

            final header = Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  CircleBackButton(onPressed: () => _goBack(context)),
                  const SizedBox(width: AppSpacing.md),
                  Text(l10n.checkoutTitle, style: textTheme.headlineLarge),
                ],
              ),
            );

            // سلة فارغة (مثلا فتحنا العنوان مباشرة): نعرضو رسالة
            if (cartController.isEmpty) {
              return Column(
                children: [
                  header,
                  Expanded(
                    child: StatusMessage(
                      icon: Icons.shopping_cart_outlined,
                      title: l10n.cartEmptyTitle,
                      message: l10n.cartEmptyHint,
                      buttonLabel: l10n.browseProducts,
                      onPressed: () => context.go(AppRoutes.home),
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                header,
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1) عنوان التوصيل
                        _SectionHeader(
                          title: l10n.deliveryAddressTitle,
                          actionLabel: l10n.changeAction,
                          onAction: () => context.push(AppRoutes.addresses),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        if (address != null)
                          ChoiceCard(
                            title: address.label.of(locale),
                            subtitle: addressLine(address, locale),
                            badge: l10n.defaultBadge,
                            selected: true,
                            onTap: () => context.push(AppRoutes.addresses),
                          )
                        else
                          _NoAddressCard(
                            onAdd: () => context.push(AppRoutes.addAddress),
                          ),
                        const SizedBox(height: AppSpacing.lg),

                        // 2) طريقة التوصيل
                        _SectionHeader(title: l10n.deliveryMethodTitle),
                        const SizedBox(height: AppSpacing.sm),
                        for (final option in mockDeliveryOptions) ...[
                          ChoiceCard(
                            title: option.name.of(locale),
                            subtitle: option.note.of(locale),
                            selected: checkoutController.deliveryId == option.id,
                            onTap: () =>
                                checkoutController.selectDelivery(option.id),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                        ],
                        const SizedBox(height: AppSpacing.sm),

                        // 3) طريقة الدفع (نغيروها من شاشة الدفع)
                        _SectionHeader(
                          title: l10n.paymentMethodTitle,
                          actionLabel: l10n.changeAction,
                          onAction: () => context.push(AppRoutes.payment),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        ChoiceCard(
                          title:
                              checkoutController.selectedPayment.name.of(locale),
                          subtitle:
                              checkoutController.selectedPayment.note.of(locale),
                          selected: true,
                          onTap: () => context.push(AppRoutes.payment),
                        ),
                        const SizedBox(height: AppSpacing.lg),

                        // 4) الملخص
                        const _SummaryCard(),
                        const SizedBox(height: AppSpacing.lg),
                      ],
                    ),
                  ),
                ),

                // زر التأكيد الثابت (معطل إذا ما كاش عنوان)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.sm,
                    AppSpacing.md,
                    AppSpacing.md,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x145B4BDB),
                        blurRadius: 16,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed:
                          address == null ? null : () => _confirm(context),
                      child: Text(l10n.confirmOrder),
                    ),
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

/// عنوان قسم + رابط اختياري (مثلا "تغيير").
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Text(title, style: textTheme.titleLarge),
        const Spacer(),
        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 32),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(actionLabel!),
          ),
      ],
    );
  }
}

/// ما كاش عنوان: رسالة + زر إضافة.
class _NoAddressCard extends StatelessWidget {
  const _NoAddressCard({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

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
            l10n.noAddressYet,
            style: textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
          ),
          TextButton(
            onPressed: onAdd,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: EdgeInsets.zero,
            ),
            child: Text(l10n.addNewAddress),
          ),
        ],
      ),
    );
  }
}

/// الملخص: المجموع الفرعي + التوصيل + الإجمالي.
class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.cardBorder,
        border: Border.all(color: AppColors.primaryLight),
      ),
      child: Column(
        children: [
          _SummaryRow(
            label: l10n.subtotal,
            value: formatPrice(context, cartController.subtotal),
          ),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(
            label: l10n.deliveryFee,
            value: formatPrice(context, cartController.delivery),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Divider(height: 1, color: AppColors.primaryLight),
          ),
          _SummaryRow(
            label: l10n.total,
            value: formatPrice(context, cartController.total),
            bold: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.bold = false,
  });

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Text(
          label,
          style: bold
              ? textTheme.titleLarge
              : textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
        ),
        const Spacer(),
        Text(
          value,
          style: bold
              ? textTheme.titleLarge?.copyWith(color: AppColors.primary)
              : textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}