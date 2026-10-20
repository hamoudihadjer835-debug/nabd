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
  final String label; // الاسم لي كتبو المستخدم (مثلا: المنزل)
  final String wilayaId;
  final String communeId;
  final String details; // الشارع، الحي، رقم البناية
  final String phone; // أرقام صافية
}