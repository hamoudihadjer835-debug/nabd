import 'package:flutter/widgets.dart';

import '../../core/models/localized_text.dart';
import 'data/geo_repository.dart';
import 'models/address.dart';

/// العناوين: القائمة + العنوان الافتراضي (في الذاكرة فقط دابا).
class AddressesController extends ChangeNotifier {
  // عناوين تجريبية (كما في Figma) بثلاث لغات. مع الـ Backend تجي من الخادم.
  final List<Address> _items = [
    const Address(
      id: 'a1',
      label: LocalizedText(ar: 'المنزل', en: 'Home', fr: 'Domicile'),
      wilayaId: 'w16', // الجزائر
      communeId: 'c514', // الجزائر الوسطى
      details: LocalizedText(
        ar: '[الشارع / الحي]',
        en: '[Street / Neighborhood]',
        fr: '[Rue / Quartier]',
      ),
      phone: '0555000000',
    ),
    const Address(
      id: 'a2',
      label: LocalizedText(ar: 'العمل', en: 'Work', fr: 'Travail'),
      wilayaId: 'w9', // البليدة
      communeId: 'c259', // البليدة
      details: LocalizedText(
        ar: '[الشارع / الحي]',
        en: '[Street / Neighborhood]',
        fr: '[Rue / Quartier]',
      ),
      phone: '0555000000',
    ),
    const Address(
      id: 'a3',
      label: LocalizedText(
        ar: 'عنوان العائلة',
        en: 'Family address',
        fr: 'Adresse de la famille',
      ),
      wilayaId: 'w31', // وهران
      communeId: 'c996', // وهران
      details: LocalizedText(
        ar: '[الشارع / الحي]',
        en: '[Street / Neighborhood]',
        fr: '[Rue / Quartier]',
      ),
      phone: '0555000000',
    ),
  ];

  String? _defaultId = 'a1';
  int _counter = 3;

  List<Address> get items => List.unmodifiable(_items);

  Address? get defaultAddress {
    for (final address in _items) {
      if (address.id == _defaultId) return address;
    }
    return null;
  }

  bool isDefault(String id) => id == _defaultId;

  /// رقم جديد لعنوان جديد.
  String nextId() => 'a${++_counter}';

  void setDefault(String id) {
    _defaultId = id;
    notifyListeners();
  }

  /// يزيد عنوان. أول عنوان (أو إذا ما كانش افتراضي) يصير افتراضي تلقائيا.
  void add(Address address, {required bool makeDefault}) {
    _items.add(address);
    if (makeDefault || _defaultId == null) _defaultId = address.id;
    notifyListeners();
  }
}

/// نسخة وحيدة نستعملوها في كل التطبيق.
final AddressesController addressesController = AddressesController();

/// نص العنوان للعرض: "الشارع، البلدية، الولاية" حسب لغة التطبيق.
String addressLine(Address address, Locale locale) {
  final wilaya = geoRepository.wilayaById(address.wilayaId);
  final commune =
      wilaya?.communes.where((c) => c.id == address.communeId).firstOrNull;
  final separator = locale.languageCode == 'ar' ? '، ' : ', ';

  return [
    address.details.of(locale),
    commune?.name.of(locale),
    wilaya?.name.of(locale),
  ].whereType<String>().where((part) => part.isNotEmpty).join(separator);
}