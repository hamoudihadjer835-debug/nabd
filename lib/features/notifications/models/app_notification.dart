import '../../../core/models/localized_text.dart';

/// نوع الإشعار (يحدد الأيقونة).
enum NotificationType {
  shipped,
  preparing,
  confirmed,
  backInStock,
  addressSaved,
  welcome,
}

/// إشعار واحد.
class AppNotification {
  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.timeLabel,
    this.isRead = false,
  });

  final String id;
  final NotificationType type;
  final LocalizedText title;
  final LocalizedText body;

  /// نص الوقت جاهز (مثلا "منذ ساعة"). مع الـ Backend نحسبوه من التاريخ.
  final LocalizedText timeLabel;

  /// القيمة الأولى (قبل ما المستخدم يفتح الإشعار).
  final bool isRead;
}