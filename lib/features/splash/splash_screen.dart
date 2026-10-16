import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/widgets/nabd_logo.dart';

/// شاشة البداية: تبقى مفتوحة حتى يضغط المستخدم على الشاشة.
/// الجملة السفلية تبدأ بالعربية ثم تتبدل للإنجليزية.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  bool _showEnglish = false; // false = عربي، true = إنجليزي

  @override
  void initState() {
    super.initState();
    // بعد ثانيتين ونصف تتبدل الجملة للإنجليزية
    _timer = Timer(const Duration(milliseconds: 2500), () {
      if (mounted) setState(() => _showEnglish = true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _goNext() => context.go(AppRoutes.onboarding);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, // الضغط يخدم في أي مكان من الشاشة
        onTap: _goNext,
        child: SafeArea(
          child: Center(
            // ظهور تدريجي (Fade-in) في 800 ملّي ثانية
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
              builder: (context, value, child) =>
                  Opacity(opacity: value, child: child),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const NabdLogo(size: 96),
                  const SizedBox(height: AppSpacing.md),
                  Text('Nabd', style: textTheme.headlineLarge),
                  Text(
                    'نبض',
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: AppSpacing.xl * 2),
                  // تبديل ناعم بين الجملتين
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      _showEnglish ? 'Your health comes first' : 'صحتك أولا',
                      key: ValueKey<bool>(_showEnglish),
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textMuted),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}