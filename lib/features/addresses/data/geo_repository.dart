import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../../../core/models/localized_text.dart';
import '../models/algeria_geo.dart';

/// يقرا الولايات والبلديات من ملف assets/data/algeria_geo.json.
/// مع الـ Backend نبدلو المصدر (من الخادم) وما نغيروش الشاشات.
class GeoRepository {
  List<Wilaya> _wilayas = const [];

  List<Wilaya> get wilayas => _wilayas;
  bool get isLoaded => _wilayas.isNotEmpty;

  /// نناديو عليها مرة وحدة عند بداية التطبيق.
  Future<void> load() async {
    if (isLoaded) return;

    final raw = await rootBundle.loadString('assets/data/algeria_geo.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;

    _wilayas = [
      for (final w in data['wilayas'] as List<dynamic>)
        _parseWilaya(w as Map<String, dynamic>),
    ];
  }

  Wilaya _parseWilaya(Map<String, dynamic> json) {
    return Wilaya(
      id: json['id'] as String,
      name: _name(json),
      communes: [
        for (final c in json['communes'] as List<dynamic>)
          Commune(
            id: (c as Map<String, dynamic>)['id'] as String,
            name: _name(c),
          ),
      ],
    );
  }

  // الإنجليزية: نستعملو الاسم اللاتيني (الفرنسي)، لأن البيانات فيها عربي وفرنسي فقط
  LocalizedText _name(Map<String, dynamic> json) {
    return LocalizedText(
      ar: json['ar'] as String,
      en: json['fr'] as String,
      fr: json['fr'] as String,
    );
  }

  Wilaya? wilayaById(String id) =>
      _wilayas.where((w) => w.id == id).firstOrNull;
}

/// نسخة وحيدة نستعملوها في كل التطبيق.
final GeoRepository geoRepository = GeoRepository();