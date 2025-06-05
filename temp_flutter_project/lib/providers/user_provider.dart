import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  Map<String, dynamic>? _userData;

  bool get isLoggedIn => _isLoggedIn;
  Map<String, dynamic>? get userData => _userData;

  Future<void> login(Map<String, dynamic> userData) async {
    _userData = userData;
    _isLoggedIn = true;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userData', userData.toString());
    
    notifyListeners();
  }

  Future<void> logout() async {
    _userData = null;
    _isLoggedIn = false;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (_isLoggedIn) {
      final userDataString = prefs.getString('userData');
      // Aqui você precisaria implementar a lógica para converter a string em Map
      // _userData = convertStringToMap(userDataString);
    }
    notifyListeners();
  }
} 