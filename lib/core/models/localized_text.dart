import 'package:flutter/widgets.dart';

/// نص بثلاث لغات (مثلا اسم منتج). نختارو منو حسب لغة التطبيق.
class LocalizedText {
  const LocalizedText({required this.ar, required this.en, required this.fr});

  /// نص واحد لكل اللغات (مثلا اسم كتبو المستخدم بنفسو، وما يتترجمش).
  const LocalizedText.same(String value)
      : ar = value,
        en = value,
        fr = value;

  final String ar;
  final String en;
  final String fr;

  String of(Locale locale) {
    switch (locale.languageCode) {
      case 'ar':
        return ar;
      case 'fr':
        return fr;
      default:
        return en;
    }
  }
}