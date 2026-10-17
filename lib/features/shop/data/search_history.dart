import 'package:flutter/foundation.dart';

/// آخر عمليات البحث (في الذاكرة فقط دابا: تضيع كي نغلقو التطبيق).
/// القيم الأولى تجريبية من Figma. نحفظوها في التلفون لاحقا.
final ValueNotifier<List<String>> recentSearches =
    ValueNotifier<List<String>>([
  'جهاز قياس الضغط',
  'ميزان حرارة رقمي',
  'قفازات طبية',
  'كمامات طبية',
]);

/// نزيدو بحث جديد في الأول (ونحيو تكراره)، ونخلو 8 كحد أقصى.
void addRecentSearch(String query) {
  final q = query.trim();
  if (q.isEmpty) return;
  final list = [...recentSearches.value]..removeWhere((e) => e == q);
  list.insert(0, q);
  recentSearches.value = list.take(8).toList();
}

void removeRecentSearch(String query) {
  recentSearches.value =
      recentSearches.value.where((e) => e != query).toList();
}

void clearRecentSearches() => recentSearches.value = [];