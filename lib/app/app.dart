import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../screens/login_screen.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import 'localization/app_localizations.dart';
import '../screens/home_screen.dart';

class MouwasatApp extends StatefulWidget {
  const MouwasatApp({Key? key}) : super(key: key);

  @override
  State<MouwasatApp> createState() => _MouwasatAppState();
}

class _MouwasatAppState extends State<MouwasatApp> {
  // Default app locale (English)
  Locale _locale = const Locale('en');

  // Authentication service instance
  final AuthService _authService = AuthService();

  // Method to change the current app language
  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application Title
      title: 'Mouwasat Medical',

      // Current locale
      locale: _locale,

      // List of localization delegates
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Supported languages
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],

      // Main theme
      theme: ThemeData(
        primaryColor: const Color(0xFF2D2B76),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2D2B76),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),

      // Determines which screen to show (Login or Home)
      home: AuthWrapper(
        changeLanguage: _changeLanguage,
        currentLocale: _locale,
        authService: _authService,
      ),

      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatefulWidget {
  // Callback to change language
  final Function(Locale) changeLanguage;

  // Currently selected locale
  final Locale currentLocale;

  // Authentication service
  final AuthService authService;

  const AuthWrapper({
    Key? key,
    required this.changeLanguage,
    required this.currentLocale,
    required this.authService,
  }) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  // Indicates session check state
  bool _isCheckingSession = true;

  // Holds authenticated user if exists
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _checkExistingSession();
  }

  // Check if user session already exists
  Future<void> _checkExistingSession() async {
    try {
      final user = await widget.authService.checkExistingSession();

      // If session found, validate it
      if (user != null) {
        final isValidSession = await widget.authService.validateCurrentSession(user);

        if (isValidSession && mounted) {
          setState(() {
            _currentUser = user;
          });
        } else {
          // Remove invalid session
          await widget.authService.logout();
        }
      }
    } catch (e) {
      // Handle session check errors silently
    } finally {
      // Stop showing splash loader
      if (mounted) {
        setState(() {
          _isCheckingSession = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Display splash screen while session is being checked
    if (_isCheckingSession) {
      return const SplashScreen();
    }

    // Navigate to HomeScreen if user is authenticated, otherwise LoginScreen
    return _currentUser != null
        ? HomeScreen(
      user: _currentUser!,
      changeLanguage: widget.changeLanguage,
      currentLocale: widget.currentLocale,
      authService: widget.authService,
    )
        : LoginScreen(
      changeLanguage: widget.changeLanguage,
      currentLocale: widget.currentLocale,
      authService: widget.authService,
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App background color while loading
      backgroundColor: const Color(0xFF2D2B76),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon container
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.medical_services_outlined,
                color: Color(0xFF2D2B76),
                size: 60,
              ),
            ),

            const SizedBox(height: 32),

            // App Name
            const Text(
              'Mouwasat',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            // App Subtitle
            const Text(
              'Medical Services',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
