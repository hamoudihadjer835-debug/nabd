import 'package:flutter/material.dart';

import '../localization/locale_controller.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';

class _Language {
  const _Language(this.locale, this.name);

  final Locale locale;
  final String name; // الاسم بلغته الأصلية
}

/// زر في الأعلى يفتح قائمة: العربية، English، Français.
class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  static const List<_Language> _languages = [
    _Language(Locale('ar'), 'العربية'),
    _Language(Locale('en'), 'English'),
    _Language(Locale('fr'), 'Français'),
  ];

  @override
  Widget build(BuildContext context) {
    final current = Localizations.localeOf(context).languageCode;
    final textTheme = Theme.of(context).textTheme;

    return PopupMenuButton<Locale>(
      tooltip: '',
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.buttonBorder),
      onSelected: (locale) => appLocale.value = locale, // نبدلو اللغة
      itemBuilder: (context) => _languages
          .map(
            (lang) => PopupMenuItem<Locale>(
              value: lang.locale,
              child: Row(
                children: [
                  Expanded(child: Text(lang.name)),
                  if (lang.locale.languageCode == current)
                    const Icon(
                      Icons.check_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                ],
              ),
            ),
          )
          .toList(),
      // شكل الزر: أيقونة كرة أرضية + رمز اللغة الحالية
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: const Color(0xB3FFFFFF), // أبيض بشفافية 70%
          borderRadius: AppRadius.buttonBorder,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.language_rounded,
              size: 18,
              color: AppColors.primary,
            ),
            const SizedBox(width: 6),
            Text(
              current.toUpperCase(),
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}