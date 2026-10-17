import '../../../core/models/localized_text.dart';
import '../models/product.dart';

/// بيانات تجريبية (Mock Data): الأسماء والأسعار والكميات للتجربة فقط.
/// الشركة المصنّعة والشهادة فارغتان عمدا: لازم تتعوض ببيانات موثقة
/// من المصنّع قبل الإطلاق (ما نخترعوش أسماء ولا أرقام شهادات).
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
    sku: 'NBD-0001',
    stockQuantity: 12,
    intendedUse: LocalizedText(
      ar: 'قياس ضغط الدم المنزلي',
      en: 'Home blood pressure measurement',
      fr: 'Mesure de la tension artérielle à domicile',
    ),
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
    sku: 'NBD-0002',
    stockQuantity: 3,
    intendedUse: LocalizedText(
      ar: 'قياس ضغط الدم عند المعصم',
      en: 'Wrist blood pressure measurement',
      fr: 'Mesure de la tension artérielle au poignet',
    ),
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
    sku: 'NBD-0003',
    stockQuantity: 0,
    intendedUse: LocalizedText(
      ar: 'قياس ضغط الدم المنزلي',
      en: 'Home blood pressure measurement',
      fr: 'Mesure de la tension artérielle à domicile',
    ),
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
    sku: 'NBD-0004',
    stockQuantity: 20,
    intendedUse: LocalizedText(
      ar: 'قياس ضغط الدم المنزلي',
      en: 'Home blood pressure measurement',
      fr: 'Mesure de la tension artérielle à domicile',
    ),
  ),
];