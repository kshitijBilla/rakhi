import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../providers/location_provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final location = context.watch<LocationProvider>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
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
                    Text(
                      'Live Map',
                      style:
                          Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textPrimary,
                              ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.safeGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color:
                                AppTheme.safeGreen.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.safeGreen,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'GPS Active',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.safeGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 300.ms),

              // Map Area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white,
                      boxShadow: AppTheme.cardShadow,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        children: [
                          // Map placeholder
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: AppTheme.backgroundPink,
                            child: CustomPaint(
                              painter: _DetailedMapPainter(),
                            ),
                          ),
                          // User location marker
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryMaroon,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.primaryMaroon
                                            .withValues(alpha: 0.4),
                                        blurRadius: 25,
                                        spreadRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(Icons.person_pin,
                                      color: Colors.white, size: 28),
                                )
                                    .animate(
                                        onPlay: (controller) =>
                                            controller.repeat(reverse: true))
                                    .scale(
                                      begin: const Offset(0.95, 0.95),
                                      end: const Offset(1.05, 1.05),
                                      duration: 1500.ms,
                                    ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: AppTheme.cardShadow,
                                  ),
                                  child: Text(
                                    location.address,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Nearby helper pins
                          Positioned(
                            top: 80,
                            left: 60,
                            child: _buildHelperPin('Helper 1', Colors.blue),
                          ),
                          Positioned(
                            top: 150,
                            right: 50,
                            child: _buildHelperPin('Helper 2', Colors.orange),
                          ),
                          Positioned(
                            bottom: 120,
                            left: 80,
                            child: _buildHelperPin('Helper 3', Colors.green),
                          ),
                          // Recording overlay
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppTheme.sosRed,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  )
                                      .animate(
                                          onPlay: (c) =>
                                              c.repeat(reverse: true))
                                      .fadeOut(duration: 700.ms),
                                  const SizedBox(width: 6),
                                  const Text(
                                    'Recording...',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.05, end: 0),

              // Location Info Card
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: AppTheme.cardShadow,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.videocam_rounded,
                              color: AppTheme.sosRed, size: 22),
                          const SizedBox(width: 10),
                          const Text(
                            'Evidence automatically saved.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildContactRow(
                          Icons.phone, 'Police control room', '112'),
                      const SizedBox(height: 10),
                      _buildContactRow(
                          Icons.phone, 'Women helpline', '1091'),
                    ],
                  ),
                ),
              ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.1, end: 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelperPin(String name, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(Icons.person, color: color, size: 16),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    ).animate().fadeIn(delay: 800.ms).scale(
          begin: const Offset(0, 0),
          end: const Offset(1, 1),
          duration: 400.ms,
        );
  }

  Widget _buildContactRow(IconData icon, String label, String number) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryMaroon.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.primaryMaroon, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        Text(
          number,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppTheme.primaryMaroon,
          ),
        ),
      ],
    );
  }
}

class _DetailedMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppTheme.primaryMaroon.withValues(alpha: 0.04)
      ..strokeWidth = 0.5;

    for (double y = 0; y < size.height; y += 15) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    for (double x = 0; x < size.width; x += 15) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    final roadPaint = Paint()
      ..color = AppTheme.primaryMaroon.withValues(alpha: 0.06)
      ..strokeWidth = 4;

    canvas.drawLine(Offset(size.width * 0.2, 0),
        Offset(size.width * 0.5, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.8, 0),
        Offset(size.width * 0.6, size.height), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.3),
        Offset(size.width, size.height * 0.5), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.7),
        Offset(size.width, size.height * 0.6), roadPaint);

    // Park areas
    final parkPaint = Paint()
      ..color = AppTheme.safeGreen.withValues(alpha: 0.06);
    canvas.drawCircle(
        Offset(size.width * 0.15, size.height * 0.2), 30, parkPaint);
    canvas.drawCircle(
        Offset(size.width * 0.85, size.height * 0.8), 25, parkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
