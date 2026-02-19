import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/sos_active_screen.dart';
import '../screens/map_screen.dart';
import '../screens/contacts_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/history_screen.dart';
import '../screens/helpline_screen.dart';
import '../screens/safe_route_screen.dart';
import '../screens/wearable_devices_screen.dart';
import '../screens/help_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String home = '/home';
  static const String sosActive = '/sos-active';
  static const String map = '/map';
  static const String contacts = '/contacts';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String history = '/history';
  static const String helpline = '/helpline';
  static const String safeRoute = '/safe-route';
  static const String wearable = '/wearable-devices';
  static const String help = '/help-support';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        onboarding: (context) => const OnboardingScreen(),
        login: (context) => const LoginScreen(),
        home: (context) => const HomeScreen(),
        sosActive: (context) => const SOSActiveScreen(),
        map: (context) => const MapScreen(),
        contacts: (context) => const ContactsScreen(),
        settings: (context) => const SettingsScreen(),
        profile: (context) => const ProfileScreen(),
        history: (context) => const HistoryScreen(),
        helpline: (context) => const HelplineScreen(),
        safeRoute: (context) => const SafeRouteScreen(),
        wearable: (context) => const WearableDevicesScreen(),
        help: (context) => const HelpScreen(),
      };
}
