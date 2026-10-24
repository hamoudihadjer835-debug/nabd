import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/widgets/status_message.dart';
import 'orders_controller.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final order = ordersController.byId(orderId);

    // طلب غير موجود (عنوان غلط): رسالة عامة بدل ما يتعطل التطبيق
    if (order == null) {
      return Scaffold(
        body: SafeArea(
          child: StatusMessage(
            icon: Icons.error_outline_rounded,
            isError: true,
            title: l10n.errorTitle,
            message: l10n.errorMessage,
            buttonLabel: l10n.backToHome,
            onPressed: () => context.go(AppRoutes.home),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // علامة ✓ خضراء داخل دائرة فاتحة
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 76,
                            height: 76,
                            decoration: const BoxDecoration(
                              color: AppColors.success,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check_rounded,
                              size: 48,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        l10n.orderReceivedTitle,
                        textAlign: TextAlign.center,
                        style: textTheme.headlineLarge,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        l10n.orderReceivedMessage,
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium
                            ?.copyWith(color: AppColors.textMuted),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // بطاقة رقم الطلب
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: AppRadius.cardBorder,
                          border: Border.all(color: AppColors.primaryLight),
                        ),
                        child: Column(
                          children: [
                            Text(
                              l10n.orderNumberLabel,
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.textMuted),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '#${order.number}',
                              textDirection: TextDirection.ltr,
                              style: textTheme.headlineLarge
                                  ?.copyWith(color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // الأزرار في الأسفل
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      // شاشة الطلبات نبنيوها في الخطوة الجاية
                      onPressed: () => context.go(AppRoutes.orders),
                      child: Text(l10n.trackOrder),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => context.go(AppRoutes.home),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLight,
                        foregroundColor: AppColors.primary,
                      ),
                      child: Text(l10n.backToHome),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}