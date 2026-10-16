import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/forgot_password_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/reset_password_screen.dart';
import '../../features/auth/sign_up_screen.dart';
import '../../features/auth/verify_code_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../localization/l10n_extension.dart';
import '../widgets/coming_soon_screen.dart';
import '../widgets/main_shell.dart';
import 'app_routes.dart';
import '../../features/shop/home_screen.dart';

/// جدول التنقل: كل عنوان مربوط بشاشة.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    // ---------- شاشات الحساب ----------
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.verifyCode,
      // البريد/الهاتف يوصلنا عبر extra من شاشة Forgot Password
      builder: (context, state) =>
          VerifyCodeScreen(identifier: (state.extra as String?) ?? ''),
    ),
    GoRoute(
      path: AppRoutes.resetPassword,
      builder: (context, state) => const ResetPasswordScreen(),
    ),

    // ---------- التطبيق الرئيسي: 5 تبويبات ----------
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainShell(navigationShell: navigationShell),
      branches: [
        // الترتيب هنا = ترتيب التبويبات في الشريط
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
                            builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.categories,
              builder: (context, state) => ComingSoonScreen(
                title: context.l10n.tabCategories,
                icon: Icons.grid_view_outlined,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.cart,
              builder: (context, state) => ComingSoonScreen(
                title: context.l10n.tabCart,
                icon: Icons.shopping_cart_outlined,
              ),
            ),
          ],
        ),
        
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => ComingSoonScreen(
                title: context.l10n.tabProfile,
                icon: Icons.person_outline_rounded,
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);