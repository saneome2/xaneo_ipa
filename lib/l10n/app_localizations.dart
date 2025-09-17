import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

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
    Locale('ru'),
    Locale('de'),
    Locale('it'),
    Locale('pt'),
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('ko'),
    Locale('zh'),
  ];

  /// Название приложения
  ///
  /// In ru, this message translates to:
  /// **'XaneoMobile'**
  String get appTitle;

  /// Заголовок приветствия
  ///
  /// In ru, this message translates to:
  /// **'Добро пожаловать в Xaneo'**
  String get welcomeTitle;

  /// Описание приветствия
  ///
  /// In ru, this message translates to:
  /// **'Xaneo - теперь и в мобильном приложении! Xaneo ещё никогда не был таким удобным и быстрым.'**
  String get welcomeDescription;

  /// Кнопка начала работы
  ///
  /// In ru, this message translates to:
  /// **'Мне уже интересно'**
  String get getStartedButton;

  /// Сообщение о подключении к серверу
  ///
  /// In ru, this message translates to:
  /// **'Подключаемся к серверу...'**
  String get connectingToServer;

  /// Отображение версии
  ///
  /// In ru, this message translates to:
  /// **'Версия: {version}'**
  String version(String version);

  /// HTTP ошибка
  ///
  /// In ru, this message translates to:
  /// **'Ошибка: HTTP {code}'**
  String httpError(int code);

  /// Ошибка подключения
  ///
  /// In ru, this message translates to:
  /// **'Ошибка подключения: {error}'**
  String connectionError(String error);

  /// Сообщение о доступном обновлении
  ///
  /// In ru, this message translates to:
  /// **'Доступно обновление!'**
  String get updateAvailable;

  /// Заголовок модального окна обновления
  ///
  /// In ru, this message translates to:
  /// **'Доступно обновление!'**
  String get updateDialogTitle;

  /// Сообщение о версиях в модальном окне обновления
  ///
  /// In ru, this message translates to:
  /// **'Ваша версия - {currentVersion}, а новая - {latestVersion}'**
  String updateDialogMessage(String currentVersion, String latestVersion);

  /// Описание способов обновления
  ///
  /// In ru, this message translates to:
  /// **'Вы можете обновиться через Google Play, RuStore или с официального сайта Xaneo.'**
  String get updateDialogDescription;

  /// Кнопка обновления
  ///
  /// In ru, this message translates to:
  /// **'Обновить'**
  String get updateButton;

  /// Кнопка отмены
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancelButton;

  /// Заголовок выбора источника обновления
  ///
  /// In ru, this message translates to:
  /// **'Выберите источник для обновления:'**
  String get selectUpdateSource;

  /// Настройки
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settings;

  /// О приложении
  ///
  /// In ru, this message translates to:
  /// **'О приложении'**
  String get about;

  /// Помощь
  ///
  /// In ru, this message translates to:
  /// **'Помощь'**
  String get help;

  /// Уведомления
  ///
  /// In ru, this message translates to:
  /// **'Уведомления'**
  String get notifications;

  /// Описание настройки уведомлений
  ///
  /// In ru, this message translates to:
  /// **'Получать уведомления о новых возможностях'**
  String get notificationsDescription;

  /// Тёмная тема
  ///
  /// In ru, this message translates to:
  /// **'Тёмная тема'**
  String get darkTheme;

  /// Описание настройки тёмной темы
  ///
  /// In ru, this message translates to:
  /// **'Использовать тёмное оформление'**
  String get darkThemeDescription;

  /// Размер шрифта
  ///
  /// In ru, this message translates to:
  /// **'Размер шрифта: {size}'**
  String fontSize(int size);

  /// Версия приложения
  ///
  /// In ru, this message translates to:
  /// **'Версия приложения'**
  String get appVersion;

  /// Опция демо-режима мессенджера в настройках
  ///
  /// In ru, this message translates to:
  /// **'Демо-режим мессенджера'**
  String get messengerDemoMode;

  /// Язык интерфейса
  ///
  /// In ru, this message translates to:
  /// **'Язык'**
  String get language;

  /// Описание настройки языка
  ///
  /// In ru, this message translates to:
  /// **'Выберите язык интерфейса'**
  String get languageDescription;

  /// Сообщение приветствия при нажатии кнопки
  ///
  /// In ru, this message translates to:
  /// **'Отлично! Добро пожаловать!'**
  String get welcomeMessage;

  /// Заголовок экрана приватности
  ///
  /// In ru, this message translates to:
  /// **'Все ваши данные в безопасности'**
  String get privacyTitle;

  /// Описание приватности
  ///
  /// In ru, this message translates to:
  /// **'Все сообщения в XaneoConnect защищены сквозным шифрованием. Ни в один момент Xaneo не знает об их содержимом.'**
  String get privacyDescription;

  /// Кнопка продолжения
  ///
  /// In ru, this message translates to:
  /// **'Давайте продолжать'**
  String get continueButton;

  /// Заголовок экрана хранения данных
  ///
  /// In ru, this message translates to:
  /// **'Все дата-центры Xaneo находятся в России'**
  String get dataStorageTitle;

  /// Описание хранения данных
  ///
  /// In ru, this message translates to:
  /// **'Ваши данные не покидают территорию страны и хранятся в безопасных дата-центрах.'**
  String get dataStorageDescription;

  /// Кнопка завершения настройки
  ///
  /// In ru, this message translates to:
  /// **'Завершить'**
  String get finishButton;

  /// Сообщение о завершении настройки
  ///
  /// In ru, this message translates to:
  /// **'Настройка завершена!'**
  String get setupCompleted;

  /// Заголовок формы входа
  ///
  /// In ru, this message translates to:
  /// **'Давайте войдем'**
  String get loginFormTitle;

  /// Заголовок формы регистрации
  ///
  /// In ru, this message translates to:
  /// **'Давайте начнём'**
  String get registerFormTitle;

  /// Подзаголовок для ввода имени при регистрации
  ///
  /// In ru, this message translates to:
  /// **'Как вас зовут?'**
  String get registerNameSubtitle;

  /// Подсказка для поля ввода имени
  ///
  /// In ru, this message translates to:
  /// **'Ваше имя'**
  String get nameFieldHint;

  /// Кнопка для перехода к следующему шагу регистрации
  ///
  /// In ru, this message translates to:
  /// **'Далее'**
  String get nextButton;

  /// Кнопка для пропуска текущего шага
  ///
  /// In ru, this message translates to:
  /// **'Пропустить'**
  String get skipButton;

  /// Подзаголовок для выбора даты рождения при регистрации
  ///
  /// In ru, this message translates to:
  /// **'Когда вы родились?'**
  String get registerBirthdateSubtitle;

  /// Подсказка для выбора даты рождения
  ///
  /// In ru, this message translates to:
  /// **'Выберите дату'**
  String get selectDate;

  /// Ссылка на информацию об ограничениях по возрасту
  ///
  /// In ru, this message translates to:
  /// **'Какие есть ограничения по возрасту?'**
  String get ageRestrictionsLink;

  /// Заголовок модального окна об ограничениях по возрасту
  ///
  /// In ru, this message translates to:
  /// **'Можно регистрироваться\nс 14 лет'**
  String get ageRestrictionsTitle;

  /// Описание ограничений по возрасту
  ///
  /// In ru, this message translates to:
  /// **'На нашем сервисе\nможно регистрироваться лицам,\nдостигшим 14 лет'**
  String get ageRestrictionsDescription;

  /// Кнопка подтверждения понимания
  ///
  /// In ru, this message translates to:
  /// **'Понятно'**
  String get gotIt;

  /// Подзаголовок для выбора никнейма при регистрации
  ///
  /// In ru, this message translates to:
  /// **'Придумайте никнейм'**
  String get registerNicknameSubtitle;

  /// Подсказка для поля ввода никнейма
  ///
  /// In ru, this message translates to:
  /// **'Ваш никнейм'**
  String get nicknameFieldHint;

  /// Ссылка для помощи в выборе никнейма
  ///
  /// In ru, this message translates to:
  /// **'Не можете придумать никнейм?'**
  String get nicknameHelpLink;

  /// Подзаголовок для ввода email при регистрации
  ///
  /// In ru, this message translates to:
  /// **'Введите e-mail'**
  String get registerEmailSubtitle;

  /// Подсказка в поле email
  ///
  /// In ru, this message translates to:
  /// **'Ваш email'**
  String get emailFieldHint;

  /// Ссылка о поддерживаемых почтовых операторах
  ///
  /// In ru, this message translates to:
  /// **'Какие почтовые операторы поддерживаются?'**
  String get supportedEmailProvidersLink;

  /// Заголовок модального окна с почтовыми операторами
  ///
  /// In ru, this message translates to:
  /// **'Поддерживаемые почтовые операторы'**
  String get supportedEmailProvidersTitle;

  /// Описание поддерживаемых почтовых операторов
  ///
  /// In ru, this message translates to:
  /// **'Поддерживаются Gmail, Outlook, Яндекс, Mail.ru и другие популярные почтовые сервисы.'**
  String get supportedEmailProvidersDescription;

  /// Ошибка неверного формата email
  ///
  /// In ru, this message translates to:
  /// **'Неверный формат email адреса'**
  String get emailFormatError;

  /// Ошибка неподдерживаемого почтового сервиса
  ///
  /// In ru, this message translates to:
  /// **'Данный почтовый сервис не поддерживается'**
  String get emailUnsupportedError;

  /// Сообщение о проверке доступности email
  ///
  /// In ru, this message translates to:
  /// **'Проверяем email...'**
  String get checkingEmail;

  /// Сообщение что email доступен для регистрации
  ///
  /// In ru, this message translates to:
  /// **'Email доступен'**
  String get emailAvailable;

  /// Ошибка - email уже используется другим пользователем
  ///
  /// In ru, this message translates to:
  /// **'Этот email уже занят'**
  String get emailTakenError;

  /// Ошибка сервера при проверке email
  ///
  /// In ru, this message translates to:
  /// **'Ошибка проверки email. Попробуйте позже'**
  String get emailServerError;

  /// Заголовок шага подтверждения email
  ///
  /// In ru, this message translates to:
  /// **'Подтвердите свою почту'**
  String get verifyEmailTitle;

  /// Описание процесса подтверждения email
  ///
  /// In ru, this message translates to:
  /// **'Мы отправили 6-значный код на ваш email. Введите его для подтверждения.'**
  String get verifyEmailDescription;

  /// Подсказка для поля ввода кода
  ///
  /// In ru, this message translates to:
  /// **'Код подтверждения'**
  String get verificationCodeHint;

  /// Кнопка проверки кода
  ///
  /// In ru, this message translates to:
  /// **'Проверить'**
  String get verifyButton;

  /// Подзаголовок для ввода пароля при регистрации
  ///
  /// In ru, this message translates to:
  /// **'Придумайте пароль'**
  String get registerPasswordSubtitle;

  /// Подсказка в поле пароля при регистрации
  ///
  /// In ru, this message translates to:
  /// **'Введите пароль'**
  String get registerPasswordFieldHint;

  /// Ошибка использования кириллицы в пароле
  ///
  /// In ru, this message translates to:
  /// **'Пароль может содержать только латинские буквы, цифры и знаки препинания'**
  String get passwordInvalidCharsError;

  /// Ошибка слабого пароля
  ///
  /// In ru, this message translates to:
  /// **'Пароль слишком слабый. Используйте буквы, цифры и спецсимволы'**
  String get passwordWeakError;

  /// Предупреждение о пароле средней силы
  ///
  /// In ru, this message translates to:
  /// **'Пароль средней силы. Рекомендуем усилить'**
  String get passwordMediumWarning;

  /// Сообщение о сильном пароле
  ///
  /// In ru, this message translates to:
  /// **'Сильный пароль'**
  String get passwordStrongSuccess;

  /// Заголовок генератора никнеймов
  ///
  /// In ru, this message translates to:
  /// **'Ваш никнейм будет сгенерирован автоматически'**
  String get nicknameGeneratorTitle;

  /// Описание генератора никнеймов
  ///
  /// In ru, this message translates to:
  /// **'Вы сможете в любое время сменить никнейм'**
  String get nicknameGeneratorDescription;

  /// Кнопка закрытия модального окна
  ///
  /// In ru, this message translates to:
  /// **'Закрыть'**
  String get closeButton;

  /// Подсказка для поля логина
  ///
  /// In ru, this message translates to:
  /// **'Логин'**
  String get loginFieldHint;

  /// Подсказка для поля пароля входа
  ///
  /// In ru, this message translates to:
  /// **'Пароль'**
  String get passwordFieldHint;

  /// Кнопка входа
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get loginButton;

  /// Сообщение об обязательности заполнения всех полей
  ///
  /// In ru, this message translates to:
  /// **'Заполните все поля'**
  String get fillAllFields;

  /// Сообщение о процессе входа
  ///
  /// In ru, this message translates to:
  /// **'Выполняется вход...'**
  String get loggingIn;

  /// Приветствие пользователя после входа
  ///
  /// In ru, this message translates to:
  /// **'Добро пожаловать, {username}!'**
  String welcomeUser(String username);

  /// Сообщение о неверных учетных данных
  ///
  /// In ru, this message translates to:
  /// **'Неверные учётные данные. Проверьте имя пользователя и пароль.'**
  String get invalidCredentials;

  /// Сообщение об ошибке сервера
  ///
  /// In ru, this message translates to:
  /// **'Ошибка сервера. Попробуйте позже.'**
  String get serverError;

  /// Сообщение об ошибке подключения при входе
  ///
  /// In ru, this message translates to:
  /// **'Ошибка подключения. Проверьте интернет-соединение.'**
  String get connectionErrorLogin;

  /// Ссылка для создания аккаунта
  ///
  /// In ru, this message translates to:
  /// **'Нет аккаунта?'**
  String get noAccount;

  /// Ссылка для восстановления пароля
  ///
  /// In ru, this message translates to:
  /// **'Забыли пароль?'**
  String get forgotPassword;

  /// Описание в модальном окне восстановления пароля
  ///
  /// In ru, this message translates to:
  /// **'Введите ваш никнейм, и мы отправим вам ссылку для входа в аккаунт на почту.'**
  String get forgotPasswordDescription;

  /// Кнопка отправки ссылки для восстановления
  ///
  /// In ru, this message translates to:
  /// **'Отправить ссылку'**
  String get sendLinkButton;

  /// Заголовок модального окна успешной отправки письма
  ///
  /// In ru, this message translates to:
  /// **'Проверьте свою почту'**
  String get checkEmailTitle;

  /// Описание в модальном окне успешной отправки письма
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, проверьте свой ящик {email} и перейдите по ссылке для входа в аккаунт.'**
  String checkEmailDescription(String email);

  /// Описание в модальном окне ввода кода восстановления пароля
  ///
  /// In ru, this message translates to:
  /// **'Введите код доступа, который был отправлен на email, привязанный к вашему аккаунту'**
  String get forgotPasswordCodeDescription;

  /// Ссылка для возврата к форме входа
  ///
  /// In ru, this message translates to:
  /// **'Уже есть аккаунт?'**
  String get alreadyHaveAccount;

  /// Сообщение о недоступности регистрации
  ///
  /// In ru, this message translates to:
  /// **'Регистрация пока недоступна'**
  String get registrationUnavailable;

  /// Сообщение о недоступности восстановления пароля
  ///
  /// In ru, this message translates to:
  /// **'Восстановление пароля пока недоступно'**
  String get passwordRecoveryUnavailable;

  /// Ошибка валидации минимальной длины никнейма
  ///
  /// In ru, this message translates to:
  /// **'Длина никнейма должна составлять не менее пяти символов'**
  String get nicknameMinLengthError;

  /// Ошибка валидации символов никнейма - только латинские
  ///
  /// In ru, this message translates to:
  /// **'Никнейм может содержать только латинские буквы, цифры, точки и нижнее подчёркивание'**
  String get nicknameLatinOnlyError;

  /// Ошибка валидации начала никнейма
  ///
  /// In ru, this message translates to:
  /// **'Никнейм не может начинаться с нижнего подчёркивания, цифры или точки'**
  String get nicknameStartError;

  /// Ошибка валидации окончания никнейма
  ///
  /// In ru, this message translates to:
  /// **'Никнейм не может заканчиваться нижним подчёркиванием или точкой'**
  String get nicknameEndError;

  /// Сообщение о проверке никнейма
  ///
  /// In ru, this message translates to:
  /// **'Проверяем никнейм...'**
  String get checkingNickname;

  /// Сообщение о том, что никнейм доступен
  ///
  /// In ru, this message translates to:
  /// **'Никнейм свободен'**
  String get nicknameAvailable;

  /// Ошибка - никнейм уже используется другим пользователем
  ///
  /// In ru, this message translates to:
  /// **'Этот никнейм уже занят'**
  String get nicknameTakenError;

  /// Ошибка сервера при проверке никнейма
  ///
  /// In ru, this message translates to:
  /// **'Ошибка проверки никнейма. Попробуйте позже'**
  String get nicknameServerError;

  /// Ошибка максимальной длины никнейма
  ///
  /// In ru, this message translates to:
  /// **'Максимум 30 символов'**
  String get nicknameMaxLengthError;

  /// Ошибка при пустом имени
  ///
  /// In ru, this message translates to:
  /// **'Имя не может быть пустым'**
  String get nameEmptyError;

  /// Заголовок модального окна подтверждения пароля
  ///
  /// In ru, this message translates to:
  /// **'Подтвердите пароль'**
  String get confirmPasswordTitle;

  /// Описание в модальном окне подтверждения пароля
  ///
  /// In ru, this message translates to:
  /// **'Введите пароль еще раз для подтверждения'**
  String get confirmPasswordDescription;

  /// Подсказка в поле подтверждения пароля
  ///
  /// In ru, this message translates to:
  /// **'Повторите пароль'**
  String get confirmPasswordFieldHint;

  /// Ошибка когда пароли не совпадают
  ///
  /// In ru, this message translates to:
  /// **'Пароли не совпадают'**
  String get passwordMismatchError;

  /// Кнопка подтверждения
  ///
  /// In ru, this message translates to:
  /// **'Подтвердить'**
  String get confirmButton;

  /// Подзаголовок для шага выбора аватарки
  ///
  /// In ru, this message translates to:
  /// **'Выберите аватарку'**
  String get registerAvatarSubtitle;

  /// Подсказка для добавления аватарки
  ///
  /// In ru, this message translates to:
  /// **'Нажмите + чтобы добавить фото'**
  String get addAvatarHint;

  /// Подсказка для выбора аватара
  ///
  /// In ru, this message translates to:
  /// **'Нажмите, чтобы выбрать фото'**
  String get avatarTapToSelect;

  /// Заголовок запроса разрешения на доступ к фото
  ///
  /// In ru, this message translates to:
  /// **'Разрешите доступ к изображениям'**
  String get photoPermissionTitle;

  /// Описание запроса разрешения на доступ к фото
  ///
  /// In ru, this message translates to:
  /// **'Разрешите нам доступ к вашим изображениям, чтобы вы могли выбрать аватар для вашего профиля'**
  String get photoPermissionDescription;

  /// Кнопка разрешения доступа
  ///
  /// In ru, this message translates to:
  /// **'Разрешить доступ'**
  String get allowAccessButton;

  /// Кнопка отказа от разрешения
  ///
  /// In ru, this message translates to:
  /// **'Не сейчас'**
  String get notNowButton;

  /// Заголовок экрана настройки аватара
  ///
  /// In ru, this message translates to:
  /// **'Настройка аватара'**
  String get avatarCropperTitle;

  /// Кнопка завершения действия
  ///
  /// In ru, this message translates to:
  /// **'Готово'**
  String get doneButton;

  /// Инструкция по использованию кроппера
  ///
  /// In ru, this message translates to:
  /// **'Перетащите круг для выбора области • Используйте точки для изменения размера'**
  String get cropInstructions;

  /// Кнопка изменения аватара
  ///
  /// In ru, this message translates to:
  /// **'Изменить аватар'**
  String get changeAvatar;

  /// Заголовок превью профиля
  ///
  /// In ru, this message translates to:
  /// **'Так будет выглядеть ваш профиль'**
  String get profilePreviewTitle;

  /// Приветствие утром
  ///
  /// In ru, this message translates to:
  /// **'Доброе утро'**
  String get goodMorning;

  /// Приветствие днем
  ///
  /// In ru, this message translates to:
  /// **'Добрый день'**
  String get goodDay;

  /// Приветствие вечером
  ///
  /// In ru, this message translates to:
  /// **'Добрый вечер'**
  String get goodEvening;

  /// Приветствие ночью
  ///
  /// In ru, this message translates to:
  /// **'Доброй ночи'**
  String get goodNight;

  /// Кнопка назад
  ///
  /// In ru, this message translates to:
  /// **'Назад'**
  String get backButton;

  /// Заголовок модального окна редактирования имени
  ///
  /// In ru, this message translates to:
  /// **'Изменить имя'**
  String get editName;

  /// Заголовок модального окна редактирования никнейма
  ///
  /// In ru, this message translates to:
  /// **'Изменить никнейм'**
  String get editNickname;

  /// Заголовок модального окна редактирования фото
  ///
  /// In ru, this message translates to:
  /// **'Изменить фото'**
  String get editPhoto;

  /// Кнопка сохранить
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get saveButton;

  /// Кнопка удалить
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get deleteButton;

  /// Кнопка удаления фото
  ///
  /// In ru, this message translates to:
  /// **'Удалить фото'**
  String get deletePhoto;

  /// Кнопка выбора фото из галереи
  ///
  /// In ru, this message translates to:
  /// **'Выбрать из галереи'**
  String get selectFromGallery;

  /// Подсказка в поле ввода имени
  ///
  /// In ru, this message translates to:
  /// **'Введите ваше имя'**
  String get enterNameHint;

  /// Подсказка в поле ввода никнейма
  ///
  /// In ru, this message translates to:
  /// **'Введите никнейм'**
  String get enterNicknameHint;

  /// Заголовок модального окна с условиями
  ///
  /// In ru, this message translates to:
  /// **'Условия использования'**
  String get termsAndConditionsTitle;

  /// Ссылка на условия использования
  ///
  /// In ru, this message translates to:
  /// **'Условия использования'**
  String get termsOfUse;

  /// Ссылка на пользовательское соглашение
  ///
  /// In ru, this message translates to:
  /// **'Пользовательское соглашение'**
  String get userAgreement;

  /// Подробный текст принятия условий с объяснением
  ///
  /// In ru, this message translates to:
  /// **'Для завершения регистрации и начала использования Xaneo необходимо принять {termsOfUse} и {userAgreement}.\n\nЭти документы содержат важную информацию о правилах использования сервиса, защите ваших данных и обязательствах сторон.\n\nПринимая условия, вы подтверждаете, что ознакомились с правилами платформы и согласны их соблюдать.\n\nБез принятия этих условий регистрация не может быть завершена, и доступ к сервису будет ограничен.'**
  String acceptTermsText(String termsOfUse, String userAgreement);

  /// Кнопка принятия условий
  ///
  /// In ru, this message translates to:
  /// **'Принять'**
  String get acceptButton;

  /// Кнопка отклонения условий
  ///
  /// In ru, this message translates to:
  /// **'Отклонить'**
  String get declineButton;

  /// Сообщение об отправке кода подтверждения
  ///
  /// In ru, this message translates to:
  /// **'Код отправлен на {email}. Действителен {seconds} секунд'**
  String verificationCodeSent(String email, int seconds);

  /// Ошибка при отправке кода подтверждения
  ///
  /// In ru, this message translates to:
  /// **'Ошибка отправки кода'**
  String get codeDeliveryError;

  /// Ошибка сервера при отправке кода
  ///
  /// In ru, this message translates to:
  /// **'Ошибка сервера при отправке кода'**
  String get serverErrorCodeDelivery;

  /// Ошибка подключения при отправке кода
  ///
  /// In ru, this message translates to:
  /// **'Ошибка подключения при отправке кода'**
  String get connectionErrorCodeDelivery;

  /// Успешное подтверждение email
  ///
  /// In ru, this message translates to:
  /// **'Email успешно подтвержден!'**
  String get emailVerificationSuccess;

  /// Неверный код подтверждения
  ///
  /// In ru, this message translates to:
  /// **'Неверный код подтверждения. Проверьте код и попробуйте снова'**
  String get invalidVerificationCode;

  /// Email не найден при верификации
  ///
  /// In ru, this message translates to:
  /// **'Email не найден. Попробуйте зарегистрироваться заново'**
  String get emailNotFound;

  /// Код подтверждения истек
  ///
  /// In ru, this message translates to:
  /// **'Код подтверждения истек. Запросите новый код'**
  String get verificationCodeExpired;

  /// Ошибка сервера при проверке кода
  ///
  /// In ru, this message translates to:
  /// **'Ошибка сервера при проверке кода. Попробуйте позже'**
  String get serverErrorCodeVerification;

  /// Ошибка подключения при проверке кода
  ///
  /// In ru, this message translates to:
  /// **'Ошибка подключения при проверке кода'**
  String get connectionErrorCodeVerification;

  /// Разрешение отклонено навсегда
  ///
  /// In ru, this message translates to:
  /// **'Разрешение навсегда отклонено. Включите его в настройках'**
  String get permissionDeniedSettings;

  /// Аватар успешно обрезан
  ///
  /// In ru, this message translates to:
  /// **'Аватар обрезан и сохранен!'**
  String get avatarCropped;

  /// Ошибка при выборе изображения
  ///
  /// In ru, this message translates to:
  /// **'Ошибка при выборе изображения'**
  String get imageSelectionError;

  /// Разрешение отклонено - предложение открыть настройки
  ///
  /// In ru, this message translates to:
  /// **'Разрешение навсегда отклонено. Откройте настройки для включения'**
  String get permissionDeniedOpenSettings;

  /// Ошибка получения разрешения на фото
  ///
  /// In ru, this message translates to:
  /// **'Не удалось получить разрешение на доступ к изображениям'**
  String get photoPermissionError;

  /// Регистрация успешно завершена
  ///
  /// In ru, this message translates to:
  /// **'Регистрация завершена!'**
  String get registrationCompleted;

  /// Название официального сайта Xaneo
  ///
  /// In ru, this message translates to:
  /// **'Официальный сайт Xaneo'**
  String get officialXaneoWebsite;

  /// Сообщение о двухфакторной аутентификации
  ///
  /// In ru, this message translates to:
  /// **'На этом аккаунте включена двухфакторная аутентификация. Введите код подтверждения, который был отправлен на {email}'**
  String twoFactorAuthMessage(String email);

  /// Заголовок выбора языка
  ///
  /// In ru, this message translates to:
  /// **'Выберите язык'**
  String get selectLanguage;

  /// Заголовок демо-мессенджера
  ///
  /// In ru, this message translates to:
  /// **'Демо-мессенджер'**
  String get messengerDemo;

  /// Мессенджер
  ///
  /// In ru, this message translates to:
  /// **'Мессенджер'**
  String get messenger;

  /// Описание мессенджера
  ///
  /// In ru, this message translates to:
  /// **'Простой, быстрый и безопасный мессенджер с современным дизайном и удобным интерфейсом.'**
  String get messengerDescription;

  /// Заголовок демо-профиля
  ///
  /// In ru, this message translates to:
  /// **'Демо-профиль'**
  String get profileDemo;

  /// Профиль
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get profile;

  /// Личная информация
  ///
  /// In ru, this message translates to:
  /// **'Личная информация'**
  String get personalInfo;

  /// Имя
  ///
  /// In ru, this message translates to:
  /// **'Имя'**
  String get name;

  /// Подсказка для поля имени
  ///
  /// In ru, this message translates to:
  /// **'Имя'**
  String get nameHint;

  /// Дата рождения
  ///
  /// In ru, this message translates to:
  /// **'Дата рождения'**
  String get birthDate;

  /// Никнейм
  ///
  /// In ru, this message translates to:
  /// **'Никнейм'**
  String get nickname;

  /// Подсказка для поля никнейма
  ///
  /// In ru, this message translates to:
  /// **'Никнейм'**
  String get nicknameHint;

  /// Телефон
  ///
  /// In ru, this message translates to:
  /// **'Телефон'**
  String get phone;

  /// Подсказка для поля телефона
  ///
  /// In ru, this message translates to:
  /// **'Номер телефона'**
  String get phoneHint;

  /// Раздел настроек
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settingsSection;

  /// Настройки чатов
  ///
  /// In ru, this message translates to:
  /// **'Настройки чатов'**
  String get chatSettings;

  /// Описание настроек чатов
  ///
  /// In ru, this message translates to:
  /// **'Здесь будут настройки чатов...'**
  String get chatSettingsDescription;

  /// Конфиденциальность и приватность
  ///
  /// In ru, this message translates to:
  /// **'Конфиденциальность и приватность'**
  String get privacySettings;

  /// Описание настроек приватности
  ///
  /// In ru, this message translates to:
  /// **'Здесь будут настройки приватности...'**
  String get privacySettingsDescription;

  /// Безопасность
  ///
  /// In ru, this message translates to:
  /// **'Безопасность'**
  String get securitySettings;

  /// Раздел настроек аутентификации
  ///
  /// In ru, this message translates to:
  /// **'Аутентификация'**
  String get securityAuthentication;

  /// Настройка смены пароля
  ///
  /// In ru, this message translates to:
  /// **'Сменить пароль'**
  String get securityChangePassword;

  /// Настройка двухфакторной аутентификации
  ///
  /// In ru, this message translates to:
  /// **'Двухфакторная аутентификация'**
  String get securityTwoFactorAuth;

  /// Сообщение о включении двухфакторной аутентификации
  ///
  /// In ru, this message translates to:
  /// **'Включена'**
  String get twoFactorEnabled;

  /// Сообщение об отключении двухфакторной аутентификации
  ///
  /// In ru, this message translates to:
  /// **'Отключена'**
  String get twoFactorDisabled;

  /// Настройка смены электронной почты
  ///
  /// In ru, this message translates to:
  /// **'Сменить почту'**
  String get securityChangeEmail;

  /// Настройка код-пароля
  ///
  /// In ru, this message translates to:
  /// **'Код-пароль'**
  String get securityPasscode;

  /// Описание настроек безопасности
  ///
  /// In ru, this message translates to:
  /// **'Здесь будут настройки безопасности...'**
  String get securitySettingsDescription;

  /// Ошибка пустого пароля
  ///
  /// In ru, this message translates to:
  /// **'Пароль не может быть пустым'**
  String get passwordEmptyError;

  /// Ошибка короткого пароля
  ///
  /// In ru, this message translates to:
  /// **'Пароль должен содержать минимум 5 символов'**
  String get passwordTooShortError;

  /// Подсказка для ввода текущего пароля
  ///
  /// In ru, this message translates to:
  /// **'Введите текущий пароль для подтверждения'**
  String get passwordEnterCurrentHint;

  /// Подсказка поля текущего пароля
  ///
  /// In ru, this message translates to:
  /// **'Текущий пароль'**
  String get passwordCurrentHint;

  /// Подсказка для подтверждения нового пароля
  ///
  /// In ru, this message translates to:
  /// **'Подтвердите новый пароль'**
  String get passwordConfirmNewHint;

  /// Ошибка несовпадения паролей
  ///
  /// In ru, this message translates to:
  /// **'Пароли не совпадают'**
  String get passwordDontMatchError;

  /// Заголовок окна нового пароля
  ///
  /// In ru, this message translates to:
  /// **'Новый пароль'**
  String get passwordNewTitle;

  /// Подсказка поля нового пароля
  ///
  /// In ru, this message translates to:
  /// **'Новый пароль'**
  String get passwordNewHint;

  /// Подсказка поля подтверждения пароля
  ///
  /// In ru, this message translates to:
  /// **'Подтвердите пароль'**
  String get passwordConfirmHint;

  /// Сообщение об успешной смене пароля
  ///
  /// In ru, this message translates to:
  /// **'Пароль успешно изменен'**
  String get passwordChangedSuccess;

  /// Кнопка Далее
  ///
  /// In ru, this message translates to:
  /// **'Далее'**
  String get passwordNextButton;

  /// Кнопка Сохранить
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get passwordSaveButton;

  /// Энергосбережение
  ///
  /// In ru, this message translates to:
  /// **'Энергосбережение'**
  String get powerSettings;

  /// Описание настроек энергосбережения
  ///
  /// In ru, this message translates to:
  /// **'Здесь будут настройки энергосбережения...'**
  String get powerSettingsDescription;

  /// Выбор языка
  ///
  /// In ru, this message translates to:
  /// **'Язык'**
  String get languageSelect;

  /// Отмена
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// Готово
  ///
  /// In ru, this message translates to:
  /// **'Готово'**
  String get ready;

  /// Сообщение о том, что контент находится в разработке
  ///
  /// In ru, this message translates to:
  /// **'Контент для \"{title}\" находится в разработке...'**
  String contentInDevelopment(String title);

  /// Сессии
  ///
  /// In ru, this message translates to:
  /// **'Сессии'**
  String get sessions;

  /// Служба поддержки
  ///
  /// In ru, this message translates to:
  /// **'Служба поддержки'**
  String get support;

  /// XaneoBenefits
  ///
  /// In ru, this message translates to:
  /// **'XaneoBenefits'**
  String get xaneoBenefits;

  /// Заголовок функций мессенджера
  ///
  /// In ru, this message translates to:
  /// **'Функционал демо-режима:'**
  String get messengerFeatures;

  /// Безопасное шифрование сообщений
  ///
  /// In ru, this message translates to:
  /// **'Безопасное шифрование сообщений'**
  String get secureEncryption;

  /// Мгновенная доставка
  ///
  /// In ru, this message translates to:
  /// **'Мгновенная доставка'**
  String get instantDelivery;

  /// Синхронизация между устройствами
  ///
  /// In ru, this message translates to:
  /// **'Синхронизация между устройствами'**
  String get deviceSync;

  /// Поддержка медиафайлов
  ///
  /// In ru, this message translates to:
  /// **'Поддержка медиафайлов'**
  String get mediaSupport;

  /// Контент для страницы сессий
  ///
  /// In ru, this message translates to:
  /// **'Здесь будут отображаться активные сессии вашего аккаунта...'**
  String get sessionsContent;

  /// Заголовок секции активных устройств
  ///
  /// In ru, this message translates to:
  /// **'Активные устройства'**
  String get activeDevices;

  /// Пометка для текущего устройства
  ///
  /// In ru, this message translates to:
  /// **'Текущее устройство'**
  String get currentDevice;

  /// Кнопка завершения сессии
  ///
  /// In ru, this message translates to:
  /// **'Завершить сессию'**
  String get terminateSession;

  /// Кнопка завершения всех других сессий
  ///
  /// In ru, this message translates to:
  /// **'Завершить все остальные сессии'**
  String get terminateAllOtherSessions;

  /// Местоположение сессии
  ///
  /// In ru, this message translates to:
  /// **'Местоположение'**
  String get sessionLocation;

  /// Время последней активности
  ///
  /// In ru, this message translates to:
  /// **'Последняя активность'**
  String get sessionLastActive;

  /// Браузер сессии
  ///
  /// In ru, this message translates to:
  /// **'Браузер'**
  String get sessionBrowser;

  /// Платформа сессии
  ///
  /// In ru, this message translates to:
  /// **'Платформа'**
  String get sessionPlatform;

  /// Подтверждение завершения сессии
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите завершить эту сессию?'**
  String get confirmTerminateSession;

  /// Подтверждение завершения всех сессий
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите завершить все остальные сессии? Это действие нельзя отменить.'**
  String get confirmTerminateAllSessions;

  /// IP адрес сессии
  ///
  /// In ru, this message translates to:
  /// **'IP адрес'**
  String get sessionIPAddress;

  /// Контент для страницы поддержки
  ///
  /// In ru, this message translates to:
  /// **'У нас очень большая нагрузка на службу поддержки. Мы стараемся ответить как можно быстрее, но в настоящее время время ожидания может составлять до 24 часов. Пожалуйста, свяжитесь с нами, и мы обязательно поможем вам решить вашу проблему.'**
  String get supportContent;

  /// No description provided for @contactSupport.
  ///
  /// In ru, this message translates to:
  /// **'Связаться'**
  String get contactSupport;

  /// Контент для страницы XaneoBenefits
  ///
  /// In ru, this message translates to:
  /// **'XaneoBenefits - программа лояльности для пользователей Xaneo. Получайте бонусы и эксклюзивные возможности...'**
  String get xaneoBenefitsContent;

  /// Заголовок раздела 'Ещё'
  ///
  /// In ru, this message translates to:
  /// **'Ещё'**
  String get more;

  /// Заголовок предварительного просмотра чата
  ///
  /// In ru, this message translates to:
  /// **'Предварительный просмотр'**
  String get chatPreview;

  /// Заголовок настройки размера текста
  ///
  /// In ru, this message translates to:
  /// **'Размер текста'**
  String get textSize;

  /// Отображение размера текста со значением
  ///
  /// In ru, this message translates to:
  /// **'Размер: {size}'**
  String textSizeValue(String size);

  /// Пример текста для демонстрации размера
  ///
  /// In ru, this message translates to:
  /// **'Пример текста'**
  String get textExample;

  /// Описание настройки тёмной темы
  ///
  /// In ru, this message translates to:
  /// **'Использовать тёмное оформление'**
  String get useDarkTheme;

  /// Заголовок настройки обоев чата
  ///
  /// In ru, this message translates to:
  /// **'Обои чата'**
  String get chatWallpapers;

  /// Заголовок настройки цветов сообщений
  ///
  /// In ru, this message translates to:
  /// **'Цвета сообщений'**
  String get messageColors;

  /// Заголовок настройки цвета моих сообщений
  ///
  /// In ru, this message translates to:
  /// **'Мои сообщения'**
  String get myMessages;

  /// Заголовок настройки цвета полученных сообщений
  ///
  /// In ru, this message translates to:
  /// **'Полученные сообщения'**
  String get receivedMessages;

  /// Заголовок настройки эмодзи для сообщений
  ///
  /// In ru, this message translates to:
  /// **'Эмодзи для сообщений'**
  String get messageEmojis;

  /// Метка для выбранного эмодзи
  ///
  /// In ru, this message translates to:
  /// **'Выбранный эмодзи:'**
  String get selectedEmoji;

  /// Подсказка для выбора обоев
  ///
  /// In ru, this message translates to:
  /// **'Выберите обои:'**
  String get chooseWallpaper;

  /// Первое демо сообщение в чате
  ///
  /// In ru, this message translates to:
  /// **'Привет! Как дела?'**
  String get demoMessage1;

  /// Второе демо сообщение в чате
  ///
  /// In ru, this message translates to:
  /// **'Всё отлично! А у тебя как?'**
  String get demoMessage2;

  /// Третье демо сообщение в чате
  ///
  /// In ru, this message translates to:
  /// **'Тоже хорошо, спасибо 😊'**
  String get demoMessage3;

  /// Разделитель даты в демо чате
  ///
  /// In ru, this message translates to:
  /// **'Сегодня'**
  String get demoDateSeparator;

  /// Статус онлайн пользователя
  ///
  /// In ru, this message translates to:
  /// **'в сети'**
  String get onlineStatus;

  /// Заголовок для настройки темы чата
  ///
  /// In ru, this message translates to:
  /// **'Тема чата'**
  String get chatTheme;

  /// Заголовок экрана настроек конфиденциальности
  ///
  /// In ru, this message translates to:
  /// **'Конфиденциальность и приватность'**
  String get privacySettingsTitle;

  /// Раздел настроек коммуникаций
  ///
  /// In ru, this message translates to:
  /// **'Коммуникации'**
  String get privacyCommunications;

  /// Раздел настроек видимости профиля
  ///
  /// In ru, this message translates to:
  /// **'Видимость профиля'**
  String get privacyProfileVisibility;

  /// Настройка кто может отправлять сообщения
  ///
  /// In ru, this message translates to:
  /// **'Сообщения'**
  String get privacyWhoCanMessage;

  /// Настройка кто может отправлять голосовые сообщения
  ///
  /// In ru, this message translates to:
  /// **'Голосовые сообщения'**
  String get privacyWhoCanRecordVoice;

  /// Настройка кто может совершать звонки
  ///
  /// In ru, this message translates to:
  /// **'Звонки'**
  String get privacyWhoCanCall;

  /// Настройка кто может отправлять видео сообщения
  ///
  /// In ru, this message translates to:
  /// **'Видеосообщения'**
  String get privacyWhoCanSendVideo;

  /// Настройка кто может отправлять ссылки
  ///
  /// In ru, this message translates to:
  /// **'Ссылки'**
  String get privacyWhoCanSendLinks;

  /// Настройка кто может приглашать в групповые чаты
  ///
  /// In ru, this message translates to:
  /// **'Приглашения'**
  String get privacyWhoCanInvite;

  /// Настройка кто видит никнейм пользователя
  ///
  /// In ru, this message translates to:
  /// **'Никнейм'**
  String get privacyWhoSeesNickname;

  /// Настройка кто видит аватар пользователя
  ///
  /// In ru, this message translates to:
  /// **'Аватар'**
  String get privacyWhoSeesAvatar;

  /// Настройка кто видит дату рождения
  ///
  /// In ru, this message translates to:
  /// **'День рождения'**
  String get privacyWhoSeesBirthday;

  /// Настройка кто видит время последнего захода
  ///
  /// In ru, this message translates to:
  /// **'Время в сети'**
  String get privacyWhoSeesOnlineTime;

  /// Вариант настройки - все пользователи
  ///
  /// In ru, this message translates to:
  /// **'Все'**
  String get privacyAll;

  /// Вариант настройки - только контакты
  ///
  /// In ru, this message translates to:
  /// **'Контакты'**
  String get privacyContacts;

  /// Вариант настройки - никто
  ///
  /// In ru, this message translates to:
  /// **'Никто'**
  String get privacyNobody;

  /// Индикатор слабой силы пароля
  ///
  /// In ru, this message translates to:
  /// **'Слабый'**
  String get passwordWeak;

  /// Индикатор средней силы пароля
  ///
  /// In ru, this message translates to:
  /// **'Средний'**
  String get passwordMedium;

  /// Индикатор сильной силы пароля
  ///
  /// In ru, this message translates to:
  /// **'Сильный'**
  String get passwordStrong;

  /// Описание для включения 2FA
  ///
  /// In ru, this message translates to:
  /// **'Для включения двухфакторной аутентификации введите код подтверждения, отправленный на {email}'**
  String twoFactorEnableDescription(String email);

  /// Описание для отключения 2FA
  ///
  /// In ru, this message translates to:
  /// **'Для отключения двухфакторной аутентификации введите код подтверждения, отправленный на {email}'**
  String twoFactorDisableDescription(String email);

  /// Описание для подтверждения смены почты
  ///
  /// In ru, this message translates to:
  /// **'Для смены почты введите код подтверждения, отправленный на demouser@example.com'**
  String get changeEmailVerificationDescription;

  /// Заголовок окна ввода новой почты
  ///
  /// In ru, this message translates to:
  /// **'Новая почта'**
  String get newEmailTitle;

  /// Описание в окне ввода новой почты
  ///
  /// In ru, this message translates to:
  /// **'Введите новый адрес электронной почты'**
  String get newEmailDescription;

  /// Кнопка изменения почты
  ///
  /// In ru, this message translates to:
  /// **'Изменить'**
  String get changeEmailButton;

  /// Заголовок окна подтверждения новой почты
  ///
  /// In ru, this message translates to:
  /// **'Подтвердите новую почту'**
  String get verifyNewEmailTitle;

  /// Описание в окне подтверждения новой почты
  ///
  /// In ru, this message translates to:
  /// **'Для подтверждения новой почты {email} введите код подтверждения, отправленный на этот адрес'**
  String verifyNewEmailDescription(String email);

  /// Кнопка подтверждения новой почты
  ///
  /// In ru, this message translates to:
  /// **'Подтвердить'**
  String get verifyNewEmailButton;

  /// Заголовок окна включения код-пароля
  ///
  /// In ru, this message translates to:
  /// **'Включить код-пароль'**
  String get passcodeVerificationTitle;

  /// Описание в окне включения код-пароля
  ///
  /// In ru, this message translates to:
  /// **'Для включения защиты код-паролем введите код подтверждения, отправленный на {email}'**
  String passcodeVerificationDescription(String email);

  /// Кнопка включения код-пароля
  ///
  /// In ru, this message translates to:
  /// **'Включить'**
  String get passcodeVerificationButton;

  /// Заголовок окна установки код-пароля
  ///
  /// In ru, this message translates to:
  /// **'Установите код-пароль'**
  String get setPasscodeTitle;

  /// Описание в окне установки код-пароля
  ///
  /// In ru, this message translates to:
  /// **'Создайте 4-значный код-пароль для дополнительной защиты'**
  String get setPasscodeDescription;

  /// Подсказка для поля ввода код-пароля
  ///
  /// In ru, this message translates to:
  /// **'Введите 4 цифры'**
  String get passcodeHint;

  /// Кнопка установки код-пароля
  ///
  /// In ru, this message translates to:
  /// **'Установить'**
  String get setPasscodeButton;

  /// Заголовок модалки XaneoBenefits
  ///
  /// In ru, this message translates to:
  /// **'XaneoBenefits (XB)'**
  String get xaneoBenefitsModalTitle;

  /// Описание модалки XaneoBenefits
  ///
  /// In ru, this message translates to:
  /// **'Премиум-подписка Xaneo'**
  String get xaneoBenefitsModalDescription;

  /// Текст выбора плана подписки
  ///
  /// In ru, this message translates to:
  /// **'Выберите план подписки:'**
  String get xaneoBenefitsSelectPlan;

  /// Название годовой подписки
  ///
  /// In ru, this message translates to:
  /// **'Годовая подписка'**
  String get xaneoBenefitsYearlyPlan;

  /// Название ежемесячной подписки
  ///
  /// In ru, this message translates to:
  /// **'Ежемесячная подписка'**
  String get xaneoBenefitsMonthlyPlan;

  /// Цена годовой подписки
  ///
  /// In ru, this message translates to:
  /// **'999 ₽ в год'**
  String get xaneoBenefitsYearlyPrice;

  /// Цена ежемесячной подписки
  ///
  /// In ru, this message translates to:
  /// **'159 ₽ в месяц'**
  String get xaneoBenefitsMonthlyPrice;

  /// Текст экономии при годовой подписке
  ///
  /// In ru, this message translates to:
  /// **'Экономия 25%! Всего 83,25 ₽ в месяц'**
  String get xaneoBenefitsSavings;

  /// Кнопка оформления подписки
  ///
  /// In ru, this message translates to:
  /// **'Оформить XB'**
  String get xaneoBenefitsSubscribeButton;

  /// Кнопка закрытия модалки
  ///
  /// In ru, this message translates to:
  /// **'Закрыть'**
  String get xaneoBenefitsCloseButton;

  /// Сообщение об успешном оформлении годовой подписки
  ///
  /// In ru, this message translates to:
  /// **'Оформлена годовая подписка XB!'**
  String get xaneoBenefitsYearlySuccess;

  /// Сообщение об успешном оформлении ежемесячной подписки
  ///
  /// In ru, this message translates to:
  /// **'Оформлена ежемесячная подписка XB!'**
  String get xaneoBenefitsMonthlySuccess;

  /// Название избранного чата
  ///
  /// In ru, this message translates to:
  /// **'Избранное'**
  String get favoritesChat;

  /// Описание избранного чата
  ///
  /// In ru, this message translates to:
  /// **'Важные сообщения и файлы'**
  String get favoritesChatDescription;

  /// Сообщение о контенте в разработке
  ///
  /// In ru, this message translates to:
  /// **'Контент для \"{title}\" находится в разработке...'**
  String contentInDevelopmentMessage(String title);

  /// Название русского языка
  ///
  /// In ru, this message translates to:
  /// **'Русский'**
  String get russianLanguage;

  /// Приветственное сообщение в чате
  ///
  /// In ru, this message translates to:
  /// **'Привет! Это чат \"{chatName}\" 🎉'**
  String chatWelcomeMessage(String chatName);

  /// Пример форматирования текста 1
  ///
  /// In ru, this message translates to:
  /// **'Здесь можно использовать **жирный** и *курсив* и __подчёркнутый__ текст!'**
  String get formattingExample1;

  /// Пример форматирования текста 2
  ///
  /// In ru, this message translates to:
  /// **'А также ~~зачёркнутый~~ и `код` 💻'**
  String get formattingExample2;

  /// Триггер для приветственного ответа
  ///
  /// In ru, this message translates to:
  /// **'привет'**
  String get greetingTrigger;

  /// Ответ на приветствие
  ///
  /// In ru, this message translates to:
  /// **'Привет! Как дела?'**
  String get greetingResponse;

  /// Сообщение о нереализованной отправке файлов
  ///
  /// In ru, this message translates to:
  /// **'Отправка файлов пока не реализована'**
  String get fileSendingNotImplemented;

  /// Статус был онлайн недавно
  ///
  /// In ru, this message translates to:
  /// **'был(а) недавно'**
  String get wasOnlineRecently;

  /// Подсказка для поля ввода сообщения
  ///
  /// In ru, this message translates to:
  /// **'Сообщение'**
  String get messageHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'ko',
    'pt',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
