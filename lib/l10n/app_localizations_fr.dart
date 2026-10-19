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

  @override
  String stockLeft(int count) {
    return '$count pièces restantes';
  }

  @override
  String get specsTitle => 'Caractéristiques';

  @override
  String get specsSubtitle => 'Informations fournies par le fabricant';

  @override
  String get specManufacturer => 'Fabricant';

  @override
  String get specIntendedUse => 'Usage prévu';

  @override
  String get specCertifications => 'Certifications';

  @override
  String get specSku => 'Référence produit';

  @override
  String get notSpecified => 'Non précisé';

  @override
  String get addToCart => 'Ajouter au panier';

  @override
  String get addedToCart => 'Ajouté au panier';

  @override
  String get productNotFound => 'Produit introuvable';

  @override
  String get recentSearches => 'Recherches récentes';

  @override
  String get clearAll => 'Tout effacer';

  @override
  String get mostSearched => 'Les plus recherchés';

  @override
  String get filterPrice => 'Prix';

  @override
  String get filterAvailability => 'Disponibilité';

  @override
  String get filterCategory => 'Catégorie';

  @override
  String get noResults => 'Aucun résultat';

  @override
  String get noResultsHint => 'Essayez d’autres mots-clés';

  @override
  String resultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count résultats',
      one: '1 résultat',
      zero: 'Aucun résultat',
    );
    return '$_temp0';
  }

  @override
  String cartItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count articles',
      one: '1 article',
    );
    return '$_temp0';
  }

  @override
  String get subtotal => 'Sous-total';

  @override
  String get deliveryFee => 'Livraison';

  @override
  String get total => 'Total';

  @override
  String get proceedToPayment => 'Passer au paiement';

  @override
  String get cartEmptyTitle => 'Votre panier est vide';

  @override
  String get cartEmptyHint =>
      'Ajoutez des fournitures médicales à votre panier, elles apparaîtront ici';

  @override
  String get browseProducts => 'Parcourir les produits';

  @override
  String get maxQuantityReached =>
      'Vous avez atteint la quantité maximale disponible';

  @override
  String get favoritesTitle => 'Favoris';

  @override
  String favoritesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count produits',
      one: '1 produit',
    );
    return '$_temp0';
  }

  @override
  String get favoritesEmptyTitle => 'Aucun favori pour le moment';

  @override
  String get favoritesEmptyHint =>
      'Appuyez sur le cœur d’un produit pour le retrouver ici';

  @override
  String get profileNamePlaceholder => '[Nom complet]';

  @override
  String get menuMyData => 'Mes informations';

  @override
  String get menuAddresses => 'Mes adresses';

  @override
  String get menuNotifications => 'Notifications';

  @override
  String get menuLanguage => 'Langue';

  @override
  String get menuHelp => 'Aide';

  @override
  String get menuLogout => 'Se déconnecter';

  @override
  String get langArabicDesc => 'Langue arabe';

  @override
  String get langFrenchDesc => 'Langue française';

  @override
  String get langEnglishDesc => 'Langue anglaise';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get logoutConfirmTitle => 'Se déconnecter ?';

  @override
  String get logoutConfirmMessage =>
      'Vous devrez vous reconnecter pour accéder à votre compte.';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get phoneLabel => 'Numéro de téléphone';

  @override
  String get changePhoto => 'Changer la photo';

  @override
  String get saveChanges => 'Enregistrer les modifications';

  @override
  String get changesSaved => 'Modifications enregistrées';

  @override
  String get invalidEmail => 'Saisissez un e-mail valide';

  @override
  String get invalidPhone =>
      'Saisissez un numéro mobile valide : 10 chiffres commençant par 05, 06 ou 07';

  @override
  String get discardTitle => 'Abandonner les modifications ?';

  @override
  String get discardMessage =>
      'Vous avez des modifications non enregistrées. Si vous quittez maintenant, elles seront perdues.';

  @override
  String get discardConfirm => 'Abandonner';

  @override
  String get keepEditing => 'Continuer';

  @override
  String get photoCamera => 'Prendre une photo';

  @override
  String get photoGallery => 'Choisir dans la galerie';

  @override
  String get photoRemove => 'Supprimer la photo';

  @override
  String get securityTitle => 'Sécurité';

  @override
  String get changePassword => 'Changer le mot de passe';
}
