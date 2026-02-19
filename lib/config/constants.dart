// ============================================================
// LEGACY CONSTANTS — NOW FORWARDED FROM AppConfig
// ============================================================
// This file re-exports AppConfig so that any existing imports
// of AppConstants still work.  All values are defined in
// config/app_config.dart — edit ONLY that file.
// ============================================================

import 'app_config.dart';

// Backward-compatible alias (use AppConfig directly in new code)
class AppConstants {
  AppConstants._();

  static const String appName = AppConfig.appName;
  static const String appTagline = AppConfig.appTagline;
  static const String appVersion = AppConfig.appVersion;
  static const String baseUrl = AppConfig.baseUrl;
  static const String sosEndpoint = AppConfig.sosEndpoint;
  static const String locationEndpoint = AppConfig.locationEndpoint;
  static const String helpersEndpoint = AppConfig.helpersEndpoint;
  static const String policeEndpoint = AppConfig.policeEndpoint;
  static const String googleMapsApiKey = AppConfig.googleMapsApiKey;
  static const String twilioAccountSid = AppConfig.twilioAccountSid;
  static const String twilioAuthToken = AppConfig.twilioAuthToken;
  static const String twilioPhoneNumber = AppConfig.twilioPhoneNumber;
  static const String usersCollection = AppConfig.usersCollection;
  static const String contactsCollection = AppConfig.contactsCollection;
  static const String sosEventsCollection = AppConfig.sosEventsCollection;
  static const String helpersCollection = AppConfig.helpersCollection;
  static const String evidenceCollection = AppConfig.evidenceCollection;
  static const String isFirstLaunchKey = AppConfig.isFirstLaunchKey;
  static const String userNameKey = AppConfig.userNameKey;
  static const String userPhoneKey = AppConfig.userPhoneKey;
  static const String emergencyContactsKey = AppConfig.emergencyContactsKey;
}
