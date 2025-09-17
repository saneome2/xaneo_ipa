// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'XaneoMobile';

  @override
  String get welcomeTitle => 'Welcome to Xaneo';

  @override
  String get welcomeDescription =>
      'Xaneo - now in a mobile app! Xaneo has never been so convenient and fast.';

  @override
  String get getStartedButton => 'I\'m already interested';

  @override
  String get connectingToServer => 'Connecting to server...';

  @override
  String version(String version) {
    return 'Version: $version';
  }

  @override
  String httpError(int code) {
    return 'Error: HTTP $code';
  }

  @override
  String connectionError(String error) {
    return 'Connection error: $error';
  }

  @override
  String get updateAvailable => 'Update available!';

  @override
  String get updateDialogTitle => 'Update available!';

  @override
  String updateDialogMessage(String currentVersion, String latestVersion) {
    return 'Your version is $currentVersion, and the new one is $latestVersion';
  }

  @override
  String get updateDialogDescription =>
      'You can update through Google Play, RuStore or from the official Xaneo website.';

  @override
  String get updateButton => 'Update';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get selectUpdateSource => 'Select update source:';

  @override
  String get settings => 'Settings';

  @override
  String get about => 'About';

  @override
  String get help => 'Help';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationsDescription =>
      'Receive notifications about new features';

  @override
  String get darkTheme => 'Dark theme';

  @override
  String get darkThemeDescription => 'Use dark appearance';

  @override
  String fontSize(int size) {
    return 'Font size: $size';
  }

  @override
  String get appVersion => 'App version';

  @override
  String get messengerDemoMode => 'Messenger demo mode';

  @override
  String get language => 'Language';

  @override
  String get languageDescription => 'Choose interface language';

  @override
  String get welcomeMessage => 'Great! Welcome!';

  @override
  String get privacyTitle => 'All your data is secure';

  @override
  String get privacyDescription =>
      'All messages in XaneoConnect are protected by end-to-end encryption. At no point does Xaneo know their content.';

  @override
  String get continueButton => 'Let\'s continue';

  @override
  String get dataStorageTitle => 'All Xaneo data centers are located in Russia';

  @override
  String get dataStorageDescription =>
      'Your data never leaves the country and is stored in secure data centers.';

  @override
  String get finishButton => 'Finish';

  @override
  String get setupCompleted => 'Setup completed!';

  @override
  String get loginFormTitle => 'Let\'s log in';

  @override
  String get registerFormTitle => 'Let\'s get started';

  @override
  String get registerNameSubtitle => 'What\'s your name?';

  @override
  String get nameFieldHint => 'Your name';

  @override
  String get nextButton => 'Next';

  @override
  String get skipButton => 'Skip';

  @override
  String get registerBirthdateSubtitle => 'When were you born?';

  @override
  String get selectDate => 'Select date';

  @override
  String get ageRestrictionsLink => 'What are the age restrictions?';

  @override
  String get ageRestrictionsTitle => 'Registration from 14 years old';

  @override
  String get ageRestrictionsDescription =>
      'You can register on our service if you are 14 years old or older';

  @override
  String get gotIt => 'Got it';

  @override
  String get registerNicknameSubtitle => 'Choose a nickname';

  @override
  String get nicknameFieldHint => 'Your nickname';

  @override
  String get nicknameHelpLink => 'Can\'t think of a nickname?';

  @override
  String get registerEmailSubtitle => 'Enter your email';

  @override
  String get emailFieldHint => 'Your email';

  @override
  String get supportedEmailProvidersLink =>
      'Which email providers are supported?';

  @override
  String get supportedEmailProvidersTitle => 'Supported Email Providers';

  @override
  String get supportedEmailProvidersDescription =>
      'Gmail, Outlook, Yandex, Mail.ru and other popular email services are supported.';

  @override
  String get emailFormatError => 'Invalid email address format';

  @override
  String get emailUnsupportedError => 'This email service is not supported';

  @override
  String get checkingEmail => 'Checking email...';

  @override
  String get emailAvailable => 'Email is available';

  @override
  String get emailTakenError => 'This email is already taken';

  @override
  String get emailServerError => 'Email check error. Please try again later';

  @override
  String get verifyEmailTitle => 'Verify your email';

  @override
  String get verifyEmailDescription =>
      'We sent a 6-digit code to your email. Enter it to confirm.';

  @override
  String get verificationCodeHint => 'Verification code';

  @override
  String get verifyButton => 'Verify';

  @override
  String get registerPasswordSubtitle => 'Create a password';

  @override
  String get registerPasswordFieldHint => 'Enter password';

  @override
  String get passwordInvalidCharsError =>
      'Password can only contain Latin letters, numbers and punctuation marks';

  @override
  String get passwordWeakError =>
      'Password is too weak. Use letters, numbers and special characters';

  @override
  String get passwordMediumWarning =>
      'Medium strength password. Recommend strengthening';

  @override
  String get passwordStrongSuccess => 'Strong password';

  @override
  String get nicknameGeneratorTitle =>
      'Your nickname will be generated automatically';

  @override
  String get nicknameGeneratorDescription =>
      'You can change your nickname at any time';

  @override
  String get closeButton => 'Close';

  @override
  String get loginFieldHint => 'Login';

  @override
  String get passwordFieldHint => 'Password';

  @override
  String get loginButton => 'Log in';

  @override
  String get fillAllFields => 'Fill in all fields';

  @override
  String get loggingIn => 'Logging in...';

  @override
  String welcomeUser(String username) {
    return 'Welcome, $username!';
  }

  @override
  String get invalidCredentials =>
      'Invalid credentials. Check your username and password.';

  @override
  String get serverError => 'Server error. Please try again later.';

  @override
  String get connectionErrorLogin =>
      'Connection error. Check your internet connection.';

  @override
  String get noAccount => 'No account?';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get forgotPasswordDescription =>
      'Enter your nickname and we will send you a link to access your account via email.';

  @override
  String get sendLinkButton => 'Send Link';

  @override
  String get checkEmailTitle => 'Check Your Email';

  @override
  String checkEmailDescription(String email) {
    return 'Please check your inbox $email and follow the link to access your account.';
  }

  @override
  String get forgotPasswordCodeDescription =>
      'Enter the access code that was sent to the email linked to your account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get registrationUnavailable => 'Registration is currently unavailable';

  @override
  String get passwordRecoveryUnavailable =>
      'Password recovery is currently unavailable';

  @override
  String get nicknameMinLengthError =>
      'Nickname length must be at least five characters';

  @override
  String get nicknameLatinOnlyError =>
      'Nickname can only contain latin letters, numbers, dots and underscore';

  @override
  String get nicknameStartError =>
      'Nickname cannot start with underscore, number or dot';

  @override
  String get nicknameEndError =>
      'Nickname cannot end with underscore or period';

  @override
  String get checkingNickname => 'Checking nickname...';

  @override
  String get nicknameAvailable => 'Nickname available';

  @override
  String get nicknameTakenError => 'This nickname is already taken';

  @override
  String get nicknameServerError =>
      'Nickname check error. Please try again later';

  @override
  String get nicknameMaxLengthError => 'Maximum 30 characters';

  @override
  String get nameEmptyError => 'Name cannot be empty';

  @override
  String get confirmPasswordTitle => 'Confirm Password';

  @override
  String get confirmPasswordDescription =>
      'Enter your password again to confirm';

  @override
  String get confirmPasswordFieldHint => 'Repeat password';

  @override
  String get passwordMismatchError => 'Passwords do not match';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get registerAvatarSubtitle => 'Choose avatar';

  @override
  String get addAvatarHint => 'Tap + to add photo';

  @override
  String get avatarTapToSelect => 'Tap to select photo';

  @override
  String get photoPermissionTitle => 'Allow access to images';

  @override
  String get photoPermissionDescription =>
      'Allow us access to your images so you can choose an avatar for your profile';

  @override
  String get allowAccessButton => 'Allow access';

  @override
  String get notNowButton => 'Not now';

  @override
  String get avatarCropperTitle => 'Avatar Setup';

  @override
  String get doneButton => 'Done';

  @override
  String get cropInstructions =>
      'Drag the circle to select area • Use dots to resize';

  @override
  String get changeAvatar => 'Change Avatar';

  @override
  String get profilePreviewTitle => 'This is how your profile will look';

  @override
  String get goodMorning => 'Good morning';

  @override
  String get goodDay => 'Good afternoon';

  @override
  String get goodEvening => 'Good evening';

  @override
  String get goodNight => 'Good night';

  @override
  String get backButton => 'Back';

  @override
  String get editName => 'Edit Name';

  @override
  String get editNickname => 'Edit Nickname';

  @override
  String get editPhoto => 'Edit Photo';

  @override
  String get saveButton => 'Save';

  @override
  String get deleteButton => 'Delete';

  @override
  String get deletePhoto => 'Delete Photo';

  @override
  String get selectFromGallery => 'Select from Gallery';

  @override
  String get enterNameHint => 'Enter your name';

  @override
  String get enterNicknameHint => 'Enter nickname';

  @override
  String get termsAndConditionsTitle => 'Terms and Conditions';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String get userAgreement => 'User Agreement';

  @override
  String acceptTermsText(String termsOfUse, String userAgreement) {
    return 'To complete registration and start using Xaneo, you must accept our $termsOfUse and $userAgreement.\n\nThese documents contain important information about service usage rules, data protection, and obligations of both parties.\n\nBy accepting these terms, you confirm that you have read and agree to comply with the platform\'s rules.\n\nWithout accepting these terms, registration cannot be completed and access to the service will be restricted.';
  }

  @override
  String get acceptButton => 'Accept';

  @override
  String get declineButton => 'Decline';

  @override
  String verificationCodeSent(String email, int seconds) {
    return 'Code sent to $email. Valid for $seconds seconds';
  }

  @override
  String get codeDeliveryError => 'Code delivery error';

  @override
  String get serverErrorCodeDelivery => 'Server error sending code';

  @override
  String get connectionErrorCodeDelivery => 'Connection error sending code';

  @override
  String get emailVerificationSuccess => 'Email successfully verified!';

  @override
  String get invalidVerificationCode =>
      'Invalid verification code. Check code and try again';

  @override
  String get emailNotFound => 'Email not found. Try registering again';

  @override
  String get verificationCodeExpired =>
      'Verification code expired. Request a new code';

  @override
  String get serverErrorCodeVerification =>
      'Server error verifying code. Try later';

  @override
  String get connectionErrorCodeVerification =>
      'Connection error verifying code';

  @override
  String get permissionDeniedSettings =>
      'Permission permanently denied. Enable it in settings';

  @override
  String get avatarCropped => 'Avatar cropped and saved!';

  @override
  String get imageSelectionError => 'Error selecting image';

  @override
  String get permissionDeniedOpenSettings =>
      'Permission permanently denied. Open settings to enable';

  @override
  String get photoPermissionError => 'Failed to get photo access permission';

  @override
  String get registrationCompleted => 'Registration completed!';

  @override
  String get officialXaneoWebsite => 'Official Xaneo Website';

  @override
  String twoFactorAuthMessage(String email) {
    return 'Two-factor authentication is enabled on this account. Enter the verification code that was sent to $email';
  }

  @override
  String get selectLanguage => 'Select language';

  @override
  String get messengerDemo => 'Messenger demo';

  @override
  String get messenger => 'Messenger';

  @override
  String get messengerDescription =>
      'Simple, fast and secure messenger with modern design and user-friendly interface.';

  @override
  String get profileDemo => 'Profile demo';

  @override
  String get profile => 'Profile';

  @override
  String get personalInfo => 'Personal information';

  @override
  String get name => 'Name';

  @override
  String get nameHint => 'Name';

  @override
  String get birthDate => 'Birth date';

  @override
  String get nickname => 'Nickname';

  @override
  String get nicknameHint => 'Nickname';

  @override
  String get phone => 'Phone';

  @override
  String get phoneHint => 'Phone number';

  @override
  String get settingsSection => 'Settings';

  @override
  String get chatSettings => 'Chat settings';

  @override
  String get chatSettingsDescription => 'Chat settings will be here...';

  @override
  String get privacySettings => 'Privacy and confidentiality';

  @override
  String get privacySettingsDescription => 'Privacy settings will be here...';

  @override
  String get securitySettings => 'Security';

  @override
  String get securityAuthentication => 'Authentication';

  @override
  String get securityChangePassword => 'Change Password';

  @override
  String get securityTwoFactorAuth => 'Two-Factor Authentication';

  @override
  String get twoFactorEnabled => 'Enabled';

  @override
  String get twoFactorDisabled => 'Disabled';

  @override
  String get securityChangeEmail => 'Change Email';

  @override
  String get securityPasscode => 'Passcode';

  @override
  String get securitySettingsDescription => 'Security settings will be here...';

  @override
  String get passwordEmptyError => 'Password cannot be empty';

  @override
  String get passwordTooShortError =>
      'Password must contain at least 5 characters';

  @override
  String get passwordEnterCurrentHint =>
      'Enter current password for confirmation';

  @override
  String get passwordCurrentHint => 'Current password';

  @override
  String get passwordConfirmNewHint => 'Confirm new password';

  @override
  String get passwordDontMatchError => 'Passwords don\'t match';

  @override
  String get passwordNewTitle => 'New password';

  @override
  String get passwordNewHint => 'New password';

  @override
  String get passwordConfirmHint => 'Confirm password';

  @override
  String get passwordChangedSuccess => 'Password changed successfully';

  @override
  String get passwordNextButton => 'Next';

  @override
  String get passwordSaveButton => 'Save';

  @override
  String get powerSettings => 'Power saving';

  @override
  String get powerSettingsDescription =>
      'Power saving settings will be here...';

  @override
  String get languageSelect => 'Language';

  @override
  String get cancel => 'Cancel';

  @override
  String get ready => 'Ready';

  @override
  String contentInDevelopment(String title) {
    return 'Content for \"$title\" is under development...';
  }

  @override
  String get sessions => 'Sessions';

  @override
  String get support => 'Support';

  @override
  String get xaneoBenefits => 'XaneoBenefits';

  @override
  String get messengerFeatures => 'Demo mode features:';

  @override
  String get secureEncryption => 'Secure message encryption';

  @override
  String get instantDelivery => 'Instant delivery';

  @override
  String get deviceSync => 'Device synchronization';

  @override
  String get mediaSupport => 'Media file support';

  @override
  String get sessionsContent =>
      'Active account sessions will be displayed here...';

  @override
  String get activeDevices => 'Active Devices';

  @override
  String get currentDevice => 'Current Device';

  @override
  String get terminateSession => 'Terminate Session';

  @override
  String get terminateAllOtherSessions => 'Terminate All Other Sessions';

  @override
  String get sessionLocation => 'Location';

  @override
  String get sessionLastActive => 'Last Active';

  @override
  String get sessionBrowser => 'Browser';

  @override
  String get sessionPlatform => 'Platform';

  @override
  String get confirmTerminateSession =>
      'Are you sure you want to terminate this session?';

  @override
  String get confirmTerminateAllSessions =>
      'Are you sure you want to terminate all other sessions? This action cannot be undone.';

  @override
  String get sessionIPAddress => 'IP Address';

  @override
  String get supportContent =>
      'We have a very high load on our support service. We strive to respond as quickly as possible, but currently the waiting time may be up to 24 hours. Please contact us and we will definitely help you solve your problem.';

  @override
  String get contactSupport => 'Contact';

  @override
  String get xaneoBenefitsContent =>
      'XaneoBenefits is a loyalty program for Xaneo users. Get bonuses and exclusive features...';

  @override
  String get more => 'More';

  @override
  String get chatPreview => 'Chat Preview';

  @override
  String get textSize => 'Text Size';

  @override
  String textSizeValue(String size) {
    return 'Size: $size';
  }

  @override
  String get textExample => 'Text example';

  @override
  String get useDarkTheme => 'Use dark appearance';

  @override
  String get chatWallpapers => 'Chat Wallpapers';

  @override
  String get messageColors => 'Message Colors';

  @override
  String get myMessages => 'My Messages';

  @override
  String get receivedMessages => 'Received Messages';

  @override
  String get messageEmojis => 'Message Emojis';

  @override
  String get selectedEmoji => 'Selected emoji:';

  @override
  String get chooseWallpaper => 'Choose wallpaper:';

  @override
  String get demoMessage1 => 'Hi! How are you?';

  @override
  String get demoMessage2 => 'Everything is great! How about you?';

  @override
  String get demoMessage3 => 'I\'m good too, thanks 😊';

  @override
  String get demoDateSeparator => 'Today';

  @override
  String get onlineStatus => 'online';

  @override
  String get chatTheme => 'Chat theme';

  @override
  String get privacySettingsTitle => 'Privacy & Security';

  @override
  String get privacyCommunications => 'Communications';

  @override
  String get privacyProfileVisibility => 'Profile Visibility';

  @override
  String get privacyWhoCanMessage => 'Messages';

  @override
  String get privacyWhoCanRecordVoice => 'Voice messages';

  @override
  String get privacyWhoCanCall => 'Calls';

  @override
  String get privacyWhoCanSendVideo => 'Video messages';

  @override
  String get privacyWhoCanSendLinks => 'Links';

  @override
  String get privacyWhoCanInvite => 'Invitations';

  @override
  String get privacyWhoSeesNickname => 'Nickname';

  @override
  String get privacyWhoSeesAvatar => 'Avatar';

  @override
  String get privacyWhoSeesBirthday => 'Birthday';

  @override
  String get privacyWhoSeesOnlineTime => 'Online time';

  @override
  String get privacyAll => 'Everyone';

  @override
  String get privacyContacts => 'Contacts';

  @override
  String get privacyNobody => 'Nobody';

  @override
  String get passwordWeak => 'Weak';

  @override
  String get passwordMedium => 'Medium';

  @override
  String get passwordStrong => 'Strong';

  @override
  String twoFactorEnableDescription(String email) {
    return 'To enable two-factor authentication, enter the verification code sent to $email';
  }

  @override
  String twoFactorDisableDescription(String email) {
    return 'To disable two-factor authentication, enter the verification code sent to $email';
  }

  @override
  String get changeEmailVerificationDescription =>
      'To change your email, enter the verification code sent to demouser@example.com';

  @override
  String get newEmailTitle => 'New Email';

  @override
  String get newEmailDescription => 'Enter new email address';

  @override
  String get changeEmailButton => 'Change';

  @override
  String get verifyNewEmailTitle => 'Verify New Email';

  @override
  String verifyNewEmailDescription(String email) {
    return 'To verify your new email $email, enter the confirmation code sent to this address';
  }

  @override
  String get verifyNewEmailButton => 'Verify';

  @override
  String get passcodeVerificationTitle => 'Enable Passcode';

  @override
  String passcodeVerificationDescription(String email) {
    return 'To enable passcode protection, enter the verification code sent to $email';
  }

  @override
  String get passcodeVerificationButton => 'Enable';

  @override
  String get setPasscodeTitle => 'Set Passcode';

  @override
  String get setPasscodeDescription =>
      'Create a 4-digit passcode for additional protection';

  @override
  String get passcodeHint => 'Enter 4 digits';

  @override
  String get setPasscodeButton => 'Set';

  @override
  String get xaneoBenefitsModalTitle => 'XaneoBenefits (XB)';

  @override
  String get xaneoBenefitsModalDescription => 'Xaneo Premium Subscription';

  @override
  String get xaneoBenefitsSelectPlan => 'Choose your subscription plan:';

  @override
  String get xaneoBenefitsYearlyPlan => 'Yearly subscription';

  @override
  String get xaneoBenefitsMonthlyPlan => 'Monthly subscription';

  @override
  String get xaneoBenefitsYearlyPrice => '£999 per year';

  @override
  String get xaneoBenefitsMonthlyPrice => '£159 per month';

  @override
  String get xaneoBenefitsSavings => 'Save 25%! Only £83.25 per month';

  @override
  String get xaneoBenefitsSubscribeButton => 'Subscribe to XB';

  @override
  String get xaneoBenefitsCloseButton => 'Close';

  @override
  String get xaneoBenefitsYearlySuccess => 'Yearly XB subscription activated!';

  @override
  String get xaneoBenefitsMonthlySuccess =>
      'Monthly XB subscription activated!';

  @override
  String get favoritesChat => 'Favorites';

  @override
  String get favoritesChatDescription => 'Important messages and files';

  @override
  String contentInDevelopmentMessage(String title) {
    return 'Content for \"$title\" is under development...';
  }

  @override
  String get russianLanguage => 'Russian';

  @override
  String chatWelcomeMessage(String chatName) {
    return 'Hello! This is \"$chatName\" chat 🎉';
  }

  @override
  String get formattingExample1 =>
      'Here you can use **bold** and *italic* and __underlined__ text!';

  @override
  String get formattingExample2 => 'And also ~~strikethrough~~ and `code` 💻';

  @override
  String get greetingTrigger => 'hello';

  @override
  String get greetingResponse => 'Hello! How are you?';

  @override
  String get fileSendingNotImplemented => 'File sending is not implemented yet';

  @override
  String get wasOnlineRecently => 'was online recently';

  @override
  String get messageHint => 'Message';
}
