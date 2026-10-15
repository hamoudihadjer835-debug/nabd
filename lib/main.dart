import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/theme/app_colors.dart';
import 'core/theme/app_dimens.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const NabdApp());
}

/// جذر التطبيق: نربط فيه الـ Theme واللغة.
class NabdApp extends StatelessWidget {
  const NabdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nabd',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,

      // اللغة: العربية دابا (RTL تلقائي). نضيفو تبديل اللغة في شاشة Profile.
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('fr'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      home: const DesignTestScreen(),
    );
  }
}

/// شاشة مؤقتة نختبرو بيها الألوان والخط والأبعاد. نمسحوها بعدين.
class DesignTestScreen extends StatelessWidget {
  const DesignTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text('Nabd — نبض', style: textTheme.headlineLarge),
            const SizedBox(height: AppSpacing.sm),
            Text('اختبار نظام التصميم', style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'المستلزمات الطبية بين يديك، بسهولة ووضوح.',
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Medical supplies • Fournitures médicales • المستلزمات الطبية',
              style: textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
            ),
            const SizedBox(height: AppSpacing.lg),
            const _ProductCard(),
            const SizedBox(height: AppSpacing.lg),
            Text('الألوان', style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            const Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                _Swatch(AppColors.primary, 'Primary'),
                _Swatch(AppColors.primaryDark, 'Primary Dark'),
                _Swatch(AppColors.primaryLight, 'Primary Light', darkText: true),
                _Swatch(AppColors.accentMint, 'Mint', darkText: true),
                _Swatch(AppColors.success, 'Success'),
                _Swatch(AppColors.warning, 'Warning', darkText: true),
                _Swatch(AppColors.error, 'Error'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// بطاقة منتج تجريبية: بطاقة بزوايا 16، شارة نعناعية، وزر أساسي.
class _ProductCard extends StatelessWidget {
  const _ProductCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.cardBorder,
        boxShadow: const [
          BoxShadow(
            color: Color(0x145B4BDB), // البنفسجي بشفافية 8%
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.accentMint,
              borderRadius: BorderRadius.circular(AppSpacing.sm),
            ),
            child: Text('متوفر', style: textTheme.labelSmall),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('جهاز قياس ضغط الدم (Tensiomètre)', style: textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            '6,500 دج — سعر تجريبي',
            style: textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart_outlined),
              label: const Text('أضف إلى السلة'),
            ),
          ),
        ],
      ),
    );
  }
}

/// مربع لوني صغير نتأكدو بيه من الألوان.
class _Swatch extends StatelessWidget {
  const _Swatch(this.color, this.label, {this.darkText = false});

  final Color color;
  final String label;
  final bool darkText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: darkText ? AppColors.text : Colors.white,
            ),
      ),
    );
  }
}