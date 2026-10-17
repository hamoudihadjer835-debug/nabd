import 'package:flutter/widgets.dart';

import '../../../core/models/localized_text.dart';

/// قسم من أقسام المتجر (مثل: أجهزة القياس).
class Category {
  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.productCount,
  });

  final String id;
  final LocalizedText name;
  final IconData icon;
  final int productCount;
}