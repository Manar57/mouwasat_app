import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import '../app/localization/app_localizations.dart';
import '../widgets/form_fields.dart';
import '../app/theme/app_theme.dart';
import '../utils/error_utils.dart';

class RegisterScreen extends StatefulWidget {
  final AuthService authService; // Service for API calls

  const RegisterScreen({
    Key? key,
    required this.authService,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _governmentIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false; // Loading state for submit button
  bool _obscurePassword = true; // Show/hide password
  bool _obscureConfirmPassword = true; // Show/hide confirm password
  bool _rememberMe = true; // Save credentials
  String? _errorMessage; // Display errors

  // Password validation requirements
  Map<String, bool> _passwordRequirements = {
    'minLength': false,
    'hasUpperCase': false,
    'hasLowerCase': false,
    'hasNumber': false,
    'hasSpecialChar': false,
  };

  // Update password requirements as user types
  void _validatePassword(String password) {
    setState(() {
      _passwordRequirements = ErrorUtils.validatePassword(password);
    });
  }

  // Check if all password requirements are met
  bool get _isPasswordValid {
    return _passwordRequirements.values.every((isMet) => isMet);
  }

  // Handle registration process
  Future<void> _handleRegistration() async {
    if (!_formKey.currentState!.validate()) return; // Validate form fields

    if (!_isPasswordValid) {
      setState(() {
        _errorMessage = localizations.pleaseMeetAllPasswordRequirements;
      });
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = localizations.passwordsDoNotMatch;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = await widget.authService.register(
        governmentId: _governmentIdController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        saveCredentials: _rememberMe,
      );

      if (mounted) {
        // Navigate to home screen after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              user: user,
              changeLanguage: (locale) {}, // Placeholder
              currentLocale: Locale('en'),
              authService: widget.authService,
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = ErrorUtils.getTranslatedErrorMessage(e.toString(), localizations);
        _isLoading = false;
      });
    }
  }

  late AppLocalizations localizations; // Localization object

  @override
  Widget build(BuildContext context) {
    localizations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Go back
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                _buildHeader(localizations), // Page title
                SizedBox(height: 32),
                _buildRegistrationForm(), // Form fields
                SizedBox(height: 24),
                _buildRegisterButton(), // Submit button
                SizedBox(height: 16),
                _buildLoginLink(), // Link to login screen
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Page header
  Widget _buildHeader(AppLocalizations localizations) {
    return Column(
      children: [
        Text(
          localizations.register,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }

  // Form fields
  Widget _buildRegistrationForm() {
    return Column(
      children: [
        GovernmentIdField(controller: _governmentIdController),
        SizedBox(height: 16),
        NameField(controller: _nameController),
        SizedBox(height: 16),
        EmailField(controller: _emailController),
        SizedBox(height: 16),
        PasswordField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          onToggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword),
          onChanged: _validatePassword, // Live password validation
        ),
        SizedBox(height: 12),
        PasswordRequirementsWidget(
          requirements: _passwordRequirements,
          localizations: localizations, // Show password rules
        ),
        SizedBox(height: 16),
        PasswordField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          onToggleVisibility: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
          labelText: localizations.confirmPassword,
          hintText: localizations.confirmYourPassword,
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (value) => setState(() => _rememberMe = value!),
              activeColor: AppTheme.primaryColor,
            ),
            Text(localizations.rememberMe),
          ],
        ),
        if (_errorMessage != null) ...[
          SizedBox(height: 16),
          ErrorMessageWidget(message: _errorMessage!),
        ],
      ],
    );
  }

  // Submit button
  Widget _buildRegisterButton() {
    return SubmitButton(
      text: localizations.createAccount,
      onPressed: _handleRegistration,
      isLoading: _isLoading,
    );
  }

  // Link to login screen
  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${localizations.alreadyHaveAccount} "),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(
                  changeLanguage: (locale) {},
                  currentLocale: Locale('en'),
                  authService: widget.authService,
                ),
              ),
            );
          },
          child: Text(
            localizations.login,
            style: TextStyle(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _governmentIdController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
