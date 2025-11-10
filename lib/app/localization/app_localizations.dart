// app_localizations.dart
import 'package:flutter/material.dart';
import 'en.dart' as en_lang;
import 'ar.dart' as ar_lang;

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': en_lang.en,
    'ar': ar_lang.ar,
  };

  String _getText(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  // Getters for all texts
  String get login => _getText('login');
  String get governmentId => _getText('governmentId');
  String get password => _getText('password');
  String get rememberMe => _getText('rememberMe');
  String get forgotPassword => _getText('forgotPassword');
  String get dontHaveAccount => _getText('dontHaveAccount');
  String get register => _getText('register');
  String get openNewFile => _getText('openNewFile');
  String get createAccount => _getText('createAccount');
  String get email => _getText('email');
  String get confirmPassword => _getText('confirmPassword');
  String get alreadyHaveAccount => _getText('alreadyHaveAccount');
  String get resetPassword => _getText('resetPassword');
  String get newPassword => _getText('newPassword');
  String get medicalServices => _getText('medicalServices');
  String get mouwasat => _getText('mouwasat');
  String get nationality => _getText('nationality');
  String get saudi => _getText('saudi');
  String get nonSaudi => _getText('nonSaudi');
  String get selectHospital => _getText('selectHospital');
  String get birthDate => _getText('birthDate');
  String get maritalStatus => _getText('maritalStatus');
  String get religion => _getText('religion');
  String get createMedicalFile => _getText('createMedicalFile');
  String get home => _getText('home');
  String get services => _getText('services');
  String get appointments => _getText('appointments');
  String get profile => _getText('profile');
  String get logout => _getText('logout');
  String get fullName => _getText('fullName');
  String get phoneNumber => _getText('phoneNumber');
  String get phoneNumberOptional => _getText('phoneNumberOptional');
  String get passwordRequirements => _getText('passwordRequirements');
  String get atLeast8Characters => _getText('atLeast8Characters');
  String get oneUppercaseLetter => _getText('oneUppercaseLetter');
  String get oneLowercaseLetter => _getText('oneLowercaseLetter');
  String get oneNumber => _getText('oneNumber');
  String get oneSpecialCharacter => _getText('oneSpecialCharacter');
  String get enterFullName => _getText('enterFullName');
  String get enterPhoneNumber => _getText('enterPhoneNumber');
  String get createPassword => _getText('createPassword');
  String get confirmYourPassword => _getText('confirmYourPassword');
  String get pleaseEnterFullName => _getText('pleaseEnterFullName');
  String get pleaseEnterPhoneNumber => _getText('pleaseEnterPhoneNumber');
  String get pleaseEnterPassword => _getText('pleaseEnterPassword');
  String get pleaseConfirmPassword => _getText('pleaseConfirmPassword');
  String get passwordsDoNotMatch => _getText('passwordsDoNotMatch');
  String get pleaseMeetAllPasswordRequirements => _getText('pleaseMeetAllPasswordRequirements');
  String get enterYourGovernmentID => _getText('enterYourGovernmentID');
  String get enterYourPassword => _getText('enterYourPassword');
  String get enterYourEmail => _getText('enterYourEmail');
  String get pleaseEnterValidEmail => _getText('pleaseEnterValidEmail');
  String get pleaseSelectNationality => _getText('pleaseSelectNationality');
  String get pleaseSelectHospital => _getText('pleaseSelectHospital');
  String get pleaseSelectBirthDate => _getText('pleaseSelectBirthDate');
  String get pleaseSelectMaritalStatus => _getText('pleaseSelectMaritalStatus');
  String get pleaseSelectReligion => _getText('pleaseSelectReligion');
  String get createMedicalFileDescription => _getText('createMedicalFileDescription');
  String get pleaseEnterGovernmentId => _getText('pleaseEnterGovernmentId');
  String get mustBe10Digits => _getText('mustBe10Digits');
  String get pleaseEnterEmail => _getText('pleaseEnterEmail');
  String get enterGovernmentId => _getText('enterGovernmentId');
  String get selectBirthDate => _getText('selectBirthDate');
  String get mouwasatHospitalRiyadh => _getText('mouwasatHospitalRiyadh');
  String get mouwasatHospitalDammam => _getText('mouwasatHospitalDammam');
  String get mouwasatHospitalKhobar => _getText('mouwasatHospitalKhobar');
  String get mouwasatHospitalMedina => _getText('mouwasatHospitalMedina');
  String get mouwasatHospitalQatif => _getText('mouwasatHospitalQatif');
  String get single => _getText('single');
  String get married => _getText('married');
  String get divorced => _getText('divorced');
  String get widowed => _getText('widowed');
  String get muslim => _getText('muslim');
  String get christian => _getText('christian');
  String get jewish => _getText('jewish');
  String get hindu => _getText('hindu');
  String get buddhist => _getText('buddhist');
  String get other => _getText('other');
  String get governmentIdMustBe10Digits => _getText('governmentIdMustBe10Digits');
  String get passwordMustBeAtLeast8Characters => _getText('passwordMustBeAtLeast8Characters');
  String get passwordResetSuccessful => _getText('passwordResetSuccessful');
  String get passwordResetDescription => _getText('passwordResetDescription');
  String get selectDate => _getText('selectDate');
  String get gregorian => _getText('gregorian');
  String get hijri => _getText('hijri');
  String get dateType => _getText('dateType');
  String get mouwasatHospital => _getText('mouwasatHospital');
  String get yourHealthOurPriority => _getText('yourHealthOurPriority');
  String get invalidGovernmentId => _getText('invalidGovernmentId');
  String get nameMustBeAtLeast2Characters => _getText('nameMustBeAtLeast2Characters');
  String get enterPassword => _getText('enterPassword');
  String get retry => _getText('retry');
  String get loading => _getText('loading');
  String get selectNationality => _getText('selectNationality');


  String get appTitle => _getText('appTitle');
  String get bmiCalculator => _getText('bmiCalculator');
  String get bmiSubtitle => _getText('bmiSubtitle');
  String get bmrCalculator => _getText('bmrCalculator');
  String get bmrSubtitle => _getText('bmrSubtitle');
  String get bodyFatCalculator => _getText('bodyFatCalculator');
  String get bodyFatSubtitle => _getText('bodyFatSubtitle');
  String get advancedBmiCalculator => _getText('advancedBmiCalculator');
  String get bmrCalculatorTitle => _getText('bmrCalculatorTitle');
  String get bodyFatCalculatorTitle => _getText('bodyFatCalculatorTitle');
  String get pleaseCorrectErrors => _getText('pleaseCorrectErrors');
  String get pleaseEnterAllNumbers => _getText('pleaseEnterAllNumbers');
  String get calculationError => _getText('calculationError');
  String get errorInCalculation => _getText('errorInCalculation');
  String get underweight => _getText('underweight');
  String get normalWeight => _getText('normalWeight');
  String get overweight => _getText('overweight');
  String get obese => _getText('obese');
  String get gender => _getText('gender');
  String get male => _getText('male');
  String get female => _getText('female');
  String get age => _getText('age');
  String get years => _getText('years');
  String get enterAge => _getText('enterAge');
  String get weight => _getText('weight');
  String get kg => _getText('kg');
  String get enterWeight => _getText('enterWeight');
  String get height => _getText('height');
  String get cm => _getText('cm');
  String get enterHeight => _getText('enterHeight');
  String get calculateBmi => _getText('calculateBmi');
  String get yourBodyAnalysis => _getText('yourBodyAnalysis');
  String get errorAge => _getText('errorAge');
  String get errorWeight => _getText('errorWeight');
  String get errorHeight => _getText('errorHeight');
  String get bodyFat => _getText('bodyFat');
  String get percent => _getText('percent');
  String get enterBodyFat => _getText('enterBodyFat');
  String get muscleMass => _getText('muscleMass');
  String get enterMuscleMass => _getText('enterMuscleMass');
  String get errorBodyFat => _getText('errorBodyFat');
  String get errorMuscleMass => _getText('errorMuscleMass');
  String get bodyCompositionAnalysis => _getText('bodyCompositionAnalysis');
  String get bodyCompositionSubtitle => _getText('bodyCompositionSubtitle');
  String get bmiScale => _getText('bmiScale');
  String get calculateBmr => _getText('calculateBmr');
  String get calculateBodyFat => _getText('calculateBodyFat');
  String get waist => _getText('waist');
  String get neck => _getText('neck');
  String get hip => _getText('hip');
  String get enterWaist => _getText('enterWaist');
  String get enterNeck => _getText('enterNeck');
  String get enterHip => _getText('enterHip');
  String get errorWaist => _getText('errorWaist');
  String get errorNeck => _getText('errorNeck');
  String get errorHip => _getText('errorHip');
  String get bmiScaleUnderweight => _getText('bmiScaleUnderweight');
  String get bmiScaleNormal => _getText('bmiScaleNormal');
  String get bmiScaleOverweight => _getText('bmiScaleOverweight');
  String get bmiScaleObese => _getText('bmiScaleObese');
  String get weightGainRequired => _getText('weightGainRequired');
  String get weightLossRequired => _getText('weightLossRequired');
  String get idealWeightRange => _getText('idealWeightRange');
  String get bodyFatPercentage => _getText('bodyFatPercentage');
  String get muscleMassPercentage => _getText('muscleMassPercentage');
  String get optional => _getText('optional');
  String get addBodyComposition => _getText('addBodyComposition');
  String get calculated => _getText('calculated');
  String get sedentary => _getText('sedentary');
  String get sedentaryDesc => _getText('sedentaryDesc');
  String get lightlyActive => _getText('lightlyActive');
  String get lightlyActiveDesc => _getText('lightlyActiveDesc');
  String get moderatelyActive => _getText('moderatelyActive');
  String get moderatelyActiveDesc => _getText('moderatelyActiveDesc');
  String get veryActive => _getText('veryActive');
  String get veryActiveDesc => _getText('veryActiveDesc');
  String get extraActive => _getText('extraActive');
  String get extraActiveDesc => _getText('extraActiveDesc');
  String get dailyCalorieNeeds => _getText('dailyCalorieNeeds');
  String get calories => _getText('calories');
  String get essentialFat => _getText('essentialFat');
  String get athletic => _getText('athletic');
  String get fitness => _getText('fitness');
  String get average => _getText('average');
  String get needToGain => _getText('needToGain');
  String get needToLose => _getText('needToLose');
  String get kgToReachNormal => _getText('kgToReachNormal');
  String get greatBmiInRange => _getText('greatBmiInRange');
  String get bmrDescription => _getText('bmrDescription');
  String get bodyFatDescription => _getText('bodyFatDescription');
  String get yourBmiResult => _getText('yourBmiResult');
  String get yourBmrResult => _getText('yourBmrResult');
  String get yourBodyFatResult => _getText('yourBodyFatResult');
  String get invalidValue => _getText('invalidValue');
  String get status => _getText('status');
  String get bmi => _getText('bmi');
  String get pleaseSelectGender => _getText('pleaseSelectGender');
  String get bodyComposition => _getText('bodyComposition');
  String get error => _getText('error');
  String get bmiUnderweightDesc => _getText('bmiUnderweightDesc');
  String get bmiNormalDesc => _getText('bmiNormalDesc');
  String get bmiOverweightDesc => _getText('bmiOverweightDesc');
  String get bmiObeseDesc => _getText('bmiObeseDesc');
  String get hospitalsTitle => _getText('hospitalsTitle');
  String get healthTools => _getText('healthTools');

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