/// عناوين الشاشات في التطبيق — نستعملها بدل كتابة النص بيدينا.
class AppRoutes {
  AppRoutes._();

  // شاشات الحساب
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String verifyCode = '/verify-code';
  static const String resetPassword = '/reset-password';

  // تبويبات الشريط السفلي
  static const String home = '/home';
  static const String categories = '/categories';
  static const String cart = '/cart';
  static const String orders = '/orders';
  static const String profile = '/profile';

  /// شاشة البحث: مسار فرعي داخل تبويب الرئيسية.
  static const String search = '/home/search';

  /// شاشة المفضلة: مسار فرعي داخل تبويب Profile.
  static const String favorites = '/profile/favorites';

  /// عنوان منتجات قسم معين، مثلا: /categories/c1
  static String categoryProducts(String categoryId) =>
      '$categories/$categoryId';

  /// نمط مسار تفاصيل المنتج (يستعمل في الراوتر).
  static const String productDetailsPattern = '/product/:productId';

  /// عنوان تفاصيل منتج معين، مثلا: /product/p1
  static String product(String productId) => '/product/$productId';
}