import '../../addresses/models/address.dart';
import '../../checkout/models/checkout_options.dart';
import '../../shop/models/product.dart';

/// حالة الطلب (كما في Figma).
enum OrderStatus {
  pendingConfirmation, // قيد التأكيد
  preparing, // قيد التحضير
  shipped, // تم الشحن
  delivered, // تم التسليم
  cancelled, // أُلغي
}

/// سطر في الطلب: نسخة من المنتج والكمية وقت الشراء.
class OrderLine {
  const OrderLine({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  int get total => product.price * quantity;
}

/// طلب واحد.
class Order {
  const Order({
    required this.id,
    required this.number,
    required this.createdAt,
    required this.status,
    required this.lines,
    required this.address,
    required this.deliveryOption,
    required this.paymentMethod,
    required this.subtotal,
    required this.deliveryFee,
    this.stepTimes = const {},
  });

  final String id;
  final String number; // مثلا NBD-10486
  final DateTime createdAt;
  final OrderStatus status;
  final List<OrderLine> lines;
  final Address address;
  final DeliveryOption deliveryOption;
  final PaymentMethod paymentMethod;
  final int subtotal;
  final int deliveryFee;

  /// وقت وصول الطلب لكل خطوة في الخط الزمني:
  /// 0 تأكيد، 1 تحضير، 2 شحن، 3 تسليم. (الخطوة غير الموجودة = لسا ما وصلتش)
  final Map<int, DateTime> stepTimes;

  int get total => subtotal + deliveryFee;

  /// الطلبات "الحالية" (ماشي منتهية).
  bool get isCurrent =>
      status == OrderStatus.pendingConfirmation ||
      status == OrderStatus.preparing ||
      status == OrderStatus.shipped;
}