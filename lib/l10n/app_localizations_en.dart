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
  String get passwordHintSignup => 'At least 6 characters';

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
  String get passwordTooShort => 'Password must be at least 6 characters';

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
      'Choose a new password with at least 6 characters';

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
}
