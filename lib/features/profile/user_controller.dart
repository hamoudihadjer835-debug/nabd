import 'package:flutter/foundation.dart';

/// بيانات المستخدم: الاسم والبريد والهاتف (في الذاكرة فقط دابا).
class UserController extends ChangeNotifier {
  String fullName = '';
  String email = '';
  String phone = '';

  void update({
    required String fullName,
    required String email,
    required String phone,
  }) {
    this.fullName = fullName;
    this.email = email;
    this.phone = phone;
    notifyListeners(); // نعلمو الشاشات (Profile) باش تتحدث
  }
}

/// نسخة وحيدة نستعملوها في كل التطبيق.
final UserController userController = UserController();