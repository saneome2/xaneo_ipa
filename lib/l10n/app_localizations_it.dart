// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'XaneoMobile';

  @override
  String get welcomeTitle => 'Benvenuto in Xaneo';

  @override
  String get welcomeDescription =>
      'Xaneo - ora anche in app mobile! Xaneo non è mai stato così conveniente e veloce.';

  @override
  String get getStartedButton => 'Sono già interessato';

  @override
  String get connectingToServer => 'Connessione al server...';

  @override
  String version(String version) {
    return 'Versione: $version';
  }

  @override
  String httpError(int code) {
    return 'Errore: HTTP $code';
  }

  @override
  String connectionError(String error) {
    return 'Errore di connessione: $error';
  }

  @override
  String get updateAvailable => 'Aggiornamento disponibile!';

  @override
  String get updateDialogTitle => 'Aggiornamento disponibile!';

  @override
  String updateDialogMessage(String currentVersion, String latestVersion) {
    return 'La tua versione è $currentVersion, quella nuova è $latestVersion';
  }

  @override
  String get updateDialogDescription =>
      'Puoi aggiornare tramite Google Play, RuStore o dal sito ufficiale Xaneo.';

  @override
  String get updateButton => 'Aggiorna';

  @override
  String get cancelButton => 'Annulla';

  @override
  String get selectUpdateSource => 'Seleziona fonte di aggiornamento:';

  @override
  String get settings => 'Impostazioni';

  @override
  String get about => 'Informazioni';

  @override
  String get help => 'Aiuto';

  @override
  String get notifications => 'Notifiche';

  @override
  String get notificationsDescription =>
      'Ricevi notifiche sulle nuove funzionalità';

  @override
  String get darkTheme => 'Tema scuro';

  @override
  String get darkThemeDescription => 'Usa aspetto scuro';

  @override
  String fontSize(int size) {
    return 'Dimensione font: $size';
  }

  @override
  String get appVersion => 'Versione app';

  @override
  String get messengerDemoMode => 'Modalità demo messenger';

  @override
  String get language => 'Lingua';

  @override
  String get languageDescription => 'Scegli lingua interfaccia';

  @override
  String get welcomeMessage => 'Ottimo! Benvenuto!';

  @override
  String get privacyTitle => 'Tutti i tuoi dati sono al sicuro';

  @override
  String get privacyDescription =>
      'Tutti i messaggi in XaneoConnect sono protetti da crittografia end-to-end. Xaneo non ne conosce mai il contenuto.';

  @override
  String get continueButton => 'Continuiamo';

  @override
  String get dataStorageTitle =>
      'Tutti i data center Xaneo si trovano in Russia';

  @override
  String get dataStorageDescription =>
      'I tuoi dati non lasciano mai il paese e sono archiviati in data center sicuri.';

  @override
  String get finishButton => 'Fine';

  @override
  String get setupCompleted => 'Configurazione completata!';

  @override
  String get loginFormTitle => 'Accediamo';

  @override
  String get registerFormTitle => 'Iniziamo';

  @override
  String get registerNameSubtitle => 'Come ti chiami?';

  @override
  String get nameFieldHint => 'Il tuo nome';

  @override
  String get nextButton => 'Avanti';

  @override
  String get skipButton => 'Salta';

  @override
  String get registerBirthdateSubtitle => 'Quando sei nato?';

  @override
  String get selectDate => 'Seleziona data';

  @override
  String get ageRestrictionsLink => 'Quali sono le restrizioni di età?';

  @override
  String get ageRestrictionsTitle => 'Registrazione dai 14 anni';

  @override
  String get ageRestrictionsDescription =>
      'Puoi registrarti al nostro servizio se hai 14 anni o più';

  @override
  String get gotIt => 'Capito';

  @override
  String get registerNicknameSubtitle => 'Scegli un nickname';

  @override
  String get nicknameFieldHint => 'Il tuo nickname';

  @override
  String get nicknameHelpLink => 'Non riesci a pensare a un nickname?';

  @override
  String get registerEmailSubtitle => 'Inserisci la tua email';

  @override
  String get emailFieldHint => 'La tua email';

  @override
  String get supportedEmailProvidersLink =>
      'Quali provider email sono supportati?';

  @override
  String get supportedEmailProvidersTitle => 'Provider Email Supportati';

  @override
  String get supportedEmailProvidersDescription =>
      'Sono supportati Gmail, Outlook, Yandex, Mail.ru e altri servizi email popolari.';

  @override
  String get emailFormatError => 'Formato indirizzo email non valido';

  @override
  String get emailUnsupportedError => 'Questo servizio email non è supportato';

  @override
  String get checkingEmail => 'Controllo email...';

  @override
  String get emailAvailable => 'Email disponibile';

  @override
  String get emailTakenError => 'Questa email è già utilizzata';

  @override
  String get emailServerError => 'Errore controllo email. Riprova più tardi';

  @override
  String get verifyEmailTitle => 'Verifica la tua email';

  @override
  String get verifyEmailDescription =>
      'Abbiamo inviato un codice a 6 cifre alla tua email. Inseriscilo per confermare.';

  @override
  String get verificationCodeHint => 'Codice di verifica';

  @override
  String get verifyButton => 'Verifica';

  @override
  String get registerPasswordSubtitle => 'Crea una password';

  @override
  String get registerPasswordFieldHint => 'Inserisci password';

  @override
  String get passwordInvalidCharsError =>
      'La password può contenere solo lettere latine, numeri e segni di punteggiatura';

  @override
  String get passwordWeakError =>
      'Password troppo debole. Usa lettere, numeri e caratteri speciali';

  @override
  String get passwordMediumWarning =>
      'Password di forza media. Si consiglia di rafforzarla';

  @override
  String get passwordStrongSuccess => 'Password forte';

  @override
  String get nicknameGeneratorTitle =>
      'Il tuo nickname sarà generato automaticamente';

  @override
  String get nicknameGeneratorDescription =>
      'Puoi cambiare il tuo nickname in qualsiasi momento';

  @override
  String get closeButton => 'Chiudi';

  @override
  String get loginFieldHint => 'Accesso';

  @override
  String get passwordFieldHint => 'Password';

  @override
  String get loginButton => 'Accedi';

  @override
  String get fillAllFields => 'Compila tutti i campi';

  @override
  String get loggingIn => 'Accesso in corso...';

  @override
  String welcomeUser(String username) {
    return 'Benvenuto, $username!';
  }

  @override
  String get invalidCredentials =>
      'Credenziali non valide. Controlla username e password.';

  @override
  String get serverError => 'Errore del server. Riprova più tardi.';

  @override
  String get connectionErrorLogin =>
      'Errore di connessione. Controlla la tua connessione internet.';

  @override
  String get noAccount => 'Non hai un account?';

  @override
  String get forgotPassword => 'Password dimenticata?';

  @override
  String get forgotPasswordDescription =>
      'Inserisci il tuo nickname e ti invieremo un link per accedere al tuo account via email.';

  @override
  String get sendLinkButton => 'Invia Link';

  @override
  String get checkEmailTitle => 'Controlla la tua Email';

  @override
  String checkEmailDescription(String email) {
    return 'Controlla la tua casella di posta $email e segui il link per accedere al tuo account.';
  }

  @override
  String get forgotPasswordCodeDescription =>
      'Inserisci il codice di accesso inviato all\'email associata al tuo account';

  @override
  String get alreadyHaveAccount => 'Hai già un account?';

  @override
  String get registrationUnavailable =>
      'La registrazione non è attualmente disponibile';

  @override
  String get passwordRecoveryUnavailable =>
      'Il recupero password non è attualmente disponibile';

  @override
  String get nicknameMinLengthError =>
      'La lunghezza del nickname deve essere di almeno cinque caratteri';

  @override
  String get nicknameLatinOnlyError =>
      'Il nickname può contenere solo lettere latine, numeri, punti e trattini bassi';

  @override
  String get nicknameStartError =>
      'Il nickname non può iniziare con trattino basso, numero o punto';

  @override
  String get nicknameEndError =>
      'Il nickname non può terminare con trattino basso o punto';

  @override
  String get checkingNickname => 'Verifica nickname...';

  @override
  String get nicknameAvailable => 'Nickname disponibile';

  @override
  String get nicknameTakenError => 'Questo nickname è già in uso';

  @override
  String get nicknameServerError =>
      'Errore del server durante la verifica del nickname';

  @override
  String get nicknameMaxLengthError =>
      'Il nickname può essere lungo al massimo 30 caratteri';

  @override
  String get nameEmptyError => 'Il nome non può essere vuoto';

  @override
  String get confirmPasswordTitle => 'Conferma password';

  @override
  String get confirmPasswordDescription =>
      'Inserisci nuovamente la tua password per continuare';

  @override
  String get confirmPasswordFieldHint => 'Reinserisci password';

  @override
  String get passwordMismatchError => 'Le password non corrispondono';

  @override
  String get confirmButton => 'Conferma';

  @override
  String get registerAvatarSubtitle => 'Aggiungi una foto profilo';

  @override
  String get addAvatarHint => 'Tocca per selezionare un\'immagine';

  @override
  String get avatarTapToSelect => 'Tocca per selezionare';

  @override
  String get photoPermissionTitle => 'Accesso alle foto';

  @override
  String get photoPermissionDescription =>
      'Abbiamo bisogno dell\'accesso alle tue foto per selezionare una foto profilo';

  @override
  String get allowAccessButton => 'Consenti accesso';

  @override
  String get notNowButton => 'Non ora';

  @override
  String get avatarCropperTitle => 'Ritaglia immagine';

  @override
  String get doneButton => 'Fatto';

  @override
  String get cropInstructions => 'Trascina per regolare l\'area dell\'immagine';

  @override
  String get changeAvatar => 'Cambia avatar';

  @override
  String get profilePreviewTitle => 'Anteprima profilo';

  @override
  String get goodMorning => 'Buongiorno';

  @override
  String get goodDay => 'Buongiorno';

  @override
  String get goodEvening => 'Buonasera';

  @override
  String get goodNight => 'Buonanotte';

  @override
  String get backButton => 'Indietro';

  @override
  String get editName => 'Modifica nome';

  @override
  String get editNickname => 'Modifica nickname';

  @override
  String get editPhoto => 'Modifica foto';

  @override
  String get saveButton => 'Salva';

  @override
  String get deleteButton => 'Elimina';

  @override
  String get deletePhoto => 'Elimina foto';

  @override
  String get selectFromGallery => 'Seleziona dalla galleria';

  @override
  String get enterNameHint => 'Inserisci nome';

  @override
  String get enterNicknameHint => 'Inserisci nickname';

  @override
  String get termsAndConditionsTitle => 'Termini e condizioni';

  @override
  String get termsOfUse => 'Termini di utilizzo';

  @override
  String get userAgreement => 'Accordo utente';

  @override
  String acceptTermsText(String termsOfUse, String userAgreement) {
    return 'Accetto i termini e le condizioni';
  }

  @override
  String get acceptButton => 'Accetta';

  @override
  String get declineButton => 'Rifiuta';

  @override
  String verificationCodeSent(String email, int seconds) {
    return 'Codice di verifica inviato';
  }

  @override
  String get codeDeliveryError => 'Errore nell\'invio del codice';

  @override
  String get serverErrorCodeDelivery =>
      'Errore del server nell\'invio del codice';

  @override
  String get connectionErrorCodeDelivery =>
      'Errore di connessione nell\'invio del codice';

  @override
  String get emailVerificationSuccess => 'Email verificata con successo';

  @override
  String get invalidVerificationCode => 'Codice di verifica non valido';

  @override
  String get emailNotFound => 'Indirizzo email non trovato';

  @override
  String get verificationCodeExpired => 'Codice di verifica scaduto';

  @override
  String get serverErrorCodeVerification =>
      'Errore del server nella verifica del codice';

  @override
  String get connectionErrorCodeVerification =>
      'Errore di connessione nella verifica del codice';

  @override
  String get permissionDeniedSettings =>
      'Permesso negato. Vai alle impostazioni.';

  @override
  String get avatarCropped => 'Avatar ritagliato';

  @override
  String get imageSelectionError => 'Errore nella selezione dell\'immagine';

  @override
  String get permissionDeniedOpenSettings =>
      'Permesso negato. Aprire impostazioni?';

  @override
  String get photoPermissionError => 'Errore permesso foto';

  @override
  String get registrationCompleted => 'Registrazione completata';

  @override
  String get officialXaneoWebsite => 'Sito web ufficiale Xaneo';

  @override
  String twoFactorAuthMessage(String email) {
    return 'Autenticazione a due fattori abilitata';
  }

  @override
  String get selectLanguage => 'Seleziona lingua';

  @override
  String get messengerDemo => 'Demo Messenger';

  @override
  String get messenger => 'Messenger';

  @override
  String get messengerDescription => 'Messaggi sicuri e veloci';

  @override
  String get profileDemo => 'Demo Profilo';

  @override
  String get profile => 'Profilo';

  @override
  String get personalInfo => 'Informazioni personali';

  @override
  String get name => 'Nome';

  @override
  String get nameHint => 'Inserisci il tuo nome';

  @override
  String get birthDate => 'Data di nascita';

  @override
  String get nickname => 'Nickname';

  @override
  String get nicknameHint => 'Inserisci il tuo nickname';

  @override
  String get phone => 'Telefono';

  @override
  String get phoneHint => 'Inserisci il tuo numero di telefono';

  @override
  String get settingsSection => 'Impostazioni';

  @override
  String get chatSettings => 'Impostazioni chat';

  @override
  String get chatSettingsDescription =>
      'Personalizza la tua esperienza di chat';

  @override
  String get privacySettings => 'Impostazioni privacy';

  @override
  String get privacySettingsDescription => 'Controlla la tua privacy';

  @override
  String get securitySettings => 'Impostazioni sicurezza';

  @override
  String get securityAuthentication => 'Autenticazione';

  @override
  String get securityChangePassword => 'Cambia password';

  @override
  String get securityTwoFactorAuth => 'Autenticazione a due fattori';

  @override
  String get twoFactorEnabled => 'Autenticazione a due fattori abilitata';

  @override
  String get twoFactorDisabled => 'Autenticazione a due fattori disabilitata';

  @override
  String get securityChangeEmail => 'Cambia email';

  @override
  String get securityPasscode => 'Passcode';

  @override
  String get securitySettingsDescription => 'Proteggi il tuo account';

  @override
  String get passwordEmptyError => 'La password non può essere vuota';

  @override
  String get passwordTooShortError =>
      'La password deve essere lunga almeno 8 caratteri';

  @override
  String get passwordEnterCurrentHint => 'Inserisci password attuale';

  @override
  String get passwordCurrentHint => 'Password attuale';

  @override
  String get passwordConfirmNewHint => 'Conferma nuova password';

  @override
  String get passwordDontMatchError => 'Le password non corrispondono';

  @override
  String get passwordNewTitle => 'Nuova password';

  @override
  String get passwordNewHint => 'Inserisci nuova password';

  @override
  String get passwordConfirmHint => 'Conferma password';

  @override
  String get passwordChangedSuccess => 'Password cambiata con successo';

  @override
  String get passwordNextButton => 'Avanti';

  @override
  String get passwordSaveButton => 'Salva';

  @override
  String get powerSettings => 'Impostazioni avanzate';

  @override
  String get powerSettingsDescription => 'Impostazioni avanzate';

  @override
  String get languageSelect => 'Seleziona lingua';

  @override
  String get cancel => 'Annulla';

  @override
  String get ready => 'Pronto';

  @override
  String contentInDevelopment(String title) {
    return 'Contenuto in sviluppo';
  }

  @override
  String get sessions => 'Sessioni';

  @override
  String get support => 'Supporto';

  @override
  String get xaneoBenefits => 'Vantaggi Xaneo';

  @override
  String get messengerFeatures => 'Funzioni Messenger';

  @override
  String get secureEncryption => 'Crittografia sicura';

  @override
  String get instantDelivery => 'Consegna istantanea';

  @override
  String get deviceSync => 'Sincronizzazione dispositivi';

  @override
  String get mediaSupport => 'Supporto multimediale';

  @override
  String get sessionsContent => 'Gestisci le tue sessioni attive';

  @override
  String get activeDevices => 'Dispositivi attivi';

  @override
  String get currentDevice => 'Dispositivo corrente';

  @override
  String get terminateSession => 'Termina sessione';

  @override
  String get terminateAllOtherSessions => 'Termina tutte le altre sessioni';

  @override
  String get sessionLocation => 'Posizione';

  @override
  String get sessionLastActive => 'Ultima attività';

  @override
  String get sessionBrowser => 'Browser';

  @override
  String get sessionPlatform => 'Piattaforma';

  @override
  String get confirmTerminateSession =>
      'Sei sicuro di voler terminare questa sessione?';

  @override
  String get confirmTerminateAllSessions =>
      'Sei sicuro di voler terminare tutte le altre sessioni?';

  @override
  String get sessionIPAddress => 'Indirizzo IP';

  @override
  String get supportContent => 'Contatta il nostro team di supporto';

  @override
  String get contactSupport => 'Contatta supporto';

  @override
  String get xaneoBenefitsContent => 'Scopri i vantaggi di Xaneo';

  @override
  String get more => 'Altro';

  @override
  String get chatPreview => 'Anteprima chat';

  @override
  String get textSize => 'Dimensione testo';

  @override
  String textSizeValue(String size) {
    return '$size%';
  }

  @override
  String get textExample => 'Testo di esempio';

  @override
  String get useDarkTheme => 'Usa tema scuro';

  @override
  String get chatWallpapers => 'Sfondi chat';

  @override
  String get messageColors => 'Colori messaggi';

  @override
  String get myMessages => 'I miei messaggi';

  @override
  String get receivedMessages => 'Messaggi ricevuti';

  @override
  String get messageEmojis => 'Emoji messaggi';

  @override
  String get selectedEmoji => 'Emoji selezionato';

  @override
  String get chooseWallpaper => 'Scegli sfondo';

  @override
  String get demoMessage1 => 'Ciao! Come stai?';

  @override
  String get demoMessage2 => 'Sto bene, grazie! E tu?';

  @override
  String get demoMessage3 => 'Anche io! Bello vederti.';

  @override
  String get demoDateSeparator => 'Oggi';

  @override
  String get onlineStatus => 'Online';

  @override
  String get chatTheme => 'Tema chat';

  @override
  String get privacySettingsTitle => 'Impostazioni privacy';

  @override
  String get privacyCommunications => 'Comunicazioni';

  @override
  String get privacyProfileVisibility => 'Visibilità profilo';

  @override
  String get privacyWhoCanMessage => 'Chi può scrivermi';

  @override
  String get privacyWhoCanRecordVoice => 'Chi può registrare messaggi vocali';

  @override
  String get privacyWhoCanCall => 'Chi può chiamarmi';

  @override
  String get privacyWhoCanSendVideo => 'Chi può inviarmi video';

  @override
  String get privacyWhoCanSendLinks => 'Chi può inviarmi link';

  @override
  String get privacyWhoCanInvite => 'Chi può invitarmi';

  @override
  String get privacyWhoSeesNickname => 'Chi vede il mio nickname';

  @override
  String get privacyWhoSeesAvatar => 'Chi vede il mio avatar';

  @override
  String get privacyWhoSeesBirthday => 'Chi vede la mia data di nascita';

  @override
  String get privacyWhoSeesOnlineTime => 'Chi vede il mio orario online';

  @override
  String get privacyAll => 'Tutti';

  @override
  String get privacyContacts => 'Contatti';

  @override
  String get privacyNobody => 'Nessuno';

  @override
  String get passwordWeak => 'Debole';

  @override
  String get passwordMedium => 'Media';

  @override
  String get passwordStrong => 'Forte';

  @override
  String twoFactorEnableDescription(String email) {
    return 'Aggiungi autenticazione a due fattori per maggiore sicurezza';
  }

  @override
  String twoFactorDisableDescription(String email) {
    return 'Disabilita autenticazione a due fattori';
  }

  @override
  String get changeEmailVerificationDescription =>
      'Riceverai un codice di verifica alla tua nuova email';

  @override
  String get newEmailTitle => 'Nuovo indirizzo email';

  @override
  String get newEmailDescription => 'Inserisci il tuo nuovo indirizzo email';

  @override
  String get changeEmailButton => 'Cambia email';

  @override
  String get verifyNewEmailTitle => 'Verifica nuova email';

  @override
  String verifyNewEmailDescription(String email) {
    return 'Inserisci il codice di verifica inviato alla tua nuova email';
  }

  @override
  String get verifyNewEmailButton => 'Verifica email';

  @override
  String get passcodeVerificationTitle => 'Verifica passcode';

  @override
  String passcodeVerificationDescription(String email) {
    return 'Inserisci il tuo passcode per continuare';
  }

  @override
  String get passcodeVerificationButton => 'Verifica passcode';

  @override
  String get setPasscodeTitle => 'Imposta passcode';

  @override
  String get setPasscodeDescription =>
      'Crea un passcode a 4 cifre per maggiore sicurezza';

  @override
  String get passcodeHint => 'Inserisci passcode';

  @override
  String get setPasscodeButton => 'Imposta passcode';

  @override
  String get xaneoBenefitsModalTitle => 'Vantaggi Premium Xaneo';

  @override
  String get xaneoBenefitsModalDescription =>
      'Sblocca funzioni premium e supporta lo sviluppo';

  @override
  String get xaneoBenefitsSelectPlan => 'Seleziona il tuo piano';

  @override
  String get xaneoBenefitsYearlyPlan => 'Piano annuale';

  @override
  String get xaneoBenefitsMonthlyPlan => 'Piano mensile';

  @override
  String get xaneoBenefitsYearlyPrice => '49,99 € / anno';

  @override
  String get xaneoBenefitsMonthlyPrice => '4,99 € / mese';

  @override
  String get xaneoBenefitsSavings => 'Risparmia 17%';

  @override
  String get xaneoBenefitsSubscribeButton => 'Abbonati';

  @override
  String get xaneoBenefitsCloseButton => 'Chiudi';

  @override
  String get xaneoBenefitsYearlySuccess =>
      'Abbonamento annuale XB completato con successo!';

  @override
  String get xaneoBenefitsMonthlySuccess =>
      'Abbonamento mensile XB completato con successo!';

  @override
  String get favoritesChat => 'Preferiti';

  @override
  String get favoritesChatDescription => 'Messaggi e file importanti';

  @override
  String contentInDevelopmentMessage(String title) {
    return 'Contenuto per \"$title\" in sviluppo...';
  }

  @override
  String get russianLanguage => 'Russo';

  @override
  String chatWelcomeMessage(String chatName) {
    return 'Ciao! Questa è la chat \"$chatName\" 🎉';
  }

  @override
  String get formattingExample1 =>
      'Qui puoi usare **grassetto**, *corsivo* e __sottolineato__!';

  @override
  String get formattingExample2 => 'Nonché ~~barrato~~ e `codice` 💻';

  @override
  String get greetingTrigger => 'ciao';

  @override
  String get greetingResponse => 'Ciao! Come stai?';

  @override
  String get fileSendingNotImplemented => 'Invio file non ancora implementato';

  @override
  String get wasOnlineRecently => 'era online di recente';

  @override
  String get messageHint => 'Messaggio';
}
