// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'XaneoMobile';

  @override
  String get welcomeTitle => 'Xaneoへようこそ';

  @override
  String get welcomeDescription =>
      'Xaneo - モバイルアプリになりました！Xaneoがこれほど便利で高速になったことはありません。';

  @override
  String get getStartedButton => 'もう興味があります';

  @override
  String get connectingToServer => 'サーバーに接続中...';

  @override
  String version(String version) {
    return 'バージョン: $version';
  }

  @override
  String httpError(int code) {
    return 'エラー: HTTP $code';
  }

  @override
  String connectionError(String error) {
    return '接続エラー：$error';
  }

  @override
  String get updateAvailable => 'アップデートが利用可能です！';

  @override
  String get updateDialogTitle => 'アップデートが利用可能です！';

  @override
  String updateDialogMessage(String currentVersion, String latestVersion) {
    return '現在のバージョンは $currentVersion で、新しいバージョンは $latestVersion です';
  }

  @override
  String get updateDialogDescription =>
      'Google Play、RuStore、またはXaneoの公式ウェブサイトからアップデートできます。';

  @override
  String get updateButton => 'アップデート';

  @override
  String get cancelButton => 'キャンセル';

  @override
  String get selectUpdateSource => 'アップデート元を選択してください：';

  @override
  String get settings => '設定';

  @override
  String get about => 'アプリについて';

  @override
  String get help => 'ヘルプ';

  @override
  String get notifications => '通知';

  @override
  String get notificationsDescription => '新機能の通知を受け取る';

  @override
  String get darkTheme => 'ダークテーマ';

  @override
  String get darkThemeDescription => 'ダークな外観を使用';

  @override
  String fontSize(int size) {
    return 'フォントサイズ: $size';
  }

  @override
  String get appVersion => 'アプリのバージョン';

  @override
  String get messengerDemoMode => 'メッセンジャーデモモード';

  @override
  String get language => '言語';

  @override
  String get languageDescription => 'インターフェース言語を選択';

  @override
  String get welcomeMessage => '素晴らしい！ようこそ！';

  @override
  String get privacyTitle => 'あなたのデータはすべて安全です';

  @override
  String get privacyDescription =>
      'XaneoConnectのすべてのメッセージはエンドツーエンド暗号化で保護されています。Xaneoがその内容を知ることは一切ありません。';

  @override
  String get continueButton => '続けましょう';

  @override
  String get dataStorageTitle => 'すべてのXaneoデータセンターはロシアにあります';

  @override
  String get dataStorageDescription => 'あなたのデータは国外に出ることなく、安全なデータセンターに保存されます。';

  @override
  String get finishButton => '完了';

  @override
  String get setupCompleted => 'セットアップが完了しました！';

  @override
  String get loginFormTitle => 'ログインしましょう';

  @override
  String get registerFormTitle => '始めましょう';

  @override
  String get registerNameSubtitle => 'お名前を教えてください';

  @override
  String get nameFieldHint => 'お名前';

  @override
  String get nextButton => '次へ';

  @override
  String get skipButton => 'スキップ';

  @override
  String get registerBirthdateSubtitle => '生年月日を教えてください';

  @override
  String get selectDate => '日付を選択';

  @override
  String get ageRestrictionsLink => '年齢制限は何ですか？';

  @override
  String get ageRestrictionsTitle => '14歳から登録可能';

  @override
  String get ageRestrictionsDescription => '14歳以上の方はサービスに登録できます';

  @override
  String get gotIt => '了解しました';

  @override
  String get registerNicknameSubtitle => 'ニックネームを選択';

  @override
  String get nicknameFieldHint => 'あなたのニックネーム';

  @override
  String get nicknameHelpLink => 'ニックネームが思い浮かびませんか？';

  @override
  String get registerEmailSubtitle => 'メールアドレスを入力してください';

  @override
  String get emailFieldHint => 'あなたのメールアドレス';

  @override
  String get supportedEmailProvidersLink => 'どのメールプロバイダーがサポートされていますか？';

  @override
  String get supportedEmailProvidersTitle => 'サポートされているメールプロバイダー';

  @override
  String get supportedEmailProvidersDescription =>
      'Gmail、Outlook、Yandex、Mail.ruなどの人気メールサービスがサポートされています。';

  @override
  String get emailFormatError => 'メールアドレスの形式が無効です';

  @override
  String get emailUnsupportedError => 'このメールサービスはサポートされていません';

  @override
  String get checkingEmail => 'メールアドレスを確認中...';

  @override
  String get emailAvailable => 'メールアドレスが利用可能です';

  @override
  String get emailTakenError => 'このメールアドレスは既に使用されています';

  @override
  String get emailServerError => 'メールアドレスの確認エラー。後でもう一度お試しください';

  @override
  String get verifyEmailTitle => 'メールアドレスを確認';

  @override
  String get verifyEmailDescription => '6桁のコードをメールアドレスに送信しました。確認のために入力してください。';

  @override
  String get verificationCodeHint => '確認コード';

  @override
  String get verifyButton => '確認';

  @override
  String get registerPasswordSubtitle => 'パスワードを作成';

  @override
  String get registerPasswordFieldHint => 'パスワードを入力';

  @override
  String get passwordInvalidCharsError => 'パスワードにはラテン文字、数字、句読点のみを使用できます';

  @override
  String get passwordWeakError => 'パスワードが弱すぎます。文字、数字、特殊文字を使用してください';

  @override
  String get passwordMediumWarning => '中程度の強さのパスワード。強化をお勧めします';

  @override
  String get passwordStrongSuccess => '強いパスワード';

  @override
  String get nicknameGeneratorTitle => 'ニックネームは自動的に生成されます';

  @override
  String get nicknameGeneratorDescription => 'ニックネームはいつでも変更できます';

  @override
  String get closeButton => '閉じる';

  @override
  String get loginFieldHint => 'ユーザー名';

  @override
  String get passwordFieldHint => 'パスワード';

  @override
  String get loginButton => 'ログイン';

  @override
  String get fillAllFields => 'すべてのフィールドを入力してください';

  @override
  String get loggingIn => 'ログイン中...';

  @override
  String welcomeUser(String username) {
    return 'ようこそ、$usernameさん！';
  }

  @override
  String get invalidCredentials => '認証情報が無効です。ユーザー名とパスワードを確認してください。';

  @override
  String get serverError => 'サーバーエラーです。後でもう一度お試しください。';

  @override
  String get connectionErrorLogin => '接続エラーです。インターネット接続を確認してください。';

  @override
  String get noAccount => 'アカウントをお持ちでない方';

  @override
  String get forgotPassword => 'パスワードを忘れましたか？';

  @override
  String get forgotPasswordDescription =>
      'ユーザー名を入力していただければ、アカウントアクセス用のリンクをメールでお送りします。';

  @override
  String get sendLinkButton => 'リンクを送信';

  @override
  String get checkEmailTitle => 'メールをご確認ください';

  @override
  String checkEmailDescription(String email) {
    return '$email の受信トレイをご確認の上、リンクをクリックしてアカウントにアクセスしてください。';
  }

  @override
  String get forgotPasswordCodeDescription =>
      'アカウントにリンクされたメールに送信されたアクセスコードを入力してください';

  @override
  String get alreadyHaveAccount => 'すでにアカウントをお持ちですか？';

  @override
  String get registrationUnavailable => '現在、登録は利用できません';

  @override
  String get passwordRecoveryUnavailable => '現在、パスワード復旧は利用できません';

  @override
  String get nicknameMinLengthError => 'ニックネームyの長さは5文字以上である必要があります';

  @override
  String get nicknameLatinOnlyError => 'ニックネームにはラテン文字、数字、ドット、アンダースコアのみ使用できます';

  @override
  String get nicknameStartError => 'ニックネームはアンダースコア、数字、ドットで始めることはできません';

  @override
  String get nicknameEndError => 'ニックネームはアンダースコアやピリオドで終わることはできません';

  @override
  String get checkingNickname => 'ニックネームを確認中...';

  @override
  String get nicknameAvailable => 'ニックネームは利用可能です';

  @override
  String get nicknameTakenError => 'このニックネームは既に使用されています';

  @override
  String get nicknameServerError => 'ニックネーム確認エラー。後でもう一度お試しください';

  @override
  String get nicknameMaxLengthError => '最大30文字';

  @override
  String get nameEmptyError => '名前を入力してください';

  @override
  String get confirmPasswordTitle => 'パスワードの確認';

  @override
  String get confirmPasswordDescription => '確認のためにパスワードをもう一度入力してください';

  @override
  String get confirmPasswordFieldHint => 'パスワードを再入力';

  @override
  String get passwordMismatchError => 'パスワードが一致しません';

  @override
  String get confirmButton => '確認';

  @override
  String get registerAvatarSubtitle => 'アバターを選択';

  @override
  String get addAvatarHint => '+ をタップして写真を追加';

  @override
  String get avatarTapToSelect => 'タップして写真を選択';

  @override
  String get photoPermissionTitle => '画像へのアクセスを許可';

  @override
  String get photoPermissionDescription =>
      'プロフィール用のアバターを選択できるよう、画像へのアクセスを許可してください';

  @override
  String get allowAccessButton => 'アクセスを許可';

  @override
  String get notNowButton => '今はしない';

  @override
  String get avatarCropperTitle => 'アバター設定';

  @override
  String get doneButton => '完了';

  @override
  String get cropInstructions => '円をドラッグしてエリアを選択 • ドットを使ってサイズ変更';

  @override
  String get changeAvatar => 'アバターを変更';

  @override
  String get profilePreviewTitle => 'あなたのプロフィールはこのように表示されます';

  @override
  String get goodMorning => 'おはようございます';

  @override
  String get goodDay => 'こんにちは';

  @override
  String get goodEvening => 'こんばんは';

  @override
  String get goodNight => 'おやすみなさい';

  @override
  String get backButton => '戻る';

  @override
  String get editName => '名前を編集';

  @override
  String get editNickname => 'ニックネームを編集';

  @override
  String get editPhoto => '写真を編集';

  @override
  String get saveButton => '保存';

  @override
  String get deleteButton => '削除';

  @override
  String get deletePhoto => '写真を削除';

  @override
  String get selectFromGallery => 'ギャラリーから選択';

  @override
  String get enterNameHint => 'お名前を入力';

  @override
  String get enterNicknameHint => 'ニックネームを入力';

  @override
  String get termsAndConditionsTitle => '利用規約';

  @override
  String get termsOfUse => '利用規約';

  @override
  String get userAgreement => 'ユーザー契約';

  @override
  String acceptTermsText(String termsOfUse, String userAgreement) {
    return '登録を完了してXaneoの使用を開始するには、$termsOfUseと$userAgreementに同意する必要があります。\n\nこれらの文書には、サービス利用規則、データ保護、両当事者の義務に関する重要な情報が含まれています。\n\nこれらの条項に同意することで、プラットフォームの規則を読み、遵守することに同意したことを確認します。\n\nこれらの条項に同意しない場合、登録を完了することはできず、サービスへのアクセスが制限されます。';
  }

  @override
  String get acceptButton => '同意する';

  @override
  String get declineButton => '拒否する';

  @override
  String verificationCodeSent(String email, int seconds) {
    return '$emailに認証コードを送信しました。有効期限は$seconds秒です';
  }

  @override
  String get codeDeliveryError => '認証コード送信エラー';

  @override
  String get serverErrorCodeDelivery => '認証コード送信時のサーバーエラー';

  @override
  String get connectionErrorCodeDelivery => '認証コード送信時の接続エラー';

  @override
  String get emailVerificationSuccess => 'メール認証が完了しました！';

  @override
  String get invalidVerificationCode => '無効な認証コードです。コードを確認して再試行してください';

  @override
  String get emailNotFound => 'メールアドレスが見つかりません。再度登録してください';

  @override
  String get verificationCodeExpired => '認証コードの有効期限が切れました。新しいコードをリクエストしてください';

  @override
  String get serverErrorCodeVerification => '認証コード確認時のサーバーエラー。後で再試行してください';

  @override
  String get connectionErrorCodeVerification => '認証コード確認時の接続エラー';

  @override
  String get permissionDeniedSettings => '権限が永続的に拒否されました。設定で有効にしてください';

  @override
  String get avatarCropped => 'アバターがトリミングされ保存されました！';

  @override
  String get imageSelectionError => '画像選択エラー';

  @override
  String get permissionDeniedOpenSettings => '権限が永続的に拒否されました。設定を開いて有効にしてください';

  @override
  String get photoPermissionError => '写真アクセス権限を取得できませんでした';

  @override
  String get registrationCompleted => '登録が完了しました！';

  @override
  String get officialXaneoWebsite => 'Xaneo公式ウェブサイト';

  @override
  String twoFactorAuthMessage(String email) {
    return 'このアカウントでは二要素認証が有効になっています。$emailに送信された認証コードを入力してください';
  }

  @override
  String get selectLanguage => '言語を選択';

  @override
  String get messengerDemo => 'メッセンジャーデモ';

  @override
  String get messenger => 'メッセンジャー';

  @override
  String get messengerDescription =>
      'モダンなデザインとユーザーフレンドリーなインターフェースを備えたシンプルで高速で安全なメッセンジャー。';

  @override
  String get profileDemo => 'プロフィールデモ';

  @override
  String get profile => 'プロフィール';

  @override
  String get personalInfo => '個人情報';

  @override
  String get name => '名前';

  @override
  String get nameHint => '名前';

  @override
  String get birthDate => '生年月日';

  @override
  String get nickname => 'ニックネーム';

  @override
  String get nicknameHint => 'ニックネーム';

  @override
  String get phone => '電話';

  @override
  String get phoneHint => '電話番号';

  @override
  String get settingsSection => '設定';

  @override
  String get chatSettings => 'チャット設定';

  @override
  String get chatSettingsDescription => 'チャット設定はここに表示されます...';

  @override
  String get privacySettings => 'プライバシーと機密性';

  @override
  String get privacySettingsDescription => 'プライバシー設定はここに表示されます...';

  @override
  String get securitySettings => 'セキュリティ';

  @override
  String get securityAuthentication => '認証';

  @override
  String get securityChangePassword => 'パスワード変更';

  @override
  String get securityTwoFactorAuth => '二要素認証';

  @override
  String get twoFactorEnabled => '有効';

  @override
  String get twoFactorDisabled => '無効';

  @override
  String get securityChangeEmail => 'メール変更';

  @override
  String get securityPasscode => 'パスコード';

  @override
  String get securitySettingsDescription => 'セキュリティ設定はここに表示されます...';

  @override
  String get passwordEmptyError => 'パスワードを空にすることはできません';

  @override
  String get passwordTooShortError => 'パスワードは少なくとも5文字以上にする必要があります';

  @override
  String get passwordEnterCurrentHint => '確認のために現在のパスワードを入力してください';

  @override
  String get passwordCurrentHint => '現在のパスワード';

  @override
  String get passwordConfirmNewHint => '新しいパスワードを確認してください';

  @override
  String get passwordDontMatchError => 'パスワードが一致しません';

  @override
  String get passwordNewTitle => '新しいパスワード';

  @override
  String get passwordNewHint => '新しいパスワード';

  @override
  String get passwordConfirmHint => 'パスワードを確認';

  @override
  String get passwordChangedSuccess => 'パスワードが正常に変更されました';

  @override
  String get passwordNextButton => '次へ';

  @override
  String get passwordSaveButton => '保存';

  @override
  String get powerSettings => '省電力';

  @override
  String get powerSettingsDescription => '省電力設定はここに表示されます...';

  @override
  String get languageSelect => '言語';

  @override
  String get cancel => 'キャンセル';

  @override
  String get ready => '完了';

  @override
  String contentInDevelopment(String title) {
    return '\"$title\"のコンテンツは開発中です...';
  }

  @override
  String get sessions => 'セッション';

  @override
  String get support => 'サポート';

  @override
  String get xaneoBenefits => 'XaneoBenefits';

  @override
  String get messengerFeatures => 'デモモードの機能:';

  @override
  String get secureEncryption => 'メッセージの安全な暗号化';

  @override
  String get instantDelivery => '即時配信';

  @override
  String get deviceSync => 'デバイス間同期';

  @override
  String get mediaSupport => 'メディアファイルサポート';

  @override
  String get sessionsContent => 'アカウントのアクティブなセッションがここに表示されます...';

  @override
  String get activeDevices => 'アクティブなデバイス';

  @override
  String get currentDevice => '現在のデバイス';

  @override
  String get terminateSession => 'セッションを終了';

  @override
  String get terminateAllOtherSessions => '他のすべてのセッションを終了';

  @override
  String get sessionLocation => '場所';

  @override
  String get sessionLastActive => '最後のアクティブ';

  @override
  String get sessionBrowser => 'ブラウザ';

  @override
  String get sessionPlatform => 'プラットフォーム';

  @override
  String get confirmTerminateSession => 'このセッションを終了してもよろしいですか？';

  @override
  String get confirmTerminateAllSessions =>
      '他のすべてのセッションを終了してもよろしいですか？この操作は元に戻せません。';

  @override
  String get sessionIPAddress => 'IPアドレス';

  @override
  String get supportContent =>
      'サポートサービスに非常に高い負荷がかかっています。できるだけ早く対応するよう努めていますが、現在待ち時間が最大24時間かかる場合があります。ぜひご連絡ください。必ずお手伝いいたします。';

  @override
  String get contactSupport => '連絡';

  @override
  String get xaneoBenefitsContent =>
      'XaneoBenefitsは、Xaneoユーザー向けのロイヤルティプログラムです。ボーナスと特別な機能を手に入れましょう...';

  @override
  String get more => 'その他';

  @override
  String get chatPreview => 'チャットプレビュー';

  @override
  String get textSize => 'テキストサイズ';

  @override
  String textSizeValue(String size) {
    return 'サイズ: $size';
  }

  @override
  String get textExample => 'テキスト例';

  @override
  String get useDarkTheme => 'ダークテーマを使用';

  @override
  String get chatWallpapers => 'チャット壁紙';

  @override
  String get messageColors => 'メッセージの色';

  @override
  String get myMessages => '自分のメッセージ';

  @override
  String get receivedMessages => '受信メッセージ';

  @override
  String get messageEmojis => 'メッセージ絵文字';

  @override
  String get selectedEmoji => '選択された絵文字:';

  @override
  String get chooseWallpaper => '壁紙を選択:';

  @override
  String get demoMessage1 => 'こんにちは！調子はどう？';

  @override
  String get demoMessage2 => '最高だよ！君は？';

  @override
  String get demoMessage3 => '僕も元気だよ、ありがとう 😊';

  @override
  String get demoDateSeparator => '今日';

  @override
  String get onlineStatus => 'オンライン';

  @override
  String get chatTheme => 'チャットのテーマ';

  @override
  String get privacySettingsTitle => 'プライバシーとセキュリティ';

  @override
  String get privacyCommunications => '通信';

  @override
  String get privacyProfileVisibility => 'プロフィールの表示';

  @override
  String get privacyWhoCanMessage => 'メッセージ';

  @override
  String get privacyWhoCanRecordVoice => 'ボイスメッセージ';

  @override
  String get privacyWhoCanCall => '通話';

  @override
  String get privacyWhoCanSendVideo => 'ビデオメッセージ';

  @override
  String get privacyWhoCanSendLinks => 'リンク';

  @override
  String get privacyWhoCanInvite => '招待';

  @override
  String get privacyWhoSeesNickname => 'ニックネーム';

  @override
  String get privacyWhoSeesAvatar => 'アバター';

  @override
  String get privacyWhoSeesBirthday => '誕生日';

  @override
  String get privacyWhoSeesOnlineTime => 'オンライ時間';

  @override
  String get privacyAll => '全員';

  @override
  String get privacyContacts => '連絡先';

  @override
  String get privacyNobody => '誰も';

  @override
  String get passwordWeak => '弱い';

  @override
  String get passwordMedium => '普通';

  @override
  String get passwordStrong => '強い';

  @override
  String twoFactorEnableDescription(String email) {
    return '2要素認証を有効にするには、$email に送信された確認コードを入力してください';
  }

  @override
  String twoFactorDisableDescription(String email) {
    return '2要素認証を無効にするには、$email に送信された確認コードを入力してください';
  }

  @override
  String get changeEmailVerificationDescription =>
      'メールアドレスを変更するには、demouser@example.com に送信された確認コードを入力してください';

  @override
  String get newEmailTitle => '新しいメール';

  @override
  String get newEmailDescription => '新しいメールアドレスを入力してください';

  @override
  String get changeEmailButton => '変更';

  @override
  String get verifyNewEmailTitle => '新しいメールを確認';

  @override
  String verifyNewEmailDescription(String email) {
    return '新しいメールアドレス$emailを確認するには、このアドレスに送信された確認コードを入力してください';
  }

  @override
  String get verifyNewEmailButton => '確認';

  @override
  String get passcodeVerificationTitle => 'パスコードを有効にする';

  @override
  String passcodeVerificationDescription(String email) {
    return 'パスコード保護を有効にするには、$emailに送信された確認コードを入力してください';
  }

  @override
  String get passcodeVerificationButton => '有効にする';

  @override
  String get setPasscodeTitle => 'パスコードを設定';

  @override
  String get setPasscodeDescription => '追加の保護のために4桁のパスコードを作成してください';

  @override
  String get passcodeHint => '4桁を入力';

  @override
  String get setPasscodeButton => '設定';

  @override
  String get xaneoBenefitsModalTitle => 'XaneoBenefits (XB)';

  @override
  String get xaneoBenefitsModalDescription => 'Xaneo プレミアムサブスクリプション';

  @override
  String get xaneoBenefitsSelectPlan => 'サブスクリプションプランを選択してください：';

  @override
  String get xaneoBenefitsYearlyPlan => '年間サブスクリプション';

  @override
  String get xaneoBenefitsMonthlyPlan => '月間サブスクリプション';

  @override
  String get xaneoBenefitsYearlyPrice => '¥999,000/年';

  @override
  String get xaneoBenefitsMonthlyPrice => '¥159,000/月';

  @override
  String get xaneoBenefitsSavings => '25% お得！月額 ¥83,250 のみ';

  @override
  String get xaneoBenefitsSubscribeButton => 'XB を購読';

  @override
  String get xaneoBenefitsCloseButton => '閉じる';

  @override
  String get xaneoBenefitsYearlySuccess => '年間 XB サブスクリプションが有効化されました！';

  @override
  String get xaneoBenefitsMonthlySuccess => '月間 XB サブスクリプションが有効化されました！';

  @override
  String get favoritesChat => 'お気に入り';

  @override
  String get favoritesChatDescription => '重要なメッセージとファイル';

  @override
  String contentInDevelopmentMessage(String title) {
    return '\"$title\" のコンテンツは開発中です...';
  }

  @override
  String get russianLanguage => 'ロシア語';

  @override
  String chatWelcomeMessage(String chatName) {
    return 'こんにちは！これは \"$chatName\" チャットです 🎉';
  }

  @override
  String get formattingExample1 => 'ここでは **太字** と *斜体* と __下線__ テキストが使えます！';

  @override
  String get formattingExample2 => 'また ~~取り消し線~~ と `コード` も使えます 💻';

  @override
  String get greetingTrigger => 'こんにちは';

  @override
  String get greetingResponse => 'こんにちは！元気ですか？';

  @override
  String get fileSendingNotImplemented => 'ファイル送信はまだ実装されていません';

  @override
  String get wasOnlineRecently => '最近オンラインでした';

  @override
  String get messageHint => 'メッセージ';
}
