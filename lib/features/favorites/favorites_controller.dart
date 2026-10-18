import 'package:flutter/foundation.dart';

/// المفضلة: تحفظ أرقام المنتجات المفضلة وتعلم الشاشات كل ما تتبدل.
class FavoritesController extends ChangeNotifier {
  // Set: مجموعة بلا تكرار، يعني المنتج ما ينزادش مرتين
  final Set<String> _ids = {};

  bool isFavorite(String productId) => _ids.contains(productId);

  int get count => _ids.length;

  /// إذا كان في المفضلة نحيوه، وإذا ما كانش نزيدوه.
  void toggle(String productId) {
    if (!_ids.add(productId)) {
      _ids.remove(productId);
    }
    notifyListeners();
  }
}

/// نسخة وحيدة من المفضلة نستعملوها في كل التطبيق.
final FavoritesController favoritesController = FavoritesController();