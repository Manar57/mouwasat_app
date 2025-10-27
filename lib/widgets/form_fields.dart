import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/input_formatters.dart';
import '../app/localization/app_localizations.dart';
import '../app/theme/app_theme.dart';
import '../utils/error_utils.dart';

// National ID field
class GovernmentIdField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final bool enabled;
  final Color? color;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;

  const GovernmentIdField({
    Key? key,
    required this.controller,
    this.validator,
    this.hintText,
    this.labelText,
    this.color,
    this.enabled = true,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      textInputAction: textInputAction,
      inputFormatters: [
        ArabicDigitsInputFormatter(),
        LengthLimitingTextInputFormatter(10),
      ],
      enabled: enabled,
      onChanged: onChanged,
      autofillHints: const [AutofillHints.username],
      decoration: InputDecoration(
        labelText: labelText ?? localizations.governmentId,
        hintText: hintText ?? localizations.enterGovernmentId,
        prefixIcon: Icon(Icons.badge_outlined, color: AppTheme.primaryColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primaryColor),
        ),
      ),
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return localizations.pleaseEnterGovernmentId;
        }
        if (value.length != 10) {
          return localizations.governmentIdMustBe10Digits;
        }
        return null;
      },
    );
  }
}

// Full Name field
class NameField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final bool enabled;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;

  const NameField({
    Key? key,
    required this.controller,
    this.validator,
    this.hintText,
    this.labelText,
    this.enabled = true,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      enabled: enabled,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText ?? localizations.fullName,
        hintText: hintText ?? localizations.enterFullName,
        prefixIcon: Icon(Icons.person_outline, color: AppTheme.primaryColor),
      ),
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return localizations.pleaseEnterFullName;
        }
        return null;
      },
    );
  }
}

// Email field
class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final bool enabled;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;

  const EmailField({
    Key? key,
    required this.controller,
    this.validator,
    this.hintText,
    this.labelText,
    this.enabled = true,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction,
      enabled: enabled,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText ?? localizations.email,
        hintText: hintText ?? localizations.enterYourEmail,
        prefixIcon: Icon(Icons.email_outlined, color: AppTheme.primaryColor),
      ),
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return localizations.pleaseEnterEmail;
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return localizations.pleaseEnterValidEmail;
        }
        return null;
      },
    );
  }
}

// Password field
class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final String? labelText;
  final String? hintText;
  final bool enabled;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;

  const PasswordField({
    Key? key,
    required this.controller,
    this.validator,
    required this.obscureText,
    required this.onToggleVisibility,
    this.labelText,
    this.hintText,
    this.enabled = true,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      textInputAction: textInputAction,
      enabled: enabled,
      onChanged: onChanged,
      autofillHints: const [AutofillHints.password],
      decoration: InputDecoration(
        labelText: labelText ?? localizations.password,
        hintText: hintText ?? localizations.createPassword,
        prefixIcon: Icon(Icons.lock_outline, color: AppTheme.primaryColor),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: AppTheme.primaryColor,
          ),
          onPressed: onToggleVisibility,
        ),
      ),
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return localizations.pleaseEnterPassword;
        }
        return null;
      },
    );
  }
}

// Confirm Password field
class ConfirmPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController passwordController;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final String? labelText;
  final String? hintText;

  const ConfirmPasswordField({
    Key? key,
    required this.controller,
    required this.passwordController,
    required this.obscureText,
    required this.onToggleVisibility,
    this.labelText,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: labelText ?? localizations.confirmPassword,
        hintText: hintText ?? localizations.confirmYourPassword,
        prefixIcon: Icon(Icons.lock_outline, color: AppTheme.primaryColor),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: AppTheme.primaryColor,
          ),
          onPressed: onToggleVisibility,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return localizations.pleaseConfirmPassword;
        }
        if (value != passwordController.text) {
          return localizations.passwordsDoNotMatch;
        }
        return null;
      },
    );
  }
}

// Phone number field
class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final bool enabled;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;

  const PhoneField({
    Key? key,
    required this.controller,
    this.validator,
    this.hintText,
    this.labelText,
    this.enabled = true,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      textInputAction: textInputAction,
      enabled: enabled,
      onChanged: onChanged,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      decoration: InputDecoration(
        labelText: labelText ?? localizations.phoneNumber,
        hintText: hintText ?? localizations.enterPhoneNumber,
        prefixIcon: Icon(Icons.phone_outlined, color: AppTheme.primaryColor),
      ),
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return localizations.pleaseEnterPhoneNumber;
        }
        return null;
      },
    );
  }
}

// Outlined button
class OutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;
  final bool enabled;
  final IconData? icon;

  const OutlineButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isLoading,
    this.width,
    this.enabled = true,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: (enabled && !isLoading) ? onPressed : null,
        child: isLoading
            ? SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            color: AppTheme.primaryColor,
            strokeWidth: 2,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: AppTheme.primaryColor),
              SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Error message widget
class ErrorMessageWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorMessageWidget({
    Key? key,
    required this.message,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: AppTheme.errorContainerDecoration,
      child: Row(
        children: [
          Icon(Icons.error_outline, color: AppTheme.errorColor, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: AppTheme.errorColor,
                fontSize: 14,
              ),
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(width: 8),
            TextButton(
              onPressed: onRetry,
              child: Text(
                localizations.retry ?? 'Retry',
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Success message widget
class SuccessMessageWidget extends StatelessWidget {
  final String message;

  const SuccessMessageWidget({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: AppTheme.successContainerDecoration,
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, color: AppTheme.successColor, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: AppTheme.successColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Password requirements widget
class PasswordRequirementsWidget extends StatelessWidget {
  final Map<String, bool> requirements;
  final AppLocalizations localizations;

  const PasswordRequirementsWidget({
    Key? key,
    required this.requirements,
    required this.localizations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final requirementList = [
      localizations.atLeast8Characters,
      localizations.oneUppercaseLetter,
      localizations.oneLowercaseLetter,
      localizations.oneNumber,
      localizations.oneSpecialCharacter,
    ];

    return Container(
      padding: EdgeInsets.all(16),
      decoration: AppTheme.containerDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.passwordRequirements,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryColor,
            ),
          ),
          SizedBox(height: 12),
          _buildRequirementItem(requirementList[0], requirements['minLength'] ?? false),
          _buildRequirementItem(requirementList[1], requirements['hasUpperCase'] ?? false),
          _buildRequirementItem(requirementList[2], requirements['hasLowerCase'] ?? false),
          _buildRequirementItem(requirementList[3], requirements['hasNumber'] ?? false),
          _buildRequirementItem(requirementList[4], requirements['hasSpecialChar'] ?? false),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text, bool isMet) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.circle_outlined,
            color: isMet ? AppTheme.successColor : AppTheme.grey300,
            size: 18,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isMet ? AppTheme.successColor : AppTheme.grey300,
                fontSize: 14,
                fontWeight: isMet ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Remember Me Checkbox
class RememberMeCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const RememberMeCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppTheme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Text(
          localizations.rememberMe,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

// Loading overlay
class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: AppTheme.primaryColor,
                    ),
                    SizedBox(height: 16),
                    Text(
                      localizations.loading ?? 'Loading...',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
