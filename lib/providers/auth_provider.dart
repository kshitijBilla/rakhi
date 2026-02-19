import 'package:flutter/material.dart';
import '../config/app_config.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _userName = AppConfig.defaultUserName;
  String _userPhone = AppConfig.defaultUserPhone;
  bool _isLoading = false;

  bool get isLoggedIn => _isLoggedIn;
  String get userName => _userName;
  String get userPhone => _userPhone;
  bool get isLoading => _isLoading;

  void setUser(String name, String phone) {
    _userName = name;
    _userPhone = phone;
    _isLoggedIn = true;
    notifyListeners();
  }

  void login(String name, String phone) {
    _isLoading = true;
    notifyListeners();

    Future.delayed(
      Duration(milliseconds: AppConfig.loginSimulationDelayMs),
      () {
        _userName = name;
        _userPhone = phone;
        _isLoggedIn = true;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  void logout() {
    _isLoggedIn = false;
    _userName = '';
    _userPhone = '';
    notifyListeners();
  }
}
