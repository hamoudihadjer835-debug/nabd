import 'package:flutter/foundation.dart';

import '../../core/models/localized_text.dart';
import '../addresses/models/address.dart';
import '../cart/cart_controller.dart';
import '../checkout/data/mock_checkout_options.dart';
import '../checkout/models/checkout_options.dart';
import '../shop/data/mock_products.dart';
import 'models/order.dart';

/// الطلبات (في الذاكرة فقط دابا). الأحدث في الأول.
class OrdersController extends ChangeNotifier {
  final List<Order> _orders = _seedOrders();
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

  // ---------- بيانات تجريبية (من Figma) ----------
  // مع الـ Backend تجي الطلبات وحالاتها من الخادم.

  static const Address _seedAddress = Address(
    id: 'seed',
    label: LocalizedText(ar: 'المنزل', en: 'Home', fr: 'Domicile'),
    wilayaId: 'w16',
    communeId: 'c514',
    details: LocalizedText(
      ar: '[الشارع / الحي]',
      en: '[Street / Neighborhood]',
      fr: '[Rue / Quartier]',
    ),
    phone: '0555000000',
  );

  static Order _seed({
    required String number,
    required OrderStatus status,
    required DateTime createdAt,
    required List<OrderLine> lines,
    Map<int, DateTime> stepTimes = const {},
  }) {
    final subtotal = lines.fold<int>(0, (sum, line) => sum + line.total);
    return Order(
      id: number,
      number: number,
      createdAt: createdAt,
      status: status,
      lines: lines,
      address: _seedAddress,
      deliveryOption: mockDeliveryOptions[1],
      paymentMethod: mockPaymentMethods.first,
      subtotal: subtotal,
      deliveryFee: CartController.deliveryFee,
      stepTimes: stepTimes,
    );
  }

  static List<Order> _seedOrders() {
    final p = mockProducts;

    return [
      _seed(
        number: 'NBD-10485',
        status: OrderStatus.pendingConfirmation,
        createdAt: DateTime(2026, 10, 16, 10, 30),
        lines: [
          OrderLine(product: p[0], quantity: 1),
          OrderLine(product: p[1], quantity: 1),
          OrderLine(product: p[3], quantity: 1),
        ],
      ),
      _seed(
        number: 'NBD-10483',
        status: OrderStatus.preparing,
        createdAt: DateTime(2026, 10, 13, 9, 15),
        lines: [
          OrderLine(product: p[0], quantity: 1),
          OrderLine(product: p[3], quantity: 1),
        ],
        stepTimes: {
          0: DateTime(2026, 10, 13, 9, 15),
          1: DateTime(2026, 10, 13, 14, 10),
        },
      ),
      _seed(
        number: 'NBD-10482',
        status: OrderStatus.shipped,
        createdAt: DateTime(2026, 10, 12, 10, 30),
        lines: [
          OrderLine(product: p[0], quantity: 1),
          OrderLine(product: p[1], quantity: 2),
          OrderLine(product: p[3], quantity: 1),
        ],
        stepTimes: {
          0: DateTime(2026, 10, 12, 10, 30),
          1: DateTime(2026, 10, 12, 14, 10),
          2: DateTime(2026, 10, 13, 9, 0),
        },
      ),
      _seed(
        number: 'NBD-10478',
        status: OrderStatus.delivered,
        createdAt: DateTime(2026, 10, 5, 11, 0),
        lines: [OrderLine(product: p[1], quantity: 1)],
        stepTimes: {
          0: DateTime(2026, 10, 5, 11, 0),
          1: DateTime(2026, 10, 5, 15, 30),
          2: DateTime(2026, 10, 6, 9, 0),
          3: DateTime(2026, 10, 7, 13, 45),
        },
      ),
    ];
  }
}

/// نسخة وحيدة نستعملوها في كل التطبيق.
final OrdersController ordersController = OrdersController();