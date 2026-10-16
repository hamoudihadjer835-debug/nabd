// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get loginTitle => 'Bienvenue sur Nabd';

  @override
  String get loginSubtitle =>
      'Connectez-vous pour suivre vos commandes et vos produits';

  @override
  String get emailOrPhoneLabel => 'E-mail ou numéro de téléphone';

  @override
  String get emailOrPhoneHint => 'example@email.com';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get passwordHintSignup => '6 caractères minimum';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get loginButton => 'Se connecter';

  @override
  String get noAccount => 'Vous n’avez pas de compte ?';

  @override
  String get signUpLink => 'Créer un compte';

  @override
  String get signUpTitle => 'Créer un nouveau compte';

  @override
  String get signUpSubtitle =>
      'Saisissez vos informations pour commencer vos achats en toute confiance';

  @override
  String get fullNameLabel => 'Nom complet';

  @override
  String get fullNameHint => 'Saisissez votre nom complet';

  @override
  String get agreePrefix => 'J’accepte les ';

  @override
  String get termsAndPrivacy => 'conditions et la politique de confidentialité';

  @override
  String get signUpButton => 'Créer un compte';

  @override
  String get haveAccount => 'Vous avez déjà un compte ?';

  @override
  String get loginLink => 'Se connecter';

  @override
  String get fieldRequired => 'Ce champ est obligatoire';

  @override
  String get invalidEmailOrPhone =>
      'Saisissez un e-mail ou un numéro de téléphone valide';

  @override
  String get passwordTooShort =>
      'Le mot de passe doit contenir au moins 6 caractères';

  @override
  String get nameRequired => 'Veuillez saisir votre nom complet';

  @override
  String get mustAcceptTerms =>
      'Veuillez accepter les conditions pour continuer';

  @override
  String get forgotSubtitle =>
      'Saisissez votre e-mail ou votre numéro de téléphone et nous vous enverrons un code de vérification';

  @override
  String get sendCodeButton => 'Envoyer le code';

  @override
  String get rememberedPassword => 'Vous vous souvenez de votre mot de passe ?';

  @override
  String get verifyTitle => 'Saisissez le code de vérification';

  @override
  String get verifySubtitle => 'Nous avons envoyé un code à 6 chiffres à';

  @override
  String get confirmButton => 'Confirmer';

  @override
  String get resendIn => 'Vous pouvez renvoyer le code dans';

  @override
  String get resendCode => 'Renvoyer le code';

  @override
  String get wrongNumber => 'Mauvais numéro ?';

  @override
  String get changeNumber => 'Changer le numéro';

  @override
  String get codeIncomplete => 'Saisissez le code à 6 chiffres';
}
