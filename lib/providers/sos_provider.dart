import 'dart:async';
import 'package:flutter/material.dart';
import '../config/app_config.dart';

enum SOSState { idle, holding, countdown, active, markingSafe }

class SOSProvider extends ChangeNotifier {
  SOSState _state = SOSState.idle;
  int _holdProgress = 0; // 0-100
  int _elapsedSeconds = 0;
  int _cancelCountdown = AppConfig.sosCancelWindowSeconds;
  Timer? _elapsedTimer;
  Timer? _cancelTimer;
  bool _locationSharing = false;
  bool _recording = false;
  bool _helpersAlerted = false;
  bool _policeNotified = false;
  bool _contactsAlerted = false;

  SOSState get state => _state;
  int get holdProgress => _holdProgress;
  int get elapsedSeconds => _elapsedSeconds;
  int get cancelCountdown => _cancelCountdown;
  bool get isActive => _state == SOSState.active;
  bool get locationSharing => _locationSharing;
  bool get recording => _recording;
  bool get helpersAlerted => _helpersAlerted;
  bool get policeNotified => _policeNotified;
  bool get contactsAlerted => _contactsAlerted;

  String get elapsedFormatted {
    final minutes = (_elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void startHolding() {
    _state = SOSState.holding;
    _holdProgress = 0;
    notifyListeners();
  }

  void updateHoldProgress(int progress) {
    _holdProgress = progress;
    notifyListeners();
  }

  void cancelHolding() {
    _state = SOSState.idle;
    _holdProgress = 0;
    notifyListeners();
  }

  void activateSOS() {
    // Instant activation per user request
    _confirmSOS();
  }

  void cancelSOS() {
    _cancelTimer?.cancel();
    _elapsedTimer?.cancel();
    _state = SOSState.idle;
    _holdProgress = 0;
    _elapsedSeconds = 0;
    _cancelCountdown = AppConfig.sosCancelWindowSeconds;
    _locationSharing = false;
    _recording = false;
    _helpersAlerted = false;
    _policeNotified = false;
    _contactsAlerted = false;
    notifyListeners();
  }

  void _confirmSOS() {
    _state = SOSState.active;
    _elapsedSeconds = 0;

    // Simulate parallel service activation using configurable delays
    Future.delayed(
      Duration(milliseconds: AppConfig.locationActivationDelayMs),
      () { _locationSharing = true; notifyListeners(); },
    );
    Future.delayed(
      Duration(milliseconds: AppConfig.recordingActivationDelayMs),
      () { _recording = true; notifyListeners(); },
    );
    Future.delayed(
      Duration(milliseconds: AppConfig.helpersActivationDelayMs),
      () { _helpersAlerted = true; notifyListeners(); },
    );
    Future.delayed(
      Duration(milliseconds: AppConfig.policeActivationDelayMs),
      () { _policeNotified = true; notifyListeners(); },
    );
    Future.delayed(
      Duration(milliseconds: AppConfig.contactsActivationDelayMs),
      () { _contactsAlerted = true; notifyListeners(); },
    );

    _elapsedTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedSeconds++;
      notifyListeners();
    });

    notifyListeners();
  }

  void markSafe() {
    _state = SOSState.markingSafe;
    notifyListeners();

    Future.delayed(
      Duration(seconds: AppConfig.markSafeDelaySeconds),
      () { cancelSOS(); },
    );
  }

  @override
  void dispose() {
    _elapsedTimer?.cancel();
    _cancelTimer?.cancel();
    super.dispose();
  }
}
