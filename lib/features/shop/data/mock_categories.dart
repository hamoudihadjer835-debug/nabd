import 'package:flutter/material.dart';

import '../../../core/models/localized_text.dart';
import '../models/category.dart';

/// بيانات تجريبية: الأسماء والأعداد للتجربة فقط.
/// نبدلوها ببيانات الـ Backend في المرحلة 6.
const List<Category> mockCategories = [
  Category(
    id: 'c1',
    name: LocalizedText(
      ar: 'أجهزة القياس',
      en: 'Measuring devices',
      fr: 'Appareils de mesure',
    ),
    icon: Icons.monitor_heart_outlined,
    productCount: 24,
  ),
  Category(
    id: 'c2',
    name: LocalizedText(
      ar: 'معدات الفحص',
      en: 'Examination equipment',
      fr: 'Matériel d’examen',
    ),
    icon: Icons.medical_services_outlined,
    productCount: 24,
  ),
  Category(
    id: 'c3',
    name: LocalizedText(
      ar: 'العناية بالجروح',
      en: 'Wound care',
      fr: 'Soins des plaies',
    ),
    icon: Icons.healing_outlined,
    productCount: 24,
  ),
  Category(
    id: 'c4',
    name: LocalizedText(
      ar: 'المستلزمات الطبية',
      en: 'Medical supplies',
      fr: 'Fournitures médicales',
    ),
    icon: Icons.inventory_2_outlined,
    productCount: 24,
  ),
];