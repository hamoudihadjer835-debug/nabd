import 'package:flutter/foundation.dart';

import 'data/mock_notifications.dart';

/// حالة القراءة: أي إشعارات تعلمت كمقروءة.
class NotificationsController extends ChangeNotifier {
  // نبدأو بالإشعارات لي isRead = true في البيانات
  final Set<String> _readIds = {
    for (final n in mockNotifications)
      if (n.isRead) n.id,
  };

  bool isRead(String id) => _readIds.contains(id);

  /// عدد غير المقروء (نستعملوه لاحقا لشارة على أيقونة).
  int get unreadCount =>
      mockNotifications.where((n) => !_readIds.contains(n.id)).length;

  void markRead(String id) {
    if (_readIds.add(id)) notifyListeners(); // add ترجع true إذا كان جديد
  }
}

/// نسخة وحيدة نستعملوها في كل التطبيق.
final NotificationsController notificationsController =
    NotificationsController();