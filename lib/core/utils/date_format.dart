import 'package:flutter/widgets.dart';

const List<String> _monthsAr = [
  'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
  'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
];

const List<String> _monthsFr = [
  'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
  'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre',
];

const List<String> _monthsEn = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December',
];

/// تاريخ بأرقام غربية واسم الشهر بلغة التطبيق: 16 أكتوبر 2026
String formatDate(DateTime date, Locale locale) {
  final months = switch (locale.languageCode) {
    'ar' => _monthsAr,
    'fr' => _monthsFr,
    _ => _monthsEn,
  };
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}

/// تاريخ + ساعة: 12 أكتوبر 2026، 10:30
String formatDateTime(DateTime date, Locale locale) {
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');
  final separator = locale.languageCode == 'ar' ? '، ' : ', ';
  return '${formatDate(date, locale)}$separator$hour:$minute';
}