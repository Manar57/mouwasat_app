import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'storage_service.dart';
import 'device_service.dart';

class AuthService {
  // Singleton instance
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Services for storage and device info
  final StorageService _storageService = StorageService();
  final DeviceService _deviceService = DeviceService();

  // In-memory storage for active sessions and users
  Map<String, String> _activeSessions = {}; // governmentId -> sessionId
  Map<String, Map<String, dynamic>> _userDatabase = {}; // governmentId -> userData

  // Initialize services and load data
  Future<void> initialize() async {
    await _storageService.init();
    await _loadUserDatabase();
    await _loadActiveSessions();
    await _deviceService.init();

    // Add default user if database is empty
    if (_userDatabase.isEmpty) {
      _userDatabase = {
        '1234567890': {
          'password': 'Test123!',
          'email': 'test@gmail.com',
          'name': 'Test User',
          'nationality': 'Saudi',
          'hospital': 'Mouwasat Hospital Riyadh',
          'birthDate': '01/01/1990',
          'maritalStatus': 'Single',
          'religion': 'MUSLIM',
        },
      };
      await _saveUserDatabase();
    }
  }

  // Load user database from storage
  Future<void> _loadUserDatabase() async {
    final userDbJson = await _storageService.getUserDatabase();
    if (userDbJson != null) {
      _userDatabase = Map<String, Map<String, dynamic>>.from(json.decode(userDbJson));
    }
  }

  // Save user database to storage
  Future<void> _saveUserDatabase() async {
    await _storageService.saveUserDatabase(json.encode(_userDatabase));
  }

  // Load active sessions from storage
  Future<void> _loadActiveSessions() async {
    final sessionsJson = await _storageService.getActiveSessions();
    if (sessionsJson != null) {
      _activeSessions = Map<String, String>.from(json.decode(sessionsJson));
    }
  }

  // Save active sessions to storage
  Future<void> _saveActiveSessions() async {
    await _storageService.saveActiveSessions(json.encode(_activeSessions));
  }

  // ---------------- LOGIN ----------------
  Future<User> login({
    required String governmentId,
    required String password,
    bool saveCredentials = false,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay

    final cleanGovernmentId = governmentId.trim();

    if (_userDatabase.containsKey(cleanGovernmentId)) {
      final userData = _userDatabase[cleanGovernmentId]!;
      final storedPassword = userData['password'];

      if (storedPassword == password) {
        final String currentSessionId = _deviceService.generateSessionId();
        final String currentDeviceId = await _deviceService.getDeviceId();

        // Save active session in memory and storage
        _activeSessions[cleanGovernmentId] = currentSessionId;
        await _saveActiveSessions();

        final user = User(
          id: 'user_${DateTime.now().millisecondsSinceEpoch}',
          governmentId: cleanGovernmentId,
          email: userData['email'],
          name: userData['name'],
          phoneNumber: userData['phoneNumber'],
          nationality: userData['nationality'],
          hospital: userData['hospital'],
          birthDate: userData['birthDate'],
          maritalStatus: userData['maritalStatus'],
          religion: userData['religion'],
          createdAt: DateTime.now(),
          currentSessionId: currentSessionId,
          deviceId: currentDeviceId,
        );

        // Save session locally
        await _storageService.saveUserSession(user);

        // Save credentials if requested
        if (saveCredentials) {
          final credentials = UserCredentials(
            governmentId: cleanGovernmentId,
            password: password,
            savedAt: DateTime.now(),
            deviceId: currentDeviceId,
          );
          await _storageService.saveCredentials(credentials);
        }

        return user;
      } else {
        throw Exception('Incorrect password'); // Login failed
      }
    } else {
      throw Exception('No account found with this Government ID');
    }
  }

  // ---------------- SESSION VALIDATION ----------------
  Future<bool> validateCurrentSession(User user) async {
    final currentSessionId = _activeSessions[user.governmentId];
    final currentDeviceId = await _deviceService.getDeviceId();

    // Check if session is valid
    if (currentSessionId == null) return false;
    if (currentSessionId != user.currentSessionId) return false;
    if (user.deviceId != currentDeviceId) return false;

    return true;
  }

  // ---------------- LOGOUT ----------------
  Future<void> logout() async {
    final currentUser = await _storageService.getUserSession();
    if (currentUser != null) {
      _activeSessions.remove(currentUser.governmentId);
      await _saveActiveSessions();
    }

    await _storageService.clearUserSession();
    await _storageService.clearCredentials();
  }

  // ---------------- CREDENTIALS ----------------
  Future<UserCredentials?> getSavedCredentials() async {
    return await _storageService.getSavedCredentials();
  }

  // ---------------- REGISTER ----------------
  Future<User> register({
    required String governmentId,
    required String password,
    required String name,
    required String email,
    String? phoneNumber,
    bool saveCredentials = false,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final cleanGovernmentId = governmentId.trim();
    final cleanEmail = email.trim().toLowerCase();

    // Check for existing user
    if (_userDatabase.containsKey(cleanGovernmentId)) {
      throw Exception('User with this Government ID already exists');
    }
    final emailExists = _userDatabase.values.any((userData) => userData['email'] == cleanEmail);
    if (emailExists) {
      throw Exception('User with this email already exists');
    }
    if (!_isStrongPassword(password)) {
      throw Exception('Password does not meet the requirements');
    }

    // Add user to database
    _userDatabase[cleanGovernmentId] = {
      'password': password,
      'email': cleanEmail,
      'name': name,
      'phoneNumber': phoneNumber,
    };
    await _saveUserDatabase();

    // Create User object
    final user = User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      governmentId: cleanGovernmentId,
      email: cleanEmail,
      name: name,
      phoneNumber: phoneNumber,
      createdAt: DateTime.now(),
      currentSessionId: _deviceService.generateSessionId(),
      deviceId: await _deviceService.getDeviceId(),
    );

    await _storageService.saveUserSession(user);

    // Save credentials if requested
    if (saveCredentials) {
      final credentials = UserCredentials(
        governmentId: cleanGovernmentId,
        password: password,
        savedAt: DateTime.now(),
        deviceId: await _deviceService.getDeviceId(),
      );
      await _storageService.saveCredentials(credentials);
    }

    return user;
  }

  // ---------------- REGISTER WITHOUT PASSWORD ----------------
  Future<User> registerWithoutPassword({
    required String governmentId,
    required String name,
    required String email,
    String? phoneNumber,
    String? nationality,
    String? hospital,
    String? birthDate,
    String? maritalStatus,
    String? religion,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final cleanGovernmentId = governmentId.trim();
    final cleanEmail = email.trim().toLowerCase();

    // Check duplicates
    if (_userDatabase.containsKey(cleanGovernmentId)) {
      throw Exception('User with this Government ID already exists');
    }
    final emailExists = _userDatabase.values.any((userData) => userData['email'] == cleanEmail);
    if (emailExists) {
      throw Exception('User with this email already exists');
    }

    final temporaryPassword = _generateTemporaryPassword(); // Auto-generate password

    _userDatabase[cleanGovernmentId] = {
      'password': temporaryPassword,
      'email': cleanEmail,
      'name': name,
      'phoneNumber': phoneNumber,
      'nationality': nationality,
      'hospital': hospital,
      'birthDate': birthDate,
      'maritalStatus': maritalStatus,
      'religion': religion,
    };
    await _saveUserDatabase();

    final user = User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      governmentId: cleanGovernmentId,
      email: cleanEmail,
      name: name,
      phoneNumber: phoneNumber,
      nationality: nationality,
      hospital: hospital,
      birthDate: birthDate,
      maritalStatus: maritalStatus,
      religion: religion,
      createdAt: DateTime.now(),
      currentSessionId: _deviceService.generateSessionId(),
      deviceId: await _deviceService.getDeviceId(),
    );

    await _storageService.saveUserSession(user);
    return user;
  }

  // ---------------- PASSWORD ----------------
  String _generateTemporaryPassword() {
    final random = DateTime.now().millisecondsSinceEpoch.toString();
    return 'Temp${random.substring(random.length - 6)}!';
  }

  bool _isStrongPassword(String password) {
    if (password.length < 8) return false;
    if (!RegExp(r'[A-Z]').hasMatch(password)) return false;
    if (!RegExp(r'[a-z]').hasMatch(password)) return false;
    if (!RegExp(r'[0-9]').hasMatch(password)) return false;
    if (!RegExp(r'[!@#$%^&*]').hasMatch(password)) return false;
    return true;
  }

  Future<void> resetPassword({
    required String governmentId,
    required String newPassword,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final cleanGovernmentId = governmentId.trim();

    if (!_userDatabase.containsKey(cleanGovernmentId)) {
      throw Exception('No account found with this Government ID');
    }

    if (!_isStrongPassword(newPassword)) {
      throw Exception('New password does not meet the requirements');
    }

    _userDatabase[cleanGovernmentId]!['password'] = newPassword;
    await _saveUserDatabase();
  }

  // ---------------- CHECK EXISTING SESSION ----------------
  Future<User?> checkExistingSession() async {
    return await _storageService.getUserSession();
  }
}