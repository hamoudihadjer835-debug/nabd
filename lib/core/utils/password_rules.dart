/// قوة كلمة السر.
enum PasswordStrength { none, weak, medium, strong }

/// قاعدة كلمة السر في كل التطبيق: 8 أحرف على الأقل، وحرف، ورقم.
/// نبدلو الأرقام هنا فقط وتتبدل في كل الشاشات.
class PasswordRules {
  PasswordRules._();

  static const int minLength = 8;

  // \p{L} = أي حرف من أي لغة (عربي، لاتيني...)
  static final RegExp _letter = RegExp(r'\p{L}', unicode: true);
  static final RegExp _digit = RegExp(r'\d');
  static final RegExp _symbol = RegExp(r'[^\p{L}\d\s]', unicode: true);

  static bool hasMinLength(String v) => v.length >= minLength;
  static bool hasLetter(String v) => _letter.hasMatch(v);
  static bool hasDigit(String v) => _digit.hasMatch(v);

  static bool isValid(String v) =>
      hasMinLength(v) && hasLetter(v) && hasDigit(v);

  /// ضعيفة: ما تحققتش الشروط. متوسطة: تحققت. قوية: تحققت وفيها رمز أو 12 حرف فما فوق.
  static PasswordStrength strengthOf(String v) {
    if (v.isEmpty) return PasswordStrength.none;
    if (!isValid(v)) return PasswordStrength.weak;
    if (v.length >= 12 || _symbol.hasMatch(v)) return PasswordStrength.strong;
    return PasswordStrength.medium;
  }
}