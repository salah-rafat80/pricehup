import 'dart:io';

/// Security service - Screenshot protection is MANDATORY and enabled at native level
class SecurityService {
  static bool _isSecured = true; // Always true on Android

  /// Enable screenshot and screen recording prevention
  /// This is MANDATORY and works at native Android level
  static Future<void> enableScreenSecurity() async {
    if (Platform.isAndroid) {
      _isSecured = true;
      // Protection is handled by MainActivity.kt - FLAG_SECURE
    }
  }

  /// Check if screen security is currently enabled
  static bool get isSecured => _isSecured;
}
