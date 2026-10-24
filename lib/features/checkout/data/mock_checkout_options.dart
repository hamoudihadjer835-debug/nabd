import '../../../core/models/localized_text.dart';
import '../models/checkout_options.dart';

// بيانات تجريبية: المدة والسعر الحقيقيان يجيو من شركة التوصيل عبر الـ Backend.
const LocalizedText _deliveryNote = LocalizedText(
  ar: 'المدة والسعر يُحدّدان لاحقًا',
  en: 'Duration and price to be set later',
  fr: 'Durée et prix à définir ultérieurement',
);

const List<DeliveryOption> mockDeliveryOptions = [
  DeliveryOption(
    id: 'yalidine-desk',
    name: LocalizedText(
      ar: 'ياليدين — الاستلام من المكتب (Stop Desk)',
      en: 'Yalidine — pickup at the office (Stop Desk)',
      fr: 'Yalidine — retrait au bureau (Stop Desk)',
    ),
    note: _deliveryNote,
  ),
  DeliveryOption(
    id: 'yalidine-home',
    name: LocalizedText(
      ar: 'ياليدين — التوصيل إلى المنزل',
      en: 'Yalidine — home delivery',
      fr: 'Yalidine — livraison à domicile',
    ),
    note: _deliveryNote,
  ),
];

// طرق الدفع نائبة (كما في Figma): تحدد لاحقا.
const LocalizedText _paymentNote = LocalizedText(
  ar: 'تُضاف عند اعتمادها',
  en: 'Added once approved',
  fr: 'Ajouté une fois approuvé',
);

const List<PaymentMethod> mockPaymentMethods = [
  PaymentMethod(
    id: 'pay1',
    name: LocalizedText(
      ar: '[طريقة الدفع 1]',
      en: '[Payment method 1]',
      fr: '[Mode de paiement 1]',
    ),
    note: _paymentNote,
  ),
  PaymentMethod(
    id: 'pay2',
    name: LocalizedText(
      ar: '[طريقة الدفع 2]',
      en: '[Payment method 2]',
      fr: '[Mode de paiement 2]',
    ),
    note: _paymentNote,
  ),
  PaymentMethod(
    id: 'pay3',
    name: LocalizedText(
      ar: '[طريقة الدفع 3]',
      en: '[Payment method 3]',
      fr: '[Mode de paiement 3]',
    ),
    note: _paymentNote,
  ),
];