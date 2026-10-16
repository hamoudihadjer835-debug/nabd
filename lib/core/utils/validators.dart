/// دوال التحقق من المدخلات (نستعملوها في Login وSign Up).
class Validators {
  Validators._();

  // نمط البريد: شيء@شيء.شيء بلا مسافات
  static final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  // نمط الهاتف: + اختياري، ثم 8 إلى 15 رقم
  static final RegExp _phone = RegExp(r'^\+?\d{8,15}$');

  static bool isEmail(String value) => _email.hasMatch(value.trim());

  static bool isPhone(String value) {
    final cleaned = value.replaceAll(RegExp(r'[\s-]'), ''); // نحيو المسافات والشرطات
    return _phone.hasMatch(cleaned);
  }

  static bool isEmailOrPhone(String value) => isEmail(value) || isPhone(value);
}