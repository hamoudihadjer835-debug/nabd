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
    this.imageAsset,
  });

  final String id;
  final String categoryId; // القسم لي ينتمي له المنتج (نفس id في Category)
  final LocalizedText name;
  final int price; // بالدينار الجزائري (DA)
  final ProductStatus status;

  /// مسار صورة المنتج (null دابا → نعرضو أيقونة مكان الصورة).
  final String? imageAsset;
}