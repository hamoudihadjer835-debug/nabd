import '../../../core/models/localized_text.dart';

/// طريقة توصيل (مثلا: ياليدين إلى المكتب).
class DeliveryOption {
  const DeliveryOption({
    required this.id,
    required this.name,
    required this.note,
  });

  final String id;
  final LocalizedText name;
  final LocalizedText note; // المدة والسعر
}

/// طريقة دفع.
class PaymentMethod {
  const PaymentMethod({
    required this.id,
    required this.name,
    required this.note,
  });

  final String id;
  final LocalizedText name;
  final LocalizedText note;
}