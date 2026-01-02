import 'package:flutter/material.dart';
import '../../config/app_constants.dart';
import '../../services/auth_service.dart';
import '../../widgets/loading_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  
  bool _isLoading = false;
  bool _codeSent = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _sendResetCode() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.forgotPassword(_emailController.text.trim());
      
      if (mounted) {
        setState(() => _codeSent = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reset code sent to your email'),
            backgroundColor: AppConstants.successColor,
          ),
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

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.confirmPasswordReset(
        email: _emailController.text.trim(),
        code: _codeController.text.trim(),
        newPassword: _newPasswordController.text,
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppConstants.successPasswordReset),
            backgroundColor: AppConstants.successColor,
          ),
        );
        Navigator.of(context).pop();
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
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacingLarge),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppConstants.spacingLarge),
                
                Icon(
                  Icons.lock_reset,
                  size: 80,
                  color: AppConstants.primaryColor,
                ),
                
                const SizedBox(height: AppConstants.spacingLarge),
                
                Text(
                  _codeSent ? 'Enter Reset Code' : 'Forgot Password?',
                  style: AppConstants.headingMedium,
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: AppConstants.spacingSmall),
                
                Text(
                  _codeSent 
                      ? 'Enter the code sent to your email and your new password'
                      : 'Enter your email address and we\'ll send you a code to reset your password',
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
                  enabled: !_codeSent,
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
                
                if (_codeSent) ...[
                  const SizedBox(height: AppConstants.spacingMedium),
                  
                  // Reset Code Field
                  TextFormField(
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Reset Code',
                      hintText: 'Enter 6-digit code',
                      prefixIcon: Icon(Icons.pin_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Reset code is required';
                      }
                      if (value.length != 6) {
                        return 'Code must be 6 digits';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: AppConstants.spacingMedium),
                  
                  // New Password Field
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      hintText: 'Enter new password',
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
                      if (value.length < AppConstants.minPasswordLength) {
                        return AppConstants.validationPasswordLength;
                      }
                      return null;
                    },
                  ),
                ],
                
                const SizedBox(height: AppConstants.spacingXLarge),
                
                // Action Button
                LoadingButton(
                  onPressed: _codeSent ? _resetPassword : _sendResetCode,
                  isLoading: _isLoading,
                  child: Text(_codeSent ? 'Reset Password' : 'Send Reset Code'),
                ),
                
                if (_codeSent) ...[
                  const SizedBox(height: AppConstants.spacingMedium),
                  TextButton(
                    onPressed: () {
                      setState(() => _codeSent = false);
                    },
                    child: const Text('Didn\'t receive code? Try again'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
