import '../../../core/models/localized_text.dart';
import '../models/algeria_geo.dart';

/// بيانات تجريبية: 5 ولايات وبعض بلدياتها (أسماء حقيقية للتجربة فقط).
/// القائمة الحقيقية (69 ولاية وأكثر من 1500 بلدية) تجي من الـ Backend
/// من مصدر رسمي، لأنها تتبدل مع التنظيم الإقليمي الجديد.
const List<Wilaya> mockWilayas = [
  Wilaya(
    id: 'alger',
    name: LocalizedText(ar: 'الجزائر', en: 'Algiers', fr: 'Alger'),
    communes: [
      Commune(
        id: 'alger-centre',
        name: LocalizedText(
          ar: 'الجزائر الوسطى',
          en: 'Algiers Centre',
          fr: 'Alger Centre',
        ),
      ),
      Commune(
        id: 'bab-el-oued',
        name: LocalizedText(
          ar: 'باب الوادي',
          en: 'Bab El Oued',
          fr: 'Bab El Oued',
        ),
      ),
      Commune(
        id: 'hussein-dey',
        name: LocalizedText(
          ar: 'حسين داي',
          en: 'Hussein Dey',
          fr: 'Hussein Dey',
        ),
      ),
    ],
  ),
  Wilaya(
    id: 'blida',
    name: LocalizedText(ar: 'البليدة', en: 'Blida', fr: 'Blida'),
    communes: [
      Commune(
        id: 'blida-centre',
        name: LocalizedText(ar: 'البليدة', en: 'Blida', fr: 'Blida'),
      ),
      Commune(
        id: 'boufarik',
        name: LocalizedText(ar: 'بوفاريك', en: 'Boufarik', fr: 'Boufarik'),
      ),
      Commune(
        id: 'mouzaia',
        name: LocalizedText(ar: 'موزاية', en: 'Mouzaia', fr: 'Mouzaïa'),
      ),
    ],
  ),
  Wilaya(
    id: 'oran',
    name: LocalizedText(ar: 'وهران', en: 'Oran', fr: 'Oran'),
    communes: [
      Commune(
        id: 'oran-centre',
        name: LocalizedText(ar: 'وهران', en: 'Oran', fr: 'Oran'),
      ),
      Commune(
        id: 'es-senia',
        name: LocalizedText(ar: 'السانية', en: 'Es Senia', fr: 'Es Sénia'),
      ),
      Commune(
        id: 'bir-el-djir',
        name: LocalizedText(
          ar: 'بئر الجير',
          en: 'Bir El Djir',
          fr: 'Bir El Djir',
        ),
      ),
    ],
  ),
  Wilaya(
    id: 'constantine',
    name: LocalizedText(ar: 'قسنطينة', en: 'Constantine', fr: 'Constantine'),
    communes: [
      Commune(
        id: 'constantine-centre',
        name: LocalizedText(
          ar: 'قسنطينة',
          en: 'Constantine',
          fr: 'Constantine',
        ),
      ),
      Commune(
        id: 'el-khroub',
        name: LocalizedText(ar: 'الخروب', en: 'El Khroub', fr: 'El Khroub'),
      ),
      Commune(
        id: 'hamma-bouziane',
        name: LocalizedText(
          ar: 'حامة بوزيان',
          en: 'Hamma Bouziane',
          fr: 'Hamma Bouziane',
        ),
      ),
    ],
  ),
  Wilaya(
    id: 'tipaza',
    name: LocalizedText(ar: 'تيبازة', en: 'Tipaza', fr: 'Tipaza'),
    communes: [
      Commune(
        id: 'tipaza-centre',
        name: LocalizedText(ar: 'تيبازة', en: 'Tipaza', fr: 'Tipaza'),
      ),
      Commune(
        id: 'kolea',
        name: LocalizedText(ar: 'القليعة', en: 'Koléa', fr: 'Koléa'),
      ),
      Commune(
        id: 'cherchell',
        name: LocalizedText(ar: 'شرشال', en: 'Cherchell', fr: 'Cherchell'),
      ),
    ],
  ),
];