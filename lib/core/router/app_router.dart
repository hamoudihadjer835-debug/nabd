import 'package:go_router/go_router.dart';

import '../../features/addresses/add_address_screen.dart';
import '../../features/addresses/addresses_screen.dart';
import '../../features/auth/forgot_password_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/reset_password_screen.dart';
import '../../features/auth/sign_up_screen.dart';
import '../../features/auth/verify_code_screen.dart';
import '../../features/cart/cart_screen.dart';
import '../../features/checkout/checkout_screen.dart';
import '../../features/checkout/payment_screen.dart';
import '../../features/favorites/favorites_screen.dart';
import '../../features/notifications/notifications_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/orders/order_confirmation_screen.dart';
import '../../features/orders/order_details_screen.dart';
import '../../features/orders/orders_screen.dart';
import '../../features/profile/change_password_screen.dart';
import '../../features/profile/edit_profile_screen.dart';
import '../../features/profile/language_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/shop/categories_screen.dart';
import '../../features/shop/category_products_screen.dart';
import '../../features/shop/home_screen.dart';
import '../../features/shop/product_details_screen.dart';
import '../../features/shop/search_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/states/state_screens.dart';
import '../widgets/main_shell.dart';
import 'app_routes.dart';

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

    // ---------- شاشات ملء الشاشة (بلا الشريط السفلي) ----------
    GoRoute(
      path: AppRoutes.productDetailsPattern,
      builder: (context, state) => ProductDetailsScreen(
        productId: state.pathParameters['productId'] ?? '',
      ),
    ),
    GoRoute(
      path: AppRoutes.language,
      builder: (context, state) => const LanguageScreen(),
    ),
    GoRoute(
      path: AppRoutes.editProfile,
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.changePassword,
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.addresses,
      builder: (context, state) => const AddressesScreen(),
    ),
    GoRoute(
      path: AppRoutes.addAddress,
      builder: (context, state) => const AddAddressScreen(),
    ),

    // ---------- مسار الطلب ----------
    GoRoute(
      path: AppRoutes.checkout,
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: AppRoutes.payment,
      builder: (context, state) => const PaymentScreen(),
    ),
    GoRoute(
      path: AppRoutes.orderConfirmationPattern,
      builder: (context, state) => OrderConfirmationScreen(
        orderId: state.pathParameters['orderId'] ?? '',
      ),
    ),
    GoRoute(
      path: AppRoutes.orderDetailsPattern,
      builder: (context, state) => OrderDetailsScreen(
        orderId: state.pathParameters['orderId'] ?? '',
      ),
    ),

    // معاينة مؤقتة لحالتي لا اتصال وخطأ
    GoRoute(
      path: AppRoutes.offlinePreview,
      builder: (context, state) => const OfflineScreen(),
    ),
    GoRoute(
      path: AppRoutes.errorPreview,
      builder: (context, state) => const ErrorScreen(),
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
              routes: [
                // مسار فرعي: /home/search
                GoRoute(
                  path: 'search',
                  builder: (context, state) => const SearchScreen(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.categories,
              builder: (context, state) => const CategoriesScreen(),
              routes: [
                // مسار فرعي: /categories/:categoryId
                GoRoute(
                  path: ':categoryId',
                  builder: (context, state) => CategoryProductsScreen(
                    categoryId: state.pathParameters['categoryId'] ?? '',
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.cart,
              builder: (context, state) => const CartScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.orders,
              builder: (context, state) => const OrdersScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const ProfileScreen(),
              routes: [
                // مسارات فرعية: /profile/favorites و/profile/notifications
                GoRoute(
                  path: 'favorites',
                  builder: (context, state) => const FavoritesScreen(),
                ),
                GoRoute(
                  path: 'notifications',
                  builder: (context, state) => const NotificationsScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);