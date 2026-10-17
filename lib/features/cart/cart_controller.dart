import 'package:flutter/foundation.dart';

import '../shop/models/product.dart';

/// سطر في السلة: منتج + كمية.
class CartItem {
  const CartItem({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  /// سعر السطر = سعر القطعة × الكمية.
  int get lineTotal => product.price * quantity;

  CartItem copyWith({int? quantity}) =>
      CartItem(product: product, quantity: quantity ?? this.quantity);
}

/// السلة: تحفظ المنتجات وتعلم الشاشات كل ما تتبدل.
class CartController extends ChangeNotifier {
  /// رسوم التوصيل: قيمة مؤقتة من Figma. القواعد الحقيقية تحددوها أنتم.
  static const int deliveryFee = 600;

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  bool get isEmpty => _items.isEmpty;

  /// عدد الأسطر (المنتجات المختلفة) — هو لي يظهر في Figma: "3 منتجات".
  int get lineCount => _items.length;

  int get subtotal => _items.fold(0, (sum, item) => sum + item.lineTotal);
  int get delivery => _items.isEmpty ? 0 : deliveryFee;
  int get total => subtotal + delivery;

  /// يزيد قطعة. يرجع false إذا ما قدرش (المنتج نفد، أو وصلنا آخر المخزون).
  bool add(Product product) {
    if (product.status == ProductStatus.outOfStock) return false;

    final index = _items.indexWhere((i) => i.product.id == product.id);
    if (index == -1) {
      _items.add(CartItem(product: product, quantity: 1));
    } else {
      final item = _items[index];
      if (item.quantity >= product.stockQuantity) return false;
      _items[index] = item.copyWith(quantity: item.quantity + 1);
    }
    notifyListeners(); // نعلمو الشاشات
    return true;
  }

  void increase(String productId) {
    final index = _items.indexWhere((i) => i.product.id == productId);
    if (index == -1) return;
    final item = _items[index];
    if (item.quantity >= item.product.stockQuantity) return;
    _items[index] = item.copyWith(quantity: item.quantity + 1);
    notifyListeners();
  }

  /// ينقص قطعة، لكن ما ينزلش تحت 1 (للحذف نستعملو remove).
  void decrease(String productId) {
    final index = _items.indexWhere((i) => i.product.id == productId);
    if (index == -1) return;
    final item = _items[index];
    if (item.quantity <= 1) return;
    _items[index] = item.copyWith(quantity: item.quantity - 1);
    notifyListeners();
  }

  void remove(String productId) {
    _items.removeWhere((i) => i.product.id == productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

/// نسخة وحيدة من السلة نستعملوها في كل التطبيق.
final CartController cartController = CartController();