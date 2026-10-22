import '../../../core/models/localized_text.dart';

/// عنوان توصيل واحد.
class Address {
  const Address({
    required this.id,
    required this.label,
    required this.wilayaId,
    required this.communeId,
    required this.details,
    required this.phone,
  });

  final String id;
  final LocalizedText label; // اسم العنوان (مثلا: المنزل)
  final String wilayaId;
  final String communeId;
  final LocalizedText details; // الشارع، الحي، رقم البناية
  final String phone; // أرقام صافية
}