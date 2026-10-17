import 'package:flutter/material.dart';

/// اللغة الحالية للتطبيق. أي شاشة تبدل القيمة، والتطبيق كامل يتحدث تلقائيا.
/// الافتراضي دابا: العربية (نزيدو زر تغيير اللغة في Profile).
final ValueNotifier<Locale> appLocale =
    ValueNotifier<Locale>(const Locale('ar'));