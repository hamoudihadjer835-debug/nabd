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
}
