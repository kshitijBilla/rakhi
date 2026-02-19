import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../config/app_config.dart';
import '../providers/auth_provider.dart';
import '../providers/location_provider.dart';
import '../widgets/sos_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final location = context.watch<LocationProvider>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Status info
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.safeGreen,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          AppConfig.gpsActiveLabel,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    // Battery & Signal icons
                    Row(
                      children: [
                        Icon(Icons.signal_cellular_alt,
                            size: 16, color: AppTheme.textSecondary),
                        const SizedBox(width: 8),
                        Icon(Icons.battery_std_rounded,
                            size: 16, color: AppTheme.safeGreen),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 300.ms),

              // Greeting
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                          ),
                      children: [
                        TextSpan(text: AppConfig.greetingPrefix),
                        TextSpan(
                          text: '${auth.userName} ',
                          style:
                              const TextStyle(color: AppTheme.primaryMaroon),
                        ),
                        TextSpan(text: AppConfig.greetingEmoji),
                      ],
                    ),
                  ),
                ),
              ).animate(delay: 200.ms).fadeIn().slideX(begin: -0.1, end: 0),

              const SizedBox(height: 16),

              // Map Preview Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.primaryMaroon.withValues(alpha: 0.08),
                        AppTheme.primaryMaroon.withValues(alpha: 0.15),
                      ],
                    ),
                    border: Border.all(
                      color: AppTheme.primaryMaroon.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Map placeholder grid pattern
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: CustomPaint(
                          size: const Size(double.infinity, 160),
                          painter: _MapGridPainter(),
                        ),
                      ),
                      // Location pin
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryMaroon,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.primaryMaroon
                                        .withValues(alpha: 0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.my_location_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                location.address,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppTheme.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.1, end: 0),

              const Spacer(),

              // SOS Button
              const SOSButton(),

              const SizedBox(height: 8),
              Text(
                AppConfig.holdInstruction,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                  letterSpacing: 1.5,
                ),
              ).animate(delay: 600.ms).fadeIn(),

              const Spacer(),

              // Quick Action Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildQuickAction(
                      Icons.alt_route_rounded,
                      AppConfig.quickActionSafeRoute,
                      AppTheme.safeGreen,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.safeRoute),
                    ),
                    _buildQuickAction(
                      Icons.support_agent_rounded,
                      AppConfig.quickActionHelpline,
                      Colors.blue,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.helpline),
                    ).animate(delay: 500.ms).fadeIn().slideX(begin: 0.2, end: 0),
                    _buildQuickAction(
                      Icons.watch_rounded,
                      AppConfig.quickActionWearable,
                      AppTheme.goldAccent,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.wearable),
                    ),
                    _buildQuickAction(
                      Icons.contacts_rounded,
                      AppConfig.quickActionContacts,
                      AppTheme.primaryMaroon,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.contacts),
                    ),
                  ],
                ),
              ).animate(delay: 700.ms).fadeIn().slideY(begin: 0.2, end: 0),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      // Bottom Navigation
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryMaroon.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BottomNavigationBar(
            currentIndex: _currentNavIndex,
            onTap: (i) {
              setState(() => _currentNavIndex = i);
              switch (i) {
                case 1:
                  Navigator.pushNamed(context, AppRoutes.map);
                  break;
                case 2:
                  Navigator.pushNamed(context, AppRoutes.history);
                  break;
                case 3:
                  Navigator.pushNamed(context, AppRoutes.profile);
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: AppConfig.navHome,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map_rounded),
                label: AppConfig.navMap,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_rounded),
                label: AppConfig.navHistory,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: AppConfig.navProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, Color color,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap?.call();
      },
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: color.withValues(alpha: 0.2),
              ),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryMaroon.withValues(alpha: 0.05)
      ..strokeWidth = 0.5;

    // Horizontal lines
    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    // Vertical lines
    for (double x = 0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Roads
    final roadPaint = Paint()
      ..color = AppTheme.primaryMaroon.withValues(alpha: 0.08)
      ..strokeWidth = 3;
    canvas.drawLine(
        Offset(size.width * 0.3, 0),
        Offset(size.width * 0.3, size.height),
        roadPaint);
    canvas.drawLine(
        Offset(size.width * 0.7, 0),
        Offset(size.width * 0.7, size.height),
        roadPaint);
    canvas.drawLine(
        Offset(0, size.height * 0.4),
        Offset(size.width, size.height * 0.4),
        roadPaint);
    canvas.drawLine(
        Offset(0, size.height * 0.7),
        Offset(size.width, size.height * 0.7),
        roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
