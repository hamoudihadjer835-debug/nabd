import 'package:flutter/material.dart';

import 'core/localization/locale_controller.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/addresses/data/geo_repository.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  // ضروري قبل ما نقراو ملف من assets قبل runApp
  WidgetsFlutterBinding.ensureInitialized();
  await geoRepository.load(); // نحملو الولايات والبلديات

  runApp(const NabdApp());
}

/// جذر التطبيق: نربط فيه الـ Theme واللغة والتنقل.
class NabdApp extends StatelessWidget {
  const NabdApp({super.key});

  @override
  Widget build(BuildContext context) {
    // نسمعو لتغير اللغة: كي تتبدل، يعاد رسم التطبيق باللغة الجديدة
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocale,
      builder: (context, locale, _) {
        return MaterialApp.router(
          title: 'Nabd',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routerConfig: appRouter,
        );
      },
    );
  }
}