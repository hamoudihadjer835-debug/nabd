import 'package:flutter/material.dart';

import '../localization/l10n_extension.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';

/// خيار في نافذة الاختيار: القيمة + النص المعروض.
class PickerOption<T> {
  const PickerOption(this.value, this.label);

  final T value;
  final String label;
}

/// يفتح نافذة تطلع من الأسفل فيها حقل بحث وقائمة، ويرجع القيمة المختارة (أو null).
Future<T?> showPickerSheet<T>(
  BuildContext context, {
  required String title,
  required List<PickerOption<T>> options,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) => _PickerSheet<T>(title: title, options: options),
  );
}

class _PickerSheet<T> extends StatefulWidget {
  const _PickerSheet({required this.title, required this.options});

  final String title;
  final List<PickerOption<T>> options;

  @override
  State<_PickerSheet<T>> createState() => _PickerSheetState<T>();
}

class _PickerSheetState<T> extends State<_PickerSheet<T>> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final filtered = widget.options
        .where((o) => o.label.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Padding(
      // باش الكيبورد ما يغطيش النافذة
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.md),
            Text(widget.title, style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: TextField(
                onChanged: (value) => setState(() => _query = value),
                decoration: InputDecoration(
                  hintText: context.l10n.searchOptionHint,
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: AppRadius.buttonBorder,
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final option = filtered[index];
                  return ListTile(
                    title: Text(option.label),
                    onTap: () => Navigator.pop(context, option.value),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// حقل يشبه حقل النص لكن يفتح نافذة اختيار بدل الكتابة.
class PickerField extends StatelessWidget {
  const PickerField({
    super.key,
    required this.label,
    required this.hint,
    required this.onTap,
    this.valueLabel,
    this.errorText,
    this.enabled = true,
  });

  final String label;
  final String hint;
  final VoidCallback onTap;
  final String? valueLabel; // النص المختار (null = ما اختارش بعد)
  final String? errorText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSpacing.sm),
        Opacity(
          opacity: enabled ? 1 : 0.5,
          child: Material(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.buttonBorder,
              side: BorderSide(
                color: hasError ? AppColors.error : AppColors.primaryLight,
              ),
            ),
            child: InkWell(
              onTap: enabled ? onTap : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        valueLabel ?? hint,
                        style: textTheme.bodyLarge?.copyWith(
                          color: valueLabel == null
                              ? AppColors.textMuted
                              : AppColors.text,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              errorText!,
              style: textTheme.bodyMedium?.copyWith(color: AppColors.error),
            ),
          ),
      ],
    );
  }
}