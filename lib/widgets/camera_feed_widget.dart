import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../config/theme.dart';

class CameraFeedWidget extends StatefulWidget {
  const CameraFeedWidget({super.key});

  @override
  State<CameraFeedWidget> createState() => _CameraFeedWidgetState();
}

class _CameraFeedWidgetState extends State<CameraFeedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveformController;
  Timer? _timer;
  int _seconds = 0;
  CameraController? _controller;
  bool _isCameraReady = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _waveformController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat();
    _startTimer();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() => _error = "No camera found");
        return;
      }

      // Use the first available camera (usually back camera on mobile, or webcam on desktop)
      final camera = cameras.first;
      _controller = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false, // We simulate audio visualizer for now to avoid feedback loop
      );

      await _controller!.initialize();
      if (mounted) {
        setState(() => _isCameraReady = true);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _error = "Camera error: $e");
      }
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() => _seconds++);
      }
    });
  }

  @override
  void dispose() {
    _waveformController.dispose();
    _timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  String get _formattedTime {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: AppTheme.sosRed.withValues(alpha: 0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Camera Feed or Fallback
            if (_isCameraReady && _controller != null)
              CameraPreview(_controller!)
            else
              _buildFallbackView(),

            // REC Indicator & Timer
            Positioned(
              top: 16,
              left: 16,
              child: Row(
                children: [
                  _BlinkingRecDot(),
                  const SizedBox(width: 8),
                  Text(
                    _formattedTime,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      fontSize: 14,
                      shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                    ),
                  ),
                ],
              ),
            ),

            // Live Label
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.sosRed,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'LIVE FEED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),

            // Bottom Bar: Waveform & Info
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.8)
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.mic, color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AnimatedBuilder(
                        animation: _waveformController,
                        builder: (context, child) {
                          return CustomPaint(
                            size: const Size(double.infinity, 20),
                            painter:
                                _WaveformPainter(_waveformController.value),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackView() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1A1A),
            Color(0xFF2C2C2C),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.videocam_off_rounded,
              color: Colors.white.withValues(alpha: 0.1),
              size: 64,
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _error!,
                  style: const TextStyle(color: Colors.white54, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BlinkingRecDot extends StatefulWidget {
  @override
  State<_BlinkingRecDot> createState() => _BlinkingRecDotState();
}

class _BlinkingRecDotState extends State<_BlinkingRecDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(
          color: AppTheme.sosRed,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _WaveformPainter extends CustomPainter {
  final double animationValue;

  _WaveformPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.safeGreen
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final centerY = size.height / 2;
    final width = size.width;

    path.moveTo(0, centerY);

    for (double x = 0; x <= width; x += 5) {
      // Create a wave effect
      final waveOutput = math.sin((x / width * 4 * math.pi) + (animationValue * 2 * math.pi));
      final amplitude = 8.0 * (math.sin(x / width * math.pi)); // Taper ends
      final y = centerY + (waveOutput * amplitude);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WaveformPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
