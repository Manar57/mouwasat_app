import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../app/localization/app_localizations.dart';
import '../widgets/form_fields.dart';
import '../app/theme/app_theme.dart';
import '../utils/error_utils.dart';
import 'home_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  // Authentication service dependency
  final AuthService authService;

  const ForgotPasswordScreen({
    Key? key,
    required this.authService,
  }) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // Form controllers
  final TextEditingController _governmentIdController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Key used to validate form fields
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // UI state variables
  bool _isLoading = false;
  bool _obscureNewPassword = true;      // Toggles "show/hide password" icon
  bool _obscureConfirmPassword = true;
  bool _resetSuccess = false;           // Switches UI to success state
  String? _errorMessage;                // Holds translated error message

  // Handles password reset logic
  Future<void> _handleResetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Attempt reset using provided government ID and new password
      await widget.authService.resetPassword(
        governmentId: _governmentIdController.text.trim(),
        newPassword: _newPasswordController.text,
      );

      // Display success UI
      if (mounted) {
        setState(() {
          _resetSuccess = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      // Display translated error message
      if (mounted) {
        setState(() {
          _errorMessage = ErrorUtils.getTranslatedErrorMessage(
            e.toString(),
            AppLocalizations.of(context),
          );
          _isLoading = false;
        });
      }
    }
  }

  // Navigates back to login screen
  void _navigateToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: _resetSuccess
          // If reset was successful, show success state UI
              ? _buildSuccessState(localizations)
          // Otherwise show reset form
              : Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                _buildHeader(localizations),
                SizedBox(height: 32),
                _buildResetForm(localizations),
                SizedBox(height: 24),
                _buildResetButton(localizations),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Screen title header
  Widget _buildHeader(AppLocalizations localizations) {
    return Column(
      children: [
        Text(
          localizations.resetPassword,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }

  // Input fields for reset
  Widget _buildResetForm(AppLocalizations localizations) {
    return Column(
      children: [
        GovernmentIdField(controller: _governmentIdController),
        SizedBox(height: 16),
        PasswordField(
          controller: _newPasswordController,
          obscureText: _obscureNewPassword,
          onToggleVisibility: () =>
              setState(() => _obscureNewPassword = !_obscureNewPassword),
          labelText: localizations.newPassword,
        ),
        SizedBox(height: 16),
        PasswordField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          onToggleVisibility: () =>
              setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
          labelText: localizations.confirmPassword,
          hintText: localizations.confirmYourPassword,
        ),
        if (_errorMessage != null) ...[
          SizedBox(height: 16),
          ErrorMessageWidget(message: _errorMessage!),
        ],
      ],
    );
  }

  // Submit button that triggers password reset
  Widget _buildResetButton(AppLocalizations localizations) {
    return SubmitButton(
      text: localizations.resetPassword,
      onPressed: _handleResetPassword,
      isLoading: _isLoading,
    );
  }

  // UI displayed when reset succeeds
  Widget _buildSuccessState(AppLocalizations localizations) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 60),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppTheme.successColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle_outline,
            color: AppTheme.successColor,
            size: 60,
          ),
        ),
        SizedBox(height: 32),
        Text(
          localizations.passwordResetSuccessful,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 16),
        Text(
          localizations.passwordResetDescription,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: 48),
        SubmitButton(
          text: localizations.login,
          onPressed: _navigateToLogin,
          isLoading: false,
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Dispose controllers to free memory
    _governmentIdController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
