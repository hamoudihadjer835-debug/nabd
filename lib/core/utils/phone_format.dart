import 'package:flutter/services.dart';

/// يكتب الأرقام بالشكل: 0555 12 34 56 (للعرض فقط. القيمة المحفوظة أرقام صافية).
String groupPhoneDigits(String digits) {
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i == 4 || i == 6 || i == 8) buffer.write(' ');
    buffer.write(digits[i]);
  }
  return buffer.toString();
}

/// يطبق التنسيق أثناء الكتابة: أرقام فقط، 10 كحد أقصى، وفراغات تلقائية.
class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length > 10) digits = digits.substring(0, 10);

    final text = groupPhoneDigits(digits);
    return TextEditingValue(
      text: text,
      // المؤشر دايما في الآخر (تبسيط)
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}