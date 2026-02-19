import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../config/app_config.dart';
import '../providers/sos_provider.dart';
import '../providers/location_provider.dart';
import '../widgets/camera_feed_widget.dart';

class SOSActiveScreen extends StatelessWidget {
  const SOSActiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sos = context.watch<SOSProvider>();
    final location = context.watch<LocationProvider>();

    // If marking safe is done, go back
    if (sos.state == SOSState.idle) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      });
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryDark,
              AppTheme.primaryMaroon,
              AppTheme.primaryMaroon.withValues(alpha: 0.95),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Cancel/Countdown Header
                if (sos.state == SOSState.countdown)
                  _buildCountdownHeader(context, sos)
                else
                  _buildActiveHeader(context),

                const SizedBox(height: 30),

                // SOS ACTIVATED title
                Text(
                  AppConfig.sosActivatedTitle,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 32,
                        letterSpacing: 3,
                      ),
                )
                    .animate()
                    .fadeIn(duration: 300.ms)
                    .then()
                    .shimmer(duration: 1500.ms, color: AppTheme.goldAccent),

                const SizedBox(height: 24),
                // Live Camera Feed
                const CameraFeedWidget()
                    .animate(delay: 200.ms)
                    .fadeIn()
                    .slideY(begin: 0.1, end: 0),

                const SizedBox(height: 24),

                // Status checklist
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      _buildStatusItem(
                        context,
                        icon: Icons.location_on_rounded,
                        label: 'Live Location Sharing',
                        isActive: sos.locationSharing,
                        delay: 400,
                      ),
                      _buildStatusItem(
                        context,
                        icon: Icons.videocam_rounded,
                        label: 'Audio & Video Recording',
                        isActive: sos.recording,
                        delay: 600,
                      ),
                      _buildStatusItem(
                        context,
                        icon: Icons.people_rounded,
                        label: 'Nearby Helpers Alerted',
                        isActive: sos.helpersAlerted,
                        delay: 800,
                      ),
                      _buildStatusItem(
                        context,
                        icon: Icons.local_police_rounded,
                        label: 'Police Notified',
                        isActive: sos.policeNotified,
                        delay: 1000,
                      ),
                      _buildStatusItem(
                        context,
                        icon: Icons.contacts_rounded,
                        label: 'Emergency Contacts Alerted',
                        isActive: sos.contactsAlerted,
                        delay: 1200,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Timer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.sosRed.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer_rounded,
                            color: AppTheme.goldAccent,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'TIME ELAPSED',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      sos.elapsedFormatted,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                )
                    .animate(delay: 1400.ms)
                    .fadeIn()
                    .slideY(begin: 0.2, end: 0),

                const SizedBox(height: 30),

                // Mark Safe / Slide to Cancel
                if (sos.state == SOSState.countdown)
                  _buildSlideToCancel(context, sos)
                else
                  _buildMarkSafeButton(context, sos),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCountdownHeader(BuildContext context, SOSProvider sos) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.sosRed.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: AppTheme.sosRed.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning_rounded,
                color: AppTheme.goldAccent, size: 22),
            const SizedBox(width: 10),
            Text(
              'Activating in ${sos.cancelCountdown}s...',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().shake(duration: 500.ms);
  }

  Widget _buildActiveHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_rounded,
                  color: Colors.white, size: 22),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.sosRed,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                )
                    .animate(onPlay: (c) => c.repeat())
                    .fadeOut(duration: 800.ms)
                    .then()
                    .fadeIn(duration: 800.ms),
                const SizedBox(width: 8),
                const Text(
                  'LIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isActive,
    required int delay,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isActive
                  ? AppTheme.safeGreen.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isActive ? Icons.check_circle_rounded : icon,
              color: isActive ? AppTheme.safeGreen : Colors.white54,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white54,
                fontSize: 16,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
          if (isActive)
            const Icon(Icons.check, color: AppTheme.safeGreen, size: 20),
        ],
      ),
    ).animate(delay: Duration(milliseconds: delay)).fadeIn().slideX(
          begin: 0.1,
          end: 0,
        );
  }

  Widget _buildSlideToCancel(BuildContext context, SOSProvider sos) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
        onTap: () {
          sos.cancelSOS();
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.sosRed.withValues(alpha: 0.6),
                AppTheme.sosRed,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border:
                Border.all(color: AppTheme.sosRed.withValues(alpha: 0.5)),
          ),
          child: Center(
            child: Text(
              'SLIDE TO CANCEL (${sos.cancelCountdown} SEC)',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildMarkSafeButton(BuildContext context, SOSProvider sos) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
        onTap: () {
          _showMarkSafeDialog(context, sos);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.safeGreen, AppTheme.safeGreen.withValues(alpha: 0.8)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppTheme.safeGreen.withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shield_rounded, color: Colors.white, size: 22),
              SizedBox(width: 10),
              Text(
                AppConfig.markSafeButton,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate(delay: 1600.ms).fadeIn().slideY(begin: 0.3, end: 0);
  }

  void _showMarkSafeDialog(BuildContext context, SOSProvider sos) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Row(
          children: [
            Icon(Icons.shield_rounded, color: AppTheme.safeGreen),
            SizedBox(width: 10),
            Text(AppConfig.markSafeDialogTitle),
          ],
        ),
        content: Text(AppConfig.markSafeDialogContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              sos.markSafe();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.safeGreen,
            ),
            child: const Text(AppConfig.markSafeConfirm,
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
