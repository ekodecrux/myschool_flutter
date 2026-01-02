import 'package:flutter/material.dart';
import '../../config/app_constants.dart';
import '../../services/auth_service.dart';
import '../../widgets/loading_button.dart';
import '../home/home_screen.dart';

class OtpLoginScreen extends StatefulWidget {
  const OtpLoginScreen({super.key});

  @override
  State<OtpLoginScreen> createState() => _OtpLoginScreenState();
}

class _OtpLoginScreenState extends State<OtpLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  
  final _mobileController = TextEditingController();
  final _otpController = TextEditingController();
  
  bool _isLoading = false;
  bool _otpSent = false;

  @override
  void dispose() {
    _mobileController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.sendOtp(_mobileController.text.trim());
      
      if (mounted) {
        setState(() => _otpSent = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP sent successfully'),
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

  Future<void> _verifyOtp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.loginWithOtp(
        mobileNumber: _mobileController.text.trim(),
        otp: _otpController.text.trim(),
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
      appBar: AppBar(
        title: const Text('Login with OTP'),
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
                  Icons.sms_outlined,
                  size: 80,
                  color: AppConstants.primaryColor,
                ),
                
                const SizedBox(height: AppConstants.spacingLarge),
                
                Text(
                  _otpSent ? 'Enter OTP' : 'Login with OTP',
                  style: AppConstants.headingMedium,
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: AppConstants.spacingSmall),
                
                Text(
                  _otpSent 
                      ? 'Enter the OTP sent to your mobile number'
                      : 'Enter your mobile number to receive OTP',
                  style: AppConstants.bodyMedium.copyWith(
                    color: AppConstants.textSecondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: AppConstants.spacingXLarge),
                
                // Mobile Number Field
                TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  enabled: !_otpSent,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    hintText: 'Enter 10-digit mobile number',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.validationPhoneRequired;
                    }
                    if (!AppConstants.phoneRegex.hasMatch(value)) {
                      return AppConstants.validationPhoneInvalid;
                    }
                    return null;
                  },
                ),
                
                if (_otpSent) ...[
                  const SizedBox(height: AppConstants.spacingMedium),
                  
                  // OTP Field
                  TextFormField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'OTP',
                      hintText: 'Enter 6-digit OTP',
                      prefixIcon: Icon(Icons.pin_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppConstants.validationOtpRequired;
                      }
                      if (value.length != 6) {
                        return AppConstants.validationOtpInvalid;
                      }
                      return null;
                    },
                  ),
                ],
                
                const SizedBox(height: AppConstants.spacingXLarge),
                
                // Action Button
                LoadingButton(
                  onPressed: _otpSent ? _verifyOtp : _sendOtp,
                  isLoading: _isLoading,
                  child: Text(_otpSent ? 'Verify & Login' : 'Send OTP'),
                ),
                
                if (_otpSent) ...[
                  const SizedBox(height: AppConstants.spacingMedium),
                  TextButton(
                    onPressed: _isLoading ? null : _sendOtp,
                    child: const Text('Resend OTP'),
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
