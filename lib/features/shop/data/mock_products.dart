import '../../../core/models/localized_text.dart';
import '../models/product.dart';

/// بيانات تجريبية (Mock Data): الأسماء والأسعار للتجربة فقط.
/// نبدلوها ببيانات الـ Backend في المرحلة 6.
const List<Product> mockProducts = [
  Product(
    id: 'p1',
    categoryId: 'c1',
    name: LocalizedText(
      ar: 'جهاز قياس ضغط الدم الرقمي',
      en: 'Digital blood pressure monitor',
      fr: 'Tensiomètre numérique',
    ),
    price: 4500,
    status: ProductStatus.available,
  ),
  Product(
    id: 'p2',
    categoryId: 'c1',
    name: LocalizedText(
      ar: 'جهاز قياس ضغط الدم المعصم',
      en: 'Wrist blood pressure monitor',
      fr: 'Tensiomètre de poignet',
    ),
    price: 3900,
    status: ProductStatus.limited,
  ),
  Product(
    id: 'p3',
    categoryId: 'c1',
    name: LocalizedText(
      ar: 'جهاز قياس ضغط الدم الناطق',
      en: 'Talking blood pressure monitor',
      fr: 'Tensiomètre parlant',
    ),
    price: 6800,
    status: ProductStatus.outOfStock,
  ),
  Product(
    id: 'p4',
    categoryId: 'c1',
    name: LocalizedText(
      ar: 'جهاز قياس ضغط الدم المنزلي',
      en: 'Home blood pressure monitor',
      fr: 'Tensiomètre domestique',
    ),
    price: 5200,
    status: ProductStatus.available,
  ),
];