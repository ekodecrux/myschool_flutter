import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
import '../models/user_model.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
  
  SharedPreferences? _prefs;

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Secure Storage Methods (for tokens)
  
  Future<void> saveAccessToken(String token) async {
    await _secureStorage.write(
      key: ApiConfig.accessTokenKey,
      value: token,
    );
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: ApiConfig.accessTokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    await _secureStorage.write(
      key: ApiConfig.refreshTokenKey,
      value: token,
    );
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: ApiConfig.refreshTokenKey);
  }

  Future<void> deleteTokens() async {
    await _secureStorage.delete(key: ApiConfig.accessTokenKey);
    await _secureStorage.delete(key: ApiConfig.refreshTokenKey);
  }

  // SharedPreferences Methods (for user data and settings)
  
  Future<void> saveUserData(User user) async {
    final userJson = jsonEncode(user.toJson());
    await _prefs?.setString(ApiConfig.userDataKey, userJson);
  }

  Future<User?> getUserData() async {
    final userJson = _prefs?.getString(ApiConfig.userDataKey);
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  Future<void> setLoggedIn(bool value) async {
    await _prefs?.setBool(ApiConfig.isLoggedInKey, value);
  }

  Future<bool> isLoggedIn() async {
    return _prefs?.getBool(ApiConfig.isLoggedInKey) ?? false;
  }

  // Clear all data (logout)
  Future<void> clearAll() async {
    await deleteTokens();
    await _prefs?.remove(ApiConfig.userDataKey);
    await _prefs?.setBool(ApiConfig.isLoggedInKey, false);
  }

  // Generic key-value storage
  Future<void> saveString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return _prefs?.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    return _prefs?.getBool(key);
  }

  Future<void> saveInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    return _prefs?.getInt(key);
  }

  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }
}
