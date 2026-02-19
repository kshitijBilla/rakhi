import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/theme.dart';
import '../config/app_config.dart';

class HelplineScreen extends StatelessWidget {
  const HelplineScreen({super.key});

  Future<void> _makeCall(String number) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: number,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      debugPrint('Could not launch $launchUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
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
                    Text('Helpline Numbers',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textPrimary)),
                  ],
                ),
              ).animate().fadeIn(duration: 300.ms),

              // List of Numbers
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: AppConfig.helplineNumbers.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = AppConfig.helplineNumbers[index];
                    return _buildHelplineTile(
                      context,
                      item['name']!,
                      item['number']!,
                      _getIcon(item['icon']!),
                      index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'local_police_rounded':
        return Icons.local_police_rounded;
      case 'woman_rounded':
        return Icons.woman_rounded;
      case 'local_hospital_rounded':
        return Icons.local_hospital_rounded;
      case 'local_fire_department_rounded':
        return Icons.local_fire_department_rounded;
      case 'home_rounded':
        return Icons.home_rounded;
      case 'security_rounded':
        return Icons.security_rounded;
      case 'child_care_rounded':
        return Icons.child_care_rounded;
      case 'elderly_rounded':
        return Icons.elderly_rounded;
      default:
        return Icons.phone_rounded;
    }
  }

  Widget _buildHelplineTile(BuildContext context, String name, String number,
      IconData icon, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _makeCall(number),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryMaroon.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: AppTheme.primaryMaroon, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        number,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryMaroon,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.safeGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.call_rounded,
                    color: AppTheme.safeGreen,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate(delay: (100 * index).ms).fadeIn().slideY(begin: 0.2, end: 0);
  }
}
