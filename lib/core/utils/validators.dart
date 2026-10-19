/// دوال التحقق من المدخلات (نستعملوها في Login وSign Up وغيرها).
class Validators {
  Validators._();

  // نمط البريد: شيء@شيء.شيء بلا مسافات
  static final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  // نمط الهاتف العام: + اختياري، ثم 8 إلى 15 رقم
  static final RegExp _phone = RegExp(r'^\+?\d{8,15}$');

  // الهاتف المحمول الجزائري: 10 أرقام، تبدأ بـ 05 أو 06 أو 07
  static final RegExp _algerianMobile = RegExp(r'^0[567]\d{8}$');

  static bool isEmail(String value) => _email.hasMatch(value.trim());

  static bool isPhone(String value) {
    final cleaned = value.replaceAll(RegExp(r'[\s-]'), ''); // نحيو المسافات والشرطات
    return _phone.hasMatch(cleaned);
  }

  static bool isEmailOrPhone(String value) => isEmail(value) || isPhone(value);

  /// يستقبل الأرقام فقط (بلا مسافات). مثال صحيح: 0555123456
  static bool isAlgerianMobile(String digits) =>
      _algerianMobile.hasMatch(digits);
}