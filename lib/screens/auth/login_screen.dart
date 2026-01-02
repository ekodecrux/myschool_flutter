import 'package:flutter/material.dart';
import '../../config/app_constants.dart';
import '../../services/auth_service.dart';
import '../../widgets/loading_button.dart';
import '../home/home_screen.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import 'otp_login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _schoolCodeController = TextEditingController();
  final _authService = AuthService();
  
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _showSchoolCode = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _schoolCodeController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.login(
        username: _emailController.text.trim(),
        password: _passwordController.text,
        schoolCode: _showSchoolCode ? _schoolCodeController.text.trim() : null,
      );

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: AppConstants.errorColor,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacingLarge),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppConstants.spacingXLarge),
                
                // Logo/Icon
                Icon(
                  Icons.school,
                  size: 80,
                  color: AppConstants.primaryColor,
                ),
                
                const SizedBox(height: AppConstants.spacingLarge),
                
                // Title
                Text(
                  'Welcome to MySchool',
                  style: AppConstants.headingLarge,
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: AppConstants.spacingSmall),
                
                Text(
                  'Sign in to continue',
                  style: AppConstants.bodyMedium.copyWith(
                    color: AppConstants.textSecondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: AppConstants.spacingXLarge),
                
                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.validationEmailRequired;
                    }
                    if (!AppConstants.emailRegex.hasMatch(value)) {
                      return AppConstants.validationEmailInvalid;
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: AppConstants.spacingMedium),
                
                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.validationPasswordRequired;
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: AppConstants.spacingMedium),
                
                // School Code Toggle
                CheckboxListTile(
                  value: _showSchoolCode,
                  onChanged: (value) {
                    setState(() => _showSchoolCode = value ?? false);
                  },
                  title: const Text('I have a school code'),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                
                // School Code Field (conditional)
                if (_showSchoolCode) ...[
                  const SizedBox(height: AppConstants.spacingMedium),
                  TextFormField(
                    controller: _schoolCodeController,
                    decoration: const InputDecoration(
                      labelText: 'School Code',
                      hintText: 'Enter school code',
                      prefixIcon: Icon(Icons.business_outlined),
                    ),
                  ),
                ],
                
                const SizedBox(height: AppConstants.spacingSmall),
                
                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                      );
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacingLarge),
                
                // Login Button
                LoadingButton(
                  onPressed: _handleLogin,
                  isLoading: _isLoading,
                  child: const Text('Sign In'),
                ),
                
                const SizedBox(height: AppConstants.spacingMedium),
                
                // OTP Login Button
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const OtpLoginScreen()),
                    );
                  },
                  icon: const Icon(Icons.sms_outlined),
                  label: const Text('Login with OTP'),
                ),
                
                const SizedBox(height: AppConstants.spacingLarge),
                
                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingMedium),
                      child: Text(
                        'OR',
                        style: AppConstants.bodySmall,
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                
                const SizedBox(height: AppConstants.spacingLarge),
                
                // Register Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: AppConstants.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const RegisterScreen()),
                        );
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
