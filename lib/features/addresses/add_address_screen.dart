import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n_extension.dart';
import '../../core/models/localized_text.dart';
import '../../core/router/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimens.dart';
import '../../core/utils/phone_format.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/circle_back_button.dart';
import '../../core/widgets/picker_field.dart';
import 'addresses_controller.dart';
import 'data/geo_repository.dart';
import 'models/address.dart';
import 'models/algeria_geo.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  final _detailsController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _wilayaId;
  String? _communeId;
  bool _isDefault = false;

  /// بعد أول محاولة حفظ نعرضو أخطاء الولاية والبلدية.
  bool _submitted = false;

  Wilaya? get _wilaya => geoRepository.wilayaById(_wilayaId ?? '');

  Commune? get _commune =>
      _wilaya?.communes.where((c) => c.id == _communeId).firstOrNull;

  String get _phoneDigits =>
      _phoneController.text.replaceAll(RegExp(r'\D'), '');

  @override
  void dispose() {
    _labelController.dispose();
    _detailsController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.addresses);
    }
  }

  // ---------- التحقق ----------
  String? _validateLabel(String? value) {
    if (value == null || value.trim().length < 2) {
      return context.l10n.fieldRequired;
    }
    return null;
  }

  String? _validateDetails(String? value) {
    if (value == null || value.trim().length < 5) {
      return context.l10n.addressDetailsRequired;
    }
    return null;
  }

  String? _validatePhone(String? value) {
    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return context.l10n.fieldRequired;
    return Validators.isAlgerianMobile(digits)
        ? null
        : context.l10n.invalidPhone;
  }

  // ---------- الاختيار ----------
  Future<void> _pickWilaya() async {
    final locale = Localizations.localeOf(context);
    final title = context.l10n.wilayaLabel;

    final picked = await showPickerSheet<String>(
      context,
      title: title,
      options: [
        for (final w in geoRepository.wilayas)
          PickerOption(w.id, w.name.of(locale)),
      ],
    );

    if (!mounted || picked == null || picked == _wilayaId) return;
    // تبديل الولاية يمسح البلدية (لأن البلديات تخص ولاية معينة)
    setState(() {
      _wilayaId = picked;
      _communeId = null;
    });
  }

  Future<void> _pickCommune() async {
    final wilaya = _wilaya;
    if (wilaya == null) return;
    final locale = Localizations.localeOf(context);
    final title = context.l10n.communeLabel;

    // نرتبو البلديات أبجديا حسب لغة التطبيق
    final options = [
      for (final c in wilaya.communes) PickerOption(c.id, c.name.of(locale)),
    ]..sort((a, b) => a.label.compareTo(b.label));

    final picked = await showPickerSheet<String>(
      context,
      title: title,
      options: options,
    );

    if (!mounted || picked == null) return;
    setState(() => _communeId = picked);
  }

  // ---------- الحفظ ----------
  void _save() {
    FocusScope.of(context).unfocus();
    final formOk = _formKey.currentState!.validate();
    setState(() => _submitted = true);
    if (!formOk || _wilayaId == null || _communeId == null) return;

    addressesController.add(
      Address(
        id: addressesController.nextId(),
        // ما كتبو المستخدم يتحفظ كما هو (ما يتترجمش)
        label: LocalizedText.same(_labelController.text.trim()),
        wilayaId: _wilayaId!,
        communeId: _communeId!,
        details: LocalizedText.same(_detailsController.text.trim()),
        phone: _phoneDigits,
      ),
      makeDefault: _isDefault,
    );

    // مؤقت: الحفظ الحقيقي مع الـ Backend (المرحلة 6)
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(context.l10n.addressSavedMessage)));
    _goBack();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);

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
                  Text(l10n.addAddressTitle, style: textTheme.headlineLarge),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        label: l10n.addressNameLabel,
                        hint: l10n.addressNameHint,
                        controller: _labelController,
                        validator: _validateLabel,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      PickerField(
                        label: l10n.wilayaLabel,
                        hint: l10n.wilayaHint,
                        valueLabel: _wilaya?.name.of(locale),
                        errorText: _submitted && _wilayaId == null
                            ? l10n.selectWilayaError
                            : null,
                        onTap: _pickWilaya,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      PickerField(
                        label: l10n.communeLabel,
                        hint: l10n.communeHint,
                        valueLabel: _commune?.name.of(locale),
                        // معطلة حتى نختارو الولاية
                        enabled: _wilayaId != null,
                        errorText: _submitted &&
                                _wilayaId != null &&
                                _communeId == null
                            ? l10n.selectCommuneError
                            : null,
                        onTap: _pickCommune,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      AppTextField(
                        label: l10n.addressDetailsLabel,
                        hint: l10n.addressDetailsHint,
                        controller: _detailsController,
                        validator: _validateDetails,
                        textInputAction: TextInputAction.next,
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
                      const SizedBox(height: AppSpacing.md),

                      // مفتاح: تعيين كعنوان افتراضي
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.setAsDefault,
                              style: textTheme.bodyLarge,
                            ),
                          ),
                          Switch(
                            value: _isDefault,
                            onChanged: (value) =>
                                setState(() => _isDefault = value),
                            thumbColor: WidgetStateProperty.all(Colors.white),
                            trackColor: WidgetStateProperty.resolveWith(
                              (states) => states.contains(WidgetState.selected)
                                  ? AppColors.primary
                                  : AppColors.textMuted,
                            ),
                            trackOutlineColor:
                                WidgetStateProperty.all(Colors.transparent),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ),
                ),
              ),
            ),

            // زر الحفظ الثابت
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
                  child: Text(l10n.saveAddress),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}