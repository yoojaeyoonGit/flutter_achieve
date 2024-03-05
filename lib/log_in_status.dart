import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void loginUser() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logoutUser() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
