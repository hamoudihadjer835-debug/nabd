import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/widgets/status_message.dart';

/// شاشة "لا يوجد اتصال بالإنترنت".
/// onRetry: يعاود الطلب. إذا ما عطيناهش، نرجعو للرئيسية (للمعاينة فقط).
class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: StatusMessage(
          icon: Icons.wifi_off_rounded,
          title: l10n.offlineTitle,
          message: l10n.offlineMessage,
          buttonLabel: l10n.retry,
          onPressed: onRetry ?? () => context.go(AppRoutes.home),
        ),
      ),
    );
  }
}

/// شاشة "حدث خطأ ما": رسالة عامة بلا أي تفصيل تقني للمستخدم.
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: StatusMessage(
          icon: Icons.warning_amber_rounded,
          isError: true,
          title: l10n.errorTitle,
          message: l10n.errorMessage,
          buttonLabel: l10n.retry,
          onPressed: onRetry ?? () => context.go(AppRoutes.home),
        ),
      ),
    );
  }
}