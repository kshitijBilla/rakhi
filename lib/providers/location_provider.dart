import 'package:flutter/material.dart';
import '../config/app_config.dart';

class LocationProvider extends ChangeNotifier {
  double _latitude = AppConfig.defaultLatitude;
  double _longitude = AppConfig.defaultLongitude;
  String _address = AppConfig.defaultAddress;
  bool _isTracking = false;
  bool _hasPermission = false;

  double get latitude => _latitude;
  double get longitude => _longitude;
  String get address => _address;
  bool get isTracking => _isTracking;
  bool get hasPermission => _hasPermission;

  String get locationLink =>
      'https://maps.google.com/?q=$_latitude,$_longitude';

  void updateLocation(double lat, double lng, String addr) {
    _latitude = lat;
    _longitude = lng;
    _address = addr;
    notifyListeners();
  }

  void startTracking() {
    _isTracking = true;
    notifyListeners();
  }

  void stopTracking() {
    _isTracking = false;
    notifyListeners();
  }

  void setPermission(bool granted) {
    _hasPermission = granted;
    notifyListeners();
  }
}
