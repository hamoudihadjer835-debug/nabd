import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/localization/l10n_extension.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/utils/phone_format.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/circle_back_button.dart';
import 'user_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // القيم عند فتح الشاشة: نقارنو بيها باش نعرفو واش تبدل شيء
  final String _initialName = userController.fullName;
  final String _initialEmail = userController.email;
  final String _initialPhone = userController.phone; // أرقام صافية

  late final _nameController = TextEditingController(text: _initialName);
  late final _emailController = TextEditingController(text: _initialEmail);
  late final _phoneController =
      TextEditingController(text: groupPhoneDigits(_initialPhone));

  /// نسمحو بالخروج بلا تأكيد (بعد الحفظ أو بعد اختيار "تجاهل").
  bool _allowLeave = false;

  /// الهاتف بأرقام صافية (بلا فراغات).
  String get _phoneDigits =>
      _phoneController.text.replaceAll(RegExp(r'\D'), '');

  /// واش تبدل شيء عن القيم الأولى؟
  bool get _isDirty =>
      _nameController.text.trim() != _initialName ||
      _emailController.text.trim() != _initialEmail ||
      _phoneDigits != _initialPhone;

  @override
  void initState() {
    super.initState();
    // كل ما المستخدم يكتب نعيدو الرسم باش نحدثو حالة زر الحفظ
    _nameController.addListener(_onChanged);
    _emailController.addListener(_onChanged);
    _phoneController.addListener(_onChanged);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onChanged() => setState(() {});

  // ---------- التحقق ----------
  String? _validateName(String? value) {
    if (value == null || value.trim().length < 2) {
      return context.l10n.nameRequired;
    }
    return null;
  }

  // البريد اختياري: فارغ مقبول، وإذا مكتوب لازم يكون صحيح
  String? _validateEmail(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return null;
    return Validators.isEmail(v) ? null : context.l10n.invalidEmail;
  }

  // الهاتف اختياري بنفس الطريقة: محمول جزائري من 10 أرقام
  String? _validatePhone(String? value) {
    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return null;
    return Validators.isAlgerianMobile(digits)
        ? null
        : context.l10n.invalidPhone;
  }

  // ---------- التنقل ----------
  /// نخرجو فعلا (بعد ما نسمحو بالخروج).
  void _leaveNow() {
    setState(() => _allowLeave = true);
    // ننتظرو الرسم الجديد باش PopScope يعرف أن الخروج مسموح
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(AppRoutes.profile);
      }
    });
  }

  /// المستخدم يبغي يخرج: إذا فيه تغييرات نسقسيوه أولا.
  Future<void> _requestLeave() async {
    if (!_isDirty) {
      _leaveNow();
      return;
    }
    final l10n = context.l10n;

    final discard = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(l10n.discardTitle),
        content: Text(l10n.discardMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.keepEditing),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.discardConfirm),
          ),
        ],
      ),
    );

    if (discard == true && mounted) _leaveNow();
  }

  // ---------- أفعال ----------
  void _comingSoon() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(context.l10n.comingSoon)));
  }

  void _save() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    userController.update(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneDigits, // نحفظو الأرقام الصافية
    );

    // مؤقت: الحفظ الحقيقي مع الـ Backend (المرحلة 6)
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(context.l10n.changesSaved)));
    _leaveNow();
  }

  /// نافذة الصورة: كاميرا / معرض / حذف (الاختيار الحقيقي نزيدوه لاحقا).
  void _openPhotoSheet() {
    final l10n = context.l10n;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        Widget option(IconData icon, String label, {bool danger = false}) {
          final color = danger ? AppColors.error : AppColors.text;
          return ListTile(
            leading: Icon(icon, color: danger ? AppColors.error : AppColors.primary),
            title: Text(label, style: TextStyle(color: color)),
            onTap: () {
              Navigator.pop(sheetContext);
              _comingSoon();
            },
          );
        }

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppSpacing.sm),
              option(Icons.photo_camera_outlined, l10n.photoCamera),
              option(Icons.photo_library_outlined, l10n.photoGallery),
              option(Icons.delete_outline_rounded, l10n.photoRemove,
                  danger: true),
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    // PopScope: يعترض زر الرجوع في النظام إذا فيه تغييرات غير محفوظة
    return PopScope(
      canPop: !_isDirty || _allowLeave,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _requestLeave();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // السهم + العنوان
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    CircleBackButton(onPressed: _requestLeave),
                    const SizedBox(width: AppSpacing.md),
                    Text(l10n.menuMyData, style: textTheme.headlineLarge),
                  ],
                ),
              ),

              // المحتوى القابل للتمرير
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSpacing.sm),
                        // دائرة الصورة + رابط تغييرها
                        Center(
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryLight,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person_outline_rounded,
                                  size: 36,
                                  color: AppColors.primary,
                                ),
                              ),
                              TextButton(
                                onPressed: _openPhotoSheet,
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                ),
                                child: Text(l10n.changePhoto),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),

                        AppTextField(
                          label: l10n.fullNameLabel,
                          hint: l10n.fullNameHint,
                          controller: _nameController,
                          validator: _validateName,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          label: l10n.emailLabel,
                          hint: l10n.emailOrPhoneHint,
                          controller: _emailController,
                          validator: _validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          ltrInput: true,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          label: l10n.phoneLabel,
                          hint: '0555 12 34 56',
                          controller: _phoneController,
                          validator: _validatePhone,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          inputFormatters: [PhoneInputFormatter()],
                          ltrInput: true,
                        ),
                        const SizedBox(height: AppSpacing.lg),

                        // قسم الأمان
                        Text(l10n.securityTitle, style: textTheme.titleLarge),
                        const SizedBox(height: AppSpacing.sm),
                        Material(
                          color: Colors.white,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppRadius.cardBorder,
                            side: const BorderSide(
                              color: AppColors.primaryLight,
                            ),
                          ),
                          child: InkWell(
                            // الشاشة نبنيوها في الخطوة الجاية (4.16c)
                            onTap: _comingSoon,
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.md),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.lock_outline_rounded,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: AppSpacing.md),
                                  Expanded(
                                    child: Text(
                                      l10n.changePassword,
                                      style: textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    isRtl
                                        ? Icons.chevron_left_rounded
                                        : Icons.chevron_right_rounded,
                                    color: AppColors.textMuted,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                      ],
                    ),
                  ),
                ),
              ),

              // زر الحفظ الثابت: معطل حتى يتبدل شيء
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
                    onPressed: _isDirty ? _save : null,
                    child: Text(l10n.saveChanges),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}