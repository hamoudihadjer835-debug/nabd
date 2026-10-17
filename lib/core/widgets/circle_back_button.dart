import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// زر الرجوع الدائري الأبيض (كما في Figma). السهم يتبع الاتجاه تلقائيا.
class CircleBackButton extends StatelessWidget {
  const CircleBackButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.arrow_back_rounded,
            size: 20,
            color: AppColors.text,
          ),
        ),
      ),
    );
  }
}