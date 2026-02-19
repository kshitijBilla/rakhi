import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../config/app_config.dart';
import '../providers/sos_provider.dart';

class SOSButton extends StatefulWidget {
  const SOSButton({super.key});

  @override
  State<SOSButton> createState() => _SOSButtonState();
}

class _SOSButtonState extends State<SOSButton>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _holdController;
  Timer? _holdTimer;
  bool _isHolding = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _holdController = AnimationController(
      vsync: this,
      duration: Duration(seconds: AppConfig.sosHoldDurationSeconds),
    );

    _holdController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        HapticFeedback.heavyImpact();
        final sos = context.read<SOSProvider>();
        sos.activateSOS();
        Navigator.pushNamed(context, AppRoutes.sosActive);
        _resetHold();
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _holdController.dispose();
    _holdTimer?.cancel();
    super.dispose();
  }

  void _startHold() {
    setState(() => _isHolding = true);
    _holdController.forward(from: 0);
    HapticFeedback.mediumImpact();
  }

  void _cancelHold() {
    _resetHold();
  }

  void _resetHold() {
    setState(() => _isHolding = false);
    _holdController.reset();
    _holdTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_pulseController, _holdController]),
      builder: (context, child) {
        final pulseValue = _pulseController.value;
        final holdValue = _holdController.value;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Outer pulse rings
            SizedBox(
              width: 220,
              height: 220,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer ring 3
                  if (!_isHolding)
                    Container(
                      width: 200 + (pulseValue * 20),
                      height: 200 + (pulseValue * 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.sosRed
                            .withValues(alpha: 0.05 + (pulseValue * 0.03)),
                      ),
                    ),
                  // Outer ring 2
                  if (!_isHolding)
                    Container(
                      width: 180 + (pulseValue * 12),
                      height: 180 + (pulseValue * 12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.sosRed
                            .withValues(alpha: 0.08 + (pulseValue * 0.04)),
                      ),
                    ),
                  // Hold progress ring
                  if (_isHolding)
                    SizedBox(
                      width: 195,
                      height: 195,
                      child: CircularProgressIndicator(
                        value: holdValue,
                        strokeWidth: 6,
                        backgroundColor:
                            AppTheme.sosRed.withValues(alpha: 0.15),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppTheme.goldAccent,
                        ),
                      ),
                    ),
                  // Main SOS Button
                  GestureDetector(
                    onLongPressStart: (_) => _startHold(),
                    onLongPressEnd: (_) => _cancelHold(),
                    onLongPressCancel: () => _cancelHold(),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: _isHolding ? 155 : 160,
                      height: _isHolding ? 155 : 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          center: Alignment.center,
                          radius: 0.8,
                          colors: [
                            _isHolding
                                ? AppTheme.sosRedDark
                                : AppTheme.sosRedLight,
                            AppTheme.sosRed,
                            AppTheme.sosRedDark,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.sosRed.withValues(
                                alpha: _isHolding ? 0.6 : 0.35),
                            blurRadius: _isHolding ? 40 : 25,
                            spreadRadius: _isHolding ? 8 : 4,
                          ),
                          BoxShadow(
                            color: AppTheme.sosRedDark.withValues(alpha: 0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppConfig.sosButtonLabel,
                            style: TextStyle(
                              fontSize: _isHolding ? 38 : 42,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 4,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                          if (!_isHolding) ...[
                            const SizedBox(height: 2),
                            Text(
                              AppConfig.sosButtonSubLabel,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withValues(alpha: 0.75),
                                letterSpacing: 3,
                              ),
                            ),
                          ],
                          if (_isHolding) ...[
                            const SizedBox(height: 2),
                            Text(
                              '${(holdValue * AppConfig.sosHoldDurationSeconds).toStringAsFixed(0)}s',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.goldAccent,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
