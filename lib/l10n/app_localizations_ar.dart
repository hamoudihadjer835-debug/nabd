// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get loginTitle => 'أهلًا بك في نبض';

  @override
  String get loginSubtitle => 'سجّل الدخول لمتابعة طلباتك ومنتجاتك';

  @override
  String get emailOrPhoneLabel => 'البريد الإلكتروني أو رقم الهاتف';

  @override
  String get emailOrPhoneHint => 'example@email.com';

  @override
  String get passwordLabel => 'كلمة السر';

  @override
  String get passwordHintSignup => '6 أحرف على الأقل';

  @override
  String get forgotPassword => 'نسيت كلمة السر؟';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get noAccount => 'ليس لديك حساب؟';

  @override
  String get signUpLink => 'إنشاء حساب';

  @override
  String get signUpTitle => 'إنشاء حساب جديد';

  @override
  String get signUpSubtitle => 'أدخل بياناتك لبدء التسوق بثقة';

  @override
  String get fullNameLabel => 'الاسم الكامل';

  @override
  String get fullNameHint => 'أدخل اسمك الكامل';

  @override
  String get agreePrefix => 'أوافق على ';

  @override
  String get termsAndPrivacy => 'الشروط وسياسة الخصوصية';

  @override
  String get signUpButton => 'إنشاء حساب';

  @override
  String get haveAccount => 'لديك حساب بالفعل؟';

  @override
  String get loginLink => 'تسجيل الدخول';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

  @override
  String get invalidEmailOrPhone => 'أدخل بريدًا إلكترونيًا أو رقم هاتف صحيحًا';

  @override
  String get passwordTooShort => 'كلمة السر يجب أن تكون 6 أحرف على الأقل';

  @override
  String get nameRequired => 'يرجى إدخال اسمك الكامل';

  @override
  String get mustAcceptTerms => 'يرجى الموافقة على الشروط للمتابعة';

  @override
  String get forgotSubtitle =>
      'أدخل بريدك الإلكتروني أو رقم هاتفك وسنرسل لك رمز التحقق';

  @override
  String get sendCodeButton => 'إرسال الرمز';

  @override
  String get rememberedPassword => 'تذكرت كلمة السر؟';

  @override
  String get verifyTitle => 'أدخل رمز التحقق';

  @override
  String get verifySubtitle => 'أرسلنا رمزًا من 6 أرقام إلى';

  @override
  String get confirmButton => 'تأكيد';

  @override
  String get resendIn => 'يمكنك إعادة إرسال الرمز بعد';

  @override
  String get resendCode => 'إعادة إرسال الرمز';

  @override
  String get wrongNumber => 'هل الرقم خاطئ؟';

  @override
  String get changeNumber => 'تغيير الرقم';

  @override
  String get codeIncomplete => 'أدخل الرمز المكوّن من 6 أرقام';

  @override
  String get resetTitle => 'إنشاء كلمة سر جديدة';

  @override
  String get resetSubtitle => 'اختر كلمة سر جديدة من 6 أحرف على الأقل';

  @override
  String get newPasswordLabel => 'كلمة السر الجديدة';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة السر';

  @override
  String get confirmPasswordHint => 'أعد إدخال كلمة السر';

  @override
  String get resetButton => 'إعادة تعيين كلمة السر';

  @override
  String get passwordsDontMatch => 'كلمتا السر غير متطابقتين';

  @override
  String get tabHome => 'الرئيسية';

  @override
  String get tabCategories => 'الأقسام';

  @override
  String get tabCart => 'السلة';

  @override
  String get tabOrders => 'الطلبات';

  @override
  String get tabProfile => 'حسابي';

  @override
  String get comingSoon => 'قريبًا';

  @override
  String get statusAvailable => 'متوفر';

  @override
  String get statusLimited => 'كمية محدودة';

  @override
  String get statusOutOfStock => 'نفد المخزون';

  @override
  String get currency => 'دج';

  @override
  String get featuredProducts => 'منتجات مميزة';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get searchHint => 'ابحث عن مستلزمات طبية...';

  @override
  String get catMeasure => 'القياس';

  @override
  String get catExam => 'الفحص';

  @override
  String get catWounds => 'الجروح';

  @override
  String get catSupplies => 'المستلزمات';

  @override
  String get promoTitle => 'عروض الأسبوع';

  @override
  String get promoSubtitle => 'تخفيضات على أجهزة القياس والفحص';

  @override
  String get promoButton => 'تسوق الآن';

  @override
  String productsCount(int count) {
    return '$count منتجًا';
  }

  @override
  String get sortBy => 'ترتيب حسب';

  @override
  String get filterLabel => 'تصفية';

  @override
  String get sortDefault => 'الافتراضي';

  @override
  String get sortPriceLow => 'السعر: من الأقل إلى الأعلى';

  @override
  String get sortPriceHigh => 'السعر: من الأعلى إلى الأقل';

  @override
  String get noProductsInCategory => 'لا توجد منتجات في هذا القسم بعد';

  @override
  String stockLeft(int count) {
    return 'متبقي $count قطعة';
  }

  @override
  String get specsTitle => 'المواصفات';

  @override
  String get specsSubtitle => 'معلومات مقدّمة من الشركة المصنّعة';

  @override
  String get specManufacturer => 'الشركة المصنّعة';

  @override
  String get specIntendedUse => 'الاستعمال المقصود';

  @override
  String get specCertifications => 'الشهادات';

  @override
  String get specSku => 'رقم المنتج';

  @override
  String get notSpecified => 'غير محدد';

  @override
  String get addToCart => 'أضف إلى السلة';

  @override
  String get addedToCart => 'تمت الإضافة إلى السلة';

  @override
  String get productNotFound => 'المنتج غير موجود';

  @override
  String get recentSearches => 'آخر عمليات البحث';

  @override
  String get clearAll => 'مسح الكل';

  @override
  String get mostSearched => 'الأكثر بحثًا';

  @override
  String get filterPrice => 'السعر';

  @override
  String get filterAvailability => 'التوفر';

  @override
  String get filterCategory => 'القسم';

  @override
  String get noResults => 'لا توجد نتائج';

  @override
  String get noResultsHint => 'جرّب كلمات بحث أخرى';

  @override
  String resultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count نتيجة',
      many: '$count نتيجة',
      few: '$count نتائج',
      two: 'نتيجتان',
      one: 'نتيجة واحدة',
      zero: 'لا توجد نتائج',
    );
    return '$_temp0';
  }

  @override
  String cartItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count منتج',
      many: '$count منتجًا',
      few: '$count منتجات',
      two: 'منتجان',
      one: 'منتج واحد',
    );
    return '$_temp0';
  }

  @override
  String get subtotal => 'المجموع الفرعي';

  @override
  String get deliveryFee => 'التوصيل';

  @override
  String get total => 'الإجمالي';

  @override
  String get proceedToPayment => 'متابعة إلى الدفع';

  @override
  String get cartEmptyTitle => 'سلتك فارغة';

  @override
  String get cartEmptyHint => 'أضف مستلزمات طبية إلى السلة وستظهر هنا';

  @override
  String get browseProducts => 'تصفّح المنتجات';

  @override
  String get maxQuantityReached => 'وصلت إلى أقصى كمية متاحة';
}
