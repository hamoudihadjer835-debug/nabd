import '../models/product.dart';
import 'mock_products.dart';

/// بحث تجريبي في المنتجات التجريبية. في المرحلة 6 نبدلوه بطلب للـ Backend.
List<Product> searchProducts(String query) {
  final words = _normalize(query)
      .split(RegExp(r'\s+'))
      .where((w) => w.isNotEmpty)
      // نحيو "ال" التعريف من بداية الكلمة: الضغط ← ضغط
      .map((w) => (w.startsWith('ال') && w.length > 3) ? w.substring(2) : w)
      .toList();

  if (words.isEmpty) return [];

  return mockProducts.where((product) {
    // نبحثو في الأسماء الثلاثة (عربي وإنجليزي وفرنسي) مرة وحدة
    final haystack = _normalize(
      '${product.name.ar} ${product.name.en} ${product.name.fr}',
    );
    // المنتج يطابق إذا كل كلمات البحث موجودة في اسمه
    return words.every((word) => haystack.contains(word));
  }).toList();
}

/// توحيد النص قبل المقارنة: حروف صغيرة، بلا تشكيل، وتوحيد بعض الحروف.
String _normalize(String input) {
  var s = input.toLowerCase().trim();
  s = s.replaceAll(RegExp(r'[\u064B-\u065F\u0670]'), ''); // التشكيل
  s = s
      .replaceAll(RegExp('[أإآ]'), 'ا')
      .replaceAll('ة', 'ه')
      .replaceAll('ى', 'ي');

  const accents = {
    'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
    'à': 'a', 'â': 'a',
    'î': 'i', 'ï': 'i',
    'ô': 'o',
    'û': 'u', 'ù': 'u', 'ü': 'u',
    'ç': 'c',
  };
  accents.forEach((accented, plain) => s = s.replaceAll(accented, plain));
  return s;
}