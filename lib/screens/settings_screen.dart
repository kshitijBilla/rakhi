import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';
import '../config/app_config.dart';
import 'help_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _autoRecord = true;
  bool _backgroundLocation = true;
  bool _vibrationFeedback = true;
  bool _wearableConnected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: AppTheme.cardShadow,
                          ),
                          child: const Icon(Icons.arrow_back_rounded,
                              color: AppTheme.primaryMaroon),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(AppConfig.settingsTitle,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textPrimary)),
                    ],
                  ),
                ).animate().fadeIn(duration: 300.ms),

                // SOS Settings
                _buildSection('SOS Settings', [
                  _buildToggleTile(
                    Icons.videocam_rounded,
                    AppConfig.settingsAutoRecord,
                    AppConfig.settingsAutoRecordSub,
                    _autoRecord,
                    (v) => setState(() => _autoRecord = v),
                  ),
                  _buildToggleTile(
                    Icons.location_on_rounded,
                    AppConfig.settingsBgLocation,
                    AppConfig.settingsBgLocationSub,
                    _backgroundLocation,
                    (v) => setState(() => _backgroundLocation = v),
                  ),
                  _buildToggleTile(
                    Icons.vibration_rounded,
                    AppConfig.settingsVibration,
                    AppConfig.settingsVibrationSub,
                    _vibrationFeedback,
                    (v) => setState(() => _vibrationFeedback = v),
                  ),
                ]),

                // Wearable
                _buildSection('Wearable Device', [
                  _buildToggleTile(
                    Icons.watch_rounded,
                    AppConfig.settingsWearable,
                    _wearableConnected
                        ? AppConfig.settingsWearableConnected
                        : AppConfig.settingsWearableDisconnected,
                    _wearableConnected,
                    (v) => setState(() => _wearableConnected = v),
                  ),
                  _buildActionTile(
                    Icons.bluetooth_searching_rounded,
                    AppConfig.settingsScanDevices,
                    AppConfig.settingsScanSub,
                    () {},
                  ),
                ]),

                // Emergency
                _buildSection('Emergency Numbers', [
                  _buildInfoTile(Icons.local_police_rounded, 'Police', AppConfig.policeNumber),
                  _buildInfoTile(Icons.woman_rounded, 'Women Helpline', AppConfig.womenHelpline),
                  _buildInfoTile(
                      Icons.local_hospital_rounded, 'Ambulance', AppConfig.ambulanceNumber),
                ]),

                // About
                  _buildSection('About', [
                    _buildInfoTile(Icons.info_outline_rounded, 'Version',
                        AppConfig.appVersion),
                    _buildActionTile(
                      Icons.help_outline_rounded,
                      'Help & Support',
                      'FAQs & Contact',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HelpScreen()),
                      ),
                    ),
                    _buildActionTile(
                      Icons.privacy_tip_outlined,
                      'Privacy Policy',
                      '',
                      () {},
                    ),
                  ]),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: AppTheme.cardShadow,
            ),
            child: Column(children: children),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.05, end: 0);
  }

  Widget _buildToggleTile(IconData icon, String title, String subtitle,
      bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryMaroon.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppTheme.primaryMaroon, size: 22),
      ),
      title: Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppTheme.textPrimary)),
      subtitle:
          Text(subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.textLight)),
      trailing: Switch(
        value: value,
        activeTrackColor: AppTheme.primaryMaroon,
        activeColor: Colors.white,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildActionTile(
      IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryMaroon.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppTheme.primaryMaroon, size: 22),
      ),
      title: Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppTheme.textPrimary)),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle,
              style: const TextStyle(fontSize: 12, color: AppTheme.textLight))
          : null,
      trailing: const Icon(Icons.chevron_right_rounded,
          color: AppTheme.textLight),
      onTap: onTap,
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryMaroon.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppTheme.primaryMaroon, size: 22),
      ),
      title: Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppTheme.textPrimary)),
      trailing: Text(value,
          style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppTheme.primaryMaroon)),
    );
  }
}
