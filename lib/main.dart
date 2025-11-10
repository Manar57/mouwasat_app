import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mouwasat_app/screens/hospitals_screen.dart';
import 'app/app.dart';
import 'app/localization/app_localizations.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize authentication service
  final authService = AuthService();
  await authService.initialize();


  runApp(const MouwasatApp());
}


