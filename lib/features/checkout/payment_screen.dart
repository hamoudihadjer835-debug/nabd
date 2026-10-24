import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/widgets/choice_card.dart';
import '../../core/widgets/circle_back_button.dart';
import 'checkout_controller.dart';
import 'data/mock_checkout_options.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // الاختيار يبدأ بالحالي، ولا يتطبق حتى نضغطو "تأكيد"
  late String _selected = checkoutController.paymentId;

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.checkout);
    }
  }

  void _confirm() {
    checkoutController.selectPayment(_selected);
    _goBack();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // السهم + العنوان
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  CircleBackButton(onPressed: _goBack),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    l10n.paymentMethodTitle,
                    style: textTheme.headlineLarge,
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                children: [
                  // تنبيه: الطرق تحدد لاحقا
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            l10n.paymentInfoBanner,
                            style: textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  for (final method in mockPaymentMethods) ...[
                    ChoiceCard(
                      title: method.name.of(locale),
                      subtitle: method.note.of(locale),
                      selected: _selected == method.id,
                      onTap: () => setState(() => _selected = method.id),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                ],
              ),
            ),

            // زر التأكيد الثابت
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
                  onPressed: _confirm,
                  child: Text(l10n.confirmButton),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}