import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../models/user_model.dart';
import 'storage_service.dart';
import 'api_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  User? _currentUser;
  User? get currentUser => _currentUser;

  // Initialize auth state
  Future<bool> init() async {
    try {
      final isLoggedIn = await _storageService.isLoggedIn();
      if (isLoggedIn) {
        _currentUser = await _storageService.getUserData();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Login with email/password
  Future<LoginResponse> login({
    required String username,
    required String password,
    String? schoolCode,
  }) async {
    try {
      final response = await _apiService.post(
        ApiConfig.login,
        data: {
          'username': username,
          'password': password,
          if (schoolCode != null) 'schoolCode': schoolCode,
        },
      );

      final loginResponse = LoginResponse.fromJson(response.data);
      
      // Save tokens
      await _storageService.saveAccessToken(loginResponse.accessToken);
      await _storageService.saveRefreshToken(loginResponse.refreshToken);
      await _storageService.setLoggedIn(true);
      
      // Fetch and save user details
      await fetchUserDetails();
      
      return loginResponse;
    } catch (e) {
      rethrow;
    }
  }

  // Login with OTP
  Future<LoginResponse> loginWithOtp({
    required String mobileNumber,
    required String otp,
  }) async {
    try {
      final response = await _apiService.post(
        ApiConfig.loginViaOtp,
        data: {
          'mobileNumber': mobileNumber,
          'otp': otp,
        },
      );

      final loginResponse = LoginResponse.fromJson(response.data);
      
      await _storageService.saveAccessToken(loginResponse.accessToken);
      await _storageService.saveRefreshToken(loginResponse.refreshToken);
      await _storageService.setLoggedIn(true);
      
      await fetchUserDetails();
      
      return loginResponse;
    } catch (e) {
      rethrow;
    }
  }

  // Send OTP
  Future<void> sendOtp(String mobileNumber) async {
    try {
      await _apiService.get(
        '${ApiConfig.sendOtp}?mobileNumber=$mobileNumber',
      );
    } catch (e) {
      rethrow;
    }
  }

  // Register new user
  Future<Map<String, dynamic>> register(RegisterRequest request) async {
    try {
      final response = await _apiService.post(
        ApiConfig.register,
        data: request.toJson(),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Forgot password
  Future<void> forgotPassword(String email) async {
    try {
      await _apiService.get(
        '${ApiConfig.forgotPassword}?email=$email',
      );
    } catch (e) {
      rethrow;
    }
  }

  // Confirm password reset
  Future<void> confirmPasswordReset({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      await _apiService.post(
        ApiConfig.confirmPassword,
        data: {
          'email': email,
          'code': code,
          'newPassword': newPassword,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  // Change password
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await _apiService.post(
        ApiConfig.changePassword,
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
        requiresAuth: true,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Fetch user details
  Future<User> fetchUserDetails() async {
    try {
      final response = await _apiService.get(
        ApiConfig.getUserDetails,
        requiresAuth: true,
      );
      
      _currentUser = User.fromJson(response.data);
      await _storageService.saveUserData(_currentUser!);
      
      return _currentUser!;
    } catch (e) {
      rethrow;
    }
  }

  // Update user details
  Future<User> updateUserDetails(Map<String, dynamic> data) async {
    try {
      await _apiService.patch(
        ApiConfig.updateUserDetails,
        data: data,
        requiresAuth: true,
      );
      
      // Fetch updated user details
      return await fetchUserDetails();
    } catch (e) {
      rethrow;
    }
  }

  // Refresh access token
  Future<void> refreshAccessToken() async {
    try {
      final refreshToken = await _storageService.getRefreshToken();
      if (refreshToken == null) {
        throw Exception('No refresh token available');
      }

      final response = await _apiService.post(
        ApiConfig.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      final newAccessToken = response.data['accessToken'];
      await _storageService.saveAccessToken(newAccessToken);
    } catch (e) {
      // If refresh fails, logout user
      await logout();
      rethrow;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _storageService.clearAll();
      _currentUser = null;
    } catch (e) {
      rethrow;
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    return await _storageService.isLoggedIn();
  }

  // Get current user role
  String? getUserRole() {
    return _currentUser?.role;
  }

  // Check if user has specific role
  bool hasRole(String role) {
    return _currentUser?.role == role;
  }

  // Check if user is admin
  bool isAdmin() {
    return _currentUser?.role == 'SUPER_ADMIN' || 
           _currentUser?.role == 'SCHOOL_ADMIN';
  }
}
