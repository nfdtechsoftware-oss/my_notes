import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuration class for environment variables
///
/// This class provides a centralized way to access environment variables
/// defined in the .env file. All sensitive data should be stored here
/// and NEVER committed to version control.
///
/// Usage:
/// ```dart
/// final appName = EnvConfig.appName;
/// final version = EnvConfig.appVersion;
/// ```
class EnvConfig {
  // App Configuration
  static String get appName => dotenv.get('APP_NAME', fallback: 'My Notes');
  static String get appVersion => dotenv.get('APP_VERSION', fallback: '1.0.0');

  // Database Configuration (for future encryption)
  static String? get databaseEncryptionKey =>
      dotenv.maybeGet('DATABASE_ENCRYPTION_KEY');

  // Future: API Keys
  static String? get apiKey => dotenv.maybeGet('API_KEY');
  static String? get analyticsId => dotenv.maybeGet('ANALYTICS_ID');

  /// Loads the environment variables from .env file
  ///
  /// This should be called in main() before runApp()
  /// ```dart
  /// await EnvConfig.load();
  /// ```
  static Future<void> load({String fileName = '.env'}) async {
    await dotenv.load(fileName: fileName);
  }

  /// Check if environment is properly configured
  static bool get isConfigured => dotenv.isInitialized;
}
