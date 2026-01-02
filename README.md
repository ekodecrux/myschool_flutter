# MySchool Flutter Mobile App

A comprehensive educational platform mobile application built with Flutter, connecting to the MySchool Flask API backend.

## Features

- **Authentication System**
  - Email/Password login with optional school code
  - OTP-based login via mobile number
  - User registration with multiple roles (Individual, Teacher, Student, Parent, School Admin)
  - Forgot password with email verification
  - JWT token management with automatic refresh
  - Secure token storage using FlutterSecureStorage

- **User Roles**
  - Individual
  - Teacher
  - Student
  - Parent
  - School Admin
  - Super Admin

- **Core Features**
  - Dashboard with user information and quick actions
  - Image Bank for browsing and managing educational images
  - Template/Maker system for creating certificates, ID cards, posters, etc.
  - User profile management
  - Credits system
  - Search functionality

## Tech Stack

- **Framework**: Flutter 3.24.5
- **Language**: Dart 3.5.4
- **State Management**: Provider + BLoC
- **HTTP Client**: Dio with Retrofit
- **Secure Storage**: FlutterSecureStorage
- **UI**: Material Design 3

## API Integration

Base URL: `https://portal.myschoolct.com/api`

The app integrates with 60+ API endpoints including:
- Authentication (login, register, OTP, password reset)
- User Management
- School Management
- Image Bank
- Templates/Makers
- Search
- Payments
- Admin Operations

## Project Structure

```
lib/
├── config/           # App configuration and constants
│   ├── api_config.dart
│   ├── app_constants.dart
│   └── app_theme.dart
├── models/           # Data models
│   └── user_model.dart
├── services/         # Business logic and API services
│   ├── api_service.dart
│   ├── auth_service.dart
│   └── storage_service.dart
├── screens/          # UI screens
│   ├── auth/
│   ├── dashboard/
│   ├── home/
│   ├── images/
│   ├── profile/
│   └── templates/
├── widgets/          # Reusable widgets
│   └── loading_button.dart
└── main.dart         # App entry point
```

## Getting Started

### Prerequisites

- Flutter SDK 3.24.5 or higher
- Dart 3.5.4 or higher
- Android Studio / Xcode (for iOS)
- Java 17 (for Android builds)

### Installation

1. Clone the repository
```bash
git clone https://github.com/ekodecrux/myschool_flutter.git
cd myschool_flutter
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

### Building APK

For Android release build:
```bash
flutter build apk --release
```

The APK will be generated at: `build/app/outputs/flutter-apk/app-release.apk`

### Building for iOS

```bash
flutter build ios --release
```

## Configuration

### API Base URL

To change the API base URL, edit `lib/config/api_config.dart`:

```dart
static const String baseUrl = 'https://portal.myschoolct.com/api';
```

### App Theme

Customize colors and styles in `lib/config/app_constants.dart` and `lib/config/app_theme.dart`

## Dependencies

Key dependencies used in this project:

- `dio`: ^5.4.3 - HTTP client
- `retrofit`: ^4.1.0 - Type-safe REST client
- `flutter_secure_storage`: ^9.2.2 - Secure token storage
- `shared_preferences`: ^2.2.3 - Local data persistence
- `provider`: ^6.1.2 - State management
- `flutter_bloc`: ^8.1.5 - BLoC pattern
- `cached_network_image`: ^3.3.1 - Image caching
- `jwt_decoder`: ^2.0.1 - JWT token decoding
- `image_picker`: ^1.1.2 - Image selection
- `permission_handler`: ^11.3.1 - Permissions management

See `pubspec.yaml` for complete list.

## Security

- JWT tokens stored securely using FlutterSecureStorage
- Automatic token refresh on expiration
- Encrypted shared preferences on Android
- Secure API communication over HTTPS

## License

Copyright © 2024 MySchool. All rights reserved.

## Support

For issues and questions, please contact the development team.
