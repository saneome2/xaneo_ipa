// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'XaneoMobile';

  @override
  String get welcomeTitle => 'Bienvenue dans Xaneo';

  @override
  String get welcomeDescription =>
      'Xaneo - maintenant dans une application mobile ! Xaneo n\'a jamais été aussi pratique et rapide.';

  @override
  String get getStartedButton => 'Ça m\'intéresse déjà';

  @override
  String get connectingToServer => 'Connexion au serveur...';

  @override
  String version(String version) {
    return 'Version : $version';
  }

  @override
  String httpError(int code) {
    return 'Erreur : HTTP $code';
  }

  @override
  String connectionError(String error) {
    return 'Erreur de connexion : $error';
  }

  @override
  String get updateAvailable => 'Mise à jour disponible !';

  @override
  String get updateDialogTitle => 'Mise à jour disponible !';

  @override
  String updateDialogMessage(String currentVersion, String latestVersion) {
    return 'Votre version est $currentVersion, et la nouvelle est $latestVersion';
  }

  @override
  String get updateDialogDescription =>
      'Vous pouvez mettre à jour via Google Play, RuStore ou depuis le site officiel de Xaneo.';

  @override
  String get updateButton => 'Mettre à jour';

  @override
  String get cancelButton => 'Annuler';

  @override
  String get selectUpdateSource => 'Sélectionnez la source de mise à jour :';

  @override
  String get settings => 'Paramètres';

  @override
  String get about => 'À propos';

  @override
  String get help => 'Aide';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationsDescription =>
      'Recevoir des notifications sur les nouvelles fonctionnalités';

  @override
  String get darkTheme => 'Thème sombre';

  @override
  String get darkThemeDescription => 'Utiliser l\'apparence sombre';

  @override
  String fontSize(int size) {
    return 'Taille de police : $size';
  }

  @override
  String get appVersion => 'Version de l\'application';

  @override
  String get messengerDemoMode => 'Mode démo du messager';

  @override
  String get language => 'Langue';

  @override
  String get languageDescription => 'Choisir la langue de l\'interface';

  @override
  String get welcomeMessage => 'Excellent ! Bienvenue !';

  @override
  String get privacyTitle => 'Toutes vos données sont sécurisées';

  @override
  String get privacyDescription =>
      'Tous les messages dans XaneoConnect sont protégés par un chiffrement de bout en bout. Xaneo ne connaît jamais leur contenu.';

  @override
  String get continueButton => 'Continuons';

  @override
  String get dataStorageTitle =>
      'Tous les centres de données Xaneo sont situés en Russie';

  @override
  String get dataStorageDescription =>
      'Vos données ne quittent jamais le pays et sont stockées dans des centres de données sécurisés.';

  @override
  String get finishButton => 'Terminer';

  @override
  String get setupCompleted => 'Configuration terminée !';

  @override
  String get loginFormTitle => 'Connectons-nous';

  @override
  String get registerFormTitle => 'Commençons';

  @override
  String get registerNameSubtitle => 'Comment vous appelez-vous ?';

  @override
  String get nameFieldHint => 'Votre nom';

  @override
  String get nextButton => 'Suivant';

  @override
  String get skipButton => 'Passer';

  @override
  String get registerBirthdateSubtitle => 'Quand êtes-vous né(e) ?';

  @override
  String get selectDate => 'Sélectionner la date';

  @override
  String get ageRestrictionsLink => 'Quelles sont les restrictions d\'âge ?';

  @override
  String get ageRestrictionsTitle => 'Inscription possible dès 14 ans';

  @override
  String get ageRestrictionsDescription =>
      'Vous pouvez vous inscrire sur notre service si vous avez 14 ans ou plus';

  @override
  String get gotIt => 'Compris';

  @override
  String get registerNicknameSubtitle => 'Choisissez un pseudo';

  @override
  String get nicknameFieldHint => 'Votre pseudo';

  @override
  String get nicknameHelpLink => 'Vous n\'arrivez pas à trouver un pseudo ?';

  @override
  String get registerEmailSubtitle => 'Saisissez votre e-mail';

  @override
  String get emailFieldHint => 'Votre e-mail';

  @override
  String get supportedEmailProvidersLink =>
      'Quels fournisseurs d\'e-mail sont pris en charge ?';

  @override
  String get supportedEmailProvidersTitle =>
      'Fournisseurs d\'e-mail pris en charge';

  @override
  String get supportedEmailProvidersDescription =>
      'Gmail, Outlook, Yandex, Mail.ru et d\'autres services de messagerie populaires sont pris en charge.';

  @override
  String get emailFormatError => 'Format d\'adresse e-mail invalide';

  @override
  String get emailUnsupportedError =>
      'Ce service de messagerie n\'est pas pris en charge';

  @override
  String get checkingEmail => 'Vérification de l\'e-mail...';

  @override
  String get emailAvailable => 'E-mail disponible';

  @override
  String get emailTakenError => 'Cet e-mail est déjà pris';

  @override
  String get emailServerError =>
      'Erreur de vérification d\'e-mail. Veuillez réessayer plus tard';

  @override
  String get verifyEmailTitle => 'Vérifiez votre e-mail';

  @override
  String get verifyEmailDescription =>
      'Nous avons envoyé un code à 6 chiffres à votre e-mail. Saisissez-le pour confirmer.';

  @override
  String get verificationCodeHint => 'Code de vérification';

  @override
  String get verifyButton => 'Vérifier';

  @override
  String get registerPasswordSubtitle => 'Créez un mot de passe';

  @override
  String get registerPasswordFieldHint => 'Entrez le mot de passe';

  @override
  String get passwordInvalidCharsError =>
      'Le mot de passe ne peut contenir que des lettres latines, des chiffres et des signes de ponctuation';

  @override
  String get passwordWeakError =>
      'Le mot de passe est trop faible. Utilisez des lettres, des chiffres et des caractères spéciaux';

  @override
  String get passwordMediumWarning =>
      'Mot de passe de force moyenne. Recommandons de renforcer';

  @override
  String get passwordStrongSuccess => 'Mot de passe fort';

  @override
  String get nicknameGeneratorTitle =>
      'Votre pseudo sera généré automatiquement';

  @override
  String get nicknameGeneratorDescription =>
      'Vous pourrez changer votre pseudo à tout moment';

  @override
  String get closeButton => 'Fermer';

  @override
  String get loginFieldHint => 'Identifiant';

  @override
  String get passwordFieldHint => 'Mot de passe';

  @override
  String get loginButton => 'Se connecter';

  @override
  String get fillAllFields => 'Veuillez remplir tous les champs';

  @override
  String get loggingIn => 'Connexion en cours...';

  @override
  String welcomeUser(String username) {
    return 'Bienvenue, $username !';
  }

  @override
  String get invalidCredentials =>
      'Identifiants invalides. Vérifiez votre nom d\'utilisateur et votre mot de passe.';

  @override
  String get serverError => 'Erreur serveur. Veuillez réessayer plus tard.';

  @override
  String get connectionErrorLogin =>
      'Erreur de connexion. Vérifiez votre connexion Internet.';

  @override
  String get noAccount => 'Pas de compte ?';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get forgotPasswordDescription =>
      'Entrez votre nom d\'utilisateur et nous vous enverrons un lien pour accéder à votre compte par email.';

  @override
  String get sendLinkButton => 'Envoyer le Lien';

  @override
  String get checkEmailTitle => 'Vérifiez votre Email';

  @override
  String checkEmailDescription(String email) {
    return 'Veuillez vérifier votre boîte de réception $email et suivre le lien pour accéder à votre compte.';
  }

  @override
  String get forgotPasswordCodeDescription =>
      'Entrez le code d\'accès qui a été envoyé à l\'email lié à votre compte';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ?';

  @override
  String get registrationUnavailable =>
      'L\'inscription n\'est pas disponible pour le moment';

  @override
  String get passwordRecoveryUnavailable =>
      'La récupération de mot de passe n\'est pas disponible pour le moment';

  @override
  String get nicknameMinLengthError =>
      'La longueur du pseudo doit être d\'au moins cinq caractères';

  @override
  String get nicknameLatinOnlyError =>
      'Le pseudo ne peut contenir que des lettres latines, des chiffres, des points et tiret bas';

  @override
  String get nicknameStartError =>
      'Le pseudo ne peut pas commencer par un tiret bas, un chiffre ou un point';

  @override
  String get nicknameEndError =>
      'Le pseudo ne peut pas se terminer par un trait de soulignement ou un point';

  @override
  String get checkingNickname => 'Vérification du pseudo...';

  @override
  String get nicknameAvailable => 'Pseudo disponible';

  @override
  String get nicknameTakenError => 'Ce pseudo est déjà pris';

  @override
  String get nicknameServerError =>
      'Erreur de vérification du pseudo. Veuillez réessayer plus tard';

  @override
  String get nicknameMaxLengthError => 'Maximum 30 caractères';

  @override
  String get nameEmptyError => 'Le nom ne peut pas être vide';

  @override
  String get confirmPasswordTitle => 'Confirmer le mot de passe';

  @override
  String get confirmPasswordDescription =>
      'Entrez votre mot de passe à nouveau pour confirmer';

  @override
  String get confirmPasswordFieldHint => 'Répéter le mot de passe';

  @override
  String get passwordMismatchError => 'Les mots de passe ne correspondent pas';

  @override
  String get confirmButton => 'Confirmer';

  @override
  String get registerAvatarSubtitle => 'Choisir un avatar';

  @override
  String get addAvatarHint => 'Appuyez sur + pour ajouter une photo';

  @override
  String get avatarTapToSelect => 'Appuyez pour sélectionner une photo';

  @override
  String get photoPermissionTitle => 'Autoriser l\'accès aux images';

  @override
  String get photoPermissionDescription =>
      'Autorisez-nous l\'accès à vos images pour que vous puissiez choisir un avatar pour votre profil';

  @override
  String get allowAccessButton => 'Autoriser l\'accès';

  @override
  String get notNowButton => 'Pas maintenant';

  @override
  String get avatarCropperTitle => 'Configuration d\'Avatar';

  @override
  String get doneButton => 'Terminé';

  @override
  String get cropInstructions =>
      'Faites glisser le cercle pour sélectionner la zone • Utilisez les points pour redimensionner';

  @override
  String get changeAvatar => 'Changer l\'Avatar';

  @override
  String get profilePreviewTitle => 'Voici à quoi ressemblera votre profil';

  @override
  String get goodMorning => 'Bonjour';

  @override
  String get goodDay => 'Bon après-midi';

  @override
  String get goodEvening => 'Bonsoir';

  @override
  String get goodNight => 'Bonne nuit';

  @override
  String get backButton => 'Retour';

  @override
  String get editName => 'Modifier le nom';

  @override
  String get editNickname => 'Modifier le pseudo';

  @override
  String get editPhoto => 'Modifier la photo';

  @override
  String get saveButton => 'Enregistrer';

  @override
  String get deleteButton => 'Supprimer';

  @override
  String get deletePhoto => 'Supprimer la photo';

  @override
  String get selectFromGallery => 'Choisir dans la galerie';

  @override
  String get enterNameHint => 'Entrez votre nom';

  @override
  String get enterNicknameHint => 'Entrez un pseudo';

  @override
  String get termsAndConditionsTitle => 'Conditions d\'utilisation';

  @override
  String get termsOfUse => 'Conditions d\'utilisation';

  @override
  String get userAgreement => 'Accord d\'utilisateur';

  @override
  String acceptTermsText(String termsOfUse, String userAgreement) {
    return 'Pour terminer l\'inscription et commencer à utiliser Xaneo, vous devez accepter nos $termsOfUse et $userAgreement.\n\nCes documents contiennent des informations importantes sur les règles d\'utilisation du service, la protection des données et les obligations des deux parties.\n\nEn acceptant ces conditions, vous confirmez avoir lu et accepté de respecter les règles de la plateforme.\n\nSans accepter ces conditions, l\'inscription ne peut pas être terminée et l\'accès au service sera restreint.';
  }

  @override
  String get acceptButton => 'Accepter';

  @override
  String get declineButton => 'Refuser';

  @override
  String verificationCodeSent(String email, int seconds) {
    return 'Code envoyé à $email. Valide pendant $seconds secondes';
  }

  @override
  String get codeDeliveryError => 'Erreur d\'envoi du code';

  @override
  String get serverErrorCodeDelivery =>
      'Erreur serveur lors de l\'envoi du code';

  @override
  String get connectionErrorCodeDelivery =>
      'Erreur de connexion lors de l\'envoi du code';

  @override
  String get emailVerificationSuccess => 'Email vérifié avec succès!';

  @override
  String get invalidVerificationCode =>
      'Code de vérification invalide. Vérifiez le code et réessayez';

  @override
  String get emailNotFound => 'Email non trouvé. Essayez de vous réinscrire';

  @override
  String get verificationCodeExpired =>
      'Code de vérification expiré. Demandez un nouveau code';

  @override
  String get serverErrorCodeVerification =>
      'Erreur serveur lors de la vérification du code. Réessayez plus tard';

  @override
  String get connectionErrorCodeVerification =>
      'Erreur de connexion lors de la vérification du code';

  @override
  String get permissionDeniedSettings =>
      'Autorisation refusée définitivement. Activez-la dans les paramètres';

  @override
  String get avatarCropped => 'Avatar recadré et sauvegardé!';

  @override
  String get imageSelectionError => 'Erreur lors de la sélection de l\'image';

  @override
  String get permissionDeniedOpenSettings =>
      'Autorisation refusée définitivement. Ouvrez les paramètres pour l\'activer';

  @override
  String get photoPermissionError =>
      'Impossible d\'obtenir l\'autorisation d\'accès aux photos';

  @override
  String get registrationCompleted => 'Inscription terminée!';

  @override
  String get officialXaneoWebsite => 'Site Web Officiel de Xaneo';

  @override
  String twoFactorAuthMessage(String email) {
    return 'L\'authentification à deux facteurs est activée sur ce compte. Entrez le code de vérification qui a été envoyé à $email';
  }

  @override
  String get selectLanguage => 'Sélectionner la langue';

  @override
  String get messengerDemo => 'Démo de messagerie';

  @override
  String get messenger => 'Messagerie';

  @override
  String get messengerDescription =>
      'Messagerie simple, rapide et sécurisée avec un design moderne et une interface conviviale.';

  @override
  String get profileDemo => 'Démo de profil';

  @override
  String get profile => 'Profil';

  @override
  String get personalInfo => 'Informations personnelles';

  @override
  String get name => 'Nom';

  @override
  String get nameHint => 'Nom';

  @override
  String get birthDate => 'Date de naissance';

  @override
  String get nickname => 'Pseudonyme';

  @override
  String get nicknameHint => 'Pseudonyme';

  @override
  String get phone => 'Téléphone';

  @override
  String get phoneHint => 'Numéro de téléphone';

  @override
  String get settingsSection => 'Paramètres';

  @override
  String get chatSettings => 'Paramètres de chat';

  @override
  String get chatSettingsDescription => 'Les paramètres de chat seront ici...';

  @override
  String get privacySettings => 'Confidentialité et vie privée';

  @override
  String get privacySettingsDescription =>
      'Les paramètres de confidentialité seront ici...';

  @override
  String get securitySettings => 'Sécurité';

  @override
  String get securityAuthentication => 'Authentification';

  @override
  String get securityChangePassword => 'Changer le Mot de Passe';

  @override
  String get securityTwoFactorAuth => 'Authentification à Deux Facteurs';

  @override
  String get twoFactorEnabled => 'Activée';

  @override
  String get twoFactorDisabled => 'Désactivée';

  @override
  String get securityChangeEmail => 'Changer l\'E-mail';

  @override
  String get securityPasscode => 'Code d\'Accès';

  @override
  String get securitySettingsDescription =>
      'Les paramètres de sécurité seront ici...';

  @override
  String get passwordEmptyError => 'Le mot de passe ne peut pas être vide';

  @override
  String get passwordTooShortError =>
      'Le mot de passe doit contenir au moins 5 caractères';

  @override
  String get passwordEnterCurrentHint =>
      'Entrez le mot de passe actuel pour confirmer';

  @override
  String get passwordCurrentHint => 'Mot de passe actuel';

  @override
  String get passwordConfirmNewHint => 'Confirmez le nouveau mot de passe';

  @override
  String get passwordDontMatchError => 'Les mots de passe ne correspondent pas';

  @override
  String get passwordNewTitle => 'Nouveau mot de passe';

  @override
  String get passwordNewHint => 'Nouveau mot de passe';

  @override
  String get passwordConfirmHint => 'Confirmez le mot de passe';

  @override
  String get passwordChangedSuccess => 'Mot de passe changé avec succès';

  @override
  String get passwordNextButton => 'Suivant';

  @override
  String get passwordSaveButton => 'Enregistrer';

  @override
  String get powerSettings => 'Économie d\'énergie';

  @override
  String get powerSettingsDescription =>
      'Les paramètres d\'économie d\'énergie seront ici...';

  @override
  String get languageSelect => 'Langue';

  @override
  String get cancel => 'Annuler';

  @override
  String get ready => 'Prêt';

  @override
  String contentInDevelopment(String title) {
    return 'Le contenu pour \"$title\" est en cours de développement...';
  }

  @override
  String get sessions => 'Sessions';

  @override
  String get support => 'Support';

  @override
  String get xaneoBenefits => 'XaneoBenefits';

  @override
  String get messengerFeatures => 'Fonctionnalités du mode démo:';

  @override
  String get secureEncryption => 'Chiffrement sécurisé des messages';

  @override
  String get instantDelivery => 'Livraison instantanée';

  @override
  String get deviceSync => 'Synchronisation entre appareils';

  @override
  String get mediaSupport => 'Support de fichiers multimédias';

  @override
  String get sessionsContent =>
      'Les sessions actives de votre compte seront affichées ici...';

  @override
  String get activeDevices => 'Appareils Actifs';

  @override
  String get currentDevice => 'Appareil Actuel';

  @override
  String get terminateSession => 'Terminer la Session';

  @override
  String get terminateAllOtherSessions => 'Terminer Toutes les Autres Sessions';

  @override
  String get sessionLocation => 'Emplacement';

  @override
  String get sessionLastActive => 'Dernière Activité';

  @override
  String get sessionBrowser => 'Navigateur';

  @override
  String get sessionPlatform => 'Plateforme';

  @override
  String get confirmTerminateSession =>
      'Êtes-vous sûr de vouloir terminer cette session?';

  @override
  String get confirmTerminateAllSessions =>
      'Êtes-vous sûr de vouloir terminer toutes les autres sessions? Cette action ne peut pas être annulée.';

  @override
  String get sessionIPAddress => 'Adresse IP';

  @override
  String get supportContent =>
      'Nous avons une charge très élevée sur notre service de support. Nous nous efforçons de répondre le plus rapidement possible, mais actuellement le temps d\'attente peut être jusqu\'à 24 heures. Veuillez nous contacter et nous vous aiderons certainement à résoudre votre problème.';

  @override
  String get contactSupport => 'Contacter';

  @override
  String get xaneoBenefitsContent =>
      'XaneoBenefits est un programme de fidélité pour les utilisateurs de Xaneo. Obtenez des bonus et des fonctionnalités exclusives...';

  @override
  String get more => 'Plus';

  @override
  String get chatPreview => 'Aperçu du chat';

  @override
  String get textSize => 'Taille du texte';

  @override
  String textSizeValue(String size) {
    return 'Taille: $size';
  }

  @override
  String get textExample => 'Exemple de texte';

  @override
  String get useDarkTheme => 'Utiliser l\'apparence sombre';

  @override
  String get chatWallpapers => 'Fonds d\'écran du chat';

  @override
  String get messageColors => 'Couleurs des messages';

  @override
  String get myMessages => 'Mes messages';

  @override
  String get receivedMessages => 'Messages reçus';

  @override
  String get messageEmojis => 'Emojis pour les messages';

  @override
  String get selectedEmoji => 'Emoji sélectionné:';

  @override
  String get chooseWallpaper => 'Choisir un fond d\'écran:';

  @override
  String get demoMessage1 => 'Salut ! Comment ça va ?';

  @override
  String get demoMessage2 => 'Tout va super ! Et toi ?';

  @override
  String get demoMessage3 => 'Moi aussi ça va bien, merci 😊';

  @override
  String get demoDateSeparator => 'Aujourd\'hui';

  @override
  String get onlineStatus => 'en ligne';

  @override
  String get chatTheme => 'Thème du chat';

  @override
  String get privacySettingsTitle => 'Confidentialité et sécurité';

  @override
  String get privacyCommunications => 'Communications';

  @override
  String get privacyProfileVisibility => 'Visibilité du profil';

  @override
  String get privacyWhoCanMessage => 'Messages';

  @override
  String get privacyWhoCanRecordVoice => 'Messages vocaux';

  @override
  String get privacyWhoCanCall => 'Appels';

  @override
  String get privacyWhoCanSendVideo => 'Messages vidéo';

  @override
  String get privacyWhoCanSendLinks => 'Liens';

  @override
  String get privacyWhoCanInvite => 'Invitations';

  @override
  String get privacyWhoSeesNickname => 'Pseudonyme';

  @override
  String get privacyWhoSeesAvatar => 'Avatar';

  @override
  String get privacyWhoSeesBirthday => 'Anniversaire';

  @override
  String get privacyWhoSeesOnlineTime => 'Heure de connexion';

  @override
  String get privacyAll => 'Tous';

  @override
  String get privacyContacts => 'Contacts';

  @override
  String get privacyNobody => 'Personne';

  @override
  String get passwordWeak => 'Faible';

  @override
  String get passwordMedium => 'Moyen';

  @override
  String get passwordStrong => 'Fort';

  @override
  String twoFactorEnableDescription(String email) {
    return 'Pour activer l\'authentification à deux facteurs, saisissez le code de vérification envoyé à $email';
  }

  @override
  String twoFactorDisableDescription(String email) {
    return 'Pour désactiver l\'authentification à deux facteurs, saisissez le code de vérification envoyé à $email';
  }

  @override
  String get changeEmailVerificationDescription =>
      'Pour changer votre e-mail, saisissez le code de vérification envoyé à demouser@example.com';

  @override
  String get newEmailTitle => 'Nouvel E-mail';

  @override
  String get newEmailDescription => 'Saisissez la nouvelle adresse e-mail';

  @override
  String get changeEmailButton => 'Changer';

  @override
  String get verifyNewEmailTitle => 'Vérifier le Nouvel E-mail';

  @override
  String verifyNewEmailDescription(String email) {
    return 'Pour vérifier votre nouvel e-mail $email, saisissez le code de confirmation envoyé à cette adresse';
  }

  @override
  String get verifyNewEmailButton => 'Vérifier';

  @override
  String get passcodeVerificationTitle => 'Activer le Code d\'Accès';

  @override
  String passcodeVerificationDescription(String email) {
    return 'Pour activer la protection par code d\'accès, saisissez le code de vérification envoyé à $email';
  }

  @override
  String get passcodeVerificationButton => 'Activer';

  @override
  String get setPasscodeTitle => 'Définir le Code d\'Accès';

  @override
  String get setPasscodeDescription =>
      'Créez un code d\'accès à 4 chiffres pour une protection supplémentaire';

  @override
  String get passcodeHint => 'Entrez 4 chiffres';

  @override
  String get setPasscodeButton => 'Définir';

  @override
  String get xaneoBenefitsModalTitle => 'XaneoBenefits (XB)';

  @override
  String get xaneoBenefitsModalDescription => 'Abonnement Premium Xaneo';

  @override
  String get xaneoBenefitsSelectPlan => 'Choisissez votre plan d\'abonnement :';

  @override
  String get xaneoBenefitsYearlyPlan => 'Abonnement annuel';

  @override
  String get xaneoBenefitsMonthlyPlan => 'Abonnement mensuel';

  @override
  String get xaneoBenefitsYearlyPrice => '€999 par an';

  @override
  String get xaneoBenefitsMonthlyPrice => '€159 par mois';

  @override
  String get xaneoBenefitsSavings =>
      'Économisez 25%! Seulement €83,25 par mois';

  @override
  String get xaneoBenefitsSubscribeButton => 'S\'abonner à XB';

  @override
  String get xaneoBenefitsCloseButton => 'Fermer';

  @override
  String get xaneoBenefitsYearlySuccess => 'Abonnement annuel XB activé !';

  @override
  String get xaneoBenefitsMonthlySuccess => 'Abonnement mensuel XB activé !';
}
