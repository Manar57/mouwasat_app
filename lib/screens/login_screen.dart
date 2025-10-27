import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'new_file_screen.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';
import '../widgets/form_fields.dart';
import '../app/localization/app_localizations.dart';
import '../app/theme/app_theme.dart';
import '../utils/error_utils.dart';

class LoginScreen extends StatefulWidget {
  final Function(Locale) changeLanguage;
  final Locale currentLocale;
  final AuthService authService;

  const LoginScreen({
    Key? key,
    required this.changeLanguage,
    required this.currentLocale,
    required this.authService,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for text input fields
  final TextEditingController _governmentIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // UI state variables
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _rememberMe = true;
  String? _errorMessage;
  double _logoOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _checkSavedCredentials(); // Load saved credentials if any
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) setState(() => _logoOpacity = 1.0); // Fade-in logo animation
    });
  }

  // Load saved credentials from local storage
  Future<void> _checkSavedCredentials() async {
    final credentials = await widget.authService.getSavedCredentials();
    if (credentials != null && mounted) {
      setState(() {
        _governmentIdController.text = credentials.governmentId;
        _passwordController.text = credentials.password;
        _rememberMe = true;
      });
    }
  }

  // Handle login process
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return; // Stop if form is invalid

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = await widget.authService.login(
        governmentId: _governmentIdController.text.trim(),
        password: _passwordController.text,
        saveCredentials: _rememberMe, // Save credentials if checked
      );

      if (mounted) {
        // Navigate to HomeScreen on successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              user: user,
              changeLanguage: widget.changeLanguage,
              currentLocale: widget.currentLocale,
              authService: widget.authService,
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = ErrorUtils.getTranslatedErrorMessage(
            e.toString(), AppLocalizations.of(context));
        _isLoading = false;
      });
    }
  }

  // Toggle app language
  void _toggleLanguage() {
    final newLocale = widget.currentLocale.languageCode == 'en'
        ? Locale('ar')
        : Locale('en');
    widget.changeLanguage(newLocale);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard on tap outside
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: AutofillGroup(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildHeader(localizations),
                    SizedBox(height: 40),
                    _buildLoginForm(localizations),
                    SizedBox(height: 30),
                    _buildLoginButton(localizations),
                    SizedBox(height: 24),
                    _buildFooter(localizations),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build header section with logo and title
  Widget _buildHeader(AppLocalizations localizations) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: _toggleLanguage,
            icon: Icon(Icons.language, color: AppTheme.primaryColor),
          ),
        ),
        AnimatedOpacity(
          opacity: _logoOpacity,
          duration: Duration(seconds: 1),
          child: Image.asset(
            'assets/images/mouwasat.png',
            width: 300,
            height: 130,
          ),
        ),
        SizedBox(height: 16),
        Text(
          localizations.mouwasatHospital,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 8),
        Text(
          localizations.yourHealthOurPriority,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  // Build login form fields
  Widget _buildLoginForm(AppLocalizations localizations) {
    return Column(
      children: [
        GovernmentIdField(controller: _governmentIdController), // National ID field
        SizedBox(height: 16),
        PasswordField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          onToggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Remember me checkbox
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
            // Forgot password button
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ForgotPasswordScreen(
                      authService: widget.authService,
                    ),
                  ),
                );
              },
              child: Text(
                localizations.forgotPassword,
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ),
          ],
        ),
        // Show error message if login failed
        if (_errorMessage != null)
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: ErrorMessageWidget(message: _errorMessage!),
          ),
      ],
    );
  }

  // Build login button
  Widget _buildLoginButton(AppLocalizations localizations) {
    return SubmitButton(
      text: localizations.login,
      onPressed: _handleLogin,
      isLoading: _isLoading,
    );
  }

  // Build footer with register link and open new file button
  Widget _buildFooter(AppLocalizations localizations) {
    return Column(
      children: [
        Divider(thickness: 0.8),
        SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(localizations.dontHaveAccount),
            SizedBox(width: 4),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RegisterScreen(
                      authService: widget.authService,
                    ),
                  ),
                );
              },
              child: Text(
                localizations.register,
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        // Open New File button
        OutlinedButton.icon(
          icon: Icon(Icons.folder_open_outlined),
          label: Text(localizations.openNewFile),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NewFileScreen(
                  authService: widget.authService,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _governmentIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
