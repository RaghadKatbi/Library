import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @signin.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signin;

  /// No description provided for @donthave.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have account?'**
  String get donthave;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get user;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify Password'**
  String get verify;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create Your Account'**
  String get create;

  /// No description provided for @mybook.
  ///
  /// In en, this message translates to:
  /// **'My book'**
  String get mybook;

  /// No description provided for @books.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get books;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @author.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get author;

  /// No description provided for @booksfromthis.
  ///
  /// In en, this message translates to:
  /// **'All the books'**
  String get booksfromthis;

  /// No description provided for @addbook.
  ///
  /// In en, this message translates to:
  /// **'Add book'**
  String get addbook;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @myprofile.
  ///
  /// In en, this message translates to:
  /// **'My profile'**
  String get myprofile;

  /// No description provided for @bookt.
  ///
  /// In en, this message translates to:
  /// **'Book Title'**
  String get bookt;

  /// No description provided for @desc.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get desc;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @numberofpage.
  ///
  /// In en, this message translates to:
  /// **'Number of page'**
  String get numberofpage;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @publishdate.
  ///
  /// In en, this message translates to:
  /// **'Publish date'**
  String get publishdate;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type Your Opinion'**
  String get type;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay with paypal'**
  String get pay;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add to your shelf book'**
  String get add;

  /// No description provided for @authorname.
  ///
  /// In en, this message translates to:
  /// **'Author Name'**
  String get authorname;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education level'**
  String get education;

  /// No description provided for @authorbirthday.
  ///
  /// In en, this message translates to:
  /// **'Author Birthday'**
  String get authorbirthday;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About Author'**
  String get about;

  /// No description provided for @publishname.
  ///
  /// In en, this message translates to:
  /// **'Publish home name'**
  String get publishname;

  /// No description provided for @publishaddress.
  ///
  /// In en, this message translates to:
  /// **'Publish home address'**
  String get publishaddress;

  /// No description provided for @pubemail.
  ///
  /// In en, this message translates to:
  /// **'Publish home email'**
  String get pubemail;

  /// No description provided for @pubphone.
  ///
  /// In en, this message translates to:
  /// **'Publish home phone'**
  String get pubphone;

  /// No description provided for @publishhome.
  ///
  /// In en, this message translates to:
  /// **'Publish Home'**
  String get publishhome;

  /// No description provided for @myshelfbook.
  ///
  /// In en, this message translates to:
  /// **'My Shelf Books'**
  String get myshelfbook;

  /// No description provided for @there.
  ///
  /// In en, this message translates to:
  /// **'There are no selected books yet'**
  String get there;

  /// No description provided for @information_library.
  ///
  /// In en, this message translates to:
  /// **'Information Library'**
  String get information_library;

  /// No description provided for @name_library.
  ///
  /// In en, this message translates to:
  /// **'Name Library'**
  String get name_library;

  /// No description provided for @addresslibrary.
  ///
  /// In en, this message translates to:
  /// **'Library Address'**
  String get addresslibrary;

  /// No description provided for @libraryemail.
  ///
  /// In en, this message translates to:
  /// **'Library Email'**
  String get libraryemail;

  /// No description provided for @libraryphone.
  ///
  /// In en, this message translates to:
  /// **'Library Phone'**
  String get libraryphone;

  /// No description provided for @changepass.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changepass;

  /// No description provided for @myinfo.
  ///
  /// In en, this message translates to:
  /// **'My Information'**
  String get myinfo;

  /// No description provided for @find.
  ///
  /// In en, this message translates to:
  /// **'Find in'**
  String get find;

  /// No description provided for @authors.
  ///
  /// In en, this message translates to:
  /// **'Authors'**
  String get authors;

  /// No description provided for @personal.
  ///
  /// In en, this message translates to:
  /// **'Personal Details'**
  String get personal;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
