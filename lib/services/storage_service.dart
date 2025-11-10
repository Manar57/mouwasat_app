import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';

class StorageService {
  // Singleton instance
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  SharedPreferences? _prefs;

  // ✅ Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Helper to get _prefs with automatic initialization
  Future<SharedPreferences> get _getPrefs async {
    if (_prefs == null) {
      await init();
    }
    return _prefs!;
  }

  // Save the user database as JSON in SharedPreferences
  Future<void> saveUserDatabase(String userDbJson) async {
    final prefs = await _getPrefs;
    await prefs.setString('user_database', userDbJson);
  }

  // Retrieve the user database JSON from SharedPreferences
  Future<String?> getUserDatabase() async {
    final prefs = await _getPrefs;
    return prefs.getString('user_database');
  }

  // Save user credentials securely
  Future<void> saveCredentials(UserCredentials credentials) async {
    await _secureStorage.write(
      key: 'saved_credentials',
      value: json.encode(credentials.toJson()),
    );
  }

  // Retrieve saved credentials
  Future<UserCredentials?> getSavedCredentials() async {
    final credentialsJson = await _secureStorage.read(key: 'saved_credentials');
    if (credentialsJson != null) {
      return UserCredentials.fromJson(json.decode(credentialsJson));
    }
    return null;
  }

  // Save the current logged-in user session securely
  Future<void> saveUserSession(User user) async {
    await _secureStorage.write(
      key: 'user_session',
      value: json.encode(user.toJson()),
    );
  }

  // Retrieve the current logged-in user session
  Future<User?> getUserSession() async {
    final userJson = await _secureStorage.read(key: 'user_session');
    if (userJson != null) {
      return User.fromJson(json.decode(userJson));
    }
    return null;
  }

  // Clear the current user session
  Future<void> clearUserSession() async {
    await _secureStorage.delete(key: 'user_session');
  }

  // Clear saved credentials
  Future<void> clearCredentials() async {
    await _secureStorage.delete(key: 'saved_credentials');
  }

  // Save active sessions as JSON in SharedPreferences
  Future<void> saveActiveSessions(String sessionsJson) async {
    final prefs = await _getPrefs;
    await prefs.setString('active_sessions', sessionsJson);
  }

  // Retrieve active sessions JSON
  Future<String?> getActiveSessions() async {
    final prefs = await _getPrefs;
    return prefs.getString('active_sessions');
  }

  // Clear all SharedPreferences and secure storage
  Future<void> clearAllStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}