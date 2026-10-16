import 'package:flutter/material.dart';

/// اللغة الحالية للتطبيق. أي شاشة تبدل القيمة، والتطبيق كامل يتحدث تلقائيا.
/// الافتراضي: الإنجليزية.
final ValueNotifier<Locale> appLocale =
    ValueNotifier<Locale>(const Locale('en'));