import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'MySchool';
  static const String appVersion = '1.0.0';
  
  // User Roles
  static const String roleSuperAdmin = 'SUPER_ADMIN';
  static const String roleSchoolAdmin = 'SCHOOL_ADMIN';
  static const String roleTeacher = 'TEACHER';
  static const String roleStudent = 'STUDENT';
  static const String roleParent = 'PARENT';
  static const String roleIndividual = 'INDIVIDUAL';
  static const String rolePublication = 'PUBLICATION';
  
  // Image Categories
  static const List<String> imageCategories = [
    'ACADEMIC',
    'CLASS',
    'GREAT',
    'IMAGE',
    'MENU',
  ];
  
  // Maker Types
  static const List<String> makerTypes = [
    'Certificate',
    'ID Card',
    'Poster',
    'Banner',
    'Invitation',
    'Newsletter',
  ];
  
  // MySchool Brand Colors (matching web app exactly)
  static const Color primaryColor = Color(0xFF34518A);      // Main brand blue from web
  static const Color secondaryColor = Color(0xFF7BA6FB);    // Hover/accent blue from web
  static const Color accentColor = Color(0xFF7BA6FB);       // Same as secondary
  static const Color errorColor = Color(0xFFD32F2F);        // Error red
  static const Color successColor = Color(0xFF388E3C);      // Success green
  static const Color warningColor = Color(0xFFF57C00);      // Warning orange
  static const Color infoColor = Color(0xFF34518A);         // Same as primary
  
  static const Color backgroundColor = Color(0xFFF5F5F5);   // Light gray background
  static const Color surfaceColor = Color(0xFFFFFFFF);      // White surface
  static const Color textPrimaryColor = Color(0xFF212121);  // Dark gray text
  static const Color textSecondaryColor = Color(0xFF757575); // Medium gray text
  static const Color borderColor = Color(0xFFDDDDDD);       // Light gray border from web
  static const Color linkColor = Color(0xFF34518A);         // Link blue (same as primary)
  
  // Text Styles (matching web app fonts: Roboto)
  static const TextStyle headingLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: textPrimaryColor,
    fontFamily: 'Roboto',
  );
  
  static const TextStyle headingMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
    fontFamily: 'Roboto',
  );
  
  static const TextStyle headingSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
    fontFamily: 'Roboto',
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textPrimaryColor,
    fontFamily: 'Roboto',
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textPrimaryColor,
    fontFamily: 'Roboto',
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textSecondaryColor,
    fontFamily: 'Roboto',
  );
  
  static const TextStyle labelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: textPrimaryColor,
    fontFamily: 'Roboto',
  );
  
  static const TextStyle linkStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: linkColor,
    decoration: TextDecoration.none,
    fontFamily: 'Roboto',
  );
  
  // Spacing
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;
  
  // Border Radius
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusXLarge = 16.0;
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int otpLength = 6;
  
  // Regex Patterns
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  
  static final RegExp phoneRegex = RegExp(
    r'^[6-9]\d{9}$',
  );
  
  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]',
  );
  
  // Error Messages
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNetwork = 'Network error. Please check your connection.';
  static const String errorTimeout = 'Request timeout. Please try again.';
  static const String errorUnauthorized = 'Session expired. Please login again.';
  static const String errorInvalidCredentials = 'Invalid email or password.';
  static const String errorEmailExists = 'Email already registered.';
  
  // Success Messages
  static const String successLogin = 'Login successful';
  static const String successRegister = 'Registration successful';
  static const String successPasswordReset = 'Password reset successful';
  static const String successProfileUpdate = 'Profile updated successfully';
  static const String successImageSaved = 'Image saved successfully';
  
  // Validation Messages
  static const String validationEmailRequired = 'Email is required';
  static const String validationEmailInvalid = 'Please enter a valid email';
  static const String validationPasswordRequired = 'Password is required';
  static const String validationPasswordLength = 'Password must be at least 8 characters';
  static const String validationPasswordWeak = 'Password must contain uppercase, lowercase, number and special character';
  static const String validationPhoneRequired = 'Phone number is required';
  static const String validationPhoneInvalid = 'Please enter a valid 10-digit phone number';
  static const String validationNameRequired = 'Name is required';
  static const String validationOtpRequired = 'OTP is required';
  static const String validationOtpInvalid = 'Please enter a valid 6-digit OTP';
}
