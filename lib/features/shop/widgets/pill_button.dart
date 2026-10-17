import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// زر بشكل حبة (Pill): نص + أيقونة، شكل فقط.
/// الضغط يتكفل بيه من حواليه (مثلا PopupMenuButton).
class PillButton extends StatelessWidget {
  const PillButton({
    super.key,
    required this.label,
    required this.icon,
    this.active = false,
  });

  final String label;
  final IconData icon;
  final bool active; // مفعّل: لون بنفسجي

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: active ? AppColors.primaryLight : Colors.white,
      shape: StadiumBorder(
        side: BorderSide(
          color: active ? AppColors.primary : AppColors.primaryLight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: active ? AppColors.primary : AppColors.text,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              icon,
              size: 18,
              color: active ? AppColors.primary : AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}