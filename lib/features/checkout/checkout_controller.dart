import 'package:flutter/foundation.dart';

import 'data/mock_checkout_options.dart';
import 'models/checkout_options.dart';

/// اختيارات المستخدم في Checkout: طريقة التوصيل وطريقة الدفع.
class CheckoutController extends ChangeNotifier {
  String deliveryId = mockDeliveryOptions.first.id;
  String paymentId = mockPaymentMethods.first.id;

  DeliveryOption get selectedDelivery => mockDeliveryOptions.firstWhere(
        (o) => o.id == deliveryId,
        orElse: () => mockDeliveryOptions.first,
      );

  PaymentMethod get selectedPayment => mockPaymentMethods.firstWhere(
        (m) => m.id == paymentId,
        orElse: () => mockPaymentMethods.first,
      );

  void selectDelivery(String id) {
    deliveryId = id;
    notifyListeners();
  }

  void selectPayment(String id) {
    paymentId = id;
    notifyListeners();
  }
}

/// نسخة وحيدة نستعملوها في كل التطبيق.
final CheckoutController checkoutController = CheckoutController();