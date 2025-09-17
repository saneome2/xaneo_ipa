// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'XaneoMobile';

  @override
  String get welcomeTitle => '欢迎使用 Xaneo';

  @override
  String get welcomeDescription => 'Xaneo - 现在有移动应用程序了！Xaneo 从未如此便捷和快速。';

  @override
  String get getStartedButton => '我很感兴趣';

  @override
  String get connectingToServer => '正在连接服务器...';

  @override
  String version(String version) {
    return '版本：$version';
  }

  @override
  String httpError(int code) {
    return '错误：HTTP $code';
  }

  @override
  String connectionError(String error) {
    return '连接错误：$error';
  }

  @override
  String get updateAvailable => '有可用更新！';

  @override
  String get updateDialogTitle => '有可用更新！';

  @override
  String updateDialogMessage(String currentVersion, String latestVersion) {
    return '您的版本是 $currentVersion，新版本是 $latestVersion';
  }

  @override
  String get updateDialogDescription =>
      '您可以通过 Google Play、RuStore 或 Xaneo 官方网站进行更新。';

  @override
  String get updateButton => '更新';

  @override
  String get cancelButton => '取消';

  @override
  String get selectUpdateSource => '选择更新来源：';

  @override
  String get settings => '设置';

  @override
  String get about => '关于';

  @override
  String get help => '帮助';

  @override
  String get notifications => '通知';

  @override
  String get notificationsDescription => '接收新功能通知';

  @override
  String get darkTheme => '深色主题';

  @override
  String get darkThemeDescription => '使用深色外观';

  @override
  String fontSize(int size) {
    return '字体大小：$size';
  }

  @override
  String get appVersion => '应用版本';

  @override
  String get messengerDemoMode => '信使演示模式';

  @override
  String get language => '语言';

  @override
  String get languageDescription => '选择界面语言';

  @override
  String get welcomeMessage => '太好了！欢迎！';

  @override
  String get privacyTitle => '您的所有数据都是安全的';

  @override
  String get privacyDescription =>
      'XaneoConnect 中的所有消息都受到端到端加密保护。Xaneo 绝不会知道其内容。';

  @override
  String get continueButton => '让我们继续';

  @override
  String get dataStorageTitle => '所有 Xaneo 数据中心都位于俄罗斯';

  @override
  String get dataStorageDescription => '您的数据不会离开该国，并存储在安全的数据中心中。';

  @override
  String get finishButton => '完成';

  @override
  String get setupCompleted => '设置完成！';

  @override
  String get loginFormTitle => '让我们登录';

  @override
  String get registerFormTitle => '让我们开始';

  @override
  String get registerNameSubtitle => '您叫什么名字？';

  @override
  String get nameFieldHint => '您的姓名';

  @override
  String get nextButton => '下一步';

  @override
  String get skipButton => '跳过';

  @override
  String get registerBirthdateSubtitle => '您的出生日期是？';

  @override
  String get selectDate => '选择日期';

  @override
  String get ageRestrictionsLink => '年龄限制是什么？';

  @override
  String get ageRestrictionsTitle => '14岁即可注册';

  @override
  String get ageRestrictionsDescription => '如果您年满14岁，即可在我们的服务上注册';

  @override
  String get gotIt => '明白了';

  @override
  String get registerNicknameSubtitle => '选择昵称';

  @override
  String get nicknameFieldHint => '您的昵称';

  @override
  String get nicknameHelpLink => '想不出昵称？';

  @override
  String get registerEmailSubtitle => '输入电子邮箱';

  @override
  String get emailFieldHint => '您的电子邮箱';

  @override
  String get supportedEmailProvidersLink => '支持哪些邮箱提供商？';

  @override
  String get supportedEmailProvidersTitle => '支持的邮箱提供商';

  @override
  String get supportedEmailProvidersDescription =>
      '支持Gmail、Outlook、Yandex、Mail.ru等热门邮箱服务。';

  @override
  String get emailFormatError => '电子邮件地址格式无效';

  @override
  String get emailUnsupportedError => '不支持此邮箱服务';

  @override
  String get checkingEmail => '正在检查邮箱...';

  @override
  String get emailAvailable => '邮箱可用';

  @override
  String get emailTakenError => '此邮箱已被占用';

  @override
  String get emailServerError => '邮箱检查错误。请稍后再试';

  @override
  String get verifyEmailTitle => '验证您的邮箱';

  @override
  String get verifyEmailDescription => '我们已向您的邮箱发送了6位验证码。请输入以确认。';

  @override
  String get verificationCodeHint => '验证码';

  @override
  String get verifyButton => '验证';

  @override
  String get registerPasswordSubtitle => '创建密码';

  @override
  String get registerPasswordFieldHint => '输入密码';

  @override
  String get passwordInvalidCharsError => '密码只能包含拉丁字母、数字和标点符号';

  @override
  String get passwordWeakError => '密码太弱。使用字母、数字和特殊字符';

  @override
  String get passwordMediumWarning => '中等强度密码。建议加强';

  @override
  String get passwordStrongSuccess => '强密码';

  @override
  String get nicknameGeneratorTitle => '您的昵称将自动生成';

  @override
  String get nicknameGeneratorDescription => '您可以随时更改昵称';

  @override
  String get closeButton => '关闭';

  @override
  String get loginFieldHint => '用户名';

  @override
  String get passwordFieldHint => '密码';

  @override
  String get loginButton => '登录';

  @override
  String get fillAllFields => '请填写所有字段';

  @override
  String get loggingIn => '正在登录...';

  @override
  String welcomeUser(String username) {
    return '欢迎，$username！';
  }

  @override
  String get invalidCredentials => '凭据无效。请检查您的用户名和密码。';

  @override
  String get serverError => '服务器错误。请稍后再试。';

  @override
  String get connectionErrorLogin => '连接错误。请检查您的网络连接。';

  @override
  String get noAccount => '没有账户？';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get forgotPasswordDescription => '输入您的用户名，我们将通过电子邮件向您发送账户访问链接。';

  @override
  String get sendLinkButton => '发送链接';

  @override
  String get checkEmailTitle => '检查您的邮箱';

  @override
  String checkEmailDescription(String email) {
    return '请检查您的收件箱 $email 并点击链接访问您的账户。';
  }

  @override
  String get forgotPasswordCodeDescription => '输入发送到与您账户关联的邮箱的访问代码';

  @override
  String get alreadyHaveAccount => '已经有账户？';

  @override
  String get registrationUnavailable => '注册暂时不可用';

  @override
  String get passwordRecoveryUnavailable => '密码恢复暂时不可用';

  @override
  String get nicknameMinLengthError => '昵称长度必须至少为五个字符';

  @override
  String get nicknameLatinOnlyError => '昵称只能包含拉丁字母、数字、点和下划线';

  @override
  String get nicknameStartError => '昵称不能以下划线、数字或点开头';

  @override
  String get nicknameEndError => '昵称不能以下划线或句号结尾';

  @override
  String get checkingNickname => '正在检查昵称...';

  @override
  String get nicknameAvailable => '昵称可用';

  @override
  String get nicknameTakenError => '该昵称已被占用';

  @override
  String get nicknameServerError => '昵称检查错误，请稍后再试';

  @override
  String get nicknameMaxLengthError => '最多30个字符';

  @override
  String get nameEmptyError => '姓名不能为空';

  @override
  String get confirmPasswordTitle => '确认密码';

  @override
  String get confirmPasswordDescription => '请再次输入密码以确认';

  @override
  String get confirmPasswordFieldHint => '重复输入密码';

  @override
  String get passwordMismatchError => '密码不匹配';

  @override
  String get confirmButton => '确认';

  @override
  String get registerAvatarSubtitle => '选择头像';

  @override
  String get addAvatarHint => '点击 + 添加照片';

  @override
  String get avatarTapToSelect => '点击选择照片';

  @override
  String get photoPermissionTitle => '允许访问图片';

  @override
  String get photoPermissionDescription => '请允许我们访问您的图片，以便您可以为您的个人资料选择头像';

  @override
  String get allowAccessButton => '允许访问';

  @override
  String get notNowButton => '暂不';

  @override
  String get avatarCropperTitle => '头像设置';

  @override
  String get doneButton => '完成';

  @override
  String get cropInstructions => '拖动圆圈选择区域 • 使用点来调整大小';

  @override
  String get changeAvatar => '更换头像';

  @override
  String get profilePreviewTitle => '您的个人资料将如下所示';

  @override
  String get goodMorning => '早上好';

  @override
  String get goodDay => '下午好';

  @override
  String get goodEvening => '晚上好';

  @override
  String get goodNight => '晚安';

  @override
  String get backButton => '返回';

  @override
  String get editName => '编辑姓名';

  @override
  String get editNickname => '编辑昵称';

  @override
  String get editPhoto => '编辑照片';

  @override
  String get saveButton => '保存';

  @override
  String get deleteButton => '删除';

  @override
  String get deletePhoto => '删除照片';

  @override
  String get selectFromGallery => '从相册选择';

  @override
  String get enterNameHint => '输入您的姓名';

  @override
  String get enterNicknameHint => '输入昵称';

  @override
  String get termsAndConditionsTitle => '条款和条件';

  @override
  String get termsOfUse => '使用条款';

  @override
  String get userAgreement => '用户协议';

  @override
  String acceptTermsText(String termsOfUse, String userAgreement) {
    return '要完成注册并开始使用 Xaneo，您必须接受我们的$termsOfUse和$userAgreement。\n\n这些文档包含有关服务使用规则、数据保护和双方义务的重要信息。\n\n通过接受这些条款，您确认已阅读并同意遵守平台规则。\n\n如果不接受这些条款，注册将无法完成，对服务的访问将受到限制。';
  }

  @override
  String get acceptButton => '接受';

  @override
  String get declineButton => '拒绝';

  @override
  String verificationCodeSent(String email, int seconds) {
    return '验证码已发送至 $email。有效期 $seconds 秒';
  }

  @override
  String get codeDeliveryError => '验证码发送错误';

  @override
  String get serverErrorCodeDelivery => '发送验证码时服务器错误';

  @override
  String get connectionErrorCodeDelivery => '发送验证码时连接错误';

  @override
  String get emailVerificationSuccess => '邮箱验证成功！';

  @override
  String get invalidVerificationCode => '验证码无效。请检查验证码后重试';

  @override
  String get emailNotFound => '邮箱未找到。请重新注册';

  @override
  String get verificationCodeExpired => '验证码已过期。请请求新的验证码';

  @override
  String get serverErrorCodeVerification => '验证验证码时服务器错误。请稍后重试';

  @override
  String get connectionErrorCodeVerification => '验证验证码时连接错误';

  @override
  String get permissionDeniedSettings => '权限被永久拒绝。请在设置中启用';

  @override
  String get avatarCropped => '头像已裁剪并保存！';

  @override
  String get imageSelectionError => '选择图片时出错';

  @override
  String get permissionDeniedOpenSettings => '权限被永久拒绝。请打开设置启用';

  @override
  String get photoPermissionError => '无法获取照片访问权限';

  @override
  String get registrationCompleted => '注册完成！';

  @override
  String get officialXaneoWebsite => 'Xaneo官方网站';

  @override
  String twoFactorAuthMessage(String email) {
    return '此账户已启用双重身份验证。请输入发送到$email的验证码';
  }

  @override
  String get selectLanguage => '选择语言';

  @override
  String get messengerDemo => '信使演示';

  @override
  String get messenger => '信使';

  @override
  String get messengerDescription => '简单、快速、安全的现代设计和用户友好界面的信使。';

  @override
  String get profileDemo => '个人资料演示';

  @override
  String get profile => '个人资料';

  @override
  String get personalInfo => '个人信息';

  @override
  String get name => '姓名';

  @override
  String get nameHint => '姓名';

  @override
  String get birthDate => '出生日期';

  @override
  String get nickname => '昵称';

  @override
  String get nicknameHint => '昵称';

  @override
  String get phone => '电话';

  @override
  String get phoneHint => '电话号码';

  @override
  String get settingsSection => '设置';

  @override
  String get chatSettings => '聊天设置';

  @override
  String get chatSettingsDescription => '聊天设置将在这里显示...';

  @override
  String get privacySettings => '隐私和保密';

  @override
  String get privacySettingsDescription => '隐私设置将在这里显示...';

  @override
  String get securitySettings => '安全';

  @override
  String get securityAuthentication => '身份验证';

  @override
  String get securityChangePassword => '更改密码';

  @override
  String get securityTwoFactorAuth => '双因素身份验证';

  @override
  String get twoFactorEnabled => '已启用';

  @override
  String get twoFactorDisabled => '已禁用';

  @override
  String get securityChangeEmail => '更改邮箱';

  @override
  String get securityPasscode => '密码';

  @override
  String get securitySettingsDescription => '安全设置将在这里显示...';

  @override
  String get passwordEmptyError => '密码不能为空';

  @override
  String get passwordTooShortError => '密码必须至少包含5个字符';

  @override
  String get passwordEnterCurrentHint => '输入当前密码进行确认';

  @override
  String get passwordCurrentHint => '当前密码';

  @override
  String get passwordConfirmNewHint => '确认新密码';

  @override
  String get passwordDontMatchError => '密码不匹配';

  @override
  String get passwordNewTitle => '新密码';

  @override
  String get passwordNewHint => '新密码';

  @override
  String get passwordConfirmHint => '确认密码';

  @override
  String get passwordChangedSuccess => '密码修改成功';

  @override
  String get passwordNextButton => '下一步';

  @override
  String get passwordSaveButton => '保存';

  @override
  String get powerSettings => '省电';

  @override
  String get powerSettingsDescription => '省电设置将在这里显示...';

  @override
  String get languageSelect => '语言';

  @override
  String get cancel => '取消';

  @override
  String get ready => '完成';

  @override
  String contentInDevelopment(String title) {
    return '\"$title\"的内容正在开发中...';
  }

  @override
  String get sessions => '会话';

  @override
  String get support => '支持';

  @override
  String get xaneoBenefits => 'XaneoBenefits';

  @override
  String get messengerFeatures => '演示模式功能：';

  @override
  String get secureEncryption => '消息安全加密';

  @override
  String get instantDelivery => '即时传递';

  @override
  String get deviceSync => '设备间同步';

  @override
  String get mediaSupport => '媒体文件支持';

  @override
  String get sessionsContent => '您账户的活跃会话将在此处显示...';

  @override
  String get activeDevices => '活跃设备';

  @override
  String get currentDevice => '当前设备';

  @override
  String get terminateSession => '终止会话';

  @override
  String get terminateAllOtherSessions => '终止所有其他会话';

  @override
  String get sessionLocation => '位置';

  @override
  String get sessionLastActive => '最后活动';

  @override
  String get sessionBrowser => '浏览器';

  @override
  String get sessionPlatform => '平台';

  @override
  String get confirmTerminateSession => '您确定要终止此会话吗？';

  @override
  String get confirmTerminateAllSessions => '您确定要终止所有其他会话吗？此操作无法撤销。';

  @override
  String get sessionIPAddress => 'IP 地址';

  @override
  String get supportContent =>
      '我们的支持服务负载非常大。我们努力尽快回复，但目前等待时间可能长达24小时。请联系我们，我们一定会帮助您解决问题。';

  @override
  String get contactSupport => '联系';

  @override
  String get xaneoBenefitsContent => 'XaneoBenefits是Xaneo用户的忠诚度计划。获得奖励和独家功能...';

  @override
  String get more => '更多';

  @override
  String get chatPreview => '聊天预览';

  @override
  String get textSize => '文字大小';

  @override
  String textSizeValue(String size) {
    return '大小: $size';
  }

  @override
  String get textExample => '文字示例';

  @override
  String get useDarkTheme => '使用深色外观';

  @override
  String get chatWallpapers => '聊天壁纸';

  @override
  String get messageColors => '消息颜色';

  @override
  String get myMessages => '我的消息';

  @override
  String get receivedMessages => '收到的消息';

  @override
  String get messageEmojis => '消息表情符号';

  @override
  String get selectedEmoji => '选中的表情符号:';

  @override
  String get chooseWallpaper => '选择壁纸:';

  @override
  String get demoMessage1 => '你好！怎么样？';

  @override
  String get demoMessage2 => '一切都很好！你呢？';

  @override
  String get demoMessage3 => '我也很好，谢谢 😊';

  @override
  String get demoDateSeparator => '今天';

  @override
  String get onlineStatus => '在线';

  @override
  String get chatTheme => '聊天主题';

  @override
  String get privacySettingsTitle => '隐私与安全';

  @override
  String get privacyCommunications => '通讯';

  @override
  String get privacyProfileVisibility => '个人资料可见性';

  @override
  String get privacyWhoCanMessage => '消息';

  @override
  String get privacyWhoCanRecordVoice => '语音消息';

  @override
  String get privacyWhoCanCall => '通话';

  @override
  String get privacyWhoCanSendVideo => '视频消息';

  @override
  String get privacyWhoCanSendLinks => '链接';

  @override
  String get privacyWhoCanInvite => '邀请';

  @override
  String get privacyWhoSeesNickname => '昵称';

  @override
  String get privacyWhoSeesAvatar => '头像';

  @override
  String get privacyWhoSeesBirthday => '生日';

  @override
  String get privacyWhoSeesOnlineTime => '在线时间';

  @override
  String get privacyAll => '所有人';

  @override
  String get privacyContacts => '联系人';

  @override
  String get privacyNobody => '没有人';

  @override
  String get passwordWeak => '弱';

  @override
  String get passwordMedium => '中等';

  @override
  String get passwordStrong => '强';

  @override
  String twoFactorEnableDescription(String email) {
    return '要启用双因素认证，请输入发送到 $email 的验证码';
  }

  @override
  String twoFactorDisableDescription(String email) {
    return '要禁用双因素认证，请输入发送到 $email 的验证码';
  }

  @override
  String get changeEmailVerificationDescription =>
      '要更改您的邮箱，请输入发送到 demouser@example.com 的验证码';

  @override
  String get newEmailTitle => '新邮箱';

  @override
  String get newEmailDescription => '输入新的邮箱地址';

  @override
  String get changeEmailButton => '更改';

  @override
  String get verifyNewEmailTitle => '验证新邮箱';

  @override
  String verifyNewEmailDescription(String email) {
    return '要验证您的新邮箱$email，请输入发送到此地址的确认码';
  }

  @override
  String get verifyNewEmailButton => '验证';

  @override
  String get passcodeVerificationTitle => '启用密码';

  @override
  String passcodeVerificationDescription(String email) {
    return '要启用密码保护，请输入发送到$email的验证码';
  }

  @override
  String get passcodeVerificationButton => '启用';

  @override
  String get setPasscodeTitle => '设置密码';

  @override
  String get setPasscodeDescription => '创建4位数字密码以获得额外保护';

  @override
  String get passcodeHint => '输入4位数字';

  @override
  String get setPasscodeButton => '设置';

  @override
  String get xaneoBenefitsModalTitle => 'XaneoBenefits (XB)';

  @override
  String get xaneoBenefitsModalDescription => 'Xaneo 高级订阅';

  @override
  String get xaneoBenefitsSelectPlan => '选择您的订阅计划：';

  @override
  String get xaneoBenefitsYearlyPlan => '年度订阅';

  @override
  String get xaneoBenefitsMonthlyPlan => '月度订阅';

  @override
  String get xaneoBenefitsYearlyPrice => '¥999/年';

  @override
  String get xaneoBenefitsMonthlyPrice => '¥159/月';

  @override
  String get xaneoBenefitsSavings => '节省 25%！每月仅 ¥83.25';

  @override
  String get xaneoBenefitsSubscribeButton => '订阅 XB';

  @override
  String get xaneoBenefitsCloseButton => '关闭';

  @override
  String get xaneoBenefitsYearlySuccess => '年度 XB 订阅已激活！';

  @override
  String get xaneoBenefitsMonthlySuccess => '月度 XB 订阅已激活！';

  @override
  String get favoritesChat => '收藏夹';

  @override
  String get favoritesChatDescription => '重要消息和文件';

  @override
  String contentInDevelopmentMessage(String title) {
    return '\"$title\" 的内容正在开发中...';
  }

  @override
  String get russianLanguage => '俄语';

  @override
  String chatWelcomeMessage(String chatName) {
    return '你好！这是 \"$chatName\" 聊天 🎉';
  }

  @override
  String get formattingExample1 => '这里可以使用 **粗体** 和 *斜体* 以及 __下划线__ 文本！';

  @override
  String get formattingExample2 => '还有 ~~删除线~~ 和 `代码` 💻';

  @override
  String get greetingTrigger => '你好';

  @override
  String get greetingResponse => '你好！你好吗？';

  @override
  String get fileSendingNotImplemented => '文件发送尚未实现';

  @override
  String get wasOnlineRecently => '最近在线';

  @override
  String get messageHint => '消息';
}
