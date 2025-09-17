// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'XaneoMobile';

  @override
  String get welcomeTitle => 'مرحباً بك في Xaneo';

  @override
  String get welcomeDescription =>
      'Xaneo - الآن في تطبيق الهاتف المحمول! لم يكن Xaneo أبداً بهذه السهولة والسرعة.';

  @override
  String get getStartedButton => 'أنا مهتم بالفعل';

  @override
  String get connectingToServer => 'جاري الاتصال بالخادم...';

  @override
  String version(String version) {
    return 'الإصدار: $version';
  }

  @override
  String httpError(int code) {
    return 'خطأ: HTTP $code';
  }

  @override
  String connectionError(String error) {
    return 'خطأ في الاتصال: $error';
  }

  @override
  String get updateAvailable => 'تحديث متاح!';

  @override
  String get updateDialogTitle => 'تحديث متاح!';

  @override
  String updateDialogMessage(String currentVersion, String latestVersion) {
    return 'إصدارك الحالي هو $currentVersion، والإصدار الجديد هو $latestVersion';
  }

  @override
  String get updateDialogDescription =>
      'يمكنك التحديث عبر Google Play أو RuStore أو من الموقع الرسمي لـ Xaneo.';

  @override
  String get updateButton => 'تحديث';

  @override
  String get cancelButton => 'إلغاء';

  @override
  String get selectUpdateSource => 'اختر مصدر التحديث:';

  @override
  String get settings => 'الإعدادات';

  @override
  String get about => 'حول التطبيق';

  @override
  String get help => 'المساعدة';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get notificationsDescription => 'تلقي إشعارات حول الميزات الجديدة';

  @override
  String get darkTheme => 'الوضع المظلم';

  @override
  String get darkThemeDescription => 'استخدام المظهر المظلم';

  @override
  String fontSize(int size) {
    return 'حجم الخط: $size';
  }

  @override
  String get appVersion => 'إصدار التطبيق';

  @override
  String get messengerDemoMode => 'وضع العرض التوضيحي للمرسل';

  @override
  String get language => 'اللغة';

  @override
  String get languageDescription => 'اختر لغة الواجهة';

  @override
  String get welcomeMessage => 'ممتاز! أهلاً وسهلاً!';

  @override
  String get privacyTitle => 'جميع بياناتك آمنة';

  @override
  String get privacyDescription =>
      'جميع الرسائل في XaneoConnect محمية بالتشفير من الطرف إلى الطرف. لا يعرف Xaneo محتواها أبداً.';

  @override
  String get continueButton => 'لنتابع';

  @override
  String get dataStorageTitle => 'جميع مراكز بيانات Xaneo موجودة في روسيا';

  @override
  String get dataStorageDescription =>
      'بياناتك لا تغادر البلاد أبداً ويتم تخزينها في مراكز بيانات آمنة.';

  @override
  String get finishButton => 'إنهاء';

  @override
  String get setupCompleted => 'تم إكمال الإعداد!';

  @override
  String get loginFormTitle => 'دعنا ندخل';

  @override
  String get registerFormTitle => 'دعنا نبدأ';

  @override
  String get registerNameSubtitle => 'ما اسمك؟';

  @override
  String get nameFieldHint => 'اسمك';

  @override
  String get nextButton => 'التالي';

  @override
  String get skipButton => 'تخطي';

  @override
  String get registerBirthdateSubtitle => 'متى ولدت؟';

  @override
  String get selectDate => 'اختر التاريخ';

  @override
  String get ageRestrictionsLink => 'ما هي القيود العمرية؟';

  @override
  String get ageRestrictionsTitle => 'يمكن التسجيل من عمر 14 سنة';

  @override
  String get ageRestrictionsDescription =>
      'يمكنك التسجيل في خدمتنا إذا كان عمرك 14 سنة أو أكثر';

  @override
  String get gotIt => 'فهمت';

  @override
  String get registerNicknameSubtitle => 'اختر اسم مستخدم';

  @override
  String get nicknameFieldHint => 'اسم المستخدم الخاص بك';

  @override
  String get nicknameHelpLink => 'لا تستطيع التفكير في اسم مستخدم؟';

  @override
  String get registerEmailSubtitle => 'أدخل بريدك الإلكتروني';

  @override
  String get emailFieldHint => 'بريدك الإلكتروني';

  @override
  String get supportedEmailProvidersLink =>
      'ما هي مقدمو البريد الإلكتروني المدعومون؟';

  @override
  String get supportedEmailProvidersTitle =>
      'مقدمو البريد الإلكتروني المدعومون';

  @override
  String get supportedEmailProvidersDescription =>
      'يدعم Gmail وOutlook وYandex وMail.ru وخدمات البريد الإلكتروني الشائعة الأخرى.';

  @override
  String get emailFormatError => 'تنسيق عنوان البريد الإلكتروني غير صحيح';

  @override
  String get emailUnsupportedError => 'خدمة البريد الإلكتروني هذه غير مدعومة';

  @override
  String get checkingEmail => 'جاري التحقق من البريد الإلكتروني...';

  @override
  String get emailAvailable => 'البريد الإلكتروني متاح';

  @override
  String get emailTakenError => 'هذا البريد الإلكتروني مأخوذ بالفعل';

  @override
  String get emailServerError =>
      'خطأ في التحقق من البريد الإلكتروني. حاول مرة أخرى لاحقاً';

  @override
  String get verifyEmailTitle => 'تحقق من بريدك الإلكتروني';

  @override
  String get verifyEmailDescription =>
      'أرسلنا رمزاً مكوناً من 6 أرقام إلى بريدك الإلكتروني. أدخله للتأكيد.';

  @override
  String get verificationCodeHint => 'رمز التحقق';

  @override
  String get verifyButton => 'تحقق';

  @override
  String get registerPasswordSubtitle => 'أنشئ كلمة مرور';

  @override
  String get registerPasswordFieldHint => 'أدخل كلمة المرور';

  @override
  String get passwordInvalidCharsError =>
      'يمكن أن تحتوي كلمة المرور على أحرف لاتينية وأرقام وعلامات ترقيم فقط';

  @override
  String get passwordWeakError =>
      'كلمة المرور ضعيفة جداً. استخدم الحروف والأرقام والرموز الخاصة';

  @override
  String get passwordMediumWarning => 'كلمة مرور متوسطة القوة. نوصي بالتقوية';

  @override
  String get passwordStrongSuccess => 'كلمة مرور قوية';

  @override
  String get nicknameGeneratorTitle =>
      'سيتم إنشاء اسم المستخدم الخاص بك تلقائياً';

  @override
  String get nicknameGeneratorDescription =>
      'يمكنك تغيير اسم المستخدم في أي وقت';

  @override
  String get closeButton => 'إغلاق';

  @override
  String get loginFieldHint => 'اسم المستخدم';

  @override
  String get passwordFieldHint => 'كلمة المرور';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get fillAllFields => 'يرجى ملء جميع الحقول';

  @override
  String get loggingIn => 'جاري تسجيل الدخول...';

  @override
  String welcomeUser(String username) {
    return 'مرحباً، $username!';
  }

  @override
  String get invalidCredentials =>
      'بيانات الاعتماد غير صحيحة. تحقق من اسم المستخدم وكلمة المرور.';

  @override
  String get serverError => 'خطأ في الخادم. يرجى المحاولة لاحقاً.';

  @override
  String get connectionErrorLogin =>
      'خطأ في الاتصال. تحقق من اتصالك بالإنترنت.';

  @override
  String get noAccount => 'ليس لديك حساب؟';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get forgotPasswordDescription =>
      'أدخل اسم المستخدم وسنرسل لك رابط الوصول إلى حسابك عبر البريد الإلكتروني.';

  @override
  String get sendLinkButton => 'إرسال الرابط';

  @override
  String get checkEmailTitle => 'تحقق من بريدك الإلكتروني';

  @override
  String checkEmailDescription(String email) {
    return 'يرجى التحقق من صندوق الوارد $email واتباع الرابط للوصول إلى حسابك.';
  }

  @override
  String get forgotPasswordCodeDescription =>
      'أدخل رمز الوصول الذي تم إرساله إلى البريد الإلكتروني المرتبط بحسابك';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get registrationUnavailable => 'التسجيل غير متاح حالياً';

  @override
  String get passwordRecoveryUnavailable =>
      'استرداد كلمة المرور غير متاح حالياً';

  @override
  String get nicknameMinLengthError =>
      'يجب أن يكون طول اسم المستخدم خمسة أحرف على الأقل';

  @override
  String get nicknameLatinOnlyError =>
      'يمكن أن يحتوي اسم المستخدم على أحرف لاتينية وأرقام ونقاط وشرطة سفلية فقط';

  @override
  String get nicknameStartError =>
      'لا يمكن أن يبدأ اسم المستخدم بشرطة سفلية أو رقم أو نقطة';

  @override
  String get nicknameEndError =>
      'لا يمكن أن ينتهي اسم المستخدم بشرطة سفلية أو نقطة';

  @override
  String get checkingNickname => 'جاري التحقق من اسم المستخدم...';

  @override
  String get nicknameAvailable => 'اسم المستخدم متاح';

  @override
  String get nicknameTakenError => 'اسم المستخدم مأخوذ بالفعل';

  @override
  String get nicknameServerError =>
      'خطأ في التحقق من اسم المستخدم. يرجى المحاولة لاحقاً';

  @override
  String get nicknameMaxLengthError => 'حد أقصى 30 حرفًا';

  @override
  String get nameEmptyError => 'لا يمكن أن يكون الاسم فارغًا';

  @override
  String get confirmPasswordTitle => 'تأكيد كلمة المرور';

  @override
  String get confirmPasswordDescription => 'أدخل كلمة المرور مرة أخرى للتأكيد';

  @override
  String get confirmPasswordFieldHint => 'كرر كلمة المرور';

  @override
  String get passwordMismatchError => 'كلمات المرور غير متطابقة';

  @override
  String get confirmButton => 'تأكيد';

  @override
  String get registerAvatarSubtitle => 'اختر صورة شخصية';

  @override
  String get addAvatarHint => 'اضغط + لإضافة صورة';

  @override
  String get avatarTapToSelect => 'اضغط لاختيار صورة';

  @override
  String get photoPermissionTitle => 'السماح بالوصول إلى الصور';

  @override
  String get photoPermissionDescription =>
      'اسمح لنا بالوصول إلى صورك حتى تتمكن من اختيار صورة شخصية لملفك الشخصي';

  @override
  String get allowAccessButton => 'السماح بالوصول';

  @override
  String get notNowButton => 'ليس الآن';

  @override
  String get avatarCropperTitle => 'إعداد الصورة الرمزية';

  @override
  String get doneButton => 'تم';

  @override
  String get cropInstructions =>
      'اسحب الدائرة لتحديد المنطقة • استخدم النقاط لتغيير الحجم';

  @override
  String get changeAvatar => 'تغيير الصورة الرمزية';

  @override
  String get profilePreviewTitle => 'هكذا سيبدو ملفك الشخصي';

  @override
  String get goodMorning => 'صباح الخير';

  @override
  String get goodDay => 'مساء الخير';

  @override
  String get goodEvening => 'مساء الخير';

  @override
  String get goodNight => 'تصبح على خير';

  @override
  String get backButton => 'رجوع';

  @override
  String get editName => 'تعديل الاسم';

  @override
  String get editNickname => 'تعديل اللقب';

  @override
  String get editPhoto => 'تعديل الصورة';

  @override
  String get saveButton => 'حفظ';

  @override
  String get deleteButton => 'حذف';

  @override
  String get deletePhoto => 'حذف الصورة';

  @override
  String get selectFromGallery => 'اختيار من المعرض';

  @override
  String get enterNameHint => 'أدخل اسمك';

  @override
  String get enterNicknameHint => 'أدخل اسم مستعار';

  @override
  String get termsAndConditionsTitle => 'الشروط والأحكام';

  @override
  String get termsOfUse => 'شروط الاستخدام';

  @override
  String get userAgreement => 'اتفاقية المستخدم';

  @override
  String acceptTermsText(String termsOfUse, String userAgreement) {
    return 'لإكمال التسجيل وبدء استخدام Xaneo، يجب عليك قبول $termsOfUse و $userAgreement.\n\nتحتوي هذه الوثائق على معلومات مهمة حول قواعد استخدام الخدمة وحماية البيانات والتزامات الطرفين.\n\nبقبول هذه الشروط، تؤكد أنك قرأت ووافقت على الالتزام بقواعد المنصة.\n\nبدون قبول هذه الشروط، لا يمكن إكمال التسجيل وسيكون الوصول إلى الخدمة مقيداً.';
  }

  @override
  String get acceptButton => 'موافق';

  @override
  String get declineButton => 'رفض';

  @override
  String verificationCodeSent(String email, int seconds) {
    return 'تم إرسال الرمز إلى $email. صالح لمدة $seconds ثانية';
  }

  @override
  String get codeDeliveryError => 'خطأ في إرسال الرمز';

  @override
  String get serverErrorCodeDelivery => 'خطأ في الخادم أثناء إرسال الرمز';

  @override
  String get connectionErrorCodeDelivery => 'خطأ في الاتصال أثناء إرسال الرمز';

  @override
  String get emailVerificationSuccess =>
      'تم التحقق من البريد الإلكتروني بنجاح!';

  @override
  String get invalidVerificationCode =>
      'رمز التحقق غير صحيح. تحقق من الرمز وحاول مرة أخرى';

  @override
  String get emailNotFound =>
      'البريد الإلكتروني غير موجود. حاول التسجيل مرة أخرى';

  @override
  String get verificationCodeExpired =>
      'انتهت صلاحية رمز التحقق. اطلب رمزاً جديداً';

  @override
  String get serverErrorCodeVerification =>
      'خطأ في الخادم أثناء التحقق من الرمز. حاول لاحقاً';

  @override
  String get connectionErrorCodeVerification =>
      'خطأ في الاتصال أثناء التحقق من الرمز';

  @override
  String get permissionDeniedSettings =>
      'تم رفض الإذن نهائياً. قم بتفعيله في الإعدادات';

  @override
  String get avatarCropped => 'تم قص الصورة الرمزية وحفظها!';

  @override
  String get imageSelectionError => 'خطأ في اختيار الصورة';

  @override
  String get permissionDeniedOpenSettings =>
      'تم رفض الإذن نهائياً. افتح الإعدادات للتفعيل';

  @override
  String get photoPermissionError => 'فشل في الحصول على إذن الوصول للصور';

  @override
  String get registrationCompleted => 'اكتمل التسجيل!';

  @override
  String get officialXaneoWebsite => 'الموقع الرسمي لـ Xaneo';

  @override
  String twoFactorAuthMessage(String email) {
    return 'تم تفعيل المصادقة الثنائية على هذا الحساب. أدخل رمز التحقق الذي تم إرساله إلى $email';
  }

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get messengerDemo => 'تجربة المراسلة';

  @override
  String get messenger => 'المراسلة';

  @override
  String get messengerDescription =>
      'مراسل بسيط وسريع وآمن بتصميم عصري وواجهة سهلة الاستخدام.';

  @override
  String get profileDemo => 'تجربة الملف الشخصي';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get personalInfo => 'المعلومات الشخصية';

  @override
  String get name => 'الاسم';

  @override
  String get nameHint => 'الاسم';

  @override
  String get birthDate => 'تاريخ الميلاد';

  @override
  String get nickname => 'الاسم المستعار';

  @override
  String get nicknameHint => 'الاسم المستعار';

  @override
  String get phone => 'الهاتف';

  @override
  String get phoneHint => 'رقم الهاتف';

  @override
  String get settingsSection => 'الإعدادات';

  @override
  String get chatSettings => 'إعدادات الدردشة';

  @override
  String get chatSettingsDescription => 'ستكون إعدادات الدردشة هنا...';

  @override
  String get privacySettings => 'الخصوصية والسرية';

  @override
  String get privacySettingsDescription => 'ستكون إعدادات الخصوصية هنا...';

  @override
  String get securitySettings => 'الأمان';

  @override
  String get securityAuthentication => 'المصادقة';

  @override
  String get securityChangePassword => 'تغيير كلمة المرور';

  @override
  String get securityTwoFactorAuth => 'المصادقة الثنائية';

  @override
  String get twoFactorEnabled => 'مفعل';

  @override
  String get twoFactorDisabled => 'معطل';

  @override
  String get securityChangeEmail => 'تغيير البريد الإلكتروني';

  @override
  String get securityPasscode => 'رمز المرور';

  @override
  String get securitySettingsDescription => 'ستكون إعدادات الأمان هنا...';

  @override
  String get passwordEmptyError => 'لا يمكن أن تكون كلمة المرور فارغة';

  @override
  String get passwordTooShortError =>
      'يجب أن تحتوي كلمة المرور على 5 أحرف على الأقل';

  @override
  String get passwordEnterCurrentHint => 'أدخل كلمة المرور الحالية للتأكيد';

  @override
  String get passwordCurrentHint => 'كلمة المرور الحالية';

  @override
  String get passwordConfirmNewHint => 'أكد كلمة المرور الجديدة';

  @override
  String get passwordDontMatchError => 'كلمات المرور غير متطابقة';

  @override
  String get passwordNewTitle => 'كلمة مرور جديدة';

  @override
  String get passwordNewHint => 'كلمة مرور جديدة';

  @override
  String get passwordConfirmHint => 'أكد كلمة المرور';

  @override
  String get passwordChangedSuccess => 'تم تغيير كلمة المرور بنجاح';

  @override
  String get passwordNextButton => 'التالي';

  @override
  String get passwordSaveButton => 'حفظ';

  @override
  String get powerSettings => 'توفير الطاقة';

  @override
  String get powerSettingsDescription => 'ستكون إعدادات توفير الطاقة هنا...';

  @override
  String get languageSelect => 'اللغة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get ready => 'جاهز';

  @override
  String contentInDevelopment(String title) {
    return 'المحتوى الخاص بـ \"$title\" قيد التطوير...';
  }

  @override
  String get sessions => 'الجلسات';

  @override
  String get support => 'الدعم';

  @override
  String get xaneoBenefits => 'XaneoBenefits';

  @override
  String get messengerFeatures => 'ميزات وضع العرض التوضيحي:';

  @override
  String get secureEncryption => 'تشفير آمن للرسائل';

  @override
  String get instantDelivery => 'التسليم الفوري';

  @override
  String get deviceSync => 'المزامنة بين الأجهزة';

  @override
  String get mediaSupport => 'دعم الملفات المتعددة الوسائط';

  @override
  String get sessionsContent => 'ستعرض هنا الجلسات النشطة لحسابك...';

  @override
  String get activeDevices => 'الأجهزة النشطة';

  @override
  String get currentDevice => 'الجهاز الحالي';

  @override
  String get terminateSession => 'إنهاء الجلسة';

  @override
  String get terminateAllOtherSessions => 'إنهاء جميع الجلسات الأخرى';

  @override
  String get sessionLocation => 'الموقع';

  @override
  String get sessionLastActive => 'آخر نشاط';

  @override
  String get sessionBrowser => 'المتصفح';

  @override
  String get sessionPlatform => 'المنصة';

  @override
  String get confirmTerminateSession =>
      'هل أنت متأكد من رغبتك في إنهاء هذه الجلسة؟';

  @override
  String get confirmTerminateAllSessions =>
      'هل أنت متأكد من رغبتك في إنهاء جميع الجلسات الأخرى؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get sessionIPAddress => 'عنوان IP';

  @override
  String get supportContent =>
      'لدينا حمل كبير جداً على خدمة الدعم الخاصة بنا. نسعى للرد بأسرع ما يمكن، ولكن حالياً قد يصل وقت الانتظار إلى 24 ساعة. يرجى الاتصال بنا وسنساعدك بالتأكيد في حل مشكلتك.';

  @override
  String get contactSupport => 'اتصال';

  @override
  String get xaneoBenefitsContent =>
      'XaneoBenefits هو برنامج ولاء لمستخدمي Xaneo. احصل على مكافآت وميزات حصرية...';

  @override
  String get more => 'المزيد';

  @override
  String get chatPreview => 'معاينة الدردشة';

  @override
  String get textSize => 'حجم النص';

  @override
  String textSizeValue(String size) {
    return 'الحجم: $size';
  }

  @override
  String get textExample => 'مثال على النص';

  @override
  String get useDarkTheme => 'استخدام المظهر الداكن';

  @override
  String get chatWallpapers => 'خلفيات الدردشة';

  @override
  String get messageColors => 'ألوان الرسائل';

  @override
  String get myMessages => 'رسائلي';

  @override
  String get receivedMessages => 'الرسائل المستلمة';

  @override
  String get messageEmojis => 'الرموز التعبيرية للرسائل';

  @override
  String get selectedEmoji => 'الرمز التعبيري المحدد:';

  @override
  String get chooseWallpaper => 'اختر خلفية:';

  @override
  String get demoMessage1 => 'مرحبا! كيف حالك؟';

  @override
  String get demoMessage2 => 'كل شيء رائع! وأنت؟';

  @override
  String get demoMessage3 => 'أنا أيضاً بخير، شكراً 😊';

  @override
  String get demoDateSeparator => 'اليوم';

  @override
  String get onlineStatus => 'متصل';

  @override
  String get chatTheme => 'موضوع الدردشة';

  @override
  String get privacySettingsTitle => 'الخصوصية والأمان';

  @override
  String get privacyCommunications => 'الاتصالات';

  @override
  String get privacyProfileVisibility => 'رؤية الملف الشخصي';

  @override
  String get privacyWhoCanMessage => 'الرسائل';

  @override
  String get privacyWhoCanRecordVoice => 'الرسائل الصوتية';

  @override
  String get privacyWhoCanCall => 'المكالمات';

  @override
  String get privacyWhoCanSendVideo => 'رسائل الفيديو';

  @override
  String get privacyWhoCanSendLinks => 'الروابط';

  @override
  String get privacyWhoCanInvite => 'الدعوات';

  @override
  String get privacyWhoSeesNickname => 'اسم المستخدم';

  @override
  String get privacyWhoSeesAvatar => 'الصورة الرمزية';

  @override
  String get privacyWhoSeesBirthday => 'تاريخ الميلاد';

  @override
  String get privacyWhoSeesOnlineTime => 'وقت الاتصال';

  @override
  String get privacyAll => 'الجميع';

  @override
  String get privacyContacts => 'جهات الاتصال';

  @override
  String get privacyNobody => 'لا أحد';

  @override
  String get passwordWeak => 'ضعيف';

  @override
  String get passwordMedium => 'متوسط';

  @override
  String get passwordStrong => 'قوي';

  @override
  String twoFactorEnableDescription(String email) {
    return 'لتمكين المصادقة الثنائية، أدخل رمز التحقق المرسل إلى $email';
  }

  @override
  String twoFactorDisableDescription(String email) {
    return 'لتعطيل المصادقة الثنائية، أدخل رمز التحقق المرسل إلى $email';
  }

  @override
  String get changeEmailVerificationDescription =>
      'لتغيير بريدك الإلكتروني، أدخل رمز التحقق المرسل إلى demouser@example.com';

  @override
  String get newEmailTitle => 'بريد إلكتروني جديد';

  @override
  String get newEmailDescription => 'أدخل عنوان البريد الإلكتروني الجديد';

  @override
  String get changeEmailButton => 'تغيير';

  @override
  String get verifyNewEmailTitle => 'تحقق من البريد الإلكتروني الجديد';

  @override
  String verifyNewEmailDescription(String email) {
    return 'للتحقق من بريدك الإلكتروني الجديد $email، أدخل رمز التحقق المرسل إلى هذا العنوان';
  }

  @override
  String get verifyNewEmailButton => 'تحقق';

  @override
  String get passcodeVerificationTitle => 'تفعيل رمز المرور';

  @override
  String passcodeVerificationDescription(String email) {
    return 'لتفعيل حماية رمز المرور، أدخل رمز التحقق المرسل إلى $email';
  }

  @override
  String get passcodeVerificationButton => 'تفعيل';

  @override
  String get setPasscodeTitle => 'تعيين رمز المرور';

  @override
  String get setPasscodeDescription =>
      'أنشئ رمز مرور مكون من 4 أرقام للحماية الإضافية';

  @override
  String get passcodeHint => 'أدخل 4 أرقام';

  @override
  String get setPasscodeButton => 'تعيين';

  @override
  String get xaneoBenefitsModalTitle => 'XaneoBenefits (XB)';

  @override
  String get xaneoBenefitsModalDescription => 'اشتراك Xaneo المميز';

  @override
  String get xaneoBenefitsSelectPlan => 'اختر خطة اشتراكك:';

  @override
  String get xaneoBenefitsYearlyPlan => 'الاشتراك السنوي';

  @override
  String get xaneoBenefitsMonthlyPlan => 'الاشتراك الشهري';

  @override
  String get xaneoBenefitsYearlyPrice => 'د.إ999 سنوياً';

  @override
  String get xaneoBenefitsMonthlyPrice => 'د.إ159 شهرياً';

  @override
  String get xaneoBenefitsSavings => 'توفير 25%! فقط د.إ83,25 شهرياً';

  @override
  String get xaneoBenefitsSubscribeButton => 'اشتراك في XB';

  @override
  String get xaneoBenefitsCloseButton => 'إغلاق';

  @override
  String get xaneoBenefitsYearlySuccess => 'تم تفعيل الاشتراك السنوي XB!';

  @override
  String get xaneoBenefitsMonthlySuccess => 'تم تفعيل الاشتراك الشهري XB!';

  @override
  String get favoritesChat => 'المفضلة';

  @override
  String get favoritesChatDescription => 'الرسائل والملفات المهمة';

  @override
  String contentInDevelopmentMessage(String title) {
    return 'المحتوى لـ \"$title\" قيد التطوير...';
  }

  @override
  String get russianLanguage => 'الروسية';

  @override
  String chatWelcomeMessage(String chatName) {
    return 'مرحبا! هذه دردشة \"$chatName\" 🎉';
  }

  @override
  String get formattingExample1 =>
      'هنا يمكنك استخدام نص **عريض** و *مائل* و __مسطر__!';

  @override
  String get formattingExample2 => 'وأيضاً ~~مشطوب~~ و `كود` 💻';

  @override
  String get greetingTrigger => 'مرحبا';

  @override
  String get greetingResponse => 'مرحبا! كيف الحال؟';

  @override
  String get fileSendingNotImplemented => 'إرسال الملفات غير مطبق بعد';

  @override
  String get wasOnlineRecently => 'كان متصلاً مؤخراً';

  @override
  String get messageHint => 'رسالة';
}
