import 'package:flutter/foundation.dart';

import '../addresses/models/address.dart';
import '../cart/cart_controller.dart';
import '../checkout/models/checkout_options.dart';
import 'models/order.dart';

/// الطلبات (في الذاكرة فقط دابا). الأحدث في الأول.
class OrdersController extends ChangeNotifier {
  final List<Order> _orders = [];
  int _counter = 10485; // آخر رقم طلب (الجاي يكون 10486)

  List<Order> get orders => List.unmodifiable(_orders);

  Order? byId(String id) {
    for (final order in _orders) {
      if (order.id == id) return order;
    }
    return null;
  }

  /// ينشئ طلبا جديدا بحالة "قيد التأكيد".
  Order place({
    required List<CartItem> items,
    required Address address,
    required DeliveryOption delivery,
    required PaymentMethod payment,
    required int subtotal,
    required int deliveryFee,
  }) {
    final number = 'NBD-${++_counter}';

    final order = Order(
      id: number,
      number: number,
      createdAt: DateTime.now(),
      status: OrderStatus.pendingConfirmation,
      // ننسخو الأسطر الآن، قبل ما نفرغو السلة
      lines: [
        for (final item in items)
          OrderLine(product: item.product, quantity: item.quantity),
      ],
      address: address,
      deliveryOption: delivery,
      paymentMethod: payment,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
    );

    _orders.insert(0, order);
    notifyListeners();
    return order;
  }
}

/// نسخة وحيدة نستعملوها في كل التطبيق.
final OrdersController ordersController = OrdersController();