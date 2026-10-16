import 'package:flutter/widgets.dart';

/// نص بثلاث لغات (مثلا اسم منتج). نختارو منو حسب لغة التطبيق.
class LocalizedText {
  const LocalizedText({required this.ar, required this.en, required this.fr});

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