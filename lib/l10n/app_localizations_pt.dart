// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'XaneoMobile';

  @override
  String get welcomeTitle => 'Bem-vindo ao Xaneo';

  @override
  String get welcomeDescription =>
      'Xaneo - agora também em app móvel! Xaneo nunca foi tão conveniente e rápido.';

  @override
  String get getStartedButton => 'Já estou interessado';

  @override
  String get connectingToServer => 'Conectando ao servidor...';

  @override
  String version(String version) {
    return 'Versão: $version';
  }

  @override
  String httpError(int code) {
    return 'Erro: HTTP $code';
  }

  @override
  String connectionError(String error) {
    return 'Erro de conexão: $error';
  }

  @override
  String get updateAvailable => 'Atualização disponível!';

  @override
  String get updateDialogTitle => 'Atualização disponível!';

  @override
  String updateDialogMessage(String currentVersion, String latestVersion) {
    return 'Sua versão é $currentVersion, a nova é $latestVersion';
  }

  @override
  String get updateDialogDescription =>
      'Você pode atualizar através do Google Play, RuStore ou do site oficial do Xaneo.';

  @override
  String get updateButton => 'Atualizar';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get selectUpdateSource => 'Selecione a fonte de atualização:';

  @override
  String get settings => 'Configurações';

  @override
  String get about => 'Sobre';

  @override
  String get help => 'Ajuda';

  @override
  String get notifications => 'Notificações';

  @override
  String get notificationsDescription =>
      'Receber notificações sobre novos recursos';

  @override
  String get darkTheme => 'Tema escuro';

  @override
  String get darkThemeDescription => 'Usar aparência escura';

  @override
  String fontSize(int size) {
    return 'Tamanho da fonte: $size';
  }

  @override
  String get appVersion => 'Versão do app';

  @override
  String get messengerDemoMode => 'Modo demo do messenger';

  @override
  String get language => 'Idioma';

  @override
  String get languageDescription => 'Escolha o idioma da interface';

  @override
  String get welcomeMessage => 'Ótimo! Bem-vindo!';

  @override
  String get privacyTitle => 'Todos os seus dados estão seguros';

  @override
  String get privacyDescription =>
      'Todas as mensagens no XaneoConnect são protegidas por criptografia de ponta a ponta. Xaneo nunca conhece seu conteúdo.';

  @override
  String get continueButton => 'Vamos continuar';

  @override
  String get dataStorageTitle =>
      'Todos os data centers da Xaneo estão localizados na Rússia';

  @override
  String get dataStorageDescription =>
      'Seus dados nunca deixam o país e são armazenados em data centers seguros.';

  @override
  String get finishButton => 'Finalizar';

  @override
  String get setupCompleted => 'Configuração concluída!';

  @override
  String get loginFormTitle => 'Vamos fazer login';

  @override
  String get registerFormTitle => 'Vamos começar';

  @override
  String get registerNameSubtitle => 'Qual é o seu nome?';

  @override
  String get nameFieldHint => 'Seu nome';

  @override
  String get nextButton => 'Próximo';

  @override
  String get skipButton => 'Pular';

  @override
  String get registerBirthdateSubtitle => 'Quando você nasceu?';

  @override
  String get selectDate => 'Selecionar data';

  @override
  String get ageRestrictionsLink => 'Quais são as restrições de idade?';

  @override
  String get ageRestrictionsTitle => 'Registro a partir de 14 anos';

  @override
  String get ageRestrictionsDescription =>
      'Você pode se registrar em nosso serviço se tiver 14 anos ou mais';

  @override
  String get gotIt => 'Entendi';

  @override
  String get registerNicknameSubtitle => 'Escolha um nickname';

  @override
  String get nicknameFieldHint => 'Seu nickname';

  @override
  String get nicknameHelpLink => 'Não consegue pensar em um nickname?';

  @override
  String get registerEmailSubtitle => 'Digite seu email';

  @override
  String get emailFieldHint => 'Seu email';

  @override
  String get supportedEmailProvidersLink =>
      'Quais provedores de email são suportados?';

  @override
  String get supportedEmailProvidersTitle => 'Provedores de Email Suportados';

  @override
  String get supportedEmailProvidersDescription =>
      'Gmail, Outlook, Yandex, Mail.ru e outros serviços de email populares são suportados.';

  @override
  String get emailFormatError => 'Formato de endereço de email inválido';

  @override
  String get emailUnsupportedError => 'Este serviço de email não é suportado';

  @override
  String get checkingEmail => 'Verificando email...';

  @override
  String get emailAvailable => 'Email disponível';

  @override
  String get emailTakenError => 'Este email já está em uso';

  @override
  String get emailServerError =>
      'Erro na verificação de email. Tente novamente mais tarde';

  @override
  String get verifyEmailTitle => 'Verifique seu email';

  @override
  String get verifyEmailDescription =>
      'Enviamos um código de 6 dígitos para seu email. Digite-o para confirmar.';

  @override
  String get verificationCodeHint => 'Código de verificação';

  @override
  String get verifyButton => 'Verificar';

  @override
  String get registerPasswordSubtitle => 'Crie uma senha';

  @override
  String get registerPasswordFieldHint => 'Digite a senha';

  @override
  String get passwordInvalidCharsError =>
      'A senha pode conter apenas letras latinas, números e sinais de pontuação';

  @override
  String get passwordWeakError =>
      'Senha muito fraca. Use letras, números e caracteres especiais';

  @override
  String get passwordMediumWarning =>
      'Senha de força média. Recomenda-se fortalecê-la';

  @override
  String get passwordStrongSuccess => 'Senha forte';

  @override
  String get nicknameGeneratorTitle =>
      'Seu nickname será gerado automaticamente';

  @override
  String get nicknameGeneratorDescription =>
      'Você pode alterar seu nickname a qualquer momento';

  @override
  String get closeButton => 'Fechar';

  @override
  String get loginFieldHint => 'Login';

  @override
  String get passwordFieldHint => 'Senha';

  @override
  String get loginButton => 'Entrar';

  @override
  String get fillAllFields => 'Preencha todos os campos';

  @override
  String get loggingIn => 'Fazendo login...';

  @override
  String welcomeUser(String username) {
    return 'Bem-vindo, $username!';
  }

  @override
  String get invalidCredentials =>
      'Credenciais inválidas. Verifique seu nome de usuário e senha.';

  @override
  String get serverError => 'Erro do servidor. Tente novamente mais tarde.';

  @override
  String get connectionErrorLogin =>
      'Erro de conexão. Verifique sua conexão com a internet.';

  @override
  String get noAccount => 'Não tem uma conta?';

  @override
  String get forgotPassword => 'Esqueceu a senha?';

  @override
  String get forgotPasswordDescription =>
      'Digite seu nickname e enviaremos um link para acessar sua conta por email.';

  @override
  String get sendLinkButton => 'Enviar Link';

  @override
  String get checkEmailTitle => 'Verifique seu Email';

  @override
  String checkEmailDescription(String email) {
    return 'Verifique sua caixa de entrada $email e siga o link para acessar sua conta.';
  }

  @override
  String get forgotPasswordCodeDescription =>
      'Digite o código de acesso enviado para o email associado à sua conta';

  @override
  String get alreadyHaveAccount => 'Já tem uma conta?';

  @override
  String get registrationUnavailable =>
      'O registro não está disponível no momento';

  @override
  String get passwordRecoveryUnavailable =>
      'A recuperação de senha não está disponível no momento';

  @override
  String get nicknameMinLengthError =>
      'O nickname deve ter pelo menos cinco caracteres';

  @override
  String get nicknameLatinOnlyError =>
      'O nickname pode conter apenas letras latinas, números, pontos e sublinhados';

  @override
  String get nicknameStartError =>
      'O nickname não pode começar com sublinhado, número ou ponto';

  @override
  String get nicknameEndError =>
      'O nickname não pode terminar com sublinhado ou ponto';

  @override
  String get checkingNickname => 'Verificando nickname...';

  @override
  String get nicknameAvailable => 'Nickname disponível';

  @override
  String get nicknameTakenError => 'Este nickname já está em uso';

  @override
  String get nicknameServerError => 'Erro do servidor ao verificar nickname';

  @override
  String get nicknameMaxLengthError =>
      'O nickname pode ter no máximo 30 caracteres';

  @override
  String get nameEmptyError => 'O nome não pode estar vazio';

  @override
  String get confirmPasswordTitle => 'Confirmar senha';

  @override
  String get confirmPasswordDescription =>
      'Digite sua senha novamente para continuar';

  @override
  String get confirmPasswordFieldHint => 'Digite a senha novamente';

  @override
  String get passwordMismatchError => 'As senhas não coincidem';

  @override
  String get confirmButton => 'Confirmar';

  @override
  String get registerAvatarSubtitle => 'Adicione uma foto de perfil';

  @override
  String get addAvatarHint => 'Toque para selecionar uma imagem';

  @override
  String get avatarTapToSelect => 'Toque para selecionar';

  @override
  String get photoPermissionTitle => 'Acesso às fotos';

  @override
  String get photoPermissionDescription =>
      'Precisamos de acesso às suas fotos para selecionar uma foto de perfil';

  @override
  String get allowAccessButton => 'Permitir acesso';

  @override
  String get notNowButton => 'Agora não';

  @override
  String get avatarCropperTitle => 'Cortar imagem';

  @override
  String get doneButton => 'Concluído';

  @override
  String get cropInstructions => 'Arraste para ajustar a área da imagem';

  @override
  String get changeAvatar => 'Alterar avatar';

  @override
  String get profilePreviewTitle => 'Pré-visualização do perfil';

  @override
  String get goodMorning => 'Bom dia';

  @override
  String get goodDay => 'Bom dia';

  @override
  String get goodEvening => 'Boa noite';

  @override
  String get goodNight => 'Boa noite';

  @override
  String get backButton => 'Voltar';

  @override
  String get editName => 'Editar nome';

  @override
  String get editNickname => 'Editar nickname';

  @override
  String get editPhoto => 'Editar foto';

  @override
  String get saveButton => 'Salvar';

  @override
  String get deleteButton => 'Excluir';

  @override
  String get deletePhoto => 'Excluir foto';

  @override
  String get selectFromGallery => 'Selecionar da galeria';

  @override
  String get enterNameHint => 'Digite o nome';

  @override
  String get enterNicknameHint => 'Digite o nickname';

  @override
  String get termsAndConditionsTitle => 'Termos e condições';

  @override
  String get termsOfUse => 'Termos de uso';

  @override
  String get userAgreement => 'Acordo do usuário';

  @override
  String acceptTermsText(String termsOfUse, String userAgreement) {
    return 'Eu aceito os termos e condições';
  }

  @override
  String get acceptButton => 'Aceitar';

  @override
  String get declineButton => 'Recusar';

  @override
  String verificationCodeSent(String email, int seconds) {
    return 'Código de verificação enviado';
  }

  @override
  String get codeDeliveryError => 'Erro ao enviar código';

  @override
  String get serverErrorCodeDelivery => 'Erro do servidor ao enviar código';

  @override
  String get connectionErrorCodeDelivery => 'Erro de conexão ao enviar código';

  @override
  String get emailVerificationSuccess => 'Email verificado com sucesso';

  @override
  String get invalidVerificationCode => 'Código de verificação inválido';

  @override
  String get emailNotFound => 'Endereço de email não encontrado';

  @override
  String get verificationCodeExpired => 'Código de verificação expirado';

  @override
  String get serverErrorCodeVerification =>
      'Erro do servidor na verificação do código';

  @override
  String get connectionErrorCodeVerification =>
      'Erro de conexão na verificação do código';

  @override
  String get permissionDeniedSettings =>
      'Permissão negada. Vá para configurações.';

  @override
  String get avatarCropped => 'Avatar cortado';

  @override
  String get imageSelectionError => 'Erro na seleção da imagem';

  @override
  String get permissionDeniedOpenSettings =>
      'Permissão negada. Abrir configurações?';

  @override
  String get photoPermissionError => 'Erro permissão foto';

  @override
  String get registrationCompleted => 'Registro concluído';

  @override
  String get officialXaneoWebsite => 'Site oficial Xaneo';

  @override
  String twoFactorAuthMessage(String email) {
    return 'Autenticação de dois fatores habilitada';
  }

  @override
  String get selectLanguage => 'Selecionar idioma';

  @override
  String get messengerDemo => 'Demo Messenger';

  @override
  String get messenger => 'Messenger';

  @override
  String get messengerDescription => 'Mensagens seguras e rápidas';

  @override
  String get profileDemo => 'Demo Perfil';

  @override
  String get profile => 'Perfil';

  @override
  String get personalInfo => 'Informações pessoais';

  @override
  String get name => 'Nome';

  @override
  String get nameHint => 'Digite seu nome';

  @override
  String get birthDate => 'Data de nascimento';

  @override
  String get nickname => 'Nickname';

  @override
  String get nicknameHint => 'Digite seu nickname';

  @override
  String get phone => 'Telefone';

  @override
  String get phoneHint => 'Digite seu número de telefone';

  @override
  String get settingsSection => 'Configurações';

  @override
  String get chatSettings => 'Configurações do chat';

  @override
  String get chatSettingsDescription => 'Personalize sua experiência de chat';

  @override
  String get privacySettings => 'Configurações de privacidade';

  @override
  String get privacySettingsDescription => 'Controle sua privacidade';

  @override
  String get securitySettings => 'Configurações de segurança';

  @override
  String get securityAuthentication => 'Autenticação';

  @override
  String get securityChangePassword => 'Alterar senha';

  @override
  String get securityTwoFactorAuth => 'Autenticação de dois fatores';

  @override
  String get twoFactorEnabled => 'Autenticação de dois fatores habilitada';

  @override
  String get twoFactorDisabled => 'Autenticação de dois fatores desabilitada';

  @override
  String get securityChangeEmail => 'Alterar email';

  @override
  String get securityPasscode => 'Código de acesso';

  @override
  String get securitySettingsDescription => 'Proteja sua conta';

  @override
  String get passwordEmptyError => 'A senha não pode estar vazia';

  @override
  String get passwordTooShortError =>
      'A senha deve ter pelo menos 8 caracteres';

  @override
  String get passwordEnterCurrentHint => 'Digite a senha atual';

  @override
  String get passwordCurrentHint => 'Senha atual';

  @override
  String get passwordConfirmNewHint => 'Confirmar nova senha';

  @override
  String get passwordDontMatchError => 'As senhas não coincidem';

  @override
  String get passwordNewTitle => 'Nova senha';

  @override
  String get passwordNewHint => 'Digite a nova senha';

  @override
  String get passwordConfirmHint => 'Confirmar senha';

  @override
  String get passwordChangedSuccess => 'Senha alterada com sucesso';

  @override
  String get passwordNextButton => 'Próximo';

  @override
  String get passwordSaveButton => 'Salvar';

  @override
  String get powerSettings => 'Configurações avançadas';

  @override
  String get powerSettingsDescription => 'Configurações avançadas';

  @override
  String get languageSelect => 'Selecionar idioma';

  @override
  String get cancel => 'Cancelar';

  @override
  String get ready => 'Pronto';

  @override
  String contentInDevelopment(String title) {
    return 'Conteúdo em desenvolvimento';
  }

  @override
  String get sessions => 'Sessões';

  @override
  String get support => 'Suporte';

  @override
  String get xaneoBenefits => 'Benefícios Xaneo';

  @override
  String get messengerFeatures => 'Recursos do Messenger';

  @override
  String get secureEncryption => 'Criptografia segura';

  @override
  String get instantDelivery => 'Entrega instantânea';

  @override
  String get deviceSync => 'Sincronização de dispositivos';

  @override
  String get mediaSupport => 'Suporte a mídia';

  @override
  String get sessionsContent => 'Gerencie suas sessões ativas';

  @override
  String get activeDevices => 'Dispositivos ativos';

  @override
  String get currentDevice => 'Dispositivo atual';

  @override
  String get terminateSession => 'Encerrar sessão';

  @override
  String get terminateAllOtherSessions => 'Encerrar todas as outras sessões';

  @override
  String get sessionLocation => 'Localização';

  @override
  String get sessionLastActive => 'Última atividade';

  @override
  String get sessionBrowser => 'Navegador';

  @override
  String get sessionPlatform => 'Plataforma';

  @override
  String get confirmTerminateSession =>
      'Tem certeza de que deseja encerrar esta sessão?';

  @override
  String get confirmTerminateAllSessions =>
      'Tem certeza de que deseja encerrar todas as outras sessões?';

  @override
  String get sessionIPAddress => 'Endereço IP';

  @override
  String get supportContent => 'Entre em contato com nossa equipe de suporte';

  @override
  String get contactSupport => 'Contatar suporte';

  @override
  String get xaneoBenefitsContent => 'Descubra os benefícios do Xaneo';

  @override
  String get more => 'Mais';

  @override
  String get chatPreview => 'Pré-visualização do chat';

  @override
  String get textSize => 'Tamanho do texto';

  @override
  String textSizeValue(String size) {
    return '$size%';
  }

  @override
  String get textExample => 'Texto de exemplo';

  @override
  String get useDarkTheme => 'Usar tema escuro';

  @override
  String get chatWallpapers => 'Papéis de parede do chat';

  @override
  String get messageColors => 'Cores das mensagens';

  @override
  String get myMessages => 'Minhas mensagens';

  @override
  String get receivedMessages => 'Mensagens recebidas';

  @override
  String get messageEmojis => 'Emojis das mensagens';

  @override
  String get selectedEmoji => 'Emoji selecionado';

  @override
  String get chooseWallpaper => 'Escolher papel de parede';

  @override
  String get demoMessage1 => 'Oi! Como você está?';

  @override
  String get demoMessage2 => 'Estou bem, obrigado! E você?';

  @override
  String get demoMessage3 => 'Eu também! Que bom te ver.';

  @override
  String get demoDateSeparator => 'Hoje';

  @override
  String get onlineStatus => 'Online';

  @override
  String get chatTheme => 'Tema do chat';

  @override
  String get privacySettingsTitle => 'Configurações de privacidade';

  @override
  String get privacyCommunications => 'Comunicações';

  @override
  String get privacyProfileVisibility => 'Visibilidade do perfil';

  @override
  String get privacyWhoCanMessage => 'Quem pode me enviar mensagens';

  @override
  String get privacyWhoCanRecordVoice => 'Quem pode gravar mensagens de voz';

  @override
  String get privacyWhoCanCall => 'Quem pode me ligar';

  @override
  String get privacyWhoCanSendVideo => 'Quem pode me enviar vídeos';

  @override
  String get privacyWhoCanSendLinks => 'Quem pode me enviar links';

  @override
  String get privacyWhoCanInvite => 'Quem pode me convidar';

  @override
  String get privacyWhoSeesNickname => 'Quem vê meu nickname';

  @override
  String get privacyWhoSeesAvatar => 'Quem vê meu avatar';

  @override
  String get privacyWhoSeesBirthday => 'Quem vê minha data de nascimento';

  @override
  String get privacyWhoSeesOnlineTime => 'Quem vê meu horário online';

  @override
  String get privacyAll => 'Todos';

  @override
  String get privacyContacts => 'Contatos';

  @override
  String get privacyNobody => 'Ninguém';

  @override
  String get passwordWeak => 'Fraca';

  @override
  String get passwordMedium => 'Média';

  @override
  String get passwordStrong => 'Forte';

  @override
  String twoFactorEnableDescription(String email) {
    return 'Adicione autenticação de dois fatores para maior segurança';
  }

  @override
  String twoFactorDisableDescription(String email) {
    return 'Desabilitar autenticação de dois fatores';
  }

  @override
  String get changeEmailVerificationDescription =>
      'Você receberá um código de verificação em seu novo email';

  @override
  String get newEmailTitle => 'Novo endereço de email';

  @override
  String get newEmailDescription => 'Digite seu novo endereço de email';

  @override
  String get changeEmailButton => 'Alterar email';

  @override
  String get verifyNewEmailTitle => 'Verificar novo email';

  @override
  String verifyNewEmailDescription(String email) {
    return 'Digite o código de verificação enviado para seu novo email';
  }

  @override
  String get verifyNewEmailButton => 'Verificar email';

  @override
  String get passcodeVerificationTitle => 'Verificação de código de acesso';

  @override
  String passcodeVerificationDescription(String email) {
    return 'Digite seu código de acesso para continuar';
  }

  @override
  String get passcodeVerificationButton => 'Verificar código de acesso';

  @override
  String get setPasscodeTitle => 'Definir código de acesso';

  @override
  String get setPasscodeDescription =>
      'Crie um código de acesso de 4 dígitos para maior segurança';

  @override
  String get passcodeHint => 'Digite o código de acesso';

  @override
  String get setPasscodeButton => 'Definir código de acesso';

  @override
  String get xaneoBenefitsModalTitle => 'Benefícios Premium Xaneo';

  @override
  String get xaneoBenefitsModalDescription =>
      'Desbloqueie recursos premium e apoie o desenvolvimento';

  @override
  String get xaneoBenefitsSelectPlan => 'Selecione seu plano';

  @override
  String get xaneoBenefitsYearlyPlan => 'Plano anual';

  @override
  String get xaneoBenefitsMonthlyPlan => 'Plano mensal';

  @override
  String get xaneoBenefitsYearlyPrice => '49,99 € / ano';

  @override
  String get xaneoBenefitsMonthlyPrice => '4,99 € / mês';

  @override
  String get xaneoBenefitsSavings => 'Economize 17%';

  @override
  String get xaneoBenefitsSubscribeButton => 'Assinar';

  @override
  String get xaneoBenefitsCloseButton => 'Fechar';

  @override
  String get xaneoBenefitsYearlySuccess =>
      'Assinatura anual XB concluída com sucesso!';

  @override
  String get xaneoBenefitsMonthlySuccess =>
      'Assinatura mensal XB concluída com sucesso!';

  @override
  String get favoritesChat => 'Favoritos';

  @override
  String get favoritesChatDescription => 'Mensagens e arquivos importantes';

  @override
  String contentInDevelopmentMessage(String title) {
    return 'Conteúdo para \"$title\" em desenvolvimento...';
  }

  @override
  String get russianLanguage => 'Russo';

  @override
  String chatWelcomeMessage(String chatName) {
    return 'Olá! Este é o chat \"$chatName\" 🎉';
  }

  @override
  String get formattingExample1 =>
      'Aqui você pode usar **negrito**, *itálico* e __sublinhado__!';

  @override
  String get formattingExample2 => 'Bem como ~~riscado~~ e `código` 💻';

  @override
  String get greetingTrigger => 'olá';

  @override
  String get greetingResponse => 'Olá! Como vai?';

  @override
  String get fileSendingNotImplemented =>
      'Envio de arquivos ainda não implementado';

  @override
  String get wasOnlineRecently => 'esteve online recentemente';

  @override
  String get messageHint => 'Mensagem';
}
