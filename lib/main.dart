import 'package:flutter/material.dart';
import 'app/app.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize authentication service
  final authService = AuthService();
  await authService.initialize();


  runApp(const MouwasatApp());
}