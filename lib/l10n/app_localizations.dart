import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

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
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @plan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get plan;

  /// No description provided for @upgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get upgrade;

  /// No description provided for @activities.
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get activities;

  /// No description provided for @trackprogress.
  ///
  /// In en, this message translates to:
  /// **'Track your progress'**
  String get trackprogress;

  /// No description provided for @lastsevendays.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get lastsevendays;

  /// No description provided for @lastTwelvemonths.
  ///
  /// In en, this message translates to:
  /// **'Last 12 months'**
  String get lastTwelvemonths;

  /// No description provided for @lessonCompleted.
  ///
  /// In en, this message translates to:
  /// **'LESSON COMPLETED'**
  String get lessonCompleted;

  /// No description provided for @conversationCompleted.
  ///
  /// In en, this message translates to:
  /// **'CONVERSATION COMPLETED'**
  String get conversationCompleted;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @policy_title.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get policy_title;

  /// No description provided for @policy_header.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy for Flashcard Learning App'**
  String get policy_header;

  /// No description provided for @policy_last_updated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: October 26, 2023'**
  String get policy_last_updated;

  /// No description provided for @policy_section_1_title.
  ///
  /// In en, this message translates to:
  /// **'1. Introduction'**
  String get policy_section_1_title;

  /// No description provided for @policy_section_1_body.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Flashcard Learning App. We are committed to protecting your personal information and your right to privacy. If you have any questions or concerns about our policy, or our practices with regards to your personal information, please contact us at support@flashcardlearning.com.'**
  String get policy_section_1_body;

  /// No description provided for @policy_section_2_title.
  ///
  /// In en, this message translates to:
  /// **'2. Information We Collect'**
  String get policy_section_2_title;

  /// No description provided for @policy_section_2_body_1.
  ///
  /// In en, this message translates to:
  /// **'We collect personal information that you voluntarily provide to us when you register on the app, express an interest in obtaining information about us or our products and services, when you participate in activities on the app or otherwise when you contact us.'**
  String get policy_section_2_body_1;

  /// No description provided for @policy_section_2_body_2.
  ///
  /// In en, this message translates to:
  /// **'The personal information that we collect depends on the context of your interactions with us and the app, the choices you make and the products and features you use. The personal information we collect may include the following: name, email address, and user-generated content like flashcards.'**
  String get policy_section_2_body_2;

  /// No description provided for @policy_section_3_title.
  ///
  /// In en, this message translates to:
  /// **'3. How We Use Your Information'**
  String get policy_section_3_title;

  /// No description provided for @policy_section_3_body.
  ///
  /// In en, this message translates to:
  /// **'We use personal information collected via our app for a variety of business purposes described below. We process your personal information for these purposes in reliance on our legitimate business interests, in order to enter into or perform a contract with you, with your consent, and/or for compliance with our legal obligations.'**
  String get policy_section_3_body;

  /// No description provided for @policy_section_4_title.
  ///
  /// In en, this message translates to:
  /// **'4. Will Your Information Be Shared With Anyone?'**
  String get policy_section_4_title;

  /// No description provided for @policy_section_4_body.
  ///
  /// In en, this message translates to:
  /// **'We only share information with your consent, to comply with laws, to provide you with services, to protect your rights, or to fulfill business obligations.'**
  String get policy_section_4_body;

  /// No description provided for @policy_section_5_title.
  ///
  /// In en, this message translates to:
  /// **'5. Contact Us'**
  String get policy_section_5_title;

  /// No description provided for @policy_section_5_body.
  ///
  /// In en, this message translates to:
  /// **'If you have questions or comments about this policy, you may email us at support@flashcardlearning.com.'**
  String get policy_section_5_body;

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_title;

  /// No description provided for @profile_username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get profile_username;

  /// No description provided for @profile_modify.
  ///
  /// In en, this message translates to:
  /// **'Modify'**
  String get profile_modify;

  /// No description provided for @profile_enter_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get profile_enter_name;

  /// No description provided for @profile_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get profile_confirm;

  /// No description provided for @profile_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profile_cancel;

  /// No description provided for @profile_plan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get profile_plan;

  /// No description provided for @profile_upgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get profile_upgrade;

  /// No description provided for @profile_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get profile_policy;

  /// No description provided for @profile_terms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get profile_terms;

  /// No description provided for @term_title.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get term_title;

  /// No description provided for @term_header.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service for Flashcard Learning App'**
  String get term_header;

  /// No description provided for @term_last_updated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: October 26, 2023'**
  String get term_last_updated;

  /// No description provided for @term_1_title.
  ///
  /// In en, this message translates to:
  /// **'1. Acceptance of Terms'**
  String get term_1_title;

  /// No description provided for @term_1_body.
  ///
  /// In en, this message translates to:
  /// **'By accessing or using the Flashcard Learning App, you agree to be bound by these Terms of Service and our Privacy Policy. If you disagree with any part of the terms, you may not access our service.'**
  String get term_1_body;

  /// No description provided for @term_2_title.
  ///
  /// In en, this message translates to:
  /// **'2. User Accounts'**
  String get term_2_title;

  /// No description provided for @term_2_body_1.
  ///
  /// In en, this message translates to:
  /// **'You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account.'**
  String get term_2_body_1;

  /// No description provided for @term_2_body_2.
  ///
  /// In en, this message translates to:
  /// **'You must be at least 13 years old to use this service. If you are under 18, you must have parental consent to use this app.'**
  String get term_2_body_2;

  /// No description provided for @term_3_title.
  ///
  /// In en, this message translates to:
  /// **'3. User-Generated Content'**
  String get term_3_title;

  /// No description provided for @term_3_body_1.
  ///
  /// In en, this message translates to:
  /// **'You retain all rights to the flashcards and other content you create using our app. By submitting content, you grant us a worldwide, non-exclusive, royalty-free license to use, store, and display that content for the purpose of providing our services to you.'**
  String get term_3_body_1;

  /// No description provided for @term_3_body_2.
  ///
  /// In en, this message translates to:
  /// **'You are solely responsible for the content you create and share. You agree not to create content that is illegal, offensive, or infringes on others\' intellectual property rights.'**
  String get term_3_body_2;

  /// No description provided for @term_4_title.
  ///
  /// In en, this message translates to:
  /// **'4. Prohibited Activities'**
  String get term_4_title;

  /// No description provided for @term_4_intro.
  ///
  /// In en, this message translates to:
  /// **'You may not use our service to:'**
  String get term_4_intro;

  /// No description provided for @term_4_list_1.
  ///
  /// In en, this message translates to:
  /// **'• Violate any laws or regulations'**
  String get term_4_list_1;

  /// No description provided for @term_4_list_2.
  ///
  /// In en, this message translates to:
  /// **'• Infringe on intellectual property rights'**
  String get term_4_list_2;

  /// No description provided for @term_4_list_3.
  ///
  /// In en, this message translates to:
  /// **'• Harass, abuse, or harm others'**
  String get term_4_list_3;

  /// No description provided for @term_4_list_4.
  ///
  /// In en, this message translates to:
  /// **'• Distribute malware or malicious code'**
  String get term_4_list_4;

  /// No description provided for @term_4_list_5.
  ///
  /// In en, this message translates to:
  /// **'• Attempt to gain unauthorized access to our systems'**
  String get term_4_list_5;

  /// No description provided for @term_5_title.
  ///
  /// In en, this message translates to:
  /// **'5. Service Modifications and Availability'**
  String get term_5_title;

  /// No description provided for @term_5_body.
  ///
  /// In en, this message translates to:
  /// **'We reserve the right to modify, suspend, or discontinue any part of our service at any time. We do not guarantee that our service will be available uninterrupted or error-free.'**
  String get term_5_body;

  /// No description provided for @term_6_title.
  ///
  /// In en, this message translates to:
  /// **'6. Termination'**
  String get term_6_title;

  /// No description provided for @term_6_body.
  ///
  /// In en, this message translates to:
  /// **'We may terminate or suspend your account immediately, without prior notice, for conduct that we believe violates these Terms of Service or is harmful to other users, us, or third parties, or for any other reason.'**
  String get term_6_body;

  /// No description provided for @term_7_title.
  ///
  /// In en, this message translates to:
  /// **'7. Disclaimer of Warranties'**
  String get term_7_title;

  /// No description provided for @term_7_body.
  ///
  /// In en, this message translates to:
  /// **'The service is provided \"as is\" without warranties of any kind, either express or implied. We do not warrant that the service will meet your requirements or be available on an uninterrupted, secure, or error-free basis.'**
  String get term_7_body;

  /// No description provided for @term_8_title.
  ///
  /// In en, this message translates to:
  /// **'8. Limitation of Liability'**
  String get term_8_title;

  /// No description provided for @term_8_body.
  ///
  /// In en, this message translates to:
  /// **'To the maximum extent permitted by law, we shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues.'**
  String get term_8_body;

  /// No description provided for @term_9_title.
  ///
  /// In en, this message translates to:
  /// **'9. Changes to Terms'**
  String get term_9_title;

  /// No description provided for @term_9_body.
  ///
  /// In en, this message translates to:
  /// **'We reserve the right to modify these terms at any time. We will provide notice of significant changes through our app or via email. Continued use of our service after changes constitutes acceptance of the new terms.'**
  String get term_9_body;

  /// No description provided for @term_10_title.
  ///
  /// In en, this message translates to:
  /// **'10. Governing Law'**
  String get term_10_title;

  /// No description provided for @term_10_body.
  ///
  /// In en, this message translates to:
  /// **'These terms shall be governed by and construed in accordance with the laws of the jurisdiction where our company is established, without regard to its conflict of law provisions.'**
  String get term_10_body;

  /// No description provided for @term_11_title.
  ///
  /// In en, this message translates to:
  /// **'11. Contact Us'**
  String get term_11_title;

  /// No description provided for @term_11_body.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions about these Terms of Service, please contact us at support@flashcardlearning.com.'**
  String get term_11_body;

  /// No description provided for @login_welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get login_welcome_back;

  /// No description provided for @login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your learning journey'**
  String get login_subtitle;

  /// No description provided for @login_email_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get login_email_required;

  /// No description provided for @login_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_password;

  /// No description provided for @login_password_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get login_password_required;

  /// No description provided for @login_button.
  ///
  /// In en, this message translates to:
  /// **'LOGIN'**
  String get login_button;

  /// No description provided for @login_or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get login_or;

  /// No description provided for @login_no_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get login_no_account;

  /// No description provided for @login_signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get login_signup;

  /// No description provided for @register_create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get register_create_account;

  /// No description provided for @register_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Start your learning journey today'**
  String get register_subtitle;

  /// No description provided for @register_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get register_email;

  /// No description provided for @register_email_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get register_email_required;

  /// No description provided for @register_email_invalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get register_email_invalid;

  /// No description provided for @register_username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get register_username;

  /// No description provided for @register_username_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter a username'**
  String get register_username_required;

  /// No description provided for @register_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get register_password;

  /// No description provided for @register_password_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get register_password_required;

  /// No description provided for @register_password_min_length.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get register_password_min_length;

  /// No description provided for @register_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get register_confirm_password;

  /// No description provided for @register_confirm_password_required.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get register_confirm_password_required;

  /// No description provided for @register_password_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get register_password_not_match;

  /// No description provided for @register_sign_up_button.
  ///
  /// In en, this message translates to:
  /// **'SIGN UP'**
  String get register_sign_up_button;

  /// No description provided for @register_done.
  ///
  /// In en, this message translates to:
  /// **'Registration Successful'**
  String get register_done;

  /// No description provided for @register_done_body.
  ///
  /// In en, this message translates to:
  /// **'Your account has been created successfully'**
  String get register_done_body;

  /// No description provided for @register_failed.
  ///
  /// In en, this message translates to:
  /// **'Registration Failed'**
  String get register_failed;

  /// No description provided for @register_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get register_have_account;

  /// No description provided for @register_login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get register_login;

  /// No description provided for @chat_title_receive_plus.
  ///
  /// In en, this message translates to:
  /// **'Receive Plus Version'**
  String get chat_title_receive_plus;

  /// No description provided for @chat_drawer_conversations.
  ///
  /// In en, this message translates to:
  /// **'Conversations'**
  String get chat_drawer_conversations;

  /// No description provided for @chat_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get chat_search;

  /// No description provided for @chat_rename_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Rename Conversation'**
  String get chat_rename_dialog_title;

  /// No description provided for @chat_rename_dialog_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter new name'**
  String get chat_rename_dialog_hint;

  /// No description provided for @chat_button_ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get chat_button_ok;

  /// No description provided for @chat_button_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get chat_button_cancel;

  /// No description provided for @chat_delete_title.
  ///
  /// In en, this message translates to:
  /// **'Delete Conversation'**
  String get chat_delete_title;

  /// No description provided for @chat_delete_confirm_body.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to delete this conversation?'**
  String get chat_delete_confirm_body;

  /// No description provided for @chat_error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get chat_error;

  /// No description provided for @chat_check_connection.
  ///
  /// In en, this message translates to:
  /// **'Check internet connection'**
  String get chat_check_connection;

  /// No description provided for @chat_blank_title.
  ///
  /// In en, this message translates to:
  /// **'Start a Conversation'**
  String get chat_blank_title;

  /// No description provided for @chat_blank_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Select a conversation from the menu\nor create a new one to begin chatting!'**
  String get chat_blank_subtitle;

  /// No description provided for @chat_input_hint.
  ///
  /// In en, this message translates to:
  /// **'Type your message...'**
  String get chat_input_hint;

  /// No description provided for @chat_attach_file.
  ///
  /// In en, this message translates to:
  /// **'Attach file tapped'**
  String get chat_attach_file;

  /// No description provided for @chat_cancle.
  ///
  /// In en, this message translates to:
  /// **'Cancle'**
  String get chat_cancle;

  /// No description provided for @dict_title.
  ///
  /// In en, this message translates to:
  /// **'📖 Dictionary'**
  String get dict_title;

  /// No description provided for @dict_ask.
  ///
  /// In en, this message translates to:
  /// **'What do you want to search?'**
  String get dict_ask;

  /// No description provided for @dict_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter the phrase you want to search'**
  String get dict_hint;

  /// No description provided for @dict_button_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get dict_button_search;

  /// No description provided for @dict_pronounce.
  ///
  /// In en, this message translates to:
  /// **'Pronounce'**
  String get dict_pronounce;

  /// No description provided for @dict_pronounce_desc.
  ///
  /// In en, this message translates to:
  /// **'Speak phrase to check pronunciation'**
  String get dict_pronounce_desc;

  /// No description provided for @dict_image.
  ///
  /// In en, this message translates to:
  /// **'Search by Image'**
  String get dict_image;

  /// No description provided for @dict_image_desc.
  ///
  /// In en, this message translates to:
  /// **'Speak phrase to check pronunciation'**
  String get dict_image_desc;

  /// No description provided for @dict_popular.
  ///
  /// In en, this message translates to:
  /// **'Popular search words'**
  String get dict_popular;

  /// No description provided for @image_title.
  ///
  /// In en, this message translates to:
  /// **'Text Recognition'**
  String get image_title;

  /// No description provided for @image_pick_image.
  ///
  /// In en, this message translates to:
  /// **'Pick an image'**
  String get image_pick_image;

  /// No description provided for @image_press_to_add.
  ///
  /// In en, this message translates to:
  /// **'Press + to add an image'**
  String get image_press_to_add;

  /// No description provided for @image_cannot_find.
  ///
  /// In en, this message translates to:
  /// **'Can not find any word'**
  String get image_cannot_find;

  /// No description provided for @image_too_many.
  ///
  /// In en, this message translates to:
  /// **'Too many words, please choose another picture'**
  String get image_too_many;

  /// No description provided for @image_recognized_word.
  ///
  /// In en, this message translates to:
  /// **'Recognized word: '**
  String get image_recognized_word;

  /// No description provided for @image_button_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get image_button_search;

  /// No description provided for @voice_hint_press_and_speak.
  ///
  /// In en, this message translates to:
  /// **'Please press mic and speak out loud'**
  String get voice_hint_press_and_speak;

  /// No description provided for @voice_correction.
  ///
  /// In en, this message translates to:
  /// **'Correction: '**
  String get voice_correction;

  /// No description provided for @voice_button_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get voice_button_search;

  /// No description provided for @icon_picker_choose_icon.
  ///
  /// In en, this message translates to:
  /// **'Choose an icon'**
  String get icon_picker_choose_icon;

  /// No description provided for @icon_picker_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'-- Choose an icon --'**
  String get icon_picker_dialog_title;

  /// No description provided for @icon_picker_discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get icon_picker_discard;

  /// No description provided for @public_flashcard_title.
  ///
  /// In en, this message translates to:
  /// **'Flashcard Public'**
  String get public_flashcard_title;

  /// No description provided for @public_flashcard_no_sets.
  ///
  /// In en, this message translates to:
  /// **'No Flashcard Sets Yet'**
  String get public_flashcard_no_sets;

  /// No description provided for @public_flashcard_no_sets_desc.
  ///
  /// In en, this message translates to:
  /// **'Start your learning journey by creating your first flashcard set!'**
  String get public_flashcard_no_sets_desc;

  /// No description provided for @myset_title.
  ///
  /// In en, this message translates to:
  /// **'Flashcard'**
  String get myset_title;

  /// No description provided for @myset_hint_enter_name.
  ///
  /// In en, this message translates to:
  /// **'Enter flashcard Set\'s name'**
  String get myset_hint_enter_name;

  /// No description provided for @myset_discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get myset_discard;

  /// No description provided for @myset_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get myset_save;

  /// No description provided for @myset_error_need_name.
  ///
  /// In en, this message translates to:
  /// **'Please input name of Set'**
  String get myset_error_need_name;

  /// No description provided for @myset_created_success.
  ///
  /// In en, this message translates to:
  /// **'Created new Flashcard Set'**
  String get myset_created_success;

  /// No description provided for @myset_created_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to create Flashcard Set'**
  String get myset_created_failed;

  /// No description provided for @myset_updated_success.
  ///
  /// In en, this message translates to:
  /// **'Updated Flashcard Set'**
  String get myset_updated_success;

  /// No description provided for @myset_updated_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update Flashcard Set'**
  String get myset_updated_failed;

  /// No description provided for @myset_delete_title.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to delete this set'**
  String get myset_delete_title;

  /// No description provided for @myset_delete_button.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get myset_delete_button;

  /// No description provided for @myset_blank_title.
  ///
  /// In en, this message translates to:
  /// **'No Flashcard Sets Yet'**
  String get myset_blank_title;

  /// No description provided for @myset_blank_desc.
  ///
  /// In en, this message translates to:
  /// **'Start your learning journey by creating your first flashcard set!'**
  String get myset_blank_desc;

  /// No description provided for @myset_blank_btn.
  ///
  /// In en, this message translates to:
  /// **'Create New Set'**
  String get myset_blank_btn;

  /// No description provided for @flashItem_cards.
  ///
  /// In en, this message translates to:
  /// **'cards'**
  String get flashItem_cards;

  /// No description provided for @flashItem_studyNow.
  ///
  /// In en, this message translates to:
  /// **'Study now'**
  String get flashItem_studyNow;

  /// No description provided for @flashItem_completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get flashItem_completed;

  /// No description provided for @flashItem_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get flashItem_edit;

  /// No description provided for @flashItem_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get flashItem_delete;

  /// No description provided for @flashItem_share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get flashItem_share;

  /// No description provided for @aiConv_title.
  ///
  /// In en, this message translates to:
  /// **'🚀 AI Conversations'**
  String get aiConv_title;

  /// No description provided for @aiConv_subtitle.
  ///
  /// In en, this message translates to:
  /// **'There are 3 conversations'**
  String get aiConv_subtitle;

  /// No description provided for @card_time_label.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get card_time_label;

  /// No description provided for @error_title.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error_title;

  /// No description provided for @error_check_internet.
  ///
  /// In en, this message translates to:
  /// **'Check internet connection'**
  String get error_check_internet;

  /// No description provided for @input_type_message.
  ///
  /// In en, this message translates to:
  /// **'Type your message...'**
  String get input_type_message;

  /// No description provided for @conversation_done.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! 🎉🎉 You just completed this conversation'**
  String get conversation_done;

  /// No description provided for @conversation_done_avg_score.
  ///
  /// In en, this message translates to:
  /// **'Average Score:'**
  String get conversation_done_avg_score;

  /// No description provided for @home_review_flashcard.
  ///
  /// In en, this message translates to:
  /// **'Review words in flashcard'**
  String get home_review_flashcard;

  /// No description provided for @home_learn_public.
  ///
  /// In en, this message translates to:
  /// **'Learn community flashcards'**
  String get home_learn_public;

  /// No description provided for @home_welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome back,\n'**
  String get home_welcome_back;

  /// No description provided for @home_what_should_do_today.
  ///
  /// In en, this message translates to:
  /// **'What should we do today?'**
  String get home_what_should_do_today;

  /// No description provided for @onboarding_title_1.
  ///
  /// In en, this message translates to:
  /// **'Unlock Your English Potential!'**
  String get onboarding_title_1;

  /// No description provided for @onboarding_body_1.
  ///
  /// In en, this message translates to:
  /// **'Learn faster with interactive flashcards designed for your success.'**
  String get onboarding_body_1;

  /// No description provided for @onboarding_title_2.
  ///
  /// In en, this message translates to:
  /// **'Turn Words Into Knowledge!'**
  String get onboarding_title_2;

  /// No description provided for @onboarding_body_2.
  ///
  /// In en, this message translates to:
  /// **'Discover the power of consistent practice and effortless learning.'**
  String get onboarding_body_2;

  /// No description provided for @onboarding_title_3.
  ///
  /// In en, this message translates to:
  /// **'Master English, One Card at a Time!'**
  String get onboarding_title_3;

  /// No description provided for @onboarding_body_3.
  ///
  /// In en, this message translates to:
  /// **'Your path to fluency starts here—take the first step today.'**
  String get onboarding_body_3;

  /// No description provided for @onboarding_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboarding_skip;

  /// No description provided for @onboarding_get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboarding_get_started;

  /// No description provided for @nav_home.
  ///
  /// In en, this message translates to:
  /// **'Homepage'**
  String get nav_home;

  /// No description provided for @nav_dictionary.
  ///
  /// In en, this message translates to:
  /// **'Dictionary'**
  String get nav_dictionary;

  /// No description provided for @nav_chat_with_ai.
  ///
  /// In en, this message translates to:
  /// **'Chat with AI'**
  String get nav_chat_with_ai;

  /// No description provided for @nav_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get nav_profile;

  /// No description provided for @sr_not_found_title.
  ///
  /// In en, this message translates to:
  /// **'Word Not Found'**
  String get sr_not_found_title;

  /// No description provided for @sr_not_found_desc.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find the word you\'re looking for. Please try another search.'**
  String get sr_not_found_desc;

  /// No description provided for @sr_search_again.
  ///
  /// In en, this message translates to:
  /// **'Search Again'**
  String get sr_search_again;

  /// No description provided for @sr_dictionary_title.
  ///
  /// In en, this message translates to:
  /// **'Dictionary'**
  String get sr_dictionary_title;

  /// No description provided for @sr_definition.
  ///
  /// In en, this message translates to:
  /// **'📘 Definition'**
  String get sr_definition;

  /// No description provided for @sr_no_meaning.
  ///
  /// In en, this message translates to:
  /// **'We could not find the meaning'**
  String get sr_no_meaning;

  /// No description provided for @sr_example.
  ///
  /// In en, this message translates to:
  /// **'✅ Example'**
  String get sr_example;

  /// No description provided for @sr_no_example.
  ///
  /// In en, this message translates to:
  /// **'We could not find the example'**
  String get sr_no_example;

  /// No description provided for @sr_watch_others.
  ///
  /// In en, this message translates to:
  /// **'Watch others practice >'**
  String get sr_watch_others;

  /// No description provided for @up_title.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Your Plan'**
  String get up_title;

  /// No description provided for @up_basic.
  ///
  /// In en, this message translates to:
  /// **'Basic'**
  String get up_basic;

  /// No description provided for @up_basic_price.
  ///
  /// In en, this message translates to:
  /// **'\$4.99/month'**
  String get up_basic_price;

  /// No description provided for @up_unlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Flashcards'**
  String get up_unlimited;

  /// No description provided for @up_basic_analytics.
  ///
  /// In en, this message translates to:
  /// **'Basic Analytics'**
  String get up_basic_analytics;

  /// No description provided for @up_no_ads.
  ///
  /// In en, this message translates to:
  /// **'No Ads'**
  String get up_no_ads;

  /// No description provided for @up_advanced_analytics.
  ///
  /// In en, this message translates to:
  /// **'Advanced Analytics'**
  String get up_advanced_analytics;

  /// No description provided for @up_priority_support.
  ///
  /// In en, this message translates to:
  /// **'Priority Support'**
  String get up_priority_support;

  /// No description provided for @up_plus.
  ///
  /// In en, this message translates to:
  /// **'Plus'**
  String get up_plus;

  /// No description provided for @up_plus_price.
  ///
  /// In en, this message translates to:
  /// **'\$9.99/month'**
  String get up_plus_price;

  /// No description provided for @up_recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get up_recommended;

  /// No description provided for @up_upgrade_now.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Now'**
  String get up_upgrade_now;

  /// No description provided for @up_upgrading_snack.
  ///
  /// In en, this message translates to:
  /// **'Upgrading...'**
  String get up_upgrading_snack;

  /// No description provided for @myset_share_error.
  ///
  /// In en, this message translates to:
  /// **'Can not share empty set'**
  String get myset_share_error;

  /// No description provided for @myset_share_success.
  ///
  /// In en, this message translates to:
  /// **'Share success'**
  String get myset_share_success;

  /// No description provided for @please_login_again.
  ///
  /// In en, this message translates to:
  /// **'Please login again'**
  String get please_login_again;

  /// No description provided for @session_expired.
  ///
  /// In en, this message translates to:
  /// **'Session expired'**
  String get session_expired;

  /// No description provided for @sorry_For_now_feature_not_available.
  ///
  /// In en, this message translates to:
  /// **'Sorry, for now, this feature is not available'**
  String get sorry_For_now_feature_not_available;

  /// No description provided for @chat_error_title.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get chat_error_title;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
