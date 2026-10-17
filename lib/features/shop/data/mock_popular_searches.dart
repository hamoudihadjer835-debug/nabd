import '../../../core/models/localized_text.dart';

/// كلمات "الأكثر بحثًا" (تجريبية).
/// الكلمة الأولى تطابق منتجات تجريبية باش نشوفو نتائج، والباقي تعطي "لا توجد نتائج".
const List<LocalizedText> mockPopularSearches = [
  LocalizedText(
    ar: 'جهاز قياس الضغط',
    en: 'Blood pressure monitor',
    fr: 'Tensiomètre',
  ),
  LocalizedText(ar: 'ميزان حرارة', en: 'Thermometer', fr: 'Thermomètre'),
  LocalizedText(
    ar: 'الإسعافات الأولية',
    en: 'First aid',
    fr: 'Premiers secours',
  ),
  LocalizedText(ar: 'قفازات', en: 'Gloves', fr: 'Gants'),
];