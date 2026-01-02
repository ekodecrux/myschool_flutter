import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'MySchool';
  static const String appTagline = 'Solutions Beyond School';
  static const String appVersion = '1.0.0';
  
  // MySchool Brand Colors (from portal.myschoolct.com)
  static const Color primaryMagenta = Color(0xFFE91E63);    // "my" in logo
  static const Color primaryBlue = Color(0xFF2196F3);       // "school" in logo
  static const Color accentOrange = Color(0xFFFF9800);      // Search/voice icons
  
  // Backward compatibility aliases
  static const Color primaryColor = primaryMagenta;         // Alias for old screens
  static const Color secondaryColor = primaryBlue;          // Alias for old screens
  static const Color accentColor = accentOrange;            // Alias for old screens
  static const Color infoColor = primaryBlue;               // Alias for old screens
  static const Color backgroundColor = Color(0xFFFFFFFF);   // White background
  static const Color surfaceColor = Color(0xFFFFFFFF);      // White surface
  static const Color errorColor = Color(0xFFF44336);        // Error red
  static const Color successColor = Color(0xFF4CAF50);      // Success green
  
  // Category Colors (from web portal)
  static const Color academicBlue = Color(0xFF5C6BC0);
  static const Color careerOrange = Color(0xFFFF9800);
  static const Color edutainmentGreen = Color(0xFF66BB6A);
  static const Color printRichPink = Color(0xFFEC407A);
  static const Color makerGray = Color(0xFF78909C);
  static const Color infoHubBlue = Color(0xFF42A5F5);
  
  // Text Colors
  static const Color textPrimaryColor = Color(0xFF212121);  // Dark text
  static const Color textSecondaryColor = Color(0xFF757575); // Gray text
  static const Color textHintColor = Color(0xFFBDBDBD);     // Light gray
  
  // Border & Divider
  static const Color borderColor = Color(0xFFE0E0E0);       // Light gray border
  static const Color dividerColor = Color(0xFFEEEEEE);      // Very light gray
  
  // User Roles
  static const String roleSuperAdmin = 'SUPER_ADMIN';
  static const String roleSchoolAdmin = 'SCHOOL_ADMIN';
  static const String roleTeacher = 'TEACHER';
  static const String roleStudent = 'STUDENT';
  static const String roleParent = 'PARENT';
  static const String roleIndividual = 'INDIVIDUAL';
  
  // Categories (matching web app)
  static const List<Map<String, dynamic>> categories = [
    {
      'id': 'academic',
      'name': 'Academic',
      'icon': 'star',
      'color': academicBlue,
    },
    {
      'id': 'early_career',
      'name': 'Early Career',
      'icon': 'work',
      'color': careerOrange,
    },
    {
      'id': 'edutainment',
      'name': 'Edutainment',
      'icon': 'games',
      'color': edutainmentGreen,
    },
    {
      'id': 'print_rich',
      'name': 'Print Rich',
      'icon': 'print',
      'color': printRichPink,
    },
    {
      'id': 'maker',
      'name': 'Maker',
      'icon': 'build',
      'color': makerGray,
    },
    {
      'id': 'info_hub',
      'name': 'Info Hub',
      'icon': 'share',
      'color': infoHubBlue,
    },
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
  
  // Text Styles
  static const TextStyle headingLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
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
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 50;
  static const int otpLength = 6;
  
  // Regex Patterns
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  
  static final RegExp phoneRegex = RegExp(
    r'^[6-9]\d{9}$',
  );
  
  // Error Messages
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNetwork = 'Network error. Please check your connection.';
  static const String errorUnauthorized = 'Session expired. Please login again.';
  
  // Success Messages
  static const String successLogin = 'Login successful';
  static const String successRegister = 'Registration successful';
  static const String successPasswordReset = 'Password reset successful';
  
  // Validation Messages
  static const String validationEmailRequired = 'Email is required';
  static const String validationEmailInvalid = 'Please enter a valid email';
  static const String validationPasswordRequired = 'Password is required';
  static const String validationPasswordLength = 'Password must be at least 6 characters';
  static const String validationPhoneRequired = 'Phone number is required';
  static const String validationPhoneInvalid = 'Please enter a valid 10-digit phone number';
  static const String validationOtpRequired = 'OTP is required';
  static const String validationOtpInvalid = 'Please enter a valid 6-digit OTP';
  static const String validationNameRequired = 'Name is required';
}
