import 'package:flutter/material.dart';

class Exercise3Notifier extends ChangeNotifier {
  String _errorMessage = "";
  bool _isLoading = false;

  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  final myUserName = "test@example.com";
  final myPassword = "Pass@123";

  Future<bool> login(String username, String password) async {
    onErrorMessageChange("");

    if (!_isValidPassword(password)) {
      onErrorMessageChange(
          "Password must be at least 8 characters and contain at least one special character.");
      return false;
    }

    _showLoading();

    try {
      // Fake API call delay
      await Future.delayed(const Duration(seconds: 2));

      if (username == myUserName && password == myPassword) {
        _hideLoading();
        return true;
      } else if (username == "throw") {
        throw "";
      } else {
        onErrorMessageChange("Invalid username or password.");
        _hideLoading();
        return false;
      }
    } catch (e) {
      onErrorMessageChange("Something went wrong. Please try again.");
      _hideLoading();
      return false;
    }
  }

  bool _isValidPassword(String password) {
    return password.length >= 8 &&
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  void onErrorMessageChange(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _showLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _hideLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
