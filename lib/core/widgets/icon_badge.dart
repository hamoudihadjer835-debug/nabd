import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// دائرة بنفسجية فاتحة فيها أيقونة (تظهر في أعلى شاشات Forgot Password وVerify Code).
class IconBadge extends StatelessWidget {
  const IconBadge({super.key, required this.icon, this.size = 72});

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.primaryLight,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: size * 0.44, color: AppColors.primary),
    );
  }
}