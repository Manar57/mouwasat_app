// services/device_service.dart
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class DeviceService {
  // Singleton instance
  static final DeviceService _instance = DeviceService._internal();
  factory DeviceService() => _instance;
  DeviceService._internal();

  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  late SharedPreferences _prefs;

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Getter for SharedPreferences (not really needed but included)
  Future<SharedPreferences> get _getPrefs async {
    return _prefs;
  }

  // Get a unique device ID (persisted in SharedPreferences)
  Future<String> getDeviceId() async {
    String? savedDeviceId = _prefs.getString('device_id');

    if (savedDeviceId != null && savedDeviceId.isNotEmpty) {
      return savedDeviceId; // return existing ID if available
    }

    // Generate a new device ID if not found
    String newDeviceId = await _generateDeviceId();
    await _prefs.setString('device_id', newDeviceId);
    return newDeviceId;
  }

  // Generate device ID based on platform info
  Future<String> _generateDeviceId() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return 'android_${androidInfo.id}_${DateTime.now().millisecondsSinceEpoch}';
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return 'ios_${iosInfo.identifierForVendor}_${DateTime.now().millisecondsSinceEpoch}';
      } else {
        // Web or other platforms
        return 'web_${DateTime.now().millisecondsSinceEpoch}_${UniqueKey().toString()}';
      }
    } catch (e) {
      // Fallback in case of error
      return 'device_${DateTime.now().millisecondsSinceEpoch}_${UniqueKey().toString()}';
    }
  }

  // Generate a unique session ID (used in AuthService)
  String generateSessionId() {
    return 'session_${DateTime.now().millisecondsSinceEpoch}_${UniqueKey().toString()}';
  }

  // Check if savedDeviceId matches the current device
  Future<bool> isSameDevice(String? savedDeviceId) async {
    if (savedDeviceId == null) return false;
    String currentDeviceId = await getDeviceId();
    return savedDeviceId == currentDeviceId;
  }
}
