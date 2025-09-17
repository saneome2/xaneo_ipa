// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'XaneoMobile';

  @override
  String get welcomeTitle => 'Willkommen bei Xaneo';

  @override
  String get welcomeDescription =>
      'Xaneo - jetzt auch als mobile App! Xaneo war noch nie so bequem und schnell.';

  @override
  String get getStartedButton => 'Ich bin schon interessiert';

  @override
  String get connectingToServer => 'Verbindung zum Server...';

  @override
  String version(String version) {
    return 'Version: $version';
  }

  @override
  String httpError(int code) {
    return 'Fehler: HTTP $code';
  }

  @override
  String connectionError(String error) {
    return 'Verbindungsfehler: $error';
  }

  @override
  String get updateAvailable => 'Update verfügbar!';

  @override
  String get updateDialogTitle => 'Update verfügbar!';

  @override
  String updateDialogMessage(String currentVersion, String latestVersion) {
    return 'Ihre Version ist $currentVersion, die neue ist $latestVersion';
  }

  @override
  String get updateDialogDescription =>
      'Sie können über Google Play, RuStore oder die offizielle Xaneo-Website aktualisieren.';

  @override
  String get updateButton => 'Aktualisieren';

  @override
  String get cancelButton => 'Abbrechen';

  @override
  String get selectUpdateSource => 'Wählen Sie die Update-Quelle:';

  @override
  String get settings => 'Einstellungen';

  @override
  String get about => 'Über die App';

  @override
  String get help => 'Hilfe';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get notificationsDescription =>
      'Benachrichtigungen über neue Funktionen erhalten';

  @override
  String get darkTheme => 'Dunkles Thema';

  @override
  String get darkThemeDescription => 'Dunkles Erscheinungsbild verwenden';

  @override
  String fontSize(int size) {
    return 'Schriftgröße: $size';
  }

  @override
  String get appVersion => 'App-Version';

  @override
  String get messengerDemoMode => 'Messenger-Demo-Modus';

  @override
  String get language => 'Sprache';

  @override
  String get languageDescription => 'Wählen Sie die Oberflächensprache';

  @override
  String get welcomeMessage => 'Großartig! Willkommen!';

  @override
  String get privacyTitle => 'Alle Ihre Daten sind sicher';

  @override
  String get privacyDescription =>
      'Alle Nachrichten in XaneoConnect sind durch Ende-zu-Ende-Verschlüsselung geschützt. Xaneo kennt zu keinem Zeitpunkt deren Inhalt.';

  @override
  String get continueButton => 'Lassen Sie uns fortfahren';

  @override
  String get dataStorageTitle =>
      'Alle Xaneo-Datenzentren befinden sich in Russland';

  @override
  String get dataStorageDescription =>
      'Ihre Daten verlassen niemals das Land und werden in sicheren Datenzentren gespeichert.';

  @override
  String get finishButton => 'Fertigstellen';

  @override
  String get setupCompleted => 'Einrichtung abgeschlossen!';

  @override
  String get loginFormTitle => 'Lassen Sie uns anmelden';

  @override
  String get registerFormTitle => 'Lassen Sie uns beginnen';

  @override
  String get registerNameSubtitle => 'Wie heißen Sie?';

  @override
  String get nameFieldHint => 'Ihr Name';

  @override
  String get nextButton => 'Weiter';

  @override
  String get skipButton => 'Überspringen';

  @override
  String get registerBirthdateSubtitle => 'Wann sind Sie geboren?';

  @override
  String get selectDate => 'Datum auswählen';

  @override
  String get ageRestrictionsLink => 'Was sind die Altersbeschränkungen?';

  @override
  String get ageRestrictionsTitle => 'Registrierung ab 14 Jahren';

  @override
  String get ageRestrictionsDescription =>
      'Sie können sich bei unserem Service registrieren, wenn Sie 14 Jahre oder älter sind';

  @override
  String get gotIt => 'Verstanden';

  @override
  String get registerNicknameSubtitle => 'Wählen Sie einen Spitznamen';

  @override
  String get nicknameFieldHint => 'Ihr Spitzname';

  @override
  String get nicknameHelpLink => 'Können Sie sich keinen Spitznamen ausdenken?';

  @override
  String get registerEmailSubtitle => 'Geben Sie Ihre E-Mail ein';

  @override
  String get emailFieldHint => 'Ihre E-Mail';

  @override
  String get supportedEmailProvidersLink =>
      'Welche E-Mail-Anbieter werden unterstützt?';

  @override
  String get supportedEmailProvidersTitle => 'Unterstützte E-Mail-Anbieter';

  @override
  String get supportedEmailProvidersDescription =>
      'Gmail, Outlook, Yandex, Mail.ru und andere beliebte E-Mail-Dienste werden unterstützt.';

  @override
  String get emailFormatError => 'Ungültiges E-Mail-Adressformat';

  @override
  String get emailUnsupportedError =>
      'Dieser E-Mail-Dienst wird nicht unterstützt';

  @override
  String get checkingEmail => 'E-Mail wird überprüft...';

  @override
  String get emailAvailable => 'E-Mail ist verfügbar';

  @override
  String get emailTakenError => 'Diese E-Mail ist bereits vergeben';

  @override
  String get emailServerError =>
      'E-Mail-Überprüfungsfehler. Bitte versuchen Sie es später erneut';

  @override
  String get verifyEmailTitle => 'Bestätigen Sie Ihre E-Mail';

  @override
  String get verifyEmailDescription =>
      'Wir haben einen 6-stelligen Code an Ihre E-Mail gesendet. Geben Sie ihn ein, um zu bestätigen.';

  @override
  String get verificationCodeHint => 'Bestätigungscode';

  @override
  String get verifyButton => 'Bestätigen';

  @override
  String get registerPasswordSubtitle => 'Erstellen Sie ein Passwort';

  @override
  String get registerPasswordFieldHint => 'Passwort eingeben';

  @override
  String get passwordInvalidCharsError =>
      'Passwort darf nur lateinische Buchstaben, Zahlen und Satzzeichen enthalten';

  @override
  String get passwordWeakError =>
      'Passwort ist zu schwach. Verwenden Sie Buchstaben, Zahlen und Sonderzeichen';

  @override
  String get passwordMediumWarning =>
      'Mittelstarkes Passwort. Stärkung empfohlen';

  @override
  String get passwordStrongSuccess => 'Starkes Passwort';

  @override
  String get nicknameGeneratorTitle =>
      'Ihr Spitzname wird automatisch generiert';

  @override
  String get nicknameGeneratorDescription =>
      'Sie können Ihren Spitznamen jederzeit ändern';

  @override
  String get closeButton => 'Schließen';

  @override
  String get loginFieldHint => 'Anmeldung';

  @override
  String get passwordFieldHint => 'Passwort';

  @override
  String get loginButton => 'Anmelden';

  @override
  String get fillAllFields => 'Füllen Sie alle Felder aus';

  @override
  String get loggingIn => 'Anmeldung...';

  @override
  String welcomeUser(String username) {
    return 'Willkommen, $username!';
  }

  @override
  String get invalidCredentials =>
      'Ungültige Anmeldedaten. Überprüfen Sie Ihren Benutzernamen und Passwort.';

  @override
  String get serverError =>
      'Serverfehler. Bitte versuchen Sie es später erneut.';

  @override
  String get connectionErrorLogin =>
      'Verbindungsfehler. Überprüfen Sie Ihre Internetverbindung.';

  @override
  String get noAccount => 'Kein Konto?';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get forgotPasswordDescription =>
      'Geben Sie Ihren Spitznamen ein und wir senden Ihnen einen Link zum Zugriff auf Ihr Konto per E-Mail.';

  @override
  String get sendLinkButton => 'Link senden';

  @override
  String get checkEmailTitle => 'Überprüfen Sie Ihre E-Mail';

  @override
  String checkEmailDescription(String email) {
    return 'Bitte überprüfen Sie Ihren Posteingang $email und folgen Sie dem Link, um auf Ihr Konto zuzugreifen.';
  }

  @override
  String get forgotPasswordCodeDescription =>
      'Geben Sie den Zugangscode ein, der an die mit Ihrem Konto verknüpfte E-Mail gesendet wurde';

  @override
  String get alreadyHaveAccount => 'Haben Sie bereits ein Konto?';

  @override
  String get registrationUnavailable =>
      'Registrierung ist derzeit nicht verfügbar';

  @override
  String get passwordRecoveryUnavailable =>
      'Passwortwiederherstellung ist derzeit nicht verfügbar';

  @override
  String get nicknameMinLengthError =>
      'Spitzname muss mindestens fünf Zeichen lang sein';

  @override
  String get nicknameLatinOnlyError =>
      'Spitzname darf nur lateinische Buchstaben, Zahlen, Punkte und Unterstriche enthalten';

  @override
  String get nicknameStartError =>
      'Spitzname darf nicht mit Unterstrich, Zahl oder Punkt beginnen';

  @override
  String get nicknameEndError =>
      'Spitzname darf nicht mit Unterstrich oder Punkt enden';

  @override
  String get checkingNickname => 'Spitzname wird überprüft...';

  @override
  String get nicknameAvailable => 'Spitzname ist verfügbar';

  @override
  String get nicknameTakenError => 'Dieser Spitzname ist bereits vergeben';

  @override
  String get nicknameServerError =>
      'Serverfehler bei der Spitzname-Überprüfung';

  @override
  String get nicknameMaxLengthError =>
      'Spitzname darf maximal 30 Zeichen lang sein';

  @override
  String get nameEmptyError => 'Name darf nicht leer sein';

  @override
  String get confirmPasswordTitle => 'Passwort bestätigen';

  @override
  String get confirmPasswordDescription =>
      'Bitte geben Sie Ihr Passwort erneut ein, um fortzufahren';

  @override
  String get confirmPasswordFieldHint => 'Passwort erneut eingeben';

  @override
  String get passwordMismatchError => 'Passwörter stimmen nicht überein';

  @override
  String get confirmButton => 'Bestätigen';

  @override
  String get registerAvatarSubtitle => 'Fügen Sie ein Profilbild hinzu';

  @override
  String get addAvatarHint => 'Tippen Sie, um ein Bild auszuwählen';

  @override
  String get avatarTapToSelect => 'Tippen Sie, um auszuwählen';

  @override
  String get photoPermissionTitle => 'Zugriff auf Fotos';

  @override
  String get photoPermissionDescription =>
      'Wir benötigen Zugriff auf Ihre Fotos, um ein Profilbild auszuwählen';

  @override
  String get allowAccessButton => 'Zugriff erlauben';

  @override
  String get notNowButton => 'Nicht jetzt';

  @override
  String get avatarCropperTitle => 'Bild zuschneiden';

  @override
  String get doneButton => 'Fertig';

  @override
  String get cropInstructions => 'Ziehen Sie, um den Bildausschnitt zu ändern';

  @override
  String get changeAvatar => 'Avatar ändern';

  @override
  String get profilePreviewTitle => 'Profilvorschau';

  @override
  String get goodMorning => 'Guten Morgen';

  @override
  String get goodDay => 'Guten Tag';

  @override
  String get goodEvening => 'Guten Abend';

  @override
  String get goodNight => 'Gute Nacht';

  @override
  String get backButton => 'Zurück';

  @override
  String get editName => 'Name bearbeiten';

  @override
  String get editNickname => 'Spitzname bearbeiten';

  @override
  String get editPhoto => 'Foto bearbeiten';

  @override
  String get saveButton => 'Speichern';

  @override
  String get deleteButton => 'Löschen';

  @override
  String get deletePhoto => 'Foto löschen';

  @override
  String get selectFromGallery => 'Aus Galerie auswählen';

  @override
  String get enterNameHint => 'Namen eingeben';

  @override
  String get enterNicknameHint => 'Spitzname eingeben';

  @override
  String get termsAndConditionsTitle => 'Nutzungsbedingungen';

  @override
  String get termsOfUse => 'Nutzungsbedingungen';

  @override
  String get userAgreement => 'Benutzervereinbarung';

  @override
  String acceptTermsText(String termsOfUse, String userAgreement) {
    return 'Ich akzeptiere die Nutzungsbedingungen';
  }

  @override
  String get acceptButton => 'Akzeptieren';

  @override
  String get declineButton => 'Ablehnen';

  @override
  String verificationCodeSent(String email, int seconds) {
    return 'Verifizierungscode wurde gesendet';
  }

  @override
  String get codeDeliveryError => 'Fehler beim Senden des Codes';

  @override
  String get serverErrorCodeDelivery => 'Serverfehler beim Senden des Codes';

  @override
  String get connectionErrorCodeDelivery =>
      'Verbindungsfehler beim Senden des Codes';

  @override
  String get emailVerificationSuccess => 'E-Mail erfolgreich verifiziert';

  @override
  String get invalidVerificationCode => 'Ungültiger Verifizierungscode';

  @override
  String get emailNotFound => 'E-Mail-Adresse nicht gefunden';

  @override
  String get verificationCodeExpired => 'Verifizierungscode ist abgelaufen';

  @override
  String get serverErrorCodeVerification =>
      'Serverfehler bei Code-Verifizierung';

  @override
  String get connectionErrorCodeVerification =>
      'Verbindungsfehler bei Code-Verifizierung';

  @override
  String get permissionDeniedSettings =>
      'Berechtigung verweigert. Gehen Sie zu den Einstellungen.';

  @override
  String get avatarCropped => 'Avatar zugeschnitten';

  @override
  String get imageSelectionError => 'Fehler bei der Bildauswahl';

  @override
  String get permissionDeniedOpenSettings =>
      'Berechtigung verweigert. Einstellungen öffnen?';

  @override
  String get photoPermissionError => 'Foto-Berechtigung Fehler';

  @override
  String get registrationCompleted => 'Registrierung abgeschlossen';

  @override
  String get officialXaneoWebsite => 'Offizielle Xaneo-Website';

  @override
  String twoFactorAuthMessage(String email) {
    return 'Zwei-Faktor-Authentifizierung ist aktiviert';
  }

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get messengerDemo => 'Messenger Demo';

  @override
  String get messenger => 'Messenger';

  @override
  String get messengerDescription => 'Sichere und schnelle Nachrichten';

  @override
  String get profileDemo => 'Profil Demo';

  @override
  String get profile => 'Profil';

  @override
  String get personalInfo => 'Persönliche Informationen';

  @override
  String get name => 'Name';

  @override
  String get nameHint => 'Geben Sie Ihren Namen ein';

  @override
  String get birthDate => 'Geburtsdatum';

  @override
  String get nickname => 'Spitzname';

  @override
  String get nicknameHint => 'Geben Sie Ihren Spitznamen ein';

  @override
  String get phone => 'Telefon';

  @override
  String get phoneHint => 'Geben Sie Ihre Telefonnummer ein';

  @override
  String get settingsSection => 'Einstellungen';

  @override
  String get chatSettings => 'Chat-Einstellungen';

  @override
  String get chatSettingsDescription => 'Passen Sie Ihr Chat-Erlebnis an';

  @override
  String get privacySettings => 'Datenschutz-Einstellungen';

  @override
  String get privacySettingsDescription =>
      'Kontrollieren Sie Ihre Privatsphäre';

  @override
  String get securitySettings => 'Sicherheits-Einstellungen';

  @override
  String get securityAuthentication => 'Authentifizierung';

  @override
  String get securityChangePassword => 'Passwort ändern';

  @override
  String get securityTwoFactorAuth => 'Zwei-Faktor-Authentifizierung';

  @override
  String get twoFactorEnabled => 'Zwei-Faktor-Authentifizierung aktiviert';

  @override
  String get twoFactorDisabled => 'Zwei-Faktor-Authentifizierung deaktiviert';

  @override
  String get securityChangeEmail => 'E-Mail ändern';

  @override
  String get securityPasscode => 'Passcode';

  @override
  String get securitySettingsDescription => 'Schützen Sie Ihr Konto';

  @override
  String get passwordEmptyError => 'Passwort darf nicht leer sein';

  @override
  String get passwordTooShortError =>
      'Passwort muss mindestens 8 Zeichen lang sein';

  @override
  String get passwordEnterCurrentHint => 'Aktuelles Passwort eingeben';

  @override
  String get passwordCurrentHint => 'Aktuelles Passwort';

  @override
  String get passwordConfirmNewHint => 'Neues Passwort bestätigen';

  @override
  String get passwordDontMatchError => 'Passwörter stimmen nicht überein';

  @override
  String get passwordNewTitle => 'Neues Passwort';

  @override
  String get passwordNewHint => 'Neues Passwort eingeben';

  @override
  String get passwordConfirmHint => 'Passwort bestätigen';

  @override
  String get passwordChangedSuccess => 'Passwort erfolgreich geändert';

  @override
  String get passwordNextButton => 'Weiter';

  @override
  String get passwordSaveButton => 'Speichern';

  @override
  String get powerSettings => 'Power-Einstellungen';

  @override
  String get powerSettingsDescription => 'Erweiterte Einstellungen';

  @override
  String get languageSelect => 'Sprache wählen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get ready => 'Bereit';

  @override
  String contentInDevelopment(String title) {
    return 'Inhalt in Entwicklung';
  }

  @override
  String get sessions => 'Sitzungen';

  @override
  String get support => 'Support';

  @override
  String get xaneoBenefits => 'Xaneo Vorteile';

  @override
  String get messengerFeatures => 'Messenger-Funktionen';

  @override
  String get secureEncryption => 'Sichere Verschlüsselung';

  @override
  String get instantDelivery => 'Sofortige Zustellung';

  @override
  String get deviceSync => 'Geräte-Synchronisation';

  @override
  String get mediaSupport => 'Medien-Unterstützung';

  @override
  String get sessionsContent => 'Verwalten Sie Ihre aktiven Sitzungen';

  @override
  String get activeDevices => 'Aktive Geräte';

  @override
  String get currentDevice => 'Aktuelles Gerät';

  @override
  String get terminateSession => 'Sitzung beenden';

  @override
  String get terminateAllOtherSessions => 'Alle anderen Sitzungen beenden';

  @override
  String get sessionLocation => 'Standort';

  @override
  String get sessionLastActive => 'Zuletzt aktiv';

  @override
  String get sessionBrowser => 'Browser';

  @override
  String get sessionPlatform => 'Plattform';

  @override
  String get confirmTerminateSession =>
      'Sind Sie sicher, dass Sie diese Sitzung beenden möchten?';

  @override
  String get confirmTerminateAllSessions =>
      'Sind Sie sicher, dass Sie alle anderen Sitzungen beenden möchten?';

  @override
  String get sessionIPAddress => 'IP-Adresse';

  @override
  String get supportContent => 'Kontaktieren Sie unser Support-Team';

  @override
  String get contactSupport => 'Support kontaktieren';

  @override
  String get xaneoBenefitsContent => 'Entdecken Sie die Vorteile von Xaneo';

  @override
  String get more => 'Mehr';

  @override
  String get chatPreview => 'Chat-Vorschau';

  @override
  String get textSize => 'Textgröße';

  @override
  String textSizeValue(String size) {
    return '$size%';
  }

  @override
  String get textExample => 'Beispieltext';

  @override
  String get useDarkTheme => 'Dunkles Thema verwenden';

  @override
  String get chatWallpapers => 'Chat-Hintergründe';

  @override
  String get messageColors => 'Nachrichtenfarben';

  @override
  String get myMessages => 'Meine Nachrichten';

  @override
  String get receivedMessages => 'Erhaltene Nachrichten';

  @override
  String get messageEmojis => 'Nachrichten-Emojis';

  @override
  String get selectedEmoji => 'Ausgewähltes Emoji';

  @override
  String get chooseWallpaper => 'Hintergrund auswählen';

  @override
  String get demoMessage1 => 'Hallo! Wie geht es dir?';

  @override
  String get demoMessage2 => 'Mir geht es gut, danke! Und dir?';

  @override
  String get demoMessage3 => 'Auch gut! Schön dich zu sehen.';

  @override
  String get demoDateSeparator => 'Heute';

  @override
  String get onlineStatus => 'Online';

  @override
  String get chatTheme => 'Chat-Thema';

  @override
  String get privacySettingsTitle => 'Datenschutz-Einstellungen';

  @override
  String get privacyCommunications => 'Kommunikation';

  @override
  String get privacyProfileVisibility => 'Profilsichtbarkeit';

  @override
  String get privacyWhoCanMessage => 'Wer kann mir schreiben';

  @override
  String get privacyWhoCanRecordVoice => 'Wer kann Sprachnachrichten aufnehmen';

  @override
  String get privacyWhoCanCall => 'Wer kann mich anrufen';

  @override
  String get privacyWhoCanSendVideo => 'Wer kann mir Videos senden';

  @override
  String get privacyWhoCanSendLinks => 'Wer kann mir Links senden';

  @override
  String get privacyWhoCanInvite => 'Wer kann mich einladen';

  @override
  String get privacyWhoSeesNickname => 'Wer sieht meinen Spitznamen';

  @override
  String get privacyWhoSeesAvatar => 'Wer sieht mein Avatar';

  @override
  String get privacyWhoSeesBirthday => 'Wer sieht mein Geburtsdatum';

  @override
  String get privacyWhoSeesOnlineTime => 'Wer sieht meine Online-Zeit';

  @override
  String get privacyAll => 'Alle';

  @override
  String get privacyContacts => 'Kontakte';

  @override
  String get privacyNobody => 'Niemand';

  @override
  String get passwordWeak => 'Schwach';

  @override
  String get passwordMedium => 'Mittel';

  @override
  String get passwordStrong => 'Stark';

  @override
  String twoFactorEnableDescription(String email) {
    return 'Zwei-Faktor-Authentifizierung hinzufügen für zusätzliche Sicherheit';
  }

  @override
  String twoFactorDisableDescription(String email) {
    return 'Zwei-Faktor-Authentifizierung deaktivieren';
  }

  @override
  String get changeEmailVerificationDescription =>
      'Sie erhalten einen Verifizierungscode an Ihre neue E-Mail-Adresse';

  @override
  String get newEmailTitle => 'Neue E-Mail-Adresse';

  @override
  String get newEmailDescription => 'Geben Sie Ihre neue E-Mail-Adresse ein';

  @override
  String get changeEmailButton => 'E-Mail ändern';

  @override
  String get verifyNewEmailTitle => 'Neue E-Mail verifizieren';

  @override
  String verifyNewEmailDescription(String email) {
    return 'Geben Sie den Verifizierungscode ein, der an Ihre neue E-Mail gesendet wurde';
  }

  @override
  String get verifyNewEmailButton => 'E-Mail verifizieren';

  @override
  String get passcodeVerificationTitle => 'Passcode-Verifizierung';

  @override
  String passcodeVerificationDescription(String email) {
    return 'Geben Sie Ihren Passcode ein, um fortzufahren';
  }

  @override
  String get passcodeVerificationButton => 'Passcode verifizieren';

  @override
  String get setPasscodeTitle => 'Passcode festlegen';

  @override
  String get setPasscodeDescription =>
      'Erstellen Sie einen 4-stelligen Passcode für zusätzliche Sicherheit';

  @override
  String get passcodeHint => 'Passcode eingeben';

  @override
  String get setPasscodeButton => 'Passcode festlegen';

  @override
  String get xaneoBenefitsModalTitle => 'Xaneo Premium Vorteile';

  @override
  String get xaneoBenefitsModalDescription =>
      'Schalten Sie Premium-Funktionen frei und unterstützen Sie die Entwicklung';

  @override
  String get xaneoBenefitsSelectPlan => 'Wählen Sie Ihren Plan';

  @override
  String get xaneoBenefitsYearlyPlan => 'Jahresplan';

  @override
  String get xaneoBenefitsMonthlyPlan => 'Monatsplan';

  @override
  String get xaneoBenefitsYearlyPrice => '49,99 € / Jahr';

  @override
  String get xaneoBenefitsMonthlyPrice => '4,99 € / Monat';

  @override
  String get xaneoBenefitsSavings => 'Sparen Sie 17%';

  @override
  String get xaneoBenefitsSubscribeButton => 'Abonnieren';

  @override
  String get xaneoBenefitsCloseButton => 'Schließen';

  @override
  String get xaneoBenefitsYearlySuccess =>
      'Jahresabonnement XB erfolgreich abgeschlossen!';

  @override
  String get xaneoBenefitsMonthlySuccess =>
      'Monatsabonnement XB erfolgreich abgeschlossen!';

  @override
  String get favoritesChat => 'Favoriten';

  @override
  String get favoritesChatDescription => 'Wichtige Nachrichten und Dateien';

  @override
  String contentInDevelopmentMessage(String title) {
    return 'Inhalt für \"$title\" wird entwickelt...';
  }

  @override
  String get russianLanguage => 'Russisch';

  @override
  String chatWelcomeMessage(String chatName) {
    return 'Hallo! Dies ist der Chat \"$chatName\" 🎉';
  }

  @override
  String get formattingExample1 =>
      'Hier können Sie **fett**, *kursiv* und __unterstrichen__ Text verwenden!';

  @override
  String get formattingExample2 => 'Sowie ~~durchgestrichen~~ und `Code` 💻';

  @override
  String get greetingTrigger => 'hallo';

  @override
  String get greetingResponse => 'Hallo! Wie geht\'s?';

  @override
  String get fileSendingNotImplemented =>
      'Datei senden ist noch nicht implementiert';

  @override
  String get wasOnlineRecently => 'war kürzlich online';

  @override
  String get messageHint => 'Nachricht';
}
