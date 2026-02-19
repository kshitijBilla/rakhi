import 'package:flutter/material.dart';
import 'theme.dart';
import '../models/contact_model.dart';

/// ============================================================
/// CENTRALIZED APP CONFIGURATION
/// ============================================================
/// All changeable values live here. When you need to tweak
/// anything — text, timing, colors, API keys, demo data —
/// edit this ONE file and it propagates everywhere.
/// ============================================================

class AppConfig {
  AppConfig._(); // prevent instantiation

  // ──────────────────────────────────────────────
  //  APP IDENTITY
  // ──────────────────────────────────────────────
  static const String appName = 'Rakhi';
  static const String appTagline = 'Your Safety. One Tap Away.';
  static const String appVersion = '1.0.0';
  static const String sosButtonLabel = 'SOS';
  static const String sosButtonSubLabel = 'GUARDHER';
  static const String holdInstruction = 'HOLD FOR 3 SECONDS';
  static const String greetingPrefix = 'Stay Safe, ';
  static const String greetingEmoji = '💛';

  // ──────────────────────────────────────────────
  //  DEFAULT USER (pre-filled on first launch)
  // ──────────────────────────────────────────────
  static const String defaultUserName = 'Saanvi';
  static const String defaultUserPhone = '';
  static const String phoneHint = '+91 XXXXX XXXXX';

  // ──────────────────────────────────────────────
  //  SOS TIMING (seconds)
  // ──────────────────────────────────────────────
  static const int sosHoldDurationSeconds = 3;
  static const int sosCancelWindowSeconds = 0;
  static const int splashDurationSeconds = 3;
  static const int loginSimulationDelayMs = 1000;
  static const int markSafeDelaySeconds = 2;

  /// Delays for simulating parallel service activation (ms)
  static const int locationActivationDelayMs = 500;
  static const int recordingActivationDelayMs = 1000;
  static const int helpersActivationDelayMs = 1500;
  static const int policeActivationDelayMs = 2000;
  static const int contactsActivationDelayMs = 2500;

  // ──────────────────────────────────────────────
  //  LOCATION DEFAULTS
  // ──────────────────────────────────────────────
  static const double defaultLatitude = 28.6139;
  static const double defaultLongitude = 77.2090;
  static const String defaultAddress = 'Connaught Place, New Delhi';
  static const int locationUpdateIntervalSeconds = 5;
  static const double defaultMapZoom = 15.0;

  // ──────────────────────────────────────────────
  //  EMERGENCY NUMBERS
  // ──────────────────────────────────────────────
  static const String policeNumber = '112';
  static const String womenHelpline = '1091';
  static const String ambulanceNumber = '102';
  static const String fireNumber = '101';
  static const String cyberCrimeNumber = '1930';
  static const String domesticAbuseNumber = '181';
  static const String childHelplineNumber = '1098';
  static const String seniorHelplineNumber = '14567';

  static const List<Map<String, String>> helplineNumbers = [
    {'name': 'Police', 'number': '112', 'icon': 'local_police_rounded'},
    {'name': 'Women Helpline', 'number': '1091', 'icon': 'woman_rounded'},
    {'name': 'Ambulance', 'number': '102', 'icon': 'local_hospital_rounded'},
    {'name': 'Fire Brigade', 'number': '101', 'icon': 'local_fire_department_rounded'},
    {'name': 'Domestic Abuse', 'number': '181', 'icon': 'home_rounded'},
    {'name': 'Cyber Crime', 'number': '1930', 'icon': 'security_rounded'},
    {'name': 'Child Helpline', 'number': '1098', 'icon': 'child_care_rounded'},
    {'name': 'Senior Citizen', 'number': '14567', 'icon': 'elderly_rounded'},
  ];

  // ──────────────────────────────────────────────
  //  API / BACKEND
  // ──────────────────────────────────────────────
  static const String baseUrl = 'http://localhost:8000';
  static const String sosEndpoint = '$baseUrl/api/sos';
  static const String locationEndpoint = '$baseUrl/api/location';
  static const String helpersEndpoint = '$baseUrl/api/helpers';
  static const String policeEndpoint = '$baseUrl/api/police-alert';
  static const String safeRouteEndpoint = '$baseUrl/api/safe-route';
  static const String wearableDevicesEndpoint = '$baseUrl/api/wearable-devices';

  // ──────────────────────────────────────────────
  //  EXTERNAL SERVICE KEYS (replace with real keys)
  // ──────────────────────────────────────────────
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
  static const String twilioAccountSid = 'YOUR_TWILIO_SID';
  static const String twilioAuthToken = 'YOUR_TWILIO_TOKEN';
  static const String twilioPhoneNumber = 'YOUR_TWILIO_NUMBER';

  // ──────────────────────────────────────────────
  //  FIREBASE COLLECTIONS
  // ──────────────────────────────────────────────
  static const String usersCollection = 'users';
  static const String contactsCollection = 'emergency_contacts';
  static const String sosEventsCollection = 'sos_events';
  static const String helpersCollection = 'helpers';
  static const String evidenceCollection = 'evidence';

  // ──────────────────────────────────────────────
  //  LOCAL STORAGE KEYS
  // ──────────────────────────────────────────────
  static const String isFirstLaunchKey = 'is_first_launch';
  static const String userNameKey = 'user_name';
  static const String userPhoneKey = 'user_phone';
  static const String emergencyContactsKey = 'emergency_contacts';

  // ──────────────────────────────────────────────
  //  SMS / NOTIFICATION TEMPLATES
  // ──────────────────────────────────────────────
  static const String sosMessageTemplate =
      '🚨 EMERGENCY SOS! I need immediate help!\n'
      '📍 My live location: {location_link}\n'
      '⏰ Time: {timestamp}\n'
      'This is an automated alert from $appName app.';

  static const String markSafeTemplate =
      '✅ I am SAFE now. Thank you for your concern.\n'
      'The emergency alert has been cancelled.\n'
      '- Sent via $appName app';

  // ──────────────────────────────────────────────
  //  UI STRINGS — ONBOARDING
  // ──────────────────────────────────────────────
  static const List<Map<String, dynamic>> onboardingPages = [
    {
      'icon': Icons.shield_outlined,
      'title': 'Feel Safe',
      'subtitle': 'wherever you go',
      'description':
          'Rakhi provides 24/7 emergency protection with one-tap SOS activation.',
    },
    {
      'icon': Icons.sos_rounded,
      'title': 'One Tap',
      'subtitle': 'sends alerts instantly',
      'description':
          'Hold the SOS button for 3 seconds to alert contacts, police, and nearby helpers.',
    },
    {
      'icon': Icons.location_on_rounded,
      'title': 'Live Tracking',
      'subtitle': 'real-time GPS sharing',
      'description':
          'Share your live location with trusted contacts. Evidence recorded automatically.',
    },
  ];

  // ──────────────────────────────────────────────
  //  UI STRINGS — LOGIN / SETUP
  // ──────────────────────────────────────────────
  static const String loginNameLabel = 'Your Name';
  static const String loginNameHint = 'Enter your name';
  static const String loginPhoneLabel = 'Phone Number';
  static const String loginContactsLabel = 'Add Emergency Contacts';
  static const String loginContactsSub = 'People to alert in emergencies';
  static const String loginLocationLabel = 'Allow Location Access';
  static const String loginLocationSub = 'Share live GPS in emergencies';
  static const String loginCameraLabel = 'Allow Camera & Microphone';
  static const String loginCameraSub = 'Auto-record evidence during SOS';
  static const String loginSmsLabel = 'Allow SMS Access';
  static const String loginSmsSub = 'Send alerts to emergency contacts';
  static const String loginContinueButton = 'Continue to Safety';
  static const String loginNameError = 'Please enter your name';

  // ──────────────────────────────────────────────
  //  UI STRINGS — HOME
  // ──────────────────────────────────────────────
  static const String gpsActiveLabel = 'GPS Active';
  static const String quickActionSafeRoute = 'Safe Route';
  static const String safeRouteTitle = 'Safe Route';
  static const String safeRouteSubtitle = 'Avoid high-risk zones';
  static const String safeRouteInputStart = 'Current Location';
  static const String safeRouteInputEnd = 'Enter Destination';
  static const String safeRouteButton = 'Find Safe Route';
  static const String quickActionHelpline = 'Helpline\nNumbers';
  static const String quickActionWearable = 'Safety\nDevices';
  static const String wearableTitle = 'Connected Devices';
  static const String wearableSubtitle = 'Manage your smart safety gear';
  static const String wearableScanButton = 'Scan for New Devices';
  static const String quickActionContacts = 'Emergency\nContacts';

  // ──────────────────────────────────────────────
  //  UI STRINGS — SOS ACTIVE SCREEN
  // ──────────────────────────────────────────────
  static const String sosActivatedTitle = 'SOS ACTIVATED';
  static const String liveLabel = 'LIVE';
  static const String timeElapsedLabel = 'TIME ELAPSED';
  static const String markSafeButton = 'MARK SAFE';
  static const String markSafeDialogTitle = 'Mark Safe?';
  static const String markSafeDialogContent =
      'This will stop all alerts, recording, and location sharing. '
      'Your contacts will be notified that you are safe.';
  static const String markSafeConfirm = 'Yes, I\'m Safe';

  /// Checklist items on the SOS Active screen
  static const List<Map<String, dynamic>> sosChecklist = [
    {'icon': Icons.location_on_rounded, 'label': 'Live Location Sharing'},
    {'icon': Icons.videocam_rounded, 'label': 'Audio & Video Recording'},
    {'icon': Icons.people_rounded, 'label': 'Nearby Helpers Alerted'},
    {'icon': Icons.local_police_rounded, 'label': 'Police Notified'},
    {'icon': Icons.contacts_rounded, 'label': 'Emergency Contacts Alerted'},
  ];

  // ──────────────────────────────────────────────
  //  UI STRINGS — MAP SCREEN
  // ──────────────────────────────────────────────
  static const String mapTitle = 'Live Map';
  static const String recordingLabel = 'Recording...';
  static const String evidenceSavedLabel = 'Evidence automatically saved.';

  // ──────────────────────────────────────────────
  //  UI STRINGS — CONTACTS SCREEN
  // ──────────────────────────────────────────────
  static const String contactsTitle = 'Emergency Contacts';
  static const String contactsBanner =
      'These contacts will be alerted when SOS is triggered.';
  static const String addContactButton = 'Add Contact';
  static const String addContactTitle = 'Add Emergency Contact';
  static const String contactNameLabel = 'Name';
  static const String contactPhoneLabel = 'Phone Number';
  static const String contactRelationLabel = 'Relation (e.g., Mother, Friend)';
  static const String primaryBadge = 'PRIMARY';

  // ──────────────────────────────────────────────
  //  UI STRINGS — SETTINGS SCREEN
  // ──────────────────────────────────────────────
  static const String settingsTitle = 'Settings';
  static const String settingsAutoRecord = 'Auto Record on SOS';
  static const String settingsAutoRecordSub =
      'Start recording when SOS is activated';
  static const String settingsBgLocation = 'Background Location';
  static const String settingsBgLocationSub =
      'Track location in background during SOS';
  static const String settingsVibration = 'Vibration Feedback';
  static const String settingsVibrationSub =
      'Haptic feedback on SOS actions';
  static const String settingsWearable = 'Smart Safety Keychain';
  static const String settingsWearableConnected = 'Connected • Battery 85%';
  static const String settingsWearableDisconnected = 'Not connected';
  static const String settingsScanDevices = 'Scan for Devices';
  static const String settingsScanSub = 'Find nearby wearable devices';

  // ──────────────────────────────────────────────
  //  UI STRINGS — PROFILE SCREEN
  // ──────────────────────────────────────────────
  static const String profileTitle = 'Profile';
  static const String profilePhoneNotSet = 'Phone not set';
  static const String profileContactsMenu = 'Emergency Contacts';
  static const String profileContactsSub = 'Manage your trusted contacts';
  static const String profileSettingsMenu = 'Settings';
  static const String profileSettingsSub = 'App preferences & wearable';
  static const String profileHistoryMenu = 'SOS History';
  static const String profileHistorySub = 'View past emergency sessions';
  static const String profileHelpMenu = 'Help & Support';
  static const String profileHelpSub = 'FAQs and contact support';

  // ──────────────────────────────────────────────
  //  UI STRINGS — HISTORY SCREEN
  // ──────────────────────────────────────────────
  static const String historyTitle = 'SOS History';
  static const String historyEmptyTitle = 'No SOS History';
  static const String historyEmptyMessage =
      'Your safety sessions will appear here.\nStay safe! 💛';

  // ──────────────────────────────────────────────
  //  NAV BAR LABELS
  // ──────────────────────────────────────────────
  static const String navHome = 'Home';
  static const String navMap = 'Map';
  static const String navHistory = 'History';
  static const String navProfile = 'Profile';

  // ──────────────────────────────────────────────
  //  DEMO / SEED DATA — Emergency Contacts
  // ──────────────────────────────────────────────
  static List<ContactModel> get demoContacts => [
        ContactModel(
          id: '1',
          name: 'Mom',
          phone: '+91 98765 43210',
          relation: 'Mother',
          isPrimary: true,
        ),
        ContactModel(
          id: '2',
          name: 'Dad',
          phone: '+91 98765 43211',
          relation: 'Father',
        ),
        ContactModel(
          id: '3',
          name: 'Best Friend',
          phone: '+91 98765 43212',
          relation: 'Friend',
        ),
      ];
}
