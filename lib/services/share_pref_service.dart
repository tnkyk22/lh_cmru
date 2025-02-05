import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKeys {
  static const String userId = 'userId';
  static const String token = 'token';
  static const String name = 'name';
  static const String email = 'email';
}

class SharePrefService {
  static final SharePrefService _instance = SharePrefService._internal();

  factory SharePrefService() {
    return _instance;
  }

  SharePrefService._internal();

  // is logged in
  Future<void> saveIsLoggedIn(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<bool> getIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> saveUserSession(String userId, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPrefKeys.userId, userId);
    await prefs.setString(SharedPrefKeys.token, token);
  }

  Future<Map<String, String?>> getUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(SharedPrefKeys.userId);
    String? token = prefs.getString(SharedPrefKeys.token);
    return {'userId': userId, 'token': token};
  }

  Future<void> clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPrefKeys.userId);
    await prefs.remove(SharedPrefKeys.token);
  }

  // profile
  Future<void> saveProfile(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPrefKeys.name, name);
    await prefs.setString(SharedPrefKeys.email, email);
  }

  Future<Map<String, String?>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString(SharedPrefKeys.name);
    String? email = prefs.getString(SharedPrefKeys.email);
    return {'name': name, 'email': email};
  }

  Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPrefKeys.name);
    await prefs.remove(SharedPrefKeys.email);
  }

  // logout
  Future<void> logout() async {
    await clearUserSession();
    await clearProfile();
    await saveIsLoggedIn(false);
  }
  
}
