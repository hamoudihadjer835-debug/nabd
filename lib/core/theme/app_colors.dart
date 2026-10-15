import 'package:flutter/material.dart';

/// ألوان تطبيق Nabd (نبض) — مأخوذة من تصميم Figma.
/// نستعمل هذا الملف فقط، ولا نكتب أي لون مباشرة في الشاشات.
class AppColors {
  AppColors._(); // يمنع إنشاء نسخة من الكلاس، لأننا نستعمله فقط كحاوية للألوان

  // البنفسجي (Primary)
  static const Color primary = Color(0xFF5B4BDB);
  static const Color primaryDark = Color(0xFF3F32B0);
  static const Color primaryLight = Color(0xFFEDEAFF);

  // النعناعي (Accent Mint)
  static const Color accentMint = Color(0xFF3DDBB0);

  // الخلفية والنصوص
  static const Color background = Color(0xFFF7F6FF);
  static const Color text = Color(0xFF1B1B2F);
  static const Color textMuted = Color(0xFF6B6B85);

  // ألوان الحالات (Status)
  static const Color success = Color(0xFF22A06B);
  static const Color warning = Color(0xFFF5A524);
  static const Color error = Color(0xFFE5484D);
}