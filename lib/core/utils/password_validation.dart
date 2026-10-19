import '../../l10n/app_localizations.dart';
import 'password_rules.dart';

/// رسالة الخطأ لكلمة سر جديدة (null = صحيحة).
/// current: كلمة السر الحالية، باش نرفضو الجديدة إذا كانت نفسها (Change Password).
String? validateNewPassword(
  AppLocalizations l10n,
  String? value, {
  required String emptyMessage,
  String? current,
}) {
  final v = value ?? '';
  if (v.isEmpty) return emptyMessage;
  if (!PasswordRules.hasMinLength(v)) return l10n.passwordTooShort;
  if (!PasswordRules.hasLetter(v) || !PasswordRules.hasDigit(v)) {
    return l10n.passwordNeedsLetterAndDigit;
  }
  if (current != null && v == current) return l10n.passwordSameAsCurrent;
  return null;
}