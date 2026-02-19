import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';
import '../config/app_config.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final List<Map<String, String>> _faqs = [
    {
      'question': 'How do I activate SOS?',
      'answer':
          'Press and hold the red SOS button on the home screen for ${AppConfig.sosHoldDurationSeconds} seconds. It will instantly alert your emergency contacts and nearby helpers.',
    },
    {
      'question': 'Who gets notified when I trigger SOS?',
      'answer':
          'Your added emergency contacts receive an SMS with your live location. The app also notifies nearby users (helpers) and the police control room.',
    },
    {
      'question': 'What is "Safe Route"?',
      'answer':
          'Safe Route analyzes crime data and lighting conditions to suggest the safest path for your navigation, avoiding high-risk zones.',
    },
    {
      'question': 'Do I need internet for SOS?',
      'answer':
          'Internet is recommended for live video/location, but the app also attempts to send SMS alerts if data is unavailable.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
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
                    Text('Help & Support',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textPrimary)),
                  ],
                ),
              ).animate().fadeIn(duration: 300.ms),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('Frequently Asked Questions'),
                      const SizedBox(height: 10),
                      ..._faqs.map((faq) => _buildFaqTile(
                          faq['question']!, faq['answer']!)),
                      
                      const SizedBox(height: 30),
                      _buildSectionHeader('Contact Support'),
                      const SizedBox(height: 10),
                      _buildContactTile(
                          Icons.email_rounded, 'Email Us', 'support@rakhi.app'),
                      _buildContactTile(
                          Icons.phone_rounded, 'Call Support', '1800-123-4567'),
                      
                      const SizedBox(height: 40),
                      Center(
                        child: Text(
                          'Version ${AppConfig.appVersion}',
                          style: const TextStyle(
                              color: AppTheme.textLight, fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppTheme.primaryMaroon,
      ),
    ).animate().fadeIn().slideX(begin: -0.1, end: 0);
  }

  Widget _buildFaqTile(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          title: Text(
            question,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
              fontSize: 15,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text(
                answer,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  height: 1.5,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
  }

  Widget _buildContactTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.primaryMaroon.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppTheme.primaryMaroon),
        ),
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
        subtitle: Text(subtitle,
            style: const TextStyle(color: AppTheme.textSecondary)),
        trailing: const Icon(Icons.chevron_right_rounded,
            color: AppTheme.textLight),
        onTap: () {
          // TODO: Implement contact action
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Simulating action: $title')),
          );
        },
      ),
    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
  }
}
