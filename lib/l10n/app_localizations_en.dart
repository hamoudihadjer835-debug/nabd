// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginTitle => 'Welcome to Nabd';

  @override
  String get loginSubtitle => 'Log in to follow your orders and products';

  @override
  String get emailOrPhoneLabel => 'Email or phone number';

  @override
  String get emailOrPhoneHint => 'example@email.com';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHintSignup => 'At least 8 characters';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get loginButton => 'Log in';

  @override
  String get noAccount => 'Don’t have an account?';

  @override
  String get signUpLink => 'Sign up';

  @override
  String get signUpTitle => 'Create a new account';

  @override
  String get signUpSubtitle =>
      'Enter your details to start shopping with confidence';

  @override
  String get fullNameLabel => 'Full name';

  @override
  String get fullNameHint => 'Enter your full name';

  @override
  String get agreePrefix => 'I agree to the ';

  @override
  String get termsAndPrivacy => 'Terms and Privacy Policy';

  @override
  String get signUpButton => 'Create account';

  @override
  String get haveAccount => 'Already have an account?';

  @override
  String get loginLink => 'Log in';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get invalidEmailOrPhone => 'Enter a valid email or phone number';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters';

  @override
  String get nameRequired => 'Please enter your full name';

  @override
  String get mustAcceptTerms => 'Please accept the terms to continue';

  @override
  String get forgotSubtitle =>
      'Enter your email or phone number and we’ll send you a verification code';

  @override
  String get sendCodeButton => 'Send code';

  @override
  String get rememberedPassword => 'Remembered your password?';

  @override
  String get verifyTitle => 'Enter verification code';

  @override
  String get verifySubtitle => 'We sent a 6-digit code to';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get resendIn => 'You can resend the code in';

  @override
  String get resendCode => 'Resend code';

  @override
  String get wrongNumber => 'Wrong number?';

  @override
  String get changeNumber => 'Change number';

  @override
  String get codeIncomplete => 'Enter the 6-digit code';

  @override
  String get resetTitle => 'Create new password';

  @override
  String get resetSubtitle =>
      'Choose a new password with at least 8 characters, including a letter and a digit';

  @override
  String get newPasswordLabel => 'New password';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get confirmPasswordHint => 'Re-enter your password';

  @override
  String get resetButton => 'Reset password';

  @override
  String get passwordsDontMatch => 'Passwords do not match';

  @override
  String get tabHome => 'Home';

  @override
  String get tabCategories => 'Categories';

  @override
  String get tabCart => 'Cart';

  @override
  String get tabOrders => 'Orders';

  @override
  String get tabProfile => 'Profile';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get statusAvailable => 'In stock';

  @override
  String get statusLimited => 'Limited quantity';

  @override
  String get statusOutOfStock => 'Out of stock';

  @override
  String get currency => 'DA';

  @override
  String get featuredProducts => 'Featured products';

  @override
  String get viewAll => 'View all';

  @override
  String get searchHint => 'Search for medical supplies...';

  @override
  String get catMeasure => 'Measuring';

  @override
  String get catExam => 'Examination';

  @override
  String get catWounds => 'Wounds';

  @override
  String get catSupplies => 'Supplies';

  @override
  String get promoTitle => 'Weekly offers';

  @override
  String get promoSubtitle => 'Discounts on measuring and examination devices';

  @override
  String get promoButton => 'Shop now';

  @override
  String productsCount(int count) {
    return '$count products';
  }

  @override
  String get sortBy => 'Sort by';

  @override
  String get filterLabel => 'Filter';

  @override
  String get sortDefault => 'Default';

  @override
  String get sortPriceLow => 'Price: low to high';

  @override
  String get sortPriceHigh => 'Price: high to low';

  @override
  String get noProductsInCategory => 'No products in this category yet';

  @override
  String stockLeft(int count) {
    return '$count left';
  }

  @override
  String get specsTitle => 'Specifications';

  @override
  String get specsSubtitle => 'Information provided by the manufacturer';

  @override
  String get specManufacturer => 'Manufacturer';

  @override
  String get specIntendedUse => 'Intended use';

  @override
  String get specCertifications => 'Certifications';

  @override
  String get specSku => 'Product number';

  @override
  String get notSpecified => 'Not specified';

  @override
  String get addToCart => 'Add to cart';

  @override
  String get addedToCart => 'Added to cart';

  @override
  String get productNotFound => 'Product not found';

  @override
  String get recentSearches => 'Recent searches';

  @override
  String get clearAll => 'Clear all';

  @override
  String get mostSearched => 'Most searched';

  @override
  String get filterPrice => 'Price';

  @override
  String get filterAvailability => 'Availability';

  @override
  String get filterCategory => 'Category';

  @override
  String get noResults => 'No results found';

  @override
  String get noResultsHint => 'Try other keywords or change the filters';

  @override
  String resultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count results',
      one: '1 result',
      zero: 'No results',
    );
    return '$_temp0';
  }

  @override
  String cartItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String get subtotal => 'Subtotal';

  @override
  String get deliveryFee => 'Delivery';

  @override
  String get total => 'Total';

  @override
  String get proceedToPayment => 'Proceed to payment';

  @override
  String get cartEmptyTitle => 'Your cart is empty';

  @override
  String get cartEmptyHint => 'Add medical products and they will show up here';

  @override
  String get browseProducts => 'Browse products';

  @override
  String get maxQuantityReached =>
      'You have reached the maximum available quantity';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String favoritesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count products',
      one: '1 product',
    );
    return '$_temp0';
  }

  @override
  String get favoritesEmptyTitle => 'No favorites yet';

  @override
  String get favoritesEmptyHint =>
      'Tap the heart on any product you like and you’ll find it here';

  @override
  String get profileNamePlaceholder => '[Full name]';

  @override
  String get menuMyData => 'My details';

  @override
  String get menuAddresses => 'My addresses';

  @override
  String get menuNotifications => 'Notifications';

  @override
  String get menuLanguage => 'Language';

  @override
  String get menuHelp => 'Help & Support';

  @override
  String get menuLogout => 'Log out';

  @override
  String get langArabicDesc => 'Arabic language';

  @override
  String get langFrenchDesc => 'French language';

  @override
  String get langEnglishDesc => 'English language';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get logoutConfirmTitle => 'Log out?';

  @override
  String get logoutConfirmMessage =>
      'You will need to sign in again to access your account.';

  @override
  String get emailLabel => 'Email';

  @override
  String get phoneLabel => 'Phone number';

  @override
  String get changePhoto => 'Change photo';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get changesSaved => 'Changes saved';

  @override
  String get invalidEmail => 'Enter a valid email';

  @override
  String get invalidPhone =>
      'Enter a valid mobile number: 10 digits starting with 05, 06 or 07';

  @override
  String get discardTitle => 'Discard changes?';

  @override
  String get discardMessage =>
      'You have unsaved changes. If you leave now, they will be lost.';

  @override
  String get discardConfirm => 'Discard';

  @override
  String get keepEditing => 'Keep editing';

  @override
  String get photoCamera => 'Take a photo';

  @override
  String get photoGallery => 'Choose from gallery';

  @override
  String get photoRemove => 'Remove photo';

  @override
  String get securityTitle => 'Security';

  @override
  String get changePassword => 'Change password';

  @override
  String get newPasswordRequired => 'Enter the new password';

  @override
  String get passwordNeedsLetterAndDigit => 'Must contain a letter and a digit';

  @override
  String get passwordSameAsCurrent =>
      'Choose a password different from the current one';

  @override
  String get passwordChanged => 'Password changed';

  @override
  String get currentPasswordLabel => 'Current password';

  @override
  String get confirmNewPasswordLabel => 'Confirm new password';

  @override
  String get currentPasswordWrong => 'Current password is incorrect';

  @override
  String get forgotCurrentPassword => 'Forgot your current password?';

  @override
  String get passwordStrengthLabel => 'Password strength';

  @override
  String get strengthWeak => 'Weak';

  @override
  String get strengthMedium => 'Medium';

  @override
  String get strengthStrong => 'Strong';

  @override
  String get ruleMinLength => 'At least 8 characters';

  @override
  String get ruleLetter => 'A letter';

  @override
  String get ruleDigit => 'A digit';

  @override
  String get genericError => 'Something went wrong. Please try again.';

  @override
  String get backToSearch => 'Back to search';

  @override
  String get retry => 'Try again';

  @override
  String get offlineTitle => 'No internet connection';

  @override
  String get offlineMessage => 'Check your connection and try again';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get errorMessage =>
      'We couldn’t complete the operation. Please try again.';

  @override
  String get addNewAddress => 'Add new address';

  @override
  String get addAddressTitle => 'Add address';

  @override
  String get addressNameLabel => 'Address name';

  @override
  String get addressNameHint => 'e.g. Home';

  @override
  String get wilayaLabel => 'Wilaya (province)';

  @override
  String get wilayaHint => 'Select wilaya';

  @override
  String get communeLabel => 'Commune (municipality)';

  @override
  String get communeHint => 'Select commune';

  @override
  String get addressDetailsLabel => 'Detailed address';

  @override
  String get addressDetailsHint => 'Street, neighborhood, building number';

  @override
  String get setAsDefault => 'Set as default address';

  @override
  String get saveAddress => 'Save address';

  @override
  String get defaultBadge => 'Default';

  @override
  String get addressSavedMessage => 'Address saved';

  @override
  String get selectWilayaError => 'Select a wilaya';

  @override
  String get selectCommuneError => 'Select a commune';

  @override
  String get addressDetailsRequired => 'Enter the detailed address';

  @override
  String get searchOptionHint => 'Search...';
}
