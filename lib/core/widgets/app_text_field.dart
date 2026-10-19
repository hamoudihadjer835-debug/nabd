import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';

/// حقل إدخال بتصميم Nabd: عنوان فوقو، خلفية بيضاء، زوايا 12.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.suffixIcon,
    this.inputFormatters,
    this.onChanged,
    this.enabled = true,
    this.ltrInput = false,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  /// للبريد والأرقام: النص من اليسار لليمين (باش ما ينعكسش ترتيبو في العربية)،
  /// لكن محاذاتو تبقى مع اتجاه الواجهة.
  final bool ltrInput;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    OutlineInputBorder border(Color color, [double width = 1]) {
      return OutlineInputBorder(
        borderRadius: AppRadius.buttonBorder,
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          enabled: enabled,
          // كلمات السر: بلا تصحيح تلقائي ولا اقتراحات
          autocorrect: !obscureText,
          enableSuggestions: !obscureText,
          textDirection: ltrInput ? TextDirection.ltr : null,
          textAlign: ltrInput
              ? (isRtl ? TextAlign.right : TextAlign.left)
              : TextAlign.start,
          style: textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            hintTextDirection: ltrInput ? TextDirection.ltr : null,
            hintStyle:
                textTheme.bodyLarge?.copyWith(color: AppColors.textMuted),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 14,
            ),
            border: border(AppColors.primaryLight),
            enabledBorder: border(AppColors.primaryLight),
            focusedBorder: border(AppColors.primary, 1.5),
            errorBorder: border(AppColors.error),
            focusedErrorBorder: border(AppColors.error, 1.5),
            errorStyle:
                textTheme.bodyMedium?.copyWith(color: AppColors.error),
          ),
        ),
      ],
    );
  }
}