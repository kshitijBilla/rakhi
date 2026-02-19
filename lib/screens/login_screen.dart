import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../config/app_config.dart';
import '../providers/auth_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController(text: AppConfig.defaultUserName);
  final _phoneController = TextEditingController();
  bool _locationGranted = false;
  bool _cameraGranted = false;
  bool _smsGranted = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final location = await Permission.locationWhenInUse.status;
    final camera = await Permission.camera.status;
    final sms = await Permission.sms.status;
    
    if (mounted) {
      setState(() {
        _locationGranted = location.isGranted;
        _cameraGranted = camera.isGranted;
        _smsGranted = sms.isGranted;
      });
    }
  }

  Future<void> _handlePermission(Permission permission, ValueSetter<bool> onUpdate, bool value) async {
    // allow the button to be clicked without condition (visual toggle)
    onUpdate(value);
    
    if (value) {
      // Request permission if turning on
      await permission.request();
      // We don't revert the switch if denied, per user request "without any condition",
      // but we will check actual status on continue.
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... (rest of build is same until tiles)
    return Scaffold(
      // ...
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ... (Header, Greeting, Name, Phone same)
                const SizedBox(height: 20),
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.shield,
                        color: AppTheme.goldAccent,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      AppConfig.appName,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.primaryMaroon,
                              ),
                    ),
                  ],
                ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2, end: 0),
                const SizedBox(height: 30),
                // Greeting
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                    children: const [
                      TextSpan(text: AppConfig.greetingPrefix),
                      TextSpan(
                        text: '${AppConfig.defaultUserName} ',
                        style: TextStyle(color: AppTheme.primaryMaroon),
                      ),
                      TextSpan(text: AppConfig.greetingEmoji),
                    ],
                  ),
                ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2, end: 0),
                const SizedBox(height: 30),
                // Name Input
                _buildSetupCard(
                  icon: Icons.person_outline_rounded,
                  title: AppConfig.loginNameLabel,
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: AppConfig.loginNameHint,
                    ),
                  ),
                ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.1, end: 0),
                const SizedBox(height: 16),
                // Phone Input
                _buildSetupCard(
                  icon: Icons.phone_outlined,
                  title: AppConfig.loginPhoneLabel,
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: AppConfig.phoneHint,
                    ),
                  ),
                ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.1, end: 0),
                const SizedBox(height: 16),
                // Emergency Contacts
                _buildPermissionTile(
                  icon: Icons.contacts_outlined,
                  title: AppConfig.loginContactsLabel,
                  subtitle: AppConfig.loginContactsSub,
                  trailing: const Icon(Icons.chevron_right_rounded,
                      color: AppTheme.primaryMaroon),
                  onTap: () async {
                    await Navigator.pushNamed(context, AppRoutes.contacts);
                    setState(() {}); 
                  },
                ).animate(delay: 500.ms).fadeIn().slideY(begin: 0.1, end: 0),
                const SizedBox(height: 12),
                
                // Location Permission
                _buildPermissionTile(
                  icon: Icons.location_on_outlined,
                  title: AppConfig.loginLocationLabel,
                  subtitle: AppConfig.loginLocationSub,
                  trailing: Switch(
                    value: _locationGranted,
                    activeTrackColor: AppTheme.primaryMaroon,
                    activeColor: Colors.white,
                    onChanged: (v) => _handlePermission(
                        Permission.locationWhenInUse, (val) => setState(() => _locationGranted = val), v),
                  ),
                  onTap: () => _handlePermission(
                      Permission.locationWhenInUse, (val) => setState(() => _locationGranted = val), !_locationGranted),
                ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.1, end: 0),
                const SizedBox(height: 12),
                
                // Camera Permission
                _buildPermissionTile(
                  icon: Icons.videocam_outlined,
                  title: AppConfig.loginCameraLabel,
                  subtitle: AppConfig.loginCameraSub,
                  trailing: Switch(
                    value: _cameraGranted,
                    activeTrackColor: AppTheme.primaryMaroon,
                    activeColor: Colors.white,
                    onChanged: (v) => _handlePermission(
                        Permission.camera, (val) => setState(() => _cameraGranted = val), v),
                  ),
                  onTap: () => _handlePermission(
                      Permission.camera, (val) => setState(() => _cameraGranted = val), !_cameraGranted),
                ).animate(delay: 700.ms).fadeIn().slideY(begin: 0.1, end: 0),
                const SizedBox(height: 12),
                
                // SMS Permission
                _buildPermissionTile(
                  icon: Icons.sms_outlined,
                  title: AppConfig.loginSmsLabel,
                  subtitle: AppConfig.loginSmsSub,
                  trailing: Switch(
                    value: _smsGranted,
                    activeTrackColor: AppTheme.primaryMaroon,
                    activeColor: Colors.white,
                    onChanged: (v) => _handlePermission(
                        Permission.sms, (val) => setState(() => _smsGranted = val), v),
                  ),
                  onTap: () => _handlePermission(
                      Permission.sms, (val) => setState(() => _smsGranted = val), !_smsGranted),
                ).animate(delay: 800.ms).fadeIn().slideY(begin: 0.1, end: 0),
                const SizedBox(height: 30),
                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _continueToHome,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryMaroon,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      AppConfig.loginContinueButton,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
                    .animate(delay: 900.ms)
                    .fadeIn()
                    .slideY(begin: 0.2, end: 0),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSetupCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.primaryMaroon, size: 22),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildPermissionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.primaryMaroon.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.primaryMaroon, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  Future<void> _continueToHome() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppConfig.loginNameError)),
      );
      return;
    }
    
    if (_phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your phone number')),
      );
      return;
    }

    if (!_locationGranted || !_cameraGranted || !_smsGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enable all permissions to proceed.')),
      );
      return;
    }

    // User requested to only check the toggles, not usage of actual system permissions
    // for the safety check.
    
    if (mounted) {
      context.read<AuthProvider>().setUser(name, _phoneController.text);
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }
}
