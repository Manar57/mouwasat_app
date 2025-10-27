import '../app/localization/app_localizations.dart';

class ErrorUtils {
  /// Returns a translated and user-friendly error message
  static String getTranslatedErrorMessage(String error, AppLocalizations localizations) {
    // Government ID errors
    if (error.contains('Government ID') && error.contains('10 digits')) {
      return localizations.governmentIdMustBe10Digits;
    }
    if (error.contains('Government ID') && error.contains('enter')) {
      return localizations.pleaseEnterGovernmentId;
    }

    // Email errors
    if (error.contains('email') && error.contains('enter')) {
      return localizations.pleaseEnterEmail;
    }
    if (error.contains('email') && error.contains('valid')) {
      return localizations.pleaseEnterValidEmail;
    }

    // Password errors
    if (error.contains('password') && error.contains('enter')) {
      return localizations.pleaseEnterPassword;
    }
    if (error.contains('password') && error.contains('8 characters')) {
      return localizations.passwordMustBeAtLeast8Characters;
    }
    if (error.contains('password') && error.contains('confirm')) {
      return localizations.pleaseConfirmPassword;
    }
    if (error.contains('password') && error.contains('match')) {
      return localizations.passwordsDoNotMatch;
    }
    if (error.contains('password') && error.contains('requirements')) {
      return localizations.pleaseMeetAllPasswordRequirements;
    }

    // Name errors
    if (error.contains('full name') && error.contains('enter')) {
      return localizations.pleaseEnterFullName;
    }

    // Phone errors
    if (error.contains('phone number') && error.contains('enter')) {
      return localizations.pleaseEnterPhoneNumber;
    }

    // Selection errors
    if (error.contains('nationality') && error.contains('select')) {
      return localizations.pleaseSelectNationality;
    }
    if (error.contains('hospital') && error.contains('select')) {
      return localizations.pleaseSelectHospital;
    }
    if (error.contains('birth date') && error.contains('select')) {
      return localizations.pleaseSelectBirthDate;
    }
    if (error.contains('marital status') && error.contains('select')) {
      return localizations.pleaseSelectMaritalStatus;
    }
    if (error.contains('religion') && error.contains('select')) {
      return localizations.pleaseSelectReligion;
    }

    // Authentication errors
    if (error.contains('invalid credentials') || error.contains('wrong password')) {
      return 'Invalid credentials. Please check your Government ID and password.';
    }
    if (error.contains('user not found')) {
      return 'User not found. Please check your Government ID.';
    }
    if (error.contains('already exists')) {
      return 'User already exists with this Government ID.';
    }

    // Network errors
    if (error.contains('network') || error.contains('connection')) {
      return 'Network error. Please check your internet connection.';
    }
    if (error.contains('timeout')) {
      return 'Request timeout. Please try again.';
    }
    if (error.contains('server')) {
      return 'Server error. Please try again later.';
    }

    // Default fallback
    return error.isNotEmpty ? error : 'An unknown error occurred.';
  }

  /// Helper function to validate password against requirements
  static Map<String, bool> validatePassword(String password) {
    return {
      'minLength': password.length >= 8,
      'hasUpperCase': RegExp(r'[A-Z]').hasMatch(password),
      'hasLowerCase': RegExp(r'[a-z]').hasMatch(password),
      'hasNumber': RegExp(r'[0-9]').hasMatch(password),
      'hasSpecialChar': RegExp(r'[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]').hasMatch(password),
    };
  }

  /// Checks if a password is valid (all requirements met)
  static bool isPasswordValid(String password) {
    final requirements = validatePassword(password);
    return requirements.values.every((isMet) => isMet);
  }

  /// Returns a list of password requirements for display
  static List<String> getPasswordRequirements(AppLocalizations localizations) {
    return [
      localizations.atLeast8Characters,
      localizations.oneUppercaseLetter,
      localizations.oneLowercaseLetter,
      localizations.oneNumber,
      localizations.oneSpecialCharacter,
    ];
  }

  /// Validate Saudi National ID
  static bool isValidGovernmentId(String governmentId) {
    if (governmentId.length != 10) return false;
    if (!RegExp(r'^[0-9]+$').hasMatch(governmentId)) return false;
    return true;
  }

  /// Validate email format
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Validate Saudi phone number
  static bool isValidSaudiPhoneNumber(String phone) {
    return RegExp(r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$').hasMatch(phone);
  }
}
