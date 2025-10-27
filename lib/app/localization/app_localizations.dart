import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const _localizedValues = {
    'en': {
      'login': 'Login',
      'governmentId': 'Government ID',
      'password': 'Password',
      'rememberMe': 'Remember me',
      'forgotPassword': 'Forgot Password?',
      'dontHaveAccount': "Don't have an account?",
      'register': 'Register',
      'openNewFile': 'Open New Medical File',
      'createAccount': 'Create Account',
      'email': 'Email',
      'confirmPassword': 'Confirm Password',
      'alreadyHaveAccount': 'Already have an account?',
      'resetPassword': 'Reset Password',
      'newPassword': 'New Password',
      'medicalServices': 'Medical Services',
      'mouwasat': 'Mouwasat',
      'nationality': 'Nationality',
      'saudi': 'Saudi',
      'nonSaudi': 'Non-Saudi',
      'selectHospital': 'Select Hospital',
      'birthDate': 'Birth Date',
      'maritalStatus': 'Marital Status',
      'religion': 'Religion',
      'createMedicalFile': 'Create Medical File',
      'home': 'Home',
      'services': 'Services',
      'appointments': 'Appointments',
      'profile': 'Profile',
      'logout': 'Logout',
      'fullName': 'Full Name',
      'phoneNumber': 'Phone Number',
      'phoneNumberOptional': 'Phone Number (Optional)',
      'passwordRequirements': 'Password Requirements',
      'atLeast8Characters': 'At least 8 characters',
      'oneUppercaseLetter': 'One uppercase letter (A-Z)',
      'oneLowercaseLetter': 'One lowercase letter (a-z)',
      'oneNumber': 'One number (0-9)',
      'oneSpecialCharacter': 'One special character (!@#\$%^&*)',
      'enterFullName': 'Enter full name',
      'enterPhoneNumber': 'Enter phone number',
      'createPassword': 'Create a password',
      'confirmYourPassword': 'Confirm your password',
      'pleaseEnterFullName': 'Please enter full name',
      'pleaseEnterPhoneNumber': 'Please enter phone number',
      'pleaseEnterPassword': 'Please enter password',
      'pleaseConfirmPassword': 'Please confirm password',
      'passwordsDoNotMatch': 'Passwords do not match',
      'pleaseMeetAllPasswordRequirements': 'Please meet all password requirements',
      'enterYourGovernmentID': 'Enter your Government ID',
      'enterYourPassword': 'Enter your password',
      'enterYourEmail': 'Enter your email',
      'pleaseEnterValidEmail': 'Please enter a valid email',
      'pleaseSelectNationality': 'Please select nationality',
      'pleaseSelectHospital': 'Please select hospital',
      'pleaseSelectBirthDate': 'Please select birth date',
      'pleaseSelectMaritalStatus': 'Please select marital status',
      'pleaseSelectReligion': 'Please select religion',

      // New translations for NewFileScreen
      'createMedicalFileDescription': 'Create your medical file with Mouwasat Hospital',
      'pleaseEnterGovernmentId': 'Please enter Government ID',
      'mustBe10Digits': 'must be 10 digits',
      'pleaseEnterEmail': 'Please enter email',
      'enterGovernmentId': 'Enter Government ID',
      'selectBirthDate': 'Select birth date',

      // Hospitals
      'mouwasatHospitalRiyadh': 'Mouwasat Hospital Riyadh',
      'mouwasatHospitalDammam': 'Mouwasat Hospital Dammam',
      'mouwasatHospitalKhobar': 'Mouwasat Hospital Khobar',
      'mouwasatHospitalMedina': 'Mouwasat Hospital Medina',
      'mouwasatHospitalQatif': 'Mouwasat Hospital Qatif',

      // Marital Statuses
      'single': 'Single',
      'married': 'Married',
      'divorced': 'Divorced',
      'widowed': 'Widowed',

      // Religions
      'muslim': 'MUSLIM',
      'christian': 'CHRISTIAN',
      'jewish': 'JEWISH',
      'hindu': 'HINDU',
      'buddhist': 'BUDDHIST',
      'other': 'OTHER',
      'governmentIdMustBe10Digits': 'Government ID must be 10 digits',
      'passwordMustBeAtLeast8Characters': 'Password must be at least 8 characters',
      'passwordResetSuccessful': 'Password Reset Successful',
      'passwordResetDescription': 'Your password has been reset successfully. You can now login with your new password.',
      'selectDate': 'Select Date',
      'gregorian': 'Gregorian',
      'hijri': 'Hijri',
      'dateType': 'Date Type',
      'mouwasatHospital': 'Mouwasat Hospital',
      'yourHealthOurPriority': 'Your Health, Our Priority',
      "invalidGovernmentId": "invalid Government Id",
      "nameMustBeAtLeast2Characters": "name Must Be AtLeast 2 Characters",
      "enterPassword": "enter Password",
      "retry": "retry",
      "loading": "loading"

    },
    'ar': {
      'login': 'تسجيل الدخول',
      'governmentId': 'الهوية الوطنية',
      'password': 'كلمة المرور',
      'rememberMe': 'تذكرني',
      'forgotPassword': 'نسيت كلمة المرور؟',
      'dontHaveAccount': 'ليس لديك حساب؟',
      'register': 'إنشاء حساب',
      'openNewFile': 'فتح ملف طبي جديد',
      'createAccount': 'إنشاء حساب',
      'email': 'البريد الإلكتروني',
      'confirmPassword': 'تأكيد كلمة المرور',
      'alreadyHaveAccount': 'لديك حساب بالفعل؟',
      'resetPassword': 'إعادة تعيين كلمة المرور',
      'newPassword': 'كلمة المرور الجديدة',
      'medicalServices': 'الخدمات الطبية',
      'mouwasat': 'المواساة',
      'nationality': 'الجنسية',
      'saudi': 'سعودي',
      'nonSaudi': 'غير سعودي',
      'selectHospital': 'اختر المستشفى',
      'birthDate': 'تاريخ الميلاد',
      'maritalStatus': 'الحالة الاجتماعية',
      'religion': 'الديانة',
      'createMedicalFile': 'إنشاء ملف طبي',
      'home': 'الرئيسية',
      'services': 'الخدمات',
      'appointments': 'المواعيد',
      'profile': 'الملف الشخصي',
      'logout': 'تسجيل الخروج',
      'fullName': 'الاسم الكامل',
      'phoneNumber': 'رقم الهاتف',
      'phoneNumberOptional': 'رقم الهاتف (اختياري)',
      'passwordRequirements': 'متطلبات كلمة المرور',
      'atLeast8Characters': '8 أحرف على الأقل',
      'oneUppercaseLetter': 'حرف كبير واحد (A-Z)',
      'oneLowercaseLetter': 'حرف صغير واحد (a-z)',
      'oneNumber': 'رقم واحد (0-9)',
      'oneSpecialCharacter': 'رمز خاص واحد (!@#\$%^&*)',
      'enterFullName': 'أدخل الاسم الكامل',
      'enterPhoneNumber': 'أدخل رقم الهاتف',
      'createPassword': 'إنشاء كلمة مرور',
      'confirmYourPassword': 'تأكيد كلمة المرور',
      'pleaseEnterFullName': 'الرجاء إدخال الاسم الكامل',
      'pleaseEnterPhoneNumber': 'الرجاء إدخال رقم الهاتف',
      'pleaseEnterPassword': 'الرجاء إدخال كلمة المرور',
      'pleaseConfirmPassword': 'الرجاء تأكيد كلمة المرور',
      'passwordsDoNotMatch': 'كلمات المرور غير متطابقة',
      'pleaseMeetAllPasswordRequirements': 'الرجاء تلبية جميع متطلبات كلمة المرور',
      'enterYourGovernmentID': 'أدخل هويتك الوطنية',
      'enterYourPassword': 'أدخل كلمة المرور',
      'enterYourEmail': 'أدخل بريدك الإلكتروني',
      'pleaseEnterValidEmail': 'الرجاء إدخال بريد إلكتروني صالح',
      'pleaseSelectNationality': 'الرجاء اختيار الجنسية',
      'pleaseSelectHospital': 'الرجاء اختيار المستشفى',
      'pleaseSelectBirthDate': 'الرجاء اختيار تاريخ الميلاد',
      'pleaseSelectMaritalStatus': 'الرجاء اختيار الحالة الاجتماعية',
      'pleaseSelectReligion': 'الرجاء اختيار الديانة',
      'governmentIdMustBe10Digits': 'يجب أن يكون رقم الهوية 10 أرقام',
      'passwordMustBeAtLeast8Characters': 'يجب أن تكون كلمة المرور 8 أحرف على الأقل',
      'passwordResetSuccessful': 'تم إعادة تعيين كلمة المرور بنجاح',
      'passwordResetDescription': 'تم إعادة تعيين كلمة المرور بنجاح. يمكنك الآن تسجيل الدخول بكلمة المرور الجديدة.',
      'selectDate': 'اختر التاريخ',
      'gregorian': 'ميلادي',
      'hijri': 'هجري',
      'dateType': 'نوع التاريخ',

      // New translations for NewFileScreen
      'createMedicalFileDescription': 'أنشئ ملفك الطبي مع مستشفى المواساة',
      'pleaseEnterGovernmentId': 'الرجاء إدخال رقم الهوية',
      'mustBe10Digits': 'يجب أن يكون 10 أرقام',
      'pleaseEnterEmail': 'الرجاء إدخال البريد الإلكتروني',
      'enterGovernmentId': 'أدخل رقم الهوية',
      'selectBirthDate': 'اختر تاريخ الميلاد',

      // Hospitals
      'mouwasatHospitalRiyadh': 'مستشفى المواساة الرياض',
      'mouwasatHospitalDammam': 'مستشفى المواساة الدمام',
      'mouwasatHospitalKhobar': 'مستشفى المواساة الخبر',
      'mouwasatHospitalMedina': 'مستشفى المواساة المدينة',
      'mouwasatHospitalQatif': 'مستشفى المواساة القطيف',

      // Marital Statuses
      'single': 'أعزب',
      'married': 'متزوج',
      'divorced': 'مطلق',
      'widowed': 'أرمل',
      'muslim': 'مسلم',
      'christian': 'مسيحي',
      'jewish': 'يهودي',
      'hindu': 'هندوسي',
      'buddhist': 'بوذي',
      'other': 'أخرى',
      'mouwasatHospital': 'مستشفى المواساة',
      'yourHealthOurPriority': 'صحّتك هي أولويتنا',
      "invalidGovernmentId": "رقم الهوية غير صالح",
      "nameMustBeAtLeast2Characters": "يجب أن يكون الاسم على الأقل حرفين",
      "enterPassword": "أدخل كلمة المرور",
      "retry": "إعادة المحاولة",
      "loading": "جاري التحميل..."

    },
  };

  // Getters for all texts
  String get login => _localizedValues[locale.languageCode]!['login']!;
  String get governmentId => _localizedValues[locale.languageCode]!['governmentId']!;
  String get password => _localizedValues[locale.languageCode]!['password']!;
  String get rememberMe => _localizedValues[locale.languageCode]!['rememberMe']!;
  String get forgotPassword => _localizedValues[locale.languageCode]!['forgotPassword']!;
  String get dontHaveAccount => _localizedValues[locale.languageCode]!['dontHaveAccount']!;
  String get register => _localizedValues[locale.languageCode]!['register']!;
  String get openNewFile => _localizedValues[locale.languageCode]!['openNewFile']!;
  String get createAccount => _localizedValues[locale.languageCode]!['createAccount']!;
  String get email => _localizedValues[locale.languageCode]!['email']!;
  String get confirmPassword => _localizedValues[locale.languageCode]!['confirmPassword']!;
  String get alreadyHaveAccount => _localizedValues[locale.languageCode]!['alreadyHaveAccount']!;
  String get resetPassword => _localizedValues[locale.languageCode]!['resetPassword']!;
  String get newPassword => _localizedValues[locale.languageCode]!['newPassword']!;
  String get medicalServices => _localizedValues[locale.languageCode]!['medicalServices']!;
  String get mouwasat => _localizedValues[locale.languageCode]!['mouwasat']!;
  String get nationality => _localizedValues[locale.languageCode]!['nationality']!;
  String get saudi => _localizedValues[locale.languageCode]!['saudi']!;
  String get nonSaudi => _localizedValues[locale.languageCode]!['nonSaudi']!;
  String get selectHospital => _localizedValues[locale.languageCode]!['selectHospital']!;
  String get birthDate => _localizedValues[locale.languageCode]!['birthDate']!;
  String get maritalStatus => _localizedValues[locale.languageCode]!['maritalStatus']!;
  String get religion => _localizedValues[locale.languageCode]!['religion']!;
  String get createMedicalFile => _localizedValues[locale.languageCode]!['createMedicalFile']!;
  String get home => _localizedValues[locale.languageCode]!['home']!;
  String get services => _localizedValues[locale.languageCode]!['services']!;
  String get appointments => _localizedValues[locale.languageCode]!['appointments']!;
  String get profile => _localizedValues[locale.languageCode]!['profile']!;
  String get logout => _localizedValues[locale.languageCode]!['logout']!;
  String get fullName => _localizedValues[locale.languageCode]!['fullName']!;
  String get phoneNumber => _localizedValues[locale.languageCode]!['phoneNumber']!;
  String get phoneNumberOptional => _localizedValues[locale.languageCode]!['phoneNumberOptional']!;
  String get passwordRequirements => _localizedValues[locale.languageCode]!['passwordRequirements']!;
  String get atLeast8Characters => _localizedValues[locale.languageCode]!['atLeast8Characters']!;
  String get oneUppercaseLetter => _localizedValues[locale.languageCode]!['oneUppercaseLetter']!;
  String get oneLowercaseLetter => _localizedValues[locale.languageCode]!['oneLowercaseLetter']!;
  String get oneNumber => _localizedValues[locale.languageCode]!['oneNumber']!;
  String get oneSpecialCharacter => _localizedValues[locale.languageCode]!['oneSpecialCharacter']!;
  String get enterFullName => _localizedValues[locale.languageCode]!['enterFullName']!;
  String get enterPhoneNumber => _localizedValues[locale.languageCode]!['enterPhoneNumber']!;
  String get createPassword => _localizedValues[locale.languageCode]!['createPassword']!;
  String get confirmYourPassword => _localizedValues[locale.languageCode]!['confirmYourPassword']!;
  String get pleaseEnterFullName => _localizedValues[locale.languageCode]!['pleaseEnterFullName']!;
  String get pleaseEnterPhoneNumber => _localizedValues[locale.languageCode]!['pleaseEnterPhoneNumber']!;
  String get pleaseEnterPassword => _localizedValues[locale.languageCode]!['pleaseEnterPassword']!;
  String get pleaseConfirmPassword => _localizedValues[locale.languageCode]!['pleaseConfirmPassword']!;
  String get passwordsDoNotMatch => _localizedValues[locale.languageCode]!['passwordsDoNotMatch']!;
  String get pleaseMeetAllPasswordRequirements => _localizedValues[locale.languageCode]!['pleaseMeetAllPasswordRequirements']!;
  String get enterYourGovernmentID => _localizedValues[locale.languageCode]!['enterYourGovernmentID']!;
  String get enterYourPassword => _localizedValues[locale.languageCode]!['enterYourPassword']!;
  String get enterYourEmail => _localizedValues[locale.languageCode]!['enterYourEmail']!;
  String get pleaseEnterValidEmail => _localizedValues[locale.languageCode]!['pleaseEnterValidEmail']!;
  String get pleaseSelectNationality => _localizedValues[locale.languageCode]!['pleaseSelectNationality']!;
  String get pleaseSelectHospital => _localizedValues[locale.languageCode]!['pleaseSelectHospital']!;
  String get pleaseSelectBirthDate => _localizedValues[locale.languageCode]!['pleaseSelectBirthDate']!;
  String get pleaseSelectMaritalStatus => _localizedValues[locale.languageCode]!['pleaseSelectMaritalStatus']!;
  String get pleaseSelectReligion => _localizedValues[locale.languageCode]!['pleaseSelectReligion']!;

  // New getters for NewFileScreen
  String get createMedicalFileDescription => _localizedValues[locale.languageCode]!['createMedicalFileDescription']!;
  String get pleaseEnterGovernmentId => _localizedValues[locale.languageCode]!['pleaseEnterGovernmentId']!;
  String get mustBe10Digits => _localizedValues[locale.languageCode]!['mustBe10Digits']!;
  String get pleaseEnterEmail => _localizedValues[locale.languageCode]!['pleaseEnterEmail']!;
  String get enterGovernmentId => _localizedValues[locale.languageCode]!['enterGovernmentId']!;
  String get selectBirthDate => _localizedValues[locale.languageCode]!['selectBirthDate']!;

  // Hospitals getters
  String get mouwasatHospitalRiyadh => _localizedValues[locale.languageCode]!['mouwasatHospitalRiyadh']!;
  String get mouwasatHospitalDammam => _localizedValues[locale.languageCode]!['mouwasatHospitalDammam']!;
  String get mouwasatHospitalKhobar => _localizedValues[locale.languageCode]!['mouwasatHospitalKhobar']!;
  String get mouwasatHospitalMedina => _localizedValues[locale.languageCode]!['mouwasatHospitalMedina']!;
  String get mouwasatHospitalQatif => _localizedValues[locale.languageCode]!['mouwasatHospitalQatif']!;

  // Marital Statuses getters
  String get single => _localizedValues[locale.languageCode]!['single']!;
  String get married => _localizedValues[locale.languageCode]!['married']!;
  String get divorced => _localizedValues[locale.languageCode]!['divorced']!;
  String get widowed => _localizedValues[locale.languageCode]!['widowed']!;

  // Religions getters
  String get muslim => _localizedValues[locale.languageCode]!['muslim']!;
  String get christian => _localizedValues[locale.languageCode]!['christian']!;
  String get jewish => _localizedValues[locale.languageCode]!['jewish']!;
  String get hindu => _localizedValues[locale.languageCode]!['hindu']!;
  String get buddhist => _localizedValues[locale.languageCode]!['buddhist']!;
  String get other => _localizedValues[locale.languageCode]!['other']!;
  String get governmentIdMustBe10Digits => _localizedValues[locale.languageCode]!['governmentIdMustBe10Digits']!;
  String get passwordMustBeAtLeast8Characters => _localizedValues[locale.languageCode]!['passwordMustBeAtLeast8Characters']!;
  String get passwordResetSuccessful => _localizedValues[locale.languageCode]!['passwordResetSuccessful']!;
  String get passwordResetDescription => _localizedValues[locale.languageCode]!['passwordResetDescription']!;
  String get selectDate => _localizedValues[locale.languageCode]!['selectDate']!;
  String get gregorian => _localizedValues[locale.languageCode]!['gregorian']!;
  String get hijri => _localizedValues[locale.languageCode]!['hijri']!;
  String get dateType => _localizedValues[locale.languageCode]!['dateType']!;
  String get mouwasatHospital => _localizedValues[locale.languageCode]!['mouwasatHospital']!;
  String get yourHealthOurPriority => _localizedValues[locale.languageCode]!['yourHealthOurPriority']!;
  String get selectNationality => _localizedValues[locale.languageCode]!['selectNationality']!;
  String get retry => 'Retry';
  String get loading => 'Loading...';

}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}