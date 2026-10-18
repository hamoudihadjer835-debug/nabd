import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/localization/locale_controller.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/widgets/circle_back_button.dart';

/// خيار لغة واحد: الرمز + الاسم بلغتو + الوصف.
class _LanguageOption {
  const _LanguageOption(this.code, this.nativeName, this.description);

  final String code;
  final String nativeName;
  final String description;
}

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  // اللغة المختارة (تبدأ باللغة الحالية). ما تتطبق حتى نضغطو "حفظ".
  late String _selected = appLocale.value.languageCode;

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.profile);
    }
  }

  void _save() {
    appLocale.value = Locale(_selected); // التطبيق كامل يتبدل
    _goBack();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    final options = [
      _LanguageOption('ar', 'العربية', l10n.langArabicDesc),
      _LanguageOption('fr', 'Français', l10n.langFrenchDesc),
      _LanguageOption('en', 'English', l10n.langEnglishDesc),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // السهم + العنوان
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  CircleBackButton(onPressed: _goBack),
                  const SizedBox(width: AppSpacing.md),
                  Text(l10n.menuLanguage, style: textTheme.headlineLarge),
                ],
              ),
            ),

            // بطاقات اللغات
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                itemCount: options.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final option = options[index];
                  return _LanguageCard(
                    option: option,
                    selected: option.code == _selected,
                    onTap: () => setState(() => _selected = option.code),
                  );
                },
              ),
            ),

            // زر الحفظ الثابت في الأسفل
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.md,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x145B4BDB),
                    blurRadius: 16,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _save,
                  child: Text(l10n.save),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// بطاقة لغة: الاسم والوصف، ودائرة اختيار (Radio) في النهاية.
class _LanguageCard extends StatelessWidget {
  const _LanguageCard({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final _LanguageOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.cardBorder,
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.primaryLight,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(option.nativeName, style: textTheme.titleLarge),
                    const SizedBox(height: 2),
                    Text(
                      option.description,
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
              // دائرة الاختيار
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? AppColors.primary : AppColors.textMuted,
                    width: 2,
                  ),
                ),
                child: selected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}