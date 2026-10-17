import '../../../core/models/localized_text.dart';

/// حالة توفر المنتج.
enum ProductStatus { available, limited, outOfStock }

/// منتج واحد في المتجر.
class Product {
  const Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.status,
    required this.sku,
    required this.stockQuantity,
    this.manufacturer,
    this.intendedUse,
    this.certification,
    this.imageAsset,
  });

  final String id;
  final String categoryId; // القسم لي ينتمي له المنتج (نفس id في Category)
  final LocalizedText name;
  final int price; // بالدينار الجزائري (DA)
  final ProductStatus status;

  final String sku; // رقم المنتج
  final int stockQuantity; // الكمية المتبقية

  // معلومات يمكن التحقق منها (null = غير محدد):
  final String? manufacturer; // اسم الشركة المصنّعة
  final LocalizedText? intendedUse; // الاستعمال المقصود
  final String? certification; // رقم الشهادة

  /// مسار صورة المنتج (null دابا → نعرضو أيقونة مكان الصورة).
  final String? imageAsset;
}