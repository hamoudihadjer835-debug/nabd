import 'package:go_router/go_router.dart';

import '../../features/auth/login_screen.dart';
import '../../features/splash/splash_screen.dart';
import 'app_routes.dart';

/// جدول التنقل: كل عنوان مربوط بشاشة.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash, // أول شاشة تفتح
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);