import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_routes.dart';
import '../../core/theme/app_dimens.dart';

/// نسخة مؤقتة: نصمموها بشكل حقيقي في الخطوة 4.3.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('تسجيل الدخول', style: textTheme.headlineLarge),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: () => context.go(AppRoutes.splash),
                child: const Text('رجوع'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}