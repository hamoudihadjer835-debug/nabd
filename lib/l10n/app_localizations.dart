import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Nabd'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log in to follow your orders and products'**
  String get loginSubtitle;

  /// No description provided for @emailOrPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Email or phone number'**
  String get emailOrPhoneLabel;

  /// No description provided for @emailOrPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'example@email.com'**
  String get emailOrPhoneHint;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHintSignup.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get passwordHintSignup;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginButton;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get noAccount;

  /// No description provided for @signUpLink.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUpLink;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create a new account'**
  String get signUpTitle;

  /// No description provided for @signUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your details to start shopping with confidence'**
  String get signUpSubtitle;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullNameLabel;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullNameHint;

  /// No description provided for @agreePrefix.
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get agreePrefix;

  /// No description provided for @termsAndPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Terms and Privacy Policy'**
  String get termsAndPrivacy;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get signUpButton;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccount;

  /// No description provided for @loginLink.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginLink;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @invalidEmailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email or phone number'**
  String get invalidEmailOrPhone;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordTooShort;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name'**
  String get nameRequired;

  /// No description provided for @mustAcceptTerms.
  ///
  /// In en, this message translates to:
  /// **'Please accept the terms to continue'**
  String get mustAcceptTerms;

  /// No description provided for @forgotSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email or phone number and we’ll send you a verification code'**
  String get forgotSubtitle;

  /// No description provided for @sendCodeButton.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get sendCodeButton;

  /// No description provided for @rememberedPassword.
  ///
  /// In en, this message translates to:
  /// **'Remembered your password?'**
  String get rememberedPassword;

  /// No description provided for @verifyTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get verifyTitle;

  /// No description provided for @verifySubtitle.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to'**
  String get verifySubtitle;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @resendIn.
  ///
  /// In en, this message translates to:
  /// **'You can resend the code in'**
  String get resendIn;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @wrongNumber.
  ///
  /// In en, this message translates to:
  /// **'Wrong number?'**
  String get wrongNumber;

  /// No description provided for @changeNumber.
  ///
  /// In en, this message translates to:
  /// **'Change number'**
  String get changeNumber;

  /// No description provided for @codeIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code'**
  String get codeIncomplete;

  /// No description provided for @resetTitle.
  ///
  /// In en, this message translates to:
  /// **'Create new password'**
  String get resetTitle;

  /// No description provided for @resetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a new password with at least 8 characters, including a letter and a digit'**
  String get resetSubtitle;

  /// No description provided for @newPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPasswordLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordLabel;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your password'**
  String get confirmPasswordHint;

  /// No description provided for @resetButton.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetButton;

  /// No description provided for @passwordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDontMatch;

  /// No description provided for @tabHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get tabHome;

  /// No description provided for @tabCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get tabCategories;

  /// No description provided for @tabCart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get tabCart;

  /// No description provided for @tabOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get tabOrders;

  /// No description provided for @tabProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tabProfile;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @statusAvailable.
  ///
  /// In en, this message translates to:
  /// **'In stock'**
  String get statusAvailable;

  /// No description provided for @statusLimited.
  ///
  /// In en, this message translates to:
  /// **'Limited quantity'**
  String get statusLimited;

  /// No description provided for @statusOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of stock'**
  String get statusOutOfStock;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'DA'**
  String get currency;

  /// No description provided for @featuredProducts.
  ///
  /// In en, this message translates to:
  /// **'Featured products'**
  String get featuredProducts;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for medical supplies...'**
  String get searchHint;

  /// No description provided for @catMeasure.
  ///
  /// In en, this message translates to:
  /// **'Measuring'**
  String get catMeasure;

  /// No description provided for @catExam.
  ///
  /// In en, this message translates to:
  /// **'Examination'**
  String get catExam;

  /// No description provided for @catWounds.
  ///
  /// In en, this message translates to:
  /// **'Wounds'**
  String get catWounds;

  /// No description provided for @catSupplies.
  ///
  /// In en, this message translates to:
  /// **'Supplies'**
  String get catSupplies;

  /// No description provided for @promoTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly offers'**
  String get promoTitle;

  /// No description provided for @promoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Discounts on measuring and examination devices'**
  String get promoSubtitle;

  /// No description provided for @promoButton.
  ///
  /// In en, this message translates to:
  /// **'Shop now'**
  String get promoButton;

  /// No description provided for @productsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} products'**
  String productsCount(int count);

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// No description provided for @filterLabel.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filterLabel;

  /// No description provided for @sortDefault.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get sortDefault;

  /// No description provided for @sortPriceLow.
  ///
  /// In en, this message translates to:
  /// **'Price: low to high'**
  String get sortPriceLow;

  /// No description provided for @sortPriceHigh.
  ///
  /// In en, this message translates to:
  /// **'Price: high to low'**
  String get sortPriceHigh;

  /// No description provided for @noProductsInCategory.
  ///
  /// In en, this message translates to:
  /// **'No products in this category yet'**
  String get noProductsInCategory;

  /// No description provided for @stockLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} left'**
  String stockLeft(int count);

  /// No description provided for @specsTitle.
  ///
  /// In en, this message translates to:
  /// **'Specifications'**
  String get specsTitle;

  /// No description provided for @specsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Information provided by the manufacturer'**
  String get specsSubtitle;

  /// No description provided for @specManufacturer.
  ///
  /// In en, this message translates to:
  /// **'Manufacturer'**
  String get specManufacturer;

  /// No description provided for @specIntendedUse.
  ///
  /// In en, this message translates to:
  /// **'Intended use'**
  String get specIntendedUse;

  /// No description provided for @specCertifications.
  ///
  /// In en, this message translates to:
  /// **'Certifications'**
  String get specCertifications;

  /// No description provided for @specSku.
  ///
  /// In en, this message translates to:
  /// **'Product number'**
  String get specSku;

  /// No description provided for @notSpecified.
  ///
  /// In en, this message translates to:
  /// **'Not specified'**
  String get notSpecified;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addToCart;

  /// No description provided for @addedToCart.
  ///
  /// In en, this message translates to:
  /// **'Added to cart'**
  String get addedToCart;

  /// No description provided for @productNotFound.
  ///
  /// In en, this message translates to:
  /// **'Product not found'**
  String get productNotFound;

  /// No description provided for @recentSearches.
  ///
  /// In en, this message translates to:
  /// **'Recent searches'**
  String get recentSearches;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearAll;

  /// No description provided for @mostSearched.
  ///
  /// In en, this message translates to:
  /// **'Most searched'**
  String get mostSearched;

  /// No description provided for @filterPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get filterPrice;

  /// No description provided for @filterAvailability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get filterAvailability;

  /// No description provided for @filterCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get filterCategory;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// No description provided for @noResultsHint.
  ///
  /// In en, this message translates to:
  /// **'Try other keywords or change the filters'**
  String get noResultsHint;

  /// No description provided for @resultsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No results} =1{1 result} other{{count} results}}'**
  String resultsCount(int count);

  /// No description provided for @cartItemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item} other{{count} items}}'**
  String cartItemsCount(int count);

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @deliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get deliveryFee;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @proceedToPayment.
  ///
  /// In en, this message translates to:
  /// **'Proceed to payment'**
  String get proceedToPayment;

  /// No description provided for @cartEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cartEmptyTitle;

  /// No description provided for @cartEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Add medical products and they will show up here'**
  String get cartEmptyHint;

  /// No description provided for @browseProducts.
  ///
  /// In en, this message translates to:
  /// **'Browse products'**
  String get browseProducts;

  /// No description provided for @maxQuantityReached.
  ///
  /// In en, this message translates to:
  /// **'You have reached the maximum available quantity'**
  String get maxQuantityReached;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesTitle;

  /// No description provided for @favoritesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 product} other{{count} products}}'**
  String favoritesCount(int count);

  /// No description provided for @favoritesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get favoritesEmptyTitle;

  /// No description provided for @favoritesEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart on any product you like and you’ll find it here'**
  String get favoritesEmptyHint;

  /// No description provided for @profileNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'[Full name]'**
  String get profileNamePlaceholder;

  /// No description provided for @menuMyData.
  ///
  /// In en, this message translates to:
  /// **'My details'**
  String get menuMyData;

  /// No description provided for @menuAddresses.
  ///
  /// In en, this message translates to:
  /// **'My addresses'**
  String get menuAddresses;

  /// No description provided for @menuNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get menuNotifications;

  /// No description provided for @menuLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get menuLanguage;

  /// No description provided for @menuHelp.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get menuHelp;

  /// No description provided for @menuLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get menuLogout;

  /// No description provided for @langArabicDesc.
  ///
  /// In en, this message translates to:
  /// **'Arabic language'**
  String get langArabicDesc;

  /// No description provided for @langFrenchDesc.
  ///
  /// In en, this message translates to:
  /// **'French language'**
  String get langFrenchDesc;

  /// No description provided for @langEnglishDesc.
  ///
  /// In en, this message translates to:
  /// **'English language'**
  String get langEnglishDesc;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'You will need to sign in again to access your account.'**
  String get logoutConfirmMessage;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneLabel;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get changePhoto;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @changesSaved.
  ///
  /// In en, this message translates to:
  /// **'Changes saved'**
  String get changesSaved;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get invalidEmail;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid mobile number: 10 digits starting with 05, 06 or 07'**
  String get invalidPhone;

  /// No description provided for @discardTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get discardTitle;

  /// No description provided for @discardMessage.
  ///
  /// In en, this message translates to:
  /// **'You have unsaved changes. If you leave now, they will be lost.'**
  String get discardMessage;

  /// No description provided for @discardConfirm.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discardConfirm;

  /// No description provided for @keepEditing.
  ///
  /// In en, this message translates to:
  /// **'Keep editing'**
  String get keepEditing;

  /// No description provided for @photoCamera.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get photoCamera;

  /// No description provided for @photoGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get photoGallery;

  /// No description provided for @photoRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get photoRemove;

  /// No description provided for @securityTitle.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get securityTitle;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @newPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter the new password'**
  String get newPasswordRequired;

  /// No description provided for @passwordNeedsLetterAndDigit.
  ///
  /// In en, this message translates to:
  /// **'Must contain a letter and a digit'**
  String get passwordNeedsLetterAndDigit;

  /// No description provided for @passwordSameAsCurrent.
  ///
  /// In en, this message translates to:
  /// **'Choose a password different from the current one'**
  String get passwordSameAsCurrent;

  /// No description provided for @passwordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password changed'**
  String get passwordChanged;

  /// No description provided for @currentPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPasswordLabel;

  /// No description provided for @confirmNewPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get confirmNewPasswordLabel;

  /// No description provided for @currentPasswordWrong.
  ///
  /// In en, this message translates to:
  /// **'Current password is incorrect'**
  String get currentPasswordWrong;

  /// No description provided for @forgotCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your current password?'**
  String get forgotCurrentPassword;

  /// No description provided for @passwordStrengthLabel.
  ///
  /// In en, this message translates to:
  /// **'Password strength'**
  String get passwordStrengthLabel;

  /// No description provided for @strengthWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get strengthWeak;

  /// No description provided for @strengthMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get strengthMedium;

  /// No description provided for @strengthStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get strengthStrong;

  /// No description provided for @ruleMinLength.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get ruleMinLength;

  /// No description provided for @ruleLetter.
  ///
  /// In en, this message translates to:
  /// **'A letter'**
  String get ruleLetter;

  /// No description provided for @ruleDigit.
  ///
  /// In en, this message translates to:
  /// **'A digit'**
  String get ruleDigit;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get genericError;

  /// No description provided for @backToSearch.
  ///
  /// In en, this message translates to:
  /// **'Back to search'**
  String get backToSearch;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @offlineTitle.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get offlineTitle;

  /// No description provided for @offlineMessage.
  ///
  /// In en, this message translates to:
  /// **'Check your connection and try again'**
  String get offlineMessage;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorTitle;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'We couldn’t complete the operation. Please try again.'**
  String get errorMessage;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add new address'**
  String get addNewAddress;

  /// No description provided for @addAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Add address'**
  String get addAddressTitle;

  /// No description provided for @addressNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Address name'**
  String get addressNameLabel;

  /// No description provided for @addressNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Home'**
  String get addressNameHint;

  /// No description provided for @wilayaLabel.
  ///
  /// In en, this message translates to:
  /// **'Wilaya (province)'**
  String get wilayaLabel;

  /// No description provided for @wilayaHint.
  ///
  /// In en, this message translates to:
  /// **'Select wilaya'**
  String get wilayaHint;

  /// No description provided for @communeLabel.
  ///
  /// In en, this message translates to:
  /// **'Commune (municipality)'**
  String get communeLabel;

  /// No description provided for @communeHint.
  ///
  /// In en, this message translates to:
  /// **'Select commune'**
  String get communeHint;

  /// No description provided for @addressDetailsLabel.
  ///
  /// In en, this message translates to:
  /// **'Detailed address'**
  String get addressDetailsLabel;

  /// No description provided for @addressDetailsHint.
  ///
  /// In en, this message translates to:
  /// **'Street, neighborhood, building number'**
  String get addressDetailsHint;

  /// No description provided for @setAsDefault.
  ///
  /// In en, this message translates to:
  /// **'Set as default address'**
  String get setAsDefault;

  /// No description provided for @saveAddress.
  ///
  /// In en, this message translates to:
  /// **'Save address'**
  String get saveAddress;

  /// No description provided for @defaultBadge.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultBadge;

  /// No description provided for @addressSavedMessage.
  ///
  /// In en, this message translates to:
  /// **'Address saved'**
  String get addressSavedMessage;

  /// No description provided for @selectWilayaError.
  ///
  /// In en, this message translates to:
  /// **'Select a wilaya'**
  String get selectWilayaError;

  /// No description provided for @selectCommuneError.
  ///
  /// In en, this message translates to:
  /// **'Select a commune'**
  String get selectCommuneError;

  /// No description provided for @addressDetailsRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter the detailed address'**
  String get addressDetailsRequired;

  /// No description provided for @searchOptionHint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchOptionHint;

  /// No description provided for @checkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkoutTitle;

  /// No description provided for @deliveryAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery address'**
  String get deliveryAddressTitle;

  /// No description provided for @deliveryMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery method'**
  String get deliveryMethodTitle;

  /// No description provided for @paymentMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethodTitle;

  /// No description provided for @changeAction.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get changeAction;

  /// No description provided for @confirmOrder.
  ///
  /// In en, this message translates to:
  /// **'Confirm order'**
  String get confirmOrder;

  /// No description provided for @noAddressYet.
  ///
  /// In en, this message translates to:
  /// **'No delivery address yet'**
  String get noAddressYet;

  /// No description provided for @paymentInfoBanner.
  ///
  /// In en, this message translates to:
  /// **'Available payment methods will be set later. The options below are temporary.'**
  String get paymentInfoBanner;

  /// No description provided for @orderReceivedTitle.
  ///
  /// In en, this message translates to:
  /// **'Your order has been received'**
  String get orderReceivedTitle;

  /// No description provided for @orderReceivedMessage.
  ///
  /// In en, this message translates to:
  /// **'Thank you for trusting Nabd. We’ll let you know when your order status changes.'**
  String get orderReceivedMessage;

  /// No description provided for @orderNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Order number'**
  String get orderNumberLabel;

  /// No description provided for @trackOrder.
  ///
  /// In en, this message translates to:
  /// **'Track order'**
  String get trackOrder;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backToHome;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
