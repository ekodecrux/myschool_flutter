import 'package:flutter/material.dart';
import 'config/app_theme.dart';
import 'config/app_constants.dart';
import 'services/storage_service.dart';
import 'screens/landing/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize storage service
  await StorageService().init();
  
  runApp(const MySchoolApp());
}

class MySchoolApp extends StatelessWidget {
  const MySchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const LandingScreen(),
    );
  }
}
