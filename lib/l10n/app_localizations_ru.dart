// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'XaneoMobile';

  @override
  String get welcomeTitle => 'Добро пожаловать в Xaneo';

  @override
  String get welcomeDescription =>
      'Xaneo - теперь и в мобильном приложении! Xaneo ещё никогда не был таким удобным и быстрым.';

  @override
  String get getStartedButton => 'Мне уже интересно';

  @override
  String get connectingToServer => 'Подключаемся к серверу...';

  @override
  String version(String version) {
    return 'Версия: $version';
  }

  @override
  String httpError(int code) {
    return 'Ошибка: HTTP $code';
  }

  @override
  String connectionError(String error) {
    return 'Ошибка подключения: $error';
  }

  @override
  String get updateAvailable => 'Доступно обновление!';

  @override
  String get updateDialogTitle => 'Доступно обновление!';

  @override
  String updateDialogMessage(String currentVersion, String latestVersion) {
    return 'Ваша версия - $currentVersion, а новая - $latestVersion';
  }

  @override
  String get updateDialogDescription =>
      'Вы можете обновиться через Google Play, RuStore или с официального сайта Xaneo.';

  @override
  String get updateButton => 'Обновить';

  @override
  String get cancelButton => 'Отмена';

  @override
  String get selectUpdateSource => 'Выберите источник для обновления:';

  @override
  String get settings => 'Настройки';

  @override
  String get about => 'О приложении';

  @override
  String get help => 'Помощь';

  @override
  String get notifications => 'Уведомления';

  @override
  String get notificationsDescription =>
      'Получать уведомления о новых возможностях';

  @override
  String get darkTheme => 'Тёмная тема';

  @override
  String get darkThemeDescription => 'Использовать тёмное оформление';

  @override
  String fontSize(int size) {
    return 'Размер шрифта: $size';
  }

  @override
  String get appVersion => 'Версия приложения';

  @override
  String get messengerDemoMode => 'Демо-режим мессенджера';

  @override
  String get language => 'Язык';

  @override
  String get languageDescription => 'Выберите язык интерфейса';

  @override
  String get welcomeMessage => 'Отлично! Добро пожаловать!';

  @override
  String get privacyTitle => 'Все ваши данные в безопасности';

  @override
  String get privacyDescription =>
      'Все сообщения в XaneoConnect защищены сквозным шифрованием. Ни в один момент Xaneo не знает об их содержимом.';

  @override
  String get continueButton => 'Давайте продолжать';

  @override
  String get dataStorageTitle => 'Все дата-центры Xaneo находятся в России';

  @override
  String get dataStorageDescription =>
      'Ваши данные не покидают территорию страны и хранятся в безопасных дата-центрах.';

  @override
  String get finishButton => 'Завершить';

  @override
  String get setupCompleted => 'Настройка завершена!';

  @override
  String get loginFormTitle => 'Давайте войдем';

  @override
  String get registerFormTitle => 'Давайте начнём';

  @override
  String get registerNameSubtitle => 'Как вас зовут?';

  @override
  String get nameFieldHint => 'Ваше имя';

  @override
  String get nextButton => 'Далее';

  @override
  String get skipButton => 'Пропустить';

  @override
  String get registerBirthdateSubtitle => 'Когда вы родились?';

  @override
  String get selectDate => 'Выберите дату';

  @override
  String get ageRestrictionsLink => 'Какие есть ограничения по возрасту?';

  @override
  String get ageRestrictionsTitle => 'Можно регистрироваться\nс 14 лет';

  @override
  String get ageRestrictionsDescription =>
      'На нашем сервисе\nможно регистрироваться лицам,\nдостигшим 14 лет';

  @override
  String get gotIt => 'Понятно';

  @override
  String get registerNicknameSubtitle => 'Придумайте никнейм';

  @override
  String get nicknameFieldHint => 'Ваш никнейм';

  @override
  String get nicknameHelpLink => 'Не можете придумать никнейм?';

  @override
  String get registerEmailSubtitle => 'Введите e-mail';

  @override
  String get emailFieldHint => 'Ваш email';

  @override
  String get supportedEmailProvidersLink =>
      'Какие почтовые операторы поддерживаются?';

  @override
  String get supportedEmailProvidersTitle =>
      'Поддерживаемые почтовые операторы';

  @override
  String get supportedEmailProvidersDescription =>
      'Поддерживаются Gmail, Outlook, Яндекс, Mail.ru и другие популярные почтовые сервисы.';

  @override
  String get emailFormatError => 'Неверный формат email адреса';

  @override
  String get emailUnsupportedError =>
      'Данный почтовый сервис не поддерживается';

  @override
  String get checkingEmail => 'Проверяем email...';

  @override
  String get emailAvailable => 'Email доступен';

  @override
  String get emailTakenError => 'Этот email уже занят';

  @override
  String get emailServerError => 'Ошибка проверки email. Попробуйте позже';

  @override
  String get verifyEmailTitle => 'Подтвердите свою почту';

  @override
  String get verifyEmailDescription =>
      'Мы отправили 6-значный код на ваш email. Введите его для подтверждения.';

  @override
  String get verificationCodeHint => 'Код подтверждения';

  @override
  String get verifyButton => 'Проверить';

  @override
  String get registerPasswordSubtitle => 'Придумайте пароль';

  @override
  String get registerPasswordFieldHint => 'Введите пароль';

  @override
  String get passwordInvalidCharsError =>
      'Пароль может содержать только латинские буквы, цифры и знаки препинания';

  @override
  String get passwordWeakError =>
      'Пароль слишком слабый. Используйте буквы, цифры и спецсимволы';

  @override
  String get passwordMediumWarning =>
      'Пароль средней силы. Рекомендуем усилить';

  @override
  String get passwordStrongSuccess => 'Сильный пароль';

  @override
  String get nicknameGeneratorTitle =>
      'Ваш никнейм будет сгенерирован автоматически';

  @override
  String get nicknameGeneratorDescription =>
      'Вы сможете в любое время сменить никнейм';

  @override
  String get closeButton => 'Закрыть';

  @override
  String get loginFieldHint => 'Логин';

  @override
  String get passwordFieldHint => 'Пароль';

  @override
  String get loginButton => 'Войти';

  @override
  String get fillAllFields => 'Заполните все поля';

  @override
  String get loggingIn => 'Выполняется вход...';

  @override
  String welcomeUser(String username) {
    return 'Добро пожаловать, $username!';
  }

  @override
  String get invalidCredentials =>
      'Неверные учётные данные. Проверьте имя пользователя и пароль.';

  @override
  String get serverError => 'Ошибка сервера. Попробуйте позже.';

  @override
  String get connectionErrorLogin =>
      'Ошибка подключения. Проверьте интернет-соединение.';

  @override
  String get noAccount => 'Нет аккаунта?';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get forgotPasswordDescription =>
      'Введите ваш никнейм, и мы отправим вам ссылку для входа в аккаунт на почту.';

  @override
  String get sendLinkButton => 'Отправить ссылку';

  @override
  String get checkEmailTitle => 'Проверьте свою почту';

  @override
  String checkEmailDescription(String email) {
    return 'Пожалуйста, проверьте свой ящик $email и перейдите по ссылке для входа в аккаунт.';
  }

  @override
  String get forgotPasswordCodeDescription =>
      'Введите код доступа, который был отправлен на email, привязанный к вашему аккаунту';

  @override
  String get alreadyHaveAccount => 'Уже есть аккаунт?';

  @override
  String get registrationUnavailable => 'Регистрация пока недоступна';

  @override
  String get passwordRecoveryUnavailable =>
      'Восстановление пароля пока недоступно';

  @override
  String get nicknameMinLengthError =>
      'Длина никнейма должна составлять не менее пяти символов';

  @override
  String get nicknameLatinOnlyError =>
      'Никнейм может содержать только латинские буквы, цифры, точки и нижнее подчёркивание';

  @override
  String get nicknameStartError =>
      'Никнейм не может начинаться с нижнего подчёркивания, цифры или точки';

  @override
  String get nicknameEndError =>
      'Никнейм не может заканчиваться нижним подчёркиванием или точкой';

  @override
  String get checkingNickname => 'Проверяем никнейм...';

  @override
  String get nicknameAvailable => 'Никнейм свободен';

  @override
  String get nicknameTakenError => 'Этот никнейм уже занят';

  @override
  String get nicknameServerError =>
      'Ошибка проверки никнейма. Попробуйте позже';

  @override
  String get nicknameMaxLengthError => 'Максимум 30 символов';

  @override
  String get nameEmptyError => 'Имя не может быть пустым';

  @override
  String get confirmPasswordTitle => 'Подтвердите пароль';

  @override
  String get confirmPasswordDescription =>
      'Введите пароль еще раз для подтверждения';

  @override
  String get confirmPasswordFieldHint => 'Повторите пароль';

  @override
  String get passwordMismatchError => 'Пароли не совпадают';

  @override
  String get confirmButton => 'Подтвердить';

  @override
  String get registerAvatarSubtitle => 'Выберите аватарку';

  @override
  String get addAvatarHint => 'Нажмите + чтобы добавить фото';

  @override
  String get avatarTapToSelect => 'Нажмите, чтобы выбрать фото';

  @override
  String get photoPermissionTitle => 'Разрешите доступ к изображениям';

  @override
  String get photoPermissionDescription =>
      'Разрешите нам доступ к вашим изображениям, чтобы вы могли выбрать аватар для вашего профиля';

  @override
  String get allowAccessButton => 'Разрешить доступ';

  @override
  String get notNowButton => 'Не сейчас';

  @override
  String get avatarCropperTitle => 'Настройка аватара';

  @override
  String get doneButton => 'Готово';

  @override
  String get cropInstructions =>
      'Перетащите круг для выбора области • Используйте точки для изменения размера';

  @override
  String get changeAvatar => 'Изменить аватар';

  @override
  String get profilePreviewTitle => 'Так будет выглядеть ваш профиль';

  @override
  String get goodMorning => 'Доброе утро';

  @override
  String get goodDay => 'Добрый день';

  @override
  String get goodEvening => 'Добрый вечер';

  @override
  String get goodNight => 'Доброй ночи';

  @override
  String get backButton => 'Назад';

  @override
  String get editName => 'Изменить имя';

  @override
  String get editNickname => 'Изменить никнейм';

  @override
  String get editPhoto => 'Изменить фото';

  @override
  String get saveButton => 'Сохранить';

  @override
  String get deleteButton => 'Удалить';

  @override
  String get deletePhoto => 'Удалить фото';

  @override
  String get selectFromGallery => 'Выбрать из галереи';

  @override
  String get enterNameHint => 'Введите ваше имя';

  @override
  String get enterNicknameHint => 'Введите никнейм';

  @override
  String get termsAndConditionsTitle => 'Условия использования';

  @override
  String get termsOfUse => 'Условия использования';

  @override
  String get userAgreement => 'Пользовательское соглашение';

  @override
  String acceptTermsText(String termsOfUse, String userAgreement) {
    return 'Для завершения регистрации и начала использования Xaneo необходимо принять $termsOfUse и $userAgreement.\n\nЭти документы содержат важную информацию о правилах использования сервиса, защите ваших данных и обязательствах сторон.\n\nПринимая условия, вы подтверждаете, что ознакомились с правилами платформы и согласны их соблюдать.\n\nБез принятия этих условий регистрация не может быть завершена, и доступ к сервису будет ограничен.';
  }

  @override
  String get acceptButton => 'Принять';

  @override
  String get declineButton => 'Отклонить';

  @override
  String verificationCodeSent(String email, int seconds) {
    return 'Код отправлен на $email. Действителен $seconds секунд';
  }

  @override
  String get codeDeliveryError => 'Ошибка отправки кода';

  @override
  String get serverErrorCodeDelivery => 'Ошибка сервера при отправке кода';

  @override
  String get connectionErrorCodeDelivery =>
      'Ошибка подключения при отправке кода';

  @override
  String get emailVerificationSuccess => 'Email успешно подтвержден!';

  @override
  String get invalidVerificationCode =>
      'Неверный код подтверждения. Проверьте код и попробуйте снова';

  @override
  String get emailNotFound =>
      'Email не найден. Попробуйте зарегистрироваться заново';

  @override
  String get verificationCodeExpired =>
      'Код подтверждения истек. Запросите новый код';

  @override
  String get serverErrorCodeVerification =>
      'Ошибка сервера при проверке кода. Попробуйте позже';

  @override
  String get connectionErrorCodeVerification =>
      'Ошибка подключения при проверке кода';

  @override
  String get permissionDeniedSettings =>
      'Разрешение навсегда отклонено. Включите его в настройках';

  @override
  String get avatarCropped => 'Аватар обрезан и сохранен!';

  @override
  String get imageSelectionError => 'Ошибка при выборе изображения';

  @override
  String get permissionDeniedOpenSettings =>
      'Разрешение навсегда отклонено. Откройте настройки для включения';

  @override
  String get photoPermissionError =>
      'Не удалось получить разрешение на доступ к изображениям';

  @override
  String get registrationCompleted => 'Регистрация завершена!';

  @override
  String get officialXaneoWebsite => 'Официальный сайт Xaneo';

  @override
  String twoFactorAuthMessage(String email) {
    return 'На этом аккаунте включена двухфакторная аутентификация. Введите код подтверждения, который был отправлен на $email';
  }

  @override
  String get selectLanguage => 'Выберите язык';

  @override
  String get messengerDemo => 'Демо-мессенджер';

  @override
  String get messenger => 'Мессенджер';

  @override
  String get messengerDescription =>
      'Простой, быстрый и безопасный мессенджер с современным дизайном и удобным интерфейсом.';

  @override
  String get profileDemo => 'Демо-профиль';

  @override
  String get profile => 'Профиль';

  @override
  String get personalInfo => 'Личная информация';

  @override
  String get name => 'Имя';

  @override
  String get nameHint => 'Имя';

  @override
  String get birthDate => 'Дата рождения';

  @override
  String get nickname => 'Никнейм';

  @override
  String get nicknameHint => 'Никнейм';

  @override
  String get phone => 'Телефон';

  @override
  String get phoneHint => 'Номер телефона';

  @override
  String get settingsSection => 'Настройки';

  @override
  String get chatSettings => 'Настройки чатов';

  @override
  String get chatSettingsDescription => 'Здесь будут настройки чатов...';

  @override
  String get privacySettings => 'Конфиденциальность и приватность';

  @override
  String get privacySettingsDescription =>
      'Здесь будут настройки приватности...';

  @override
  String get securitySettings => 'Безопасность';

  @override
  String get securityAuthentication => 'Аутентификация';

  @override
  String get securityChangePassword => 'Сменить пароль';

  @override
  String get securityTwoFactorAuth => 'Двухфакторная аутентификация';

  @override
  String get twoFactorEnabled => 'Включена';

  @override
  String get twoFactorDisabled => 'Отключена';

  @override
  String get securityChangeEmail => 'Сменить почту';

  @override
  String get securityPasscode => 'Код-пароль';

  @override
  String get securitySettingsDescription =>
      'Здесь будут настройки безопасности...';

  @override
  String get passwordEmptyError => 'Пароль не может быть пустым';

  @override
  String get passwordTooShortError =>
      'Пароль должен содержать минимум 5 символов';

  @override
  String get passwordEnterCurrentHint =>
      'Введите текущий пароль для подтверждения';

  @override
  String get passwordCurrentHint => 'Текущий пароль';

  @override
  String get passwordConfirmNewHint => 'Подтвердите новый пароль';

  @override
  String get passwordDontMatchError => 'Пароли не совпадают';

  @override
  String get passwordNewTitle => 'Новый пароль';

  @override
  String get passwordNewHint => 'Новый пароль';

  @override
  String get passwordConfirmHint => 'Подтвердите пароль';

  @override
  String get passwordChangedSuccess => 'Пароль успешно изменен';

  @override
  String get passwordNextButton => 'Далее';

  @override
  String get passwordSaveButton => 'Сохранить';

  @override
  String get powerSettings => 'Энергосбережение';

  @override
  String get powerSettingsDescription =>
      'Здесь будут настройки энергосбережения...';

  @override
  String get languageSelect => 'Язык';

  @override
  String get cancel => 'Отмена';

  @override
  String get ready => 'Готово';

  @override
  String contentInDevelopment(String title) {
    return 'Контент для \"$title\" находится в разработке...';
  }

  @override
  String get sessions => 'Сессии';

  @override
  String get support => 'Служба поддержки';

  @override
  String get xaneoBenefits => 'XaneoBenefits';

  @override
  String get messengerFeatures => 'Функционал демо-режима:';

  @override
  String get secureEncryption => 'Безопасное шифрование сообщений';

  @override
  String get instantDelivery => 'Мгновенная доставка';

  @override
  String get deviceSync => 'Синхронизация между устройствами';

  @override
  String get mediaSupport => 'Поддержка медиафайлов';

  @override
  String get sessionsContent =>
      'Здесь будут отображаться активные сессии вашего аккаунта...';

  @override
  String get activeDevices => 'Активные устройства';

  @override
  String get currentDevice => 'Текущее устройство';

  @override
  String get terminateSession => 'Завершить сессию';

  @override
  String get terminateAllOtherSessions => 'Завершить все остальные сессии';

  @override
  String get sessionLocation => 'Местоположение';

  @override
  String get sessionLastActive => 'Последняя активность';

  @override
  String get sessionBrowser => 'Браузер';

  @override
  String get sessionPlatform => 'Платформа';

  @override
  String get confirmTerminateSession =>
      'Вы уверены, что хотите завершить эту сессию?';

  @override
  String get confirmTerminateAllSessions =>
      'Вы уверены, что хотите завершить все остальные сессии? Это действие нельзя отменить.';

  @override
  String get sessionIPAddress => 'IP адрес';

  @override
  String get supportContent =>
      'У нас очень большая нагрузка на службу поддержки. Мы стараемся ответить как можно быстрее, но в настоящее время время ожидания может составлять до 24 часов. Пожалуйста, свяжитесь с нами, и мы обязательно поможем вам решить вашу проблему.';

  @override
  String get contactSupport => 'Связаться';

  @override
  String get xaneoBenefitsContent =>
      'XaneoBenefits - программа лояльности для пользователей Xaneo. Получайте бонусы и эксклюзивные возможности...';

  @override
  String get more => 'Ещё';

  @override
  String get chatPreview => 'Предварительный просмотр';

  @override
  String get textSize => 'Размер текста';

  @override
  String textSizeValue(String size) {
    return 'Размер: $size';
  }

  @override
  String get textExample => 'Пример текста';

  @override
  String get useDarkTheme => 'Использовать тёмное оформление';

  @override
  String get chatWallpapers => 'Обои чата';

  @override
  String get messageColors => 'Цвета сообщений';

  @override
  String get myMessages => 'Мои сообщения';

  @override
  String get receivedMessages => 'Полученные сообщения';

  @override
  String get messageEmojis => 'Эмодзи для сообщений';

  @override
  String get selectedEmoji => 'Выбранный эмодзи:';

  @override
  String get chooseWallpaper => 'Выберите обои:';

  @override
  String get demoMessage1 => 'Привет! Как дела?';

  @override
  String get demoMessage2 => 'Всё отлично! А у тебя как?';

  @override
  String get demoMessage3 => 'Тоже хорошо, спасибо 😊';

  @override
  String get demoDateSeparator => 'Сегодня';

  @override
  String get onlineStatus => 'в сети';

  @override
  String get chatTheme => 'Тема чата';

  @override
  String get privacySettingsTitle => 'Конфиденциальность и приватность';

  @override
  String get privacyCommunications => 'Коммуникации';

  @override
  String get privacyProfileVisibility => 'Видимость профиля';

  @override
  String get privacyWhoCanMessage => 'Сообщения';

  @override
  String get privacyWhoCanRecordVoice => 'Голосовые сообщения';

  @override
  String get privacyWhoCanCall => 'Звонки';

  @override
  String get privacyWhoCanSendVideo => 'Видеосообщения';

  @override
  String get privacyWhoCanSendLinks => 'Ссылки';

  @override
  String get privacyWhoCanInvite => 'Приглашения';

  @override
  String get privacyWhoSeesNickname => 'Никнейм';

  @override
  String get privacyWhoSeesAvatar => 'Аватар';

  @override
  String get privacyWhoSeesBirthday => 'День рождения';

  @override
  String get privacyWhoSeesOnlineTime => 'Время в сети';

  @override
  String get privacyAll => 'Все';

  @override
  String get privacyContacts => 'Контакты';

  @override
  String get privacyNobody => 'Никто';

  @override
  String get passwordWeak => 'Слабый';

  @override
  String get passwordMedium => 'Средний';

  @override
  String get passwordStrong => 'Сильный';

  @override
  String twoFactorEnableDescription(String email) {
    return 'Для включения двухфакторной аутентификации введите код подтверждения, отправленный на $email';
  }

  @override
  String twoFactorDisableDescription(String email) {
    return 'Для отключения двухфакторной аутентификации введите код подтверждения, отправленный на $email';
  }

  @override
  String get changeEmailVerificationDescription =>
      'Для смены почты введите код подтверждения, отправленный на demouser@example.com';

  @override
  String get newEmailTitle => 'Новая почта';

  @override
  String get newEmailDescription => 'Введите новый адрес электронной почты';

  @override
  String get changeEmailButton => 'Изменить';

  @override
  String get verifyNewEmailTitle => 'Подтвердите новую почту';

  @override
  String verifyNewEmailDescription(String email) {
    return 'Для подтверждения новой почты $email введите код подтверждения, отправленный на этот адрес';
  }

  @override
  String get verifyNewEmailButton => 'Подтвердить';

  @override
  String get passcodeVerificationTitle => 'Включить код-пароль';

  @override
  String passcodeVerificationDescription(String email) {
    return 'Для включения защиты код-паролем введите код подтверждения, отправленный на $email';
  }

  @override
  String get passcodeVerificationButton => 'Включить';

  @override
  String get setPasscodeTitle => 'Установите код-пароль';

  @override
  String get setPasscodeDescription =>
      'Создайте 4-значный код-пароль для дополнительной защиты';

  @override
  String get passcodeHint => 'Введите 4 цифры';

  @override
  String get setPasscodeButton => 'Установить';

  @override
  String get xaneoBenefitsModalTitle => 'XaneoBenefits (XB)';

  @override
  String get xaneoBenefitsModalDescription => 'Премиум-подписка Xaneo';

  @override
  String get xaneoBenefitsSelectPlan => 'Выберите план подписки:';

  @override
  String get xaneoBenefitsYearlyPlan => 'Годовая подписка';

  @override
  String get xaneoBenefitsMonthlyPlan => 'Ежемесячная подписка';

  @override
  String get xaneoBenefitsYearlyPrice => '999 ₽ в год';

  @override
  String get xaneoBenefitsMonthlyPrice => '159 ₽ в месяц';

  @override
  String get xaneoBenefitsSavings => 'Экономия 25%! Всего 83,25 ₽ в месяц';

  @override
  String get xaneoBenefitsSubscribeButton => 'Оформить XB';

  @override
  String get xaneoBenefitsCloseButton => 'Закрыть';

  @override
  String get xaneoBenefitsYearlySuccess => 'Оформлена годовая подписка XB!';

  @override
  String get xaneoBenefitsMonthlySuccess =>
      'Оформлена ежемесячная подписка XB!';

  @override
  String get favoritesChat => 'Избранное';

  @override
  String get favoritesChatDescription => 'Важные сообщения и файлы';

  @override
  String contentInDevelopmentMessage(String title) {
    return 'Контент для \"$title\" находится в разработке...';
  }

  @override
  String get russianLanguage => 'Русский';

  @override
  String chatWelcomeMessage(String chatName) {
    return 'Привет! Это чат \"$chatName\" 🎉';
  }

  @override
  String get formattingExample1 =>
      'Здесь можно использовать **жирный** и *курсив* и __подчёркнутый__ текст!';

  @override
  String get formattingExample2 => 'А также ~~зачёркнутый~~ и `код` 💻';

  @override
  String get greetingTrigger => 'привет';

  @override
  String get greetingResponse => 'Привет! Как дела?';

  @override
  String get fileSendingNotImplemented => 'Отправка файлов пока не реализована';

  @override
  String get wasOnlineRecently => 'был(а) недавно';

  @override
  String get messageHint => 'Сообщение';
}
