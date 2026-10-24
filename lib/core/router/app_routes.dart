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

  /// شاشة اللغة: ملء الشاشة بلا الشريط السفلي.
  static const String language = '/language';
    /// شاشة تعديل البيانات: ملء الشاشة بلا الشريط السفلي.
  static const String editProfile = '/edit-profile';
    /// شاشة تغيير كلمة السر: ملء الشاشة بلا الشريط السفلي.
  static const String changePassword = '/change-password';
  /// مسارات معاينة مؤقتة لشاشتي لا اتصال وخطأ (نحيوهم بعد ربط الـ Backend).
  static const String offlinePreview = '/preview/offline';
  static const String errorPreview = '/preview/error';
  /// عنوان منتجات قسم معين، مثلا: /categories/c1
  static String categoryProducts(String categoryId) =>
      '$categories/$categoryId';

  /// نمط مسار تفاصيل المنتج (يستعمل في الراوتر).
  static const String productDetailsPattern = '/product/:productId';

  /// عنوان تفاصيل منتج معين، مثلا: /product/p1
  static String product(String productId) => '/product/$productId';
    /// شاشة الإشعارات: مسار فرعي داخل تبويب Profile.
  static const String notifications = '/profile/notifications';
    /// شاشتا العناوين: ملء الشاشة بلا الشريط السفلي.
  static const String addresses = '/addresses';
  static const String addAddress = '/add-address';
    /// مسار الطلب: شاشات ملء الشاشة بلا الشريط السفلي.
  static const String checkout = '/checkout';
  static const String payment = '/payment';

  /// نمط مسار تأكيد الطلب (يستعمل في الراوتر).
  static const String orderConfirmationPattern =
      '/order-confirmation/:orderId';

  /// عنوان تأكيد طلب معين، مثلا: /order-confirmation/NBD-10486
  static String orderConfirmation(String orderId) =>
      '/order-confirmation/$orderId';
}