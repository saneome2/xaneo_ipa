// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'XaneoMobile';

  @override
  String get welcomeTitle => 'Bienvenido a Xaneo';

  @override
  String get welcomeDescription =>
      'Xaneo - ¡ahora en una aplicación móvil! Xaneo nunca ha sido tan conveniente y rápido.';

  @override
  String get getStartedButton => 'Ya me interesa';

  @override
  String get connectingToServer => 'Conectando al servidor...';

  @override
  String version(String version) {
    return 'Versión: $version';
  }

  @override
  String httpError(int code) {
    return 'Error: HTTP $code';
  }

  @override
  String connectionError(String error) {
    return 'Error de conexión: $error';
  }

  @override
  String get updateAvailable => '¡Actualización disponible!';

  @override
  String get updateDialogTitle => '¡Actualización disponible!';

  @override
  String updateDialogMessage(String currentVersion, String latestVersion) {
    return 'Su versión es $currentVersion, y la nueva es $latestVersion';
  }

  @override
  String get updateDialogDescription =>
      'Puede actualizar a través de Google Play, RuStore o desde el sitio web oficial de Xaneo.';

  @override
  String get updateButton => 'Actualizar';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get selectUpdateSource => 'Seleccione fuente de actualización:';

  @override
  String get settings => 'Configuración';

  @override
  String get about => 'Acerca de';

  @override
  String get help => 'Ayuda';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get notificationsDescription =>
      'Recibir notificaciones sobre nuevas características';

  @override
  String get darkTheme => 'Tema oscuro';

  @override
  String get darkThemeDescription => 'Usar apariencia oscura';

  @override
  String fontSize(int size) {
    return 'Tamaño de fuente: $size';
  }

  @override
  String get appVersion => 'Versión de la aplicación';

  @override
  String get messengerDemoMode => 'Modo demo del mensajero';

  @override
  String get language => 'Idioma';

  @override
  String get languageDescription => 'Elegir idioma de la interfaz';

  @override
  String get welcomeMessage => '¡Excelente! ¡Bienvenido!';

  @override
  String get privacyTitle => 'Todos tus datos están seguros';

  @override
  String get privacyDescription =>
      'Todos los mensajes en XaneoConnect están protegidos por cifrado de extremo a extremo. Xaneo nunca conoce su contenido.';

  @override
  String get continueButton => 'Continuemos';

  @override
  String get dataStorageTitle =>
      'Todos los centros de datos de Xaneo están ubicados en Rusia';

  @override
  String get dataStorageDescription =>
      'Tus datos nunca salen del país y se almacenan en centros de datos seguros.';

  @override
  String get finishButton => 'Finalizar';

  @override
  String get setupCompleted => '¡Configuración completada!';

  @override
  String get loginFormTitle => 'Iniciemos sesión';

  @override
  String get registerFormTitle => 'Comencemos';

  @override
  String get registerNameSubtitle => '¿Cómo te llamas?';

  @override
  String get nameFieldHint => 'Tu nombre';

  @override
  String get nextButton => 'Siguiente';

  @override
  String get skipButton => 'Saltar';

  @override
  String get registerBirthdateSubtitle => '¿Cuándo naciste?';

  @override
  String get selectDate => 'Seleccionar fecha';

  @override
  String get ageRestrictionsLink => '¿Cuáles son las restricciones de edad?';

  @override
  String get ageRestrictionsTitle => 'Registro posible desde los 14 años';

  @override
  String get ageRestrictionsDescription =>
      'Puedes registrarte en nuestro servicio si tienes 14 años o más';

  @override
  String get gotIt => 'Entendido';

  @override
  String get registerNicknameSubtitle => 'Elige un apodo';

  @override
  String get nicknameFieldHint => 'Tu apodo';

  @override
  String get nicknameHelpLink => '¿No puedes pensar en un apodo?';

  @override
  String get registerEmailSubtitle => 'Ingresa tu correo electrónico';

  @override
  String get emailFieldHint => 'Tu correo electrónico';

  @override
  String get supportedEmailProvidersLink =>
      '¿Qué proveedores de correo electrónico son compatibles?';

  @override
  String get supportedEmailProvidersTitle =>
      'Proveedores de correo electrónico compatibles';

  @override
  String get supportedEmailProvidersDescription =>
      'Se admiten Gmail, Outlook, Yandex, Mail.ru y otros servicios de correo populares.';

  @override
  String get emailFormatError =>
      'Formato de dirección de correo electrónico inválido';

  @override
  String get emailUnsupportedError =>
      'Este servicio de correo electrónico no es compatible';

  @override
  String get checkingEmail => 'Verificando correo...';

  @override
  String get emailAvailable => 'Correo disponible';

  @override
  String get emailTakenError => 'Este correo ya está ocupado';

  @override
  String get emailServerError =>
      'Error al verificar correo. Inténtelo más tarde';

  @override
  String get verifyEmailTitle => 'Verifique su correo electrónico';

  @override
  String get verifyEmailDescription =>
      'Enviamos un código de 6 dígitos a su correo. Ingréselo para confirmar.';

  @override
  String get verificationCodeHint => 'Código de verificación';

  @override
  String get verifyButton => 'Verificar';

  @override
  String get registerPasswordSubtitle => 'Crea una contraseña';

  @override
  String get registerPasswordFieldHint => 'Ingresa contraseña';

  @override
  String get passwordInvalidCharsError =>
      'La contraseña solo puede contener letras latinas, números y signos de puntuación';

  @override
  String get passwordWeakError =>
      'La contraseña es demasiado débil. Usa letras, números y caracteres especiales';

  @override
  String get passwordMediumWarning =>
      'Contraseña de fuerza media. Recomendamos fortalecer';

  @override
  String get passwordStrongSuccess => 'Contraseña fuerte';

  @override
  String get nicknameGeneratorTitle => 'Tu apodo se generará automáticamente';

  @override
  String get nicknameGeneratorDescription =>
      'Podrás cambiar tu apodo en cualquier momento';

  @override
  String get closeButton => 'Cerrar';

  @override
  String get loginFieldHint => 'Usuario';

  @override
  String get passwordFieldHint => 'Contraseña';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get fillAllFields => 'Por favor complete todos los campos';

  @override
  String get loggingIn => 'Iniciando sesión...';

  @override
  String welcomeUser(String username) {
    return '¡Bienvenido, $username!';
  }

  @override
  String get invalidCredentials =>
      'Credenciales inválidas. Verifique su nombre de usuario y contraseña.';

  @override
  String get serverError => 'Error del servidor. Por favor intente más tarde.';

  @override
  String get connectionErrorLogin =>
      'Error de conexión. Verifique su conexión a Internet.';

  @override
  String get noAccount => '¿No tiene cuenta?';

  @override
  String get forgotPassword => '¿Olvidaste la contraseña?';

  @override
  String get forgotPasswordDescription =>
      'Introduce tu nombre de usuario y te enviaremos un enlace para acceder a tu cuenta por correo electrónico.';

  @override
  String get sendLinkButton => 'Enviar Enlace';

  @override
  String get checkEmailTitle => 'Revisa tu Correo';

  @override
  String checkEmailDescription(String email) {
    return 'Por favor, revisa tu bandeja de entrada $email y sigue el enlace para acceder a tu cuenta.';
  }

  @override
  String get forgotPasswordCodeDescription =>
      'Ingresa el código de acceso que fue enviado al email vinculado a tu cuenta';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get registrationUnavailable =>
      'El registro no está disponible por el momento';

  @override
  String get passwordRecoveryUnavailable =>
      'La recuperación de contraseña no está disponible por el momento';

  @override
  String get nicknameMinLengthError =>
      'La longitud del apodo debe ser de al menos cinco caracteres';

  @override
  String get nicknameLatinOnlyError =>
      'El apodo solo puede contener letras latinas, números, puntos y guión bajo';

  @override
  String get nicknameStartError =>
      'El apodo no puede empezar con guión bajo, número o punto';

  @override
  String get nicknameEndError =>
      'El nombre de usuario no puede terminar con guión bajo o punto';

  @override
  String get checkingNickname => 'Verificando nombre de usuario...';

  @override
  String get nicknameAvailable => 'Nombre de usuario disponible';

  @override
  String get nicknameTakenError => 'Este nombre de usuario ya está tomado';

  @override
  String get nicknameServerError =>
      'Error al verificar nombre de usuario. Inténtelo más tarde';

  @override
  String get nicknameMaxLengthError => 'Máximo 30 caracteres';

  @override
  String get nameEmptyError => 'El nombre no puede estar vacío';

  @override
  String get confirmPasswordTitle => 'Confirmar contraseña';

  @override
  String get confirmPasswordDescription =>
      'Ingrese su contraseña nuevamente para confirmar';

  @override
  String get confirmPasswordFieldHint => 'Repetir contraseña';

  @override
  String get passwordMismatchError => 'Las contraseñas no coinciden';

  @override
  String get confirmButton => 'Confirmar';

  @override
  String get registerAvatarSubtitle => 'Elegir avatar';

  @override
  String get addAvatarHint => 'Toca + para agregar foto';

  @override
  String get avatarTapToSelect => 'Toca para seleccionar foto';

  @override
  String get photoPermissionTitle => 'Permitir acceso a imágenes';

  @override
  String get photoPermissionDescription =>
      'Permítenos acceso a tus imágenes para que puedas elegir un avatar para tu perfil';

  @override
  String get allowAccessButton => 'Permitir acceso';

  @override
  String get notNowButton => 'Ahora no';

  @override
  String get avatarCropperTitle => 'Configuración de Avatar';

  @override
  String get doneButton => 'Hecho';

  @override
  String get cropInstructions =>
      'Arrastra el círculo para seleccionar área • Usa los puntos para redimensionar';

  @override
  String get changeAvatar => 'Cambiar Avatar';

  @override
  String get profilePreviewTitle => 'Así se verá tu perfil';

  @override
  String get goodMorning => 'Buenos días';

  @override
  String get goodDay => 'Buenas tardes';

  @override
  String get goodEvening => 'Buenas tardes';

  @override
  String get goodNight => 'Buenas noches';

  @override
  String get backButton => 'Atrás';

  @override
  String get editName => 'Editar nombre';

  @override
  String get editNickname => 'Editar apodo';

  @override
  String get editPhoto => 'Editar foto';

  @override
  String get saveButton => 'Guardar';

  @override
  String get deleteButton => 'Eliminar';

  @override
  String get deletePhoto => 'Eliminar foto';

  @override
  String get selectFromGallery => 'Seleccionar de la galería';

  @override
  String get enterNameHint => 'Ingresa tu nombre';

  @override
  String get enterNicknameHint => 'Ingresa un apodo';

  @override
  String get termsAndConditionsTitle => 'Términos y Condiciones';

  @override
  String get termsOfUse => 'Términos de Uso';

  @override
  String get userAgreement => 'Acuerdo de Usuario';

  @override
  String acceptTermsText(String termsOfUse, String userAgreement) {
    return 'Para completar el registro y comenzar a usar Xaneo, debe aceptar nuestros $termsOfUse y $userAgreement.\n\nEstos documentos contienen información importante sobre las reglas de uso del servicio, protección de datos y obligaciones de ambas partes.\n\nAl aceptar estos términos, confirma que ha leído y acepta cumplir con las reglas de la plataforma.\n\nSin aceptar estos términos, el registro no se puede completar y el acceso al servicio será restringido.';
  }

  @override
  String get acceptButton => 'Aceptar';

  @override
  String get declineButton => 'Rechazar';

  @override
  String verificationCodeSent(String email, int seconds) {
    return 'Código enviado a $email. Válido por $seconds segundos';
  }

  @override
  String get codeDeliveryError => 'Error al enviar código';

  @override
  String get serverErrorCodeDelivery => 'Error del servidor al enviar código';

  @override
  String get connectionErrorCodeDelivery =>
      'Error de conexión al enviar código';

  @override
  String get emailVerificationSuccess => '¡Email verificado exitosamente!';

  @override
  String get invalidVerificationCode =>
      'Código de verificación inválido. Verifique el código e intente nuevamente';

  @override
  String get emailNotFound =>
      'Email no encontrado. Intente registrarse nuevamente';

  @override
  String get verificationCodeExpired =>
      'Código de verificación expirado. Solicite un nuevo código';

  @override
  String get serverErrorCodeVerification =>
      'Error del servidor al verificar código. Intente más tarde';

  @override
  String get connectionErrorCodeVerification =>
      'Error de conexión al verificar código';

  @override
  String get permissionDeniedSettings =>
      'Permiso denegado permanentemente. Actívelo en configuración';

  @override
  String get avatarCropped => '¡Avatar recortado y guardado!';

  @override
  String get imageSelectionError => 'Error al seleccionar imagen';

  @override
  String get permissionDeniedOpenSettings =>
      'Permiso denegado permanentemente. Abra configuración para activar';

  @override
  String get photoPermissionError =>
      'No se pudo obtener permiso de acceso a fotos';

  @override
  String get registrationCompleted => '¡Registro completado!';

  @override
  String get officialXaneoWebsite => 'Sitio Web Oficial de Xaneo';

  @override
  String twoFactorAuthMessage(String email) {
    return 'La autenticación de dos factores está habilitada en esta cuenta. Ingrese el código de verificación que fue enviado a $email';
  }

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get messengerDemo => 'Demo de mensajería';

  @override
  String get messenger => 'Mensajería';

  @override
  String get messengerDescription =>
      'Mensajero simple, rápido y seguro con diseño moderno e interfaz fácil de usar.';

  @override
  String get profileDemo => 'Demo de perfil';

  @override
  String get profile => 'Perfil';

  @override
  String get personalInfo => 'Información personal';

  @override
  String get name => 'Nombre';

  @override
  String get nameHint => 'Nombre';

  @override
  String get birthDate => 'Fecha de nacimiento';

  @override
  String get nickname => 'Apodo';

  @override
  String get nicknameHint => 'Apodo';

  @override
  String get phone => 'Teléfono';

  @override
  String get phoneHint => 'Número de teléfono';

  @override
  String get settingsSection => 'Configuración';

  @override
  String get chatSettings => 'Configuración de chats';

  @override
  String get chatSettingsDescription =>
      'Aquí estarán las configuraciones de chats...';

  @override
  String get privacySettings => 'Privacidad y confidencialidad';

  @override
  String get privacySettingsDescription =>
      'Aquí estarán las configuraciones de privacidad...';

  @override
  String get securitySettings => 'Seguridad';

  @override
  String get securityAuthentication => 'Autenticación';

  @override
  String get securityChangePassword => 'Cambiar Contraseña';

  @override
  String get securityTwoFactorAuth => 'Autenticación de Dos Factores';

  @override
  String get twoFactorEnabled => 'Habilitada';

  @override
  String get twoFactorDisabled => 'Deshabilitada';

  @override
  String get securityChangeEmail => 'Cambiar Correo';

  @override
  String get securityPasscode => 'Código de Acceso';

  @override
  String get securitySettingsDescription =>
      'Aquí estarán las configuraciones de seguridad...';

  @override
  String get passwordEmptyError => 'La contraseña no puede estar vacía';

  @override
  String get passwordTooShortError =>
      'La contraseña debe contener al menos 5 caracteres';

  @override
  String get passwordEnterCurrentHint =>
      'Ingrese la contraseña actual para confirmar';

  @override
  String get passwordCurrentHint => 'Contraseña actual';

  @override
  String get passwordConfirmNewHint => 'Confirme la nueva contraseña';

  @override
  String get passwordDontMatchError => 'Las contraseñas no coinciden';

  @override
  String get passwordNewTitle => 'Nueva contraseña';

  @override
  String get passwordNewHint => 'Nueva contraseña';

  @override
  String get passwordConfirmHint => 'Confirme la contraseña';

  @override
  String get passwordChangedSuccess => 'Contraseña cambiada exitosamente';

  @override
  String get passwordNextButton => 'Siguiente';

  @override
  String get passwordSaveButton => 'Guardar';

  @override
  String get powerSettings => 'Ahorro de energía';

  @override
  String get powerSettingsDescription =>
      'Aquí estarán las configuraciones de ahorro de energía...';

  @override
  String get languageSelect => 'Idioma';

  @override
  String get cancel => 'Cancelar';

  @override
  String get ready => 'Listo';

  @override
  String contentInDevelopment(String title) {
    return 'El contenido para \"$title\" está en desarrollo...';
  }

  @override
  String get sessions => 'Sesiones';

  @override
  String get support => 'Soporte';

  @override
  String get xaneoBenefits => 'XaneoBenefits';

  @override
  String get messengerFeatures => 'Características del modo demo:';

  @override
  String get secureEncryption => 'Cifrado seguro de mensajes';

  @override
  String get instantDelivery => 'Entrega instantánea';

  @override
  String get deviceSync => 'Sincronización entre dispositivos';

  @override
  String get mediaSupport => 'Soporte de archivos multimedia';

  @override
  String get sessionsContent =>
      'Aquí se mostrarán las sesiones activas de tu cuenta...';

  @override
  String get activeDevices => 'Dispositivos Activos';

  @override
  String get currentDevice => 'Dispositivo Actual';

  @override
  String get terminateSession => 'Terminar Sesión';

  @override
  String get terminateAllOtherSessions => 'Terminar Todas las Otras Sesiones';

  @override
  String get sessionLocation => 'Ubicación';

  @override
  String get sessionLastActive => 'Última Actividad';

  @override
  String get sessionBrowser => 'Navegador';

  @override
  String get sessionPlatform => 'Plataforma';

  @override
  String get confirmTerminateSession =>
      '¿Estás seguro de que quieres terminar esta sesión?';

  @override
  String get confirmTerminateAllSessions =>
      '¿Estás seguro de que quieres terminar todas las otras sesiones? Esta acción no se puede deshacer.';

  @override
  String get sessionIPAddress => 'Dirección IP';

  @override
  String get supportContent =>
      'Tenemos una carga muy alta en nuestro servicio de soporte. Nos esforzamos por responder lo más rápido posible, pero actualmente el tiempo de espera puede ser de hasta 24 horas. Por favor, contáctanos y definitivamente te ayudaremos a resolver tu problema.';

  @override
  String get contactSupport => 'Contactar';

  @override
  String get xaneoBenefitsContent =>
      'XaneoBenefits es un programa de fidelización para usuarios de Xaneo. Obtén bonos y características exclusivas...';

  @override
  String get more => 'Más';

  @override
  String get chatPreview => 'Vista previa del chat';

  @override
  String get textSize => 'Tamaño del texto';

  @override
  String textSizeValue(String size) {
    return 'Tamaño: $size';
  }

  @override
  String get textExample => 'Ejemplo de texto';

  @override
  String get useDarkTheme => 'Usar apariencia oscura';

  @override
  String get chatWallpapers => 'Fondos de chat';

  @override
  String get messageColors => 'Colores de mensajes';

  @override
  String get myMessages => 'Mis mensajes';

  @override
  String get receivedMessages => 'Mensajes recibidos';

  @override
  String get messageEmojis => 'Emojis para mensajes';

  @override
  String get selectedEmoji => 'Emoji seleccionado:';

  @override
  String get chooseWallpaper => 'Elegir fondo:';

  @override
  String get demoMessage1 => '¡Hola! ¿Cómo estás?';

  @override
  String get demoMessage2 => '¡Todo genial! ¿Y tú?';

  @override
  String get demoMessage3 => 'Yo también estoy bien, gracias 😊';

  @override
  String get demoDateSeparator => 'Hoy';

  @override
  String get onlineStatus => 'en línea';

  @override
  String get chatTheme => 'Tema del chat';

  @override
  String get privacySettingsTitle => 'Privacidad y seguridad';

  @override
  String get privacyCommunications => 'Comunicaciones';

  @override
  String get privacyProfileVisibility => 'Visibilidad del perfil';

  @override
  String get privacyWhoCanMessage => 'Mensajes';

  @override
  String get privacyWhoCanRecordVoice => 'Mensajes de voz';

  @override
  String get privacyWhoCanCall => 'Llamadas';

  @override
  String get privacyWhoCanSendVideo => 'Mensajes de video';

  @override
  String get privacyWhoCanSendLinks => 'Enlaces';

  @override
  String get privacyWhoCanInvite => 'Invitaciones';

  @override
  String get privacyWhoSeesNickname => 'Nickname';

  @override
  String get privacyWhoSeesAvatar => 'Avatar';

  @override
  String get privacyWhoSeesBirthday => 'Cumpleaños';

  @override
  String get privacyWhoSeesOnlineTime => 'Hora de conexión';

  @override
  String get privacyAll => 'Todos';

  @override
  String get privacyContacts => 'Contactos';

  @override
  String get privacyNobody => 'Nadie';

  @override
  String get passwordWeak => 'Débil';

  @override
  String get passwordMedium => 'Medio';

  @override
  String get passwordStrong => 'Fuerte';

  @override
  String twoFactorEnableDescription(String email) {
    return 'Para habilitar la autenticación de dos factores, ingrese el código de verificación enviado a $email';
  }

  @override
  String twoFactorDisableDescription(String email) {
    return 'Para deshabilitar la autenticación de dos factores, ingrese el código de verificación enviado a $email';
  }

  @override
  String get changeEmailVerificationDescription =>
      'Para cambiar su correo electrónico, ingrese el código de verificación enviado a demouser@example.com';

  @override
  String get newEmailTitle => 'Nuevo Correo';

  @override
  String get newEmailDescription =>
      'Ingrese nueva dirección de correo electrónico';

  @override
  String get changeEmailButton => 'Cambiar';

  @override
  String get verifyNewEmailTitle => 'Verificar Nuevo Correo';

  @override
  String verifyNewEmailDescription(String email) {
    return 'Para verificar su nuevo correo $email, ingrese el código de confirmación enviado a esta dirección';
  }

  @override
  String get verifyNewEmailButton => 'Verificar';

  @override
  String get passcodeVerificationTitle => 'Habilitar Código de Acceso';

  @override
  String passcodeVerificationDescription(String email) {
    return 'Para habilitar la protección con código de acceso, ingrese el código de verificación enviado a $email';
  }

  @override
  String get passcodeVerificationButton => 'Habilitar';

  @override
  String get setPasscodeTitle => 'Establecer Código de Acceso';

  @override
  String get setPasscodeDescription =>
      'Cree un código de acceso de 4 dígitos para protección adicional';

  @override
  String get passcodeHint => 'Ingrese 4 dígitos';

  @override
  String get setPasscodeButton => 'Establecer';

  @override
  String get xaneoBenefitsModalTitle => 'XaneoBenefits (XB)';

  @override
  String get xaneoBenefitsModalDescription => 'Suscripción Premium de Xaneo';

  @override
  String get xaneoBenefitsSelectPlan => 'Elija su plan de suscripción:';

  @override
  String get xaneoBenefitsYearlyPlan => 'Suscripción anual';

  @override
  String get xaneoBenefitsMonthlyPlan => 'Suscripción mensual';

  @override
  String get xaneoBenefitsYearlyPrice => '€999 al año';

  @override
  String get xaneoBenefitsMonthlyPrice => '€159 al mes';

  @override
  String get xaneoBenefitsSavings => '¡Ahorra 25%! Solo €83,25 al mes';

  @override
  String get xaneoBenefitsSubscribeButton => 'Suscribirse a XB';

  @override
  String get xaneoBenefitsCloseButton => 'Cerrar';

  @override
  String get xaneoBenefitsYearlySuccess => '¡Suscripción anual XB activada!';

  @override
  String get xaneoBenefitsMonthlySuccess => '¡Suscripción mensual XB activada!';

  @override
  String get favoritesChat => 'Favoritos';

  @override
  String get favoritesChatDescription => 'Mensajes y archivos importantes';

  @override
  String contentInDevelopmentMessage(String title) {
    return 'El contenido para \"$title\" está en desarrollo...';
  }

  @override
  String get russianLanguage => 'Ruso';

  @override
  String chatWelcomeMessage(String chatName) {
    return '¡Hola! Este es el chat \"$chatName\" 🎉';
  }

  @override
  String get formattingExample1 =>
      '¡Aquí puedes usar texto en **negrita** y *cursiva* y __subrayado__!';

  @override
  String get formattingExample2 => 'Y también ~~tachado~~ y `código` 💻';

  @override
  String get greetingTrigger => 'hola';

  @override
  String get greetingResponse => '¡Hola! ¿Cómo estás?';

  @override
  String get fileSendingNotImplemented =>
      'El envío de archivos aún no está implementado';

  @override
  String get wasOnlineRecently => 'estuvo en línea recientemente';

  @override
  String get messageHint => 'Mensaje';
}
