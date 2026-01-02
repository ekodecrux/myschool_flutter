import 'package:flutter/material.dart';
import '../../config/app_constants.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../widgets/loading_button.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  
  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();
  final _schoolCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;
  String _selectedRole = AppConstants.roleIndividual;

  final List<Map<String, String>> _roles = [
    {'value': AppConstants.roleIndividual, 'label': 'Individual'},
    {'value': AppConstants.roleTeacher, 'label': 'Teacher'},
    {'value': AppConstants.roleStudent, 'label': 'Student'},
    {'value': AppConstants.roleParent, 'label': 'Parent'},
    {'value': AppConstants.roleSchoolAdmin, 'label': 'School Admin'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _mobileController.dispose();
    _schoolCodeController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final request = RegisterRequest(
        email: _emailController.text.trim(),
        name: _nameController.text.trim(),
        password: _passwordController.text,
        mobileNumber: _mobileController.text.trim(),
        userRole: _selectedRole,
        schoolCode: _schoolCodeController.text.trim().isNotEmpty 
            ? _schoolCodeController.text.trim() 
            : null,
        city: _cityController.text.trim().isNotEmpty 
            ? _cityController.text.trim() 
            : null,
        state: _stateController.text.trim().isNotEmpty 
            ? _stateController.text.trim() 
            : null,
      );

      await _authService.register(request);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppConstants.successRegister),
            backgroundColor: AppConstants.successColor,
          ),
        );
        
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
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
        title: const Text('Create Account'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacingLarge),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Full Name
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Enter your full name',
                    prefixIcon: Icon(Icons.person_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.validationNameRequired;
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: AppConstants.spacingMedium),
                
                // Email
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
                
                // Password
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
                    if (value.length < AppConstants.minPasswordLength) {
                      return AppConstants.validationPasswordLength;
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: AppConstants.spacingMedium),
                
                // Mobile Number
                TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    hintText: 'Enter your mobile number',
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
                
                const SizedBox(height: AppConstants.spacingMedium),
                
                // Role Selection
                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  decoration: const InputDecoration(
                    labelText: 'Role',
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                  items: _roles.map((role) {
                    return DropdownMenuItem(
                      value: role['value'],
                      child: Text(role['label']!),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedRole = value!);
                  },
                ),
                
                const SizedBox(height: AppConstants.spacingMedium),
                
                // School Code (optional)
                TextFormField(
                  controller: _schoolCodeController,
                  decoration: const InputDecoration(
                    labelText: 'School Code (Optional)',
                    hintText: 'Enter school code if applicable',
                    prefixIcon: Icon(Icons.business_outlined),
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacingMedium),
                
                // City
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'City (Optional)',
                    hintText: 'Enter your city',
                    prefixIcon: Icon(Icons.location_city_outlined),
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacingMedium),
                
                // State
                TextFormField(
                  controller: _stateController,
                  decoration: const InputDecoration(
                    labelText: 'State (Optional)',
                    hintText: 'Enter your state',
                    prefixIcon: Icon(Icons.map_outlined),
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacingXLarge),
                
                // Register Button
                LoadingButton(
                  onPressed: _handleRegister,
                  isLoading: _isLoading,
                  child: const Text('Create Account'),
                ),
                
                const SizedBox(height: AppConstants.spacingMedium),
                
                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppConstants.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Sign In'),
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
