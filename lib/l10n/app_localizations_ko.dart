// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'XaneoMobile';

  @override
  String get welcomeTitle => 'Xaneo에 오신 것을 환영합니다';

  @override
  String get welcomeDescription =>
      'Xaneo - 이제 모바일 앱으로도 만나보세요! Xaneo가 이렇게 편리하고 빠른 적은 없었습니다.';

  @override
  String get getStartedButton => '이미 관심이 있어요';

  @override
  String get connectingToServer => '서버에 연결 중...';

  @override
  String version(String version) {
    return '버전: $version';
  }

  @override
  String httpError(int code) {
    return '오류: HTTP $code';
  }

  @override
  String connectionError(String error) {
    return '연결 오류: $error';
  }

  @override
  String get updateAvailable => '업데이트가 사용 가능합니다!';

  @override
  String get updateDialogTitle => '업데이트가 사용 가능합니다!';

  @override
  String updateDialogMessage(String currentVersion, String latestVersion) {
    return '현재 버전은 $currentVersion이고, 새 버전은 $latestVersion입니다';
  }

  @override
  String get updateDialogDescription =>
      'Google Play, RuStore 또는 Xaneo 공식 웹사이트를 통해 업데이트할 수 있습니다.';

  @override
  String get updateButton => '업데이트';

  @override
  String get cancelButton => '취소';

  @override
  String get selectUpdateSource => '업데이트 소스 선택:';

  @override
  String get settings => '설정';

  @override
  String get about => '앱 정보';

  @override
  String get help => '도움말';

  @override
  String get notifications => '알림';

  @override
  String get notificationsDescription => '새로운 기능에 대한 알림 받기';

  @override
  String get darkTheme => '다크 테마';

  @override
  String get darkThemeDescription => '어두운 화면 사용';

  @override
  String fontSize(int size) {
    return '글꼴 크기: $size';
  }

  @override
  String get appVersion => '앱 버전';

  @override
  String get messengerDemoMode => '메신저 데모 모드';

  @override
  String get language => '언어';

  @override
  String get languageDescription => '인터페이스 언어 선택';

  @override
  String get welcomeMessage => '훌륭해요! 환영합니다!';

  @override
  String get privacyTitle => '모든 데이터가 안전합니다';

  @override
  String get privacyDescription =>
      'XaneoConnect의 모든 메시지는 종단간 암호화로 보호됩니다. Xaneo는 그 내용을 결코 알지 못합니다.';

  @override
  String get continueButton => '계속 진행하겠습니다';

  @override
  String get dataStorageTitle => '모든 Xaneo 데이터 센터는 러시아에 있습니다';

  @override
  String get dataStorageDescription => '귀하의 데이터는 국경을 넘지 않으며 안전한 데이터 센터에 저장됩니다.';

  @override
  String get finishButton => '완료';

  @override
  String get setupCompleted => '설정이 완료되었습니다!';

  @override
  String get loginFormTitle => '로그인하겠습니다';

  @override
  String get registerFormTitle => '시작해보겠습니다';

  @override
  String get registerNameSubtitle => '성함이 어떻게 되시나요?';

  @override
  String get nameFieldHint => '성함';

  @override
  String get nextButton => '다음';

  @override
  String get skipButton => '건너뛰기';

  @override
  String get registerBirthdateSubtitle => '생년월일이 언제인가요?';

  @override
  String get selectDate => '날짜 선택';

  @override
  String get ageRestrictionsLink => '연령 제한은 무엇인가요?';

  @override
  String get ageRestrictionsTitle => '14세부터 가입 가능';

  @override
  String get ageRestrictionsDescription => '14세 이상이면 저희 서비스에 가입할 수 있습니다';

  @override
  String get gotIt => '알겠습니다';

  @override
  String get registerNicknameSubtitle => '닉네임을 선택하세요';

  @override
  String get nicknameFieldHint => '닉네임';

  @override
  String get nicknameHelpLink => '닉네임을 생각해낼 수 없나요?';

  @override
  String get registerEmailSubtitle => '이메일을 입력하세요';

  @override
  String get emailFieldHint => '귀하의 이메일';

  @override
  String get supportedEmailProvidersLink => '어떤 이메일 제공업체가 지원됩니까?';

  @override
  String get supportedEmailProvidersTitle => '지원되는 이메일 제공업체';

  @override
  String get supportedEmailProvidersDescription =>
      'Gmail, Outlook, Yandex, Mail.ru 및 기타 인기 이메일 서비스가 지원됩니다.';

  @override
  String get emailFormatError => '잘못된 이메일 주소 형식';

  @override
  String get emailUnsupportedError => '이 이메일 서비스는 지원되지 않습니다';

  @override
  String get checkingEmail => '이메일 확인 중...';

  @override
  String get emailAvailable => '이메일을 사용할 수 있습니다';

  @override
  String get emailTakenError => '이 이메일은 이미 사용 중입니다';

  @override
  String get emailServerError => '이메일 확인 오류. 나중에 다시 시도해 주세요';

  @override
  String get verifyEmailTitle => '이메일을 확인하세요';

  @override
  String get verifyEmailDescription => '6자리 코드를 이메일로 보냈습니다. 확인을 위해 입력해 주세요.';

  @override
  String get verificationCodeHint => '확인 코드';

  @override
  String get verifyButton => '확인';

  @override
  String get registerPasswordSubtitle => '비밀번호 만들기';

  @override
  String get registerPasswordFieldHint => '비밀번호 입력';

  @override
  String get passwordInvalidCharsError => '비밀번호에는 라틴 문자, 숫자 및 구두점만 사용할 수 있습니다';

  @override
  String get passwordWeakError => '비밀번호가 너무 약합니다. 문자, 숫자 및 특수 문자를 사용하세요';

  @override
  String get passwordMediumWarning => '중간 강도 비밀번호입니다. 강화를 권장합니다';

  @override
  String get passwordStrongSuccess => '강한 비밀번호';

  @override
  String get nicknameGeneratorTitle => '닉네임이 자동으로 생성됩니다';

  @override
  String get nicknameGeneratorDescription => '언제든지 닉네임을 변경할 수 있습니다';

  @override
  String get closeButton => '닫기';

  @override
  String get loginFieldHint => '사용자명';

  @override
  String get passwordFieldHint => '비밀번호';

  @override
  String get loginButton => '로그인';

  @override
  String get fillAllFields => '모든 필드를 입력해 주세요';

  @override
  String get loggingIn => '로그인 중...';

  @override
  String welcomeUser(String username) {
    return '환영합니다, $username님!';
  }

  @override
  String get invalidCredentials => '잘못된 자격 증명입니다. 사용자명과 비밀번호를 확인해 주세요.';

  @override
  String get serverError => '서버 오류입니다. 나중에 다시 시도해 주세요.';

  @override
  String get connectionErrorLogin => '연결 오류입니다. 인터넷 연결을 확인해 주세요.';

  @override
  String get noAccount => '계정이 없으신가요?';

  @override
  String get forgotPassword => '비밀번호를 잊으셨나요?';

  @override
  String get forgotPasswordDescription => '사용자명을 입력하시면 계정 접속 링크를 이메일로 보내드립니다.';

  @override
  String get sendLinkButton => '링크 보내기';

  @override
  String get checkEmailTitle => '이메일을 확인하세요';

  @override
  String checkEmailDescription(String email) {
    return '$email 받은편지함을 확인하고 링크를 따라 계정에 접속하세요.';
  }

  @override
  String get forgotPasswordCodeDescription => '계정에 연결된 이메일로 발송된 액세스 코드를 입력하세요';

  @override
  String get alreadyHaveAccount => '이미 계정이 있으신가요?';

  @override
  String get registrationUnavailable => '현재 회원가입을 이용할 수 없습니다';

  @override
  String get passwordRecoveryUnavailable => '현재 비밀번호 복구를 이용할 수 없습니다';

  @override
  String get nicknameMinLengthError => '닉네임의 길이는 최소 5자 이상이어야 합니다';

  @override
  String get nicknameLatinOnlyError => '닉네임은 라틴 문자, 숫자, 점, 밑줄만 포함할 수 있습니다';

  @override
  String get nicknameStartError => '닉네임은 밑줄, 숫자, 점으로 시작할 수 없습니다';

  @override
  String get nicknameEndError => '닉네임은 밑줄이나 마침표로 끝날 수 없습니다';

  @override
  String get checkingNickname => '닉네임 확인 중...';

  @override
  String get nicknameAvailable => '닉네임 사용 가능';

  @override
  String get nicknameTakenError => '이 닉네임은 이미 사용 중입니다';

  @override
  String get nicknameServerError => '닉네임 확인 오류. 나중에 다시 시도해주세요';

  @override
  String get nicknameMaxLengthError => '최대 30자';

  @override
  String get nameEmptyError => '이름은 비워둘 수 없습니다';

  @override
  String get confirmPasswordTitle => '비밀번호 확인';

  @override
  String get confirmPasswordDescription => '확인을 위해 비밀번호를 다시 입력해주세요';

  @override
  String get confirmPasswordFieldHint => '비밀번호 재입력';

  @override
  String get passwordMismatchError => '비밀번호가 일치하지 않습니다';

  @override
  String get confirmButton => '확인';

  @override
  String get registerAvatarSubtitle => '아바타 선택';

  @override
  String get addAvatarHint => '+ 를 눌러 사진 추가';

  @override
  String get avatarTapToSelect => '탭하여 사진 선택';

  @override
  String get photoPermissionTitle => '이미지 접근 허용';

  @override
  String get photoPermissionDescription =>
      '프로필용 아바타를 선택할 수 있도록 이미지에 대한 접근을 허용해 주세요';

  @override
  String get allowAccessButton => '접근 허용';

  @override
  String get notNowButton => '나중에';

  @override
  String get avatarCropperTitle => '아바타 설정';

  @override
  String get doneButton => '완료';

  @override
  String get cropInstructions => '원을 드래그하여 영역 선택 • 점을 사용하여 크기 조정';

  @override
  String get changeAvatar => '아바타 변경';

  @override
  String get profilePreviewTitle => '귀하의 프로필이 이렇게 보일 것입니다';

  @override
  String get goodMorning => '좋은 아침입니다';

  @override
  String get goodDay => '안녕하세요';

  @override
  String get goodEvening => '좋은 저녁입니다';

  @override
  String get goodNight => '안녕히 주무세요';

  @override
  String get backButton => '뒤로';

  @override
  String get editName => '이름 편집';

  @override
  String get editNickname => '닉네임 편집';

  @override
  String get editPhoto => '사진 편집';

  @override
  String get saveButton => '저장';

  @override
  String get deleteButton => '삭제';

  @override
  String get deletePhoto => '사진 삭제';

  @override
  String get selectFromGallery => '갤러리에서 선택';

  @override
  String get enterNameHint => '이름을 입력하세요';

  @override
  String get enterNicknameHint => '닉네임을 입력하세요';

  @override
  String get termsAndConditionsTitle => '이용약관';

  @override
  String get termsOfUse => '이용약관';

  @override
  String get userAgreement => '사용자 계약';

  @override
  String acceptTermsText(String termsOfUse, String userAgreement) {
    return '등록을 완료하고 Xaneo 사용을 시작하려면 $termsOfUse 및 $userAgreement에 동의해야 합니다.\n\n이 문서들은 서비스 이용 규칙, 데이터 보호 및 양 당사자의 의무에 대한 중요한 정보를 포함하고 있습니다.\n\n이 약관에 동의함으로써 플랫폼 규칙을 읽고 준수하는 데 동의함을 확인합니다.\n\n이 약관에 동의하지 않으면 등록을 완료할 수 없으며 서비스 이용이 제한됩니다.';
  }

  @override
  String get acceptButton => '동의';

  @override
  String get declineButton => '거부';

  @override
  String verificationCodeSent(String email, int seconds) {
    return '$email로 인증코드를 발송했습니다. $seconds초 동안 유효합니다';
  }

  @override
  String get codeDeliveryError => '인증코드 발송 오류';

  @override
  String get serverErrorCodeDelivery => '인증코드 발송 중 서버 오류';

  @override
  String get connectionErrorCodeDelivery => '인증코드 발송 중 연결 오류';

  @override
  String get emailVerificationSuccess => '이메일 인증이 완료되었습니다!';

  @override
  String get invalidVerificationCode => '잘못된 인증코드입니다. 코드를 확인하고 다시 시도하세요';

  @override
  String get emailNotFound => '이메일을 찾을 수 없습니다. 다시 등록해보세요';

  @override
  String get verificationCodeExpired => '인증코드가 만료되었습니다. 새 코드를 요청하세요';

  @override
  String get serverErrorCodeVerification => '인증코드 확인 중 서버 오류. 나중에 다시 시도하세요';

  @override
  String get connectionErrorCodeVerification => '인증코드 확인 중 연결 오류';

  @override
  String get permissionDeniedSettings => '권한이 영구적으로 거부되었습니다. 설정에서 활성화하세요';

  @override
  String get avatarCropped => '아바타가 잘리고 저장되었습니다!';

  @override
  String get imageSelectionError => '이미지 선택 오류';

  @override
  String get permissionDeniedOpenSettings => '권한이 영구적으로 거부되었습니다. 설정을 열어 활성화하세요';

  @override
  String get photoPermissionError => '사진 접근 권한을 얻을 수 없습니다';

  @override
  String get registrationCompleted => '등록이 완료되었습니다!';

  @override
  String get officialXaneoWebsite => 'Xaneo 공식 웹사이트';

  @override
  String twoFactorAuthMessage(String email) {
    return '이 계정에서 이중 인증이 활성화되어 있습니다. $email로 전송된 인증코드를 입력하세요';
  }

  @override
  String get selectLanguage => '언어 선택';

  @override
  String get messengerDemo => '메신저 데모';

  @override
  String get messenger => '메신저';

  @override
  String get messengerDescription =>
      '현대적인 디자인과 사용자 친화적인 인터페이스를 갖춘 간단하고 빠르고 안전한 메신저.';

  @override
  String get profileDemo => '프로필 데모';

  @override
  String get profile => '프로필';

  @override
  String get personalInfo => '개인 정보';

  @override
  String get name => '이름';

  @override
  String get nameHint => '이름';

  @override
  String get birthDate => '생년월일';

  @override
  String get nickname => '닉네임';

  @override
  String get nicknameHint => '닉네임';

  @override
  String get phone => '전화';

  @override
  String get phoneHint => '전화번호';

  @override
  String get settingsSection => '설정';

  @override
  String get chatSettings => '채팅 설정';

  @override
  String get chatSettingsDescription => '채팅 설정이 여기에 표시됩니다...';

  @override
  String get privacySettings => '개인정보 보호 및 기밀성';

  @override
  String get privacySettingsDescription => '개인정보 설정이 여기에 표시됩니다...';

  @override
  String get securitySettings => '보안';

  @override
  String get securityAuthentication => '인증';

  @override
  String get securityChangePassword => '비밀번호 변경';

  @override
  String get securityTwoFactorAuth => '이중 인증';

  @override
  String get twoFactorEnabled => '활성화됨';

  @override
  String get twoFactorDisabled => '비활성화됨';

  @override
  String get securityChangeEmail => '이메일 변경';

  @override
  String get securityPasscode => '패스코드';

  @override
  String get securitySettingsDescription => '보안 설정이 여기에 표시됩니다...';

  @override
  String get passwordEmptyError => '비밀번호를 비워둘 수 없습니다';

  @override
  String get passwordTooShortError => '비밀번호는 최소 1자 이상이어야 합니다';

  @override
  String get passwordEnterCurrentHint => '확인을 위해 현재 비밀번호를 입력하세요';

  @override
  String get passwordCurrentHint => '현재 비밀번호';

  @override
  String get passwordConfirmNewHint => '새 비밀번호를 확인하세요';

  @override
  String get passwordDontMatchError => '비밀번호가 일치하지 않습니다';

  @override
  String get passwordNewTitle => '새 비밀번호';

  @override
  String get passwordNewHint => '새 비밀번호';

  @override
  String get passwordConfirmHint => '비밀번호 확인';

  @override
  String get passwordChangedSuccess => '비밀번호가 성공적으로 변경되었습니다';

  @override
  String get passwordNextButton => '다음';

  @override
  String get passwordSaveButton => '저장';

  @override
  String get powerSettings => '전력 절약';

  @override
  String get powerSettingsDescription => '전력 절약 설정이 여기에 표시됩니다...';

  @override
  String get languageSelect => '언어';

  @override
  String get cancel => '취소';

  @override
  String get ready => '완료';

  @override
  String contentInDevelopment(String title) {
    return '\"$title\"의 콘텐츠가 개발 중입니다...';
  }

  @override
  String get sessions => '세션';

  @override
  String get support => '지원';

  @override
  String get xaneoBenefits => 'XaneoBenefits';

  @override
  String get messengerFeatures => '데모 모드 기능:';

  @override
  String get secureEncryption => '메시지 보안 암호화';

  @override
  String get instantDelivery => '즉시 전송';

  @override
  String get deviceSync => '기기 간 동기화';

  @override
  String get mediaSupport => '미디어 파일 지원';

  @override
  String get sessionsContent => '계정의 활성 세션이 여기에 표시됩니다...';

  @override
  String get activeDevices => '활성 기기';

  @override
  String get currentDevice => '현재 기기';

  @override
  String get terminateSession => '세션 종료';

  @override
  String get terminateAllOtherSessions => '다른 모든 세션 종료';

  @override
  String get sessionLocation => '위치';

  @override
  String get sessionLastActive => '마지막 활동';

  @override
  String get sessionBrowser => '브라우저';

  @override
  String get sessionPlatform => '플랫폼';

  @override
  String get confirmTerminateSession => '이 세션을 종료하시겠습니까?';

  @override
  String get confirmTerminateAllSessions =>
      '다른 모든 세션을 종료하시겠습니까? 이 작업은 되돌릴 수 없습니다.';

  @override
  String get sessionIPAddress => 'IP 주소';

  @override
  String get supportContent =>
      '저희 지원 서비스에 매우 높은 부하가 걸려 있습니다. 최대한 빨리 응답하기 위해 노력하고 있지만, 현재 대기 시간이 최대 24시간까지 걸릴 수 있습니다. 연락 주시면 반드시 문제를 해결해 드리겠습니다.';

  @override
  String get contactSupport => '연락';

  @override
  String get xaneoBenefitsContent =>
      'XaneoBenefits는 Xaneo 사용자를 위한 충성도 프로그램입니다. 보너스와 독점 기능을 받아보세요...';

  @override
  String get more => '더보기';

  @override
  String get chatPreview => '채팅 미리보기';

  @override
  String get textSize => '텍스트 크기';

  @override
  String textSizeValue(String size) {
    return '크기: $size';
  }

  @override
  String get textExample => '텍스트 예시';

  @override
  String get useDarkTheme => '다크 테마 사용';

  @override
  String get chatWallpapers => '채팅 배경화면';

  @override
  String get messageColors => '메시지 색상';

  @override
  String get myMessages => '내 메시지';

  @override
  String get receivedMessages => '받은 메시지';

  @override
  String get messageEmojis => '메시지 이모지';

  @override
  String get selectedEmoji => '선택된 이모지:';

  @override
  String get chooseWallpaper => '배경화면 선택:';

  @override
  String get demoMessage1 => '안녕! 어떻게 지내?';

  @override
  String get demoMessage2 => '다 잘돼! 너는?';

  @override
  String get demoMessage3 => '나도 잘 지내, 고마워 😊';

  @override
  String get demoDateSeparator => '오늘';

  @override
  String get onlineStatus => '온라인';

  @override
  String get chatTheme => '채팅 테마';

  @override
  String get privacySettingsTitle => '개인정보 및 보안';

  @override
  String get privacyCommunications => '커뮤니케이션';

  @override
  String get privacyProfileVisibility => '프로필 표시';

  @override
  String get privacyWhoCanMessage => '메시지';

  @override
  String get privacyWhoCanRecordVoice => '음성 메시지';

  @override
  String get privacyWhoCanCall => '전화';

  @override
  String get privacyWhoCanSendVideo => '비디오 메시지';

  @override
  String get privacyWhoCanSendLinks => '링크';

  @override
  String get privacyWhoCanInvite => '초대';

  @override
  String get privacyWhoSeesNickname => '닉네임';

  @override
  String get privacyWhoSeesAvatar => '아바타';

  @override
  String get privacyWhoSeesBirthday => '생일';

  @override
  String get privacyWhoSeesOnlineTime => '온라인 시간';

  @override
  String get privacyAll => '모두';

  @override
  String get privacyContacts => '연락처';

  @override
  String get privacyNobody => '아무도';

  @override
  String get passwordWeak => '약함';

  @override
  String get passwordMedium => '보통';

  @override
  String get passwordStrong => '강함';

  @override
  String twoFactorEnableDescription(String email) {
    return '2단계 인증을 활성화하려면 $email로 전송된 확인 코드를 입력하세요';
  }

  @override
  String twoFactorDisableDescription(String email) {
    return '2단계 인증을 비활성화하려면 $email로 전송된 확인 코드를 입력하세요';
  }

  @override
  String get changeEmailVerificationDescription =>
      '이메일을 변경하려면 demouser@example.com로 전송된 확인 코드를 입력하세요';

  @override
  String get newEmailTitle => '새 이메일';

  @override
  String get newEmailDescription => '새 이메일 주소를 입력하세요';

  @override
  String get changeEmailButton => '변경';

  @override
  String get verifyNewEmailTitle => '새 이메일 확인';

  @override
  String verifyNewEmailDescription(String email) {
    return '새 이메일 $email을 확인하려면 이 주소로 전송된 확인 코드를 입력하세요';
  }

  @override
  String get verifyNewEmailButton => '확인';

  @override
  String get passcodeVerificationTitle => '패스코드 활성화';

  @override
  String passcodeVerificationDescription(String email) {
    return '패스코드 보호를 활성화하려면 $email로 전송된 확인 코드를 입력하세요';
  }

  @override
  String get passcodeVerificationButton => '활성화';

  @override
  String get setPasscodeTitle => '패스코드 설정';

  @override
  String get setPasscodeDescription => '추가 보호를 위해 4자리 패스코드를 생성하세요';

  @override
  String get passcodeHint => '4자리 입력';

  @override
  String get setPasscodeButton => '설정';

  @override
  String get xaneoBenefitsModalTitle => 'XaneoBenefits (XB)';

  @override
  String get xaneoBenefitsModalDescription => 'Xaneo 프리미엄 구독';

  @override
  String get xaneoBenefitsSelectPlan => '구독 플랜을 선택하세요:';

  @override
  String get xaneoBenefitsYearlyPlan => '연간 구독';

  @override
  String get xaneoBenefitsMonthlyPlan => '월간 구독';

  @override
  String get xaneoBenefitsYearlyPrice => '₩999,000/년';

  @override
  String get xaneoBenefitsMonthlyPrice => '₩159,000/월';

  @override
  String get xaneoBenefitsSavings => '25% 절약! 월 ₩83,250만';

  @override
  String get xaneoBenefitsSubscribeButton => 'XB 구독하기';

  @override
  String get xaneoBenefitsCloseButton => '닫기';

  @override
  String get xaneoBenefitsYearlySuccess => '연간 XB 구독이 활성화되었습니다!';

  @override
  String get xaneoBenefitsMonthlySuccess => '월간 XB 구독이 활성화되었습니다!';
}
