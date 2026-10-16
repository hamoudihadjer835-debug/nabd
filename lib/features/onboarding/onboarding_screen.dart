import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';

/// بيانات شريحة واحدة: أيقونة + عنوان + شرح.
class _OnboardingPage {
  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

/// الشرائح الثلاث — بدلي النصوص من هنا فقط.
const List<_OnboardingPage> _pages = [
  _OnboardingPage(
    icon: Icons.search_rounded,
    title: 'بحث أسهل، اختيار أوضح',
    description: 'ابحث بالاسم أو الفئة واطلع على تفاصيل كل منتج.',
  ),
  _OnboardingPage(
    icon: Icons.verified_outlined,
    title: 'تفاصيل موثوقة قبل كل طلب',
    description: 'اطلع على الشركة المصنّعة والاستعمال المقصود والشهادات المتاحة.',
  ),
  _OnboardingPage(
    icon: Icons.local_shipping_outlined,
    title: 'تتبع طلبك',
    description: 'تابع طلبك من التأكيد حتى التسليم.',
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0; // رقم الشريحة الحالية (يبدأ من 0)

  bool get _isLast => _currentIndex == _pages.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_isLast) {
      context.go(AppRoutes.login); // آخر شريحة: نروحو لـ Login
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Onboarding بالعربية: نفرضو RTL على هذه الشاشة فقط
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.primaryLight,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (index) =>
                      setState(() => _currentIndex = index),
                  itemBuilder: (context, index) =>
                      _PageContent(page: _pages[index]),
                ),
              ),
              _Dots(count: _pages.length, current: _currentIndex),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: _next,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(160, 48),
                ),
                child: Text(_isLast ? 'ابدأ الآن' : 'التالي'),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
} // <-- هذا القوس لي كان ناقص: يقفل الكلاس _OnboardingScreenState

/// محتوى شريحة واحدة.
class _PageContent extends StatelessWidget {
  const _PageContent({required this.page});

  final _OnboardingPage page;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xl),
          // مكان الصورة: بطاقة شبه شفافة فيها أيقونة كبيرة
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0x99FFFFFF), // أبيض بشفافية 60%
                borderRadius: AppRadius.cardBorder,
              ),
              child: Center(
                child: Icon(page.icon, size: 96, color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: textTheme.headlineLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

/// النقاط تحت الشرائح: النقطة الحالية بنفسجية والباقي باهت.
class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.primary : const Color(0x4D5B4BDB),
          ),
        );
      }),
    );
  }
}