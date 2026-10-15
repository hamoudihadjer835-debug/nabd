import 'package:flutter/material.dart';

/// استدارة الزوايا — نفس قيم Figma (Radius/card وRadius/button).
class AppRadius {
  AppRadius._();

  static const double card = 16;
  static const double button = 12;

  // جاهزة للاستعمال مباشرة داخل Container وCard
  static final BorderRadius cardBorder = BorderRadius.circular(card);
  static final BorderRadius buttonBorder = BorderRadius.circular(button);
}

/// المسافات — شبكة 8px.
class AppSpacing {
  AppSpacing._();

  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}