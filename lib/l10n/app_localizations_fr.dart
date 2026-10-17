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

  @override
  String get resetTitle => 'Créer un nouveau mot de passe';

  @override
  String get resetSubtitle =>
      'Choisissez un nouveau mot de passe d’au moins 6 caractères';

  @override
  String get newPasswordLabel => 'Nouveau mot de passe';

  @override
  String get confirmPasswordLabel => 'Confirmer le mot de passe';

  @override
  String get confirmPasswordHint => 'Saisissez à nouveau le mot de passe';

  @override
  String get resetButton => 'Réinitialiser le mot de passe';

  @override
  String get passwordsDontMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get tabHome => 'Accueil';

  @override
  String get tabCategories => 'Catégories';

  @override
  String get tabCart => 'Panier';

  @override
  String get tabOrders => 'Commandes';

  @override
  String get tabProfile => 'Profil';

  @override
  String get comingSoon => 'Bientôt disponible';

  @override
  String get statusAvailable => 'En stock';

  @override
  String get statusLimited => 'Quantité limitée';

  @override
  String get statusOutOfStock => 'Rupture de stock';

  @override
  String get currency => 'DA';

  @override
  String get featuredProducts => 'Produits en vedette';

  @override
  String get viewAll => 'Voir tout';

  @override
  String get searchHint => 'Rechercher des fournitures médicales...';

  @override
  String get catMeasure => 'Mesure';

  @override
  String get catExam => 'Examen';

  @override
  String get catWounds => 'Plaies';

  @override
  String get catSupplies => 'Fournitures';

  @override
  String get promoTitle => 'Offres de la semaine';

  @override
  String get promoSubtitle =>
      'Réductions sur les appareils de mesure et d’examen';

  @override
  String get promoButton => 'Acheter maintenant';

  @override
  String productsCount(int count) {
    return '$count produits';
  }

  @override
  String get sortBy => 'Trier par';

  @override
  String get filterLabel => 'Filtrer';

  @override
  String get sortDefault => 'Par défaut';

  @override
  String get sortPriceLow => 'Prix : croissant';

  @override
  String get sortPriceHigh => 'Prix : décroissant';

  @override
  String get noProductsInCategory =>
      'Aucun produit dans cette catégorie pour le moment';
}
