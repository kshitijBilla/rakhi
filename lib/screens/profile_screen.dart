import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../config/app_config.dart';
import '../providers/auth_provider.dart';
import 'help_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Header
                Row(
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
                    Text(AppConfig.profileTitle,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textPrimary)),
                  ],
                ).animate().fadeIn(duration: 300.ms),

                const SizedBox(height: 30),

                // Avatar
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryMaroon.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      auth.userName.isNotEmpty ? auth.userName[0].toUpperCase() : 'S',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ).animate(delay: 200.ms).scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.0, 1.0),
                      duration: 400.ms,
                    ),

                const SizedBox(height: 16),
                Text(
                  auth.userName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                ).animate(delay: 300.ms).fadeIn(),
                const SizedBox(height: 4),
                Text(
                  auth.userPhone.isNotEmpty ? auth.userPhone : AppConfig.profilePhoneNotSet,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textLight,
                  ),
                ).animate(delay: 400.ms).fadeIn(),

                const SizedBox(height: 30),

                // Stats Cards
                Row(
                  children: [
                    Expanded(
                        child: _buildStatCard('0', 'SOS\nTriggered',
                            AppTheme.sosRed)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _buildStatCard(
                            '3', 'Emergency\nContacts', AppTheme.primaryMaroon)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _buildStatCard(
                            '0', 'Recordings\nSaved', AppTheme.goldDark)),
                  ],
                ).animate(delay: 500.ms).fadeIn().slideY(begin: 0.1, end: 0),

                const SizedBox(height: 24),

                // Menu Items
                _buildMenuItem(
                  Icons.contacts_rounded,
                  AppConfig.profileContactsMenu,
                  AppConfig.profileContactsSub,
                  () => Navigator.pushNamed(context, AppRoutes.contacts),
                ).animate(delay: 600.ms).fadeIn().slideX(begin: 0.05, end: 0),
                _buildMenuItem(
                  Icons.settings_rounded,
                  AppConfig.profileSettingsMenu,
                  AppConfig.profileSettingsSub,
                  () => Navigator.pushNamed(context, AppRoutes.settings),
                ).animate(delay: 700.ms).fadeIn().slideX(begin: 0.05, end: 0),
                _buildMenuItem(
                  Icons.history_rounded,
                  AppConfig.profileHistoryMenu,
                  AppConfig.profileHistorySub,
                  () => Navigator.pushNamed(context, AppRoutes.history),
                ).animate(delay: 800.ms).fadeIn().slideX(begin: 0.05, end: 0),
                _buildMenuItem(
                  Icons.help_outline_rounded,
                  AppConfig.profileHelpMenu,
                  AppConfig.profileHelpSub,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HelpScreen()),
                  ),
                ).animate(delay: 900.ms).fadeIn().slideX(begin: 0.05, end: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.textLight,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      IconData icon, String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
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
              child: Icon(icon, color: AppTheme.primaryMaroon, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppTheme.textPrimary)),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 12, color: AppTheme.textLight)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: AppTheme.textLight),
          ],
        ),
      ),
    );
  }
}
