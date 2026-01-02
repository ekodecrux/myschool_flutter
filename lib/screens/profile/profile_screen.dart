import 'package:flutter/material.dart';
import '../../config/app_constants.dart';
import '../../services/auth_service.dart';
import '../../models/user_model.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _authService = AuthService();
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await _authService.fetchUserDetails();
      if (mounted) {
        setState(() {
          _user = user;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _authService.logout();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit profile
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadUserData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppConstants.spacingMedium),
                child: Column(
                  children: [
                    // Profile Header
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppConstants.spacingLarge),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: AppConstants.primaryColor,
                              child: Text(
                                _user?.name.substring(0, 1).toUpperCase() ?? 'U',
                                style: const TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: AppConstants.spacingMedium),
                            Text(
                              _user?.name ?? 'User',
                              style: AppConstants.headingMedium,
                            ),
                            const SizedBox(height: AppConstants.spacingSmall),
                            Text(
                              _user?.email ?? '',
                              style: AppConstants.bodyMedium.copyWith(
                                color: AppConstants.textSecondaryColor,
                              ),
                            ),
                            const SizedBox(height: AppConstants.spacingMedium),
                            Chip(
                              label: Text(_user?.role ?? 'INDIVIDUAL'),
                              backgroundColor: AppConstants.primaryColor.withOpacity(0.1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: AppConstants.spacingMedium),
                    
                    // User Details
                    Card(
                      child: Column(
                        children: [
                          if (_user?.mobileNumber != null)
                            ListTile(
                              leading: const Icon(Icons.phone),
                              title: const Text('Mobile'),
                              subtitle: Text(_user!.mobileNumber!),
                            ),
                          if (_user?.schoolCode != null)
                            ListTile(
                              leading: const Icon(Icons.business),
                              title: const Text('School Code'),
                              subtitle: Text(_user!.schoolCode!),
                            ),
                          if (_user?.city != null)
                            ListTile(
                              leading: const Icon(Icons.location_city),
                              title: const Text('City'),
                              subtitle: Text(_user!.city!),
                            ),
                          if (_user?.state != null)
                            ListTile(
                              leading: const Icon(Icons.map),
                              title: const Text('State'),
                              subtitle: Text(_user!.state!),
                            ),
                          ListTile(
                            leading: const Icon(Icons.account_balance_wallet),
                            title: const Text('Credits'),
                            subtitle: Text('${_user?.credits ?? 0} credits'),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: AppConstants.spacingMedium),
                    
                    // Settings
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.lock_outline),
                            title: const Text('Change Password'),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              // TODO: Navigate to change password
                            },
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.notifications_outline),
                            title: const Text('Notifications'),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              // TODO: Navigate to notifications settings
                            },
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.help_outline),
                            title: const Text('Help & Support'),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              // TODO: Navigate to help
                            },
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.info_outline),
                            title: const Text('About'),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              // TODO: Show about dialog
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: AppConstants.spacingMedium),
                    
                    // Logout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _handleLogout,
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.errorColor,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: AppConstants.spacingLarge),
                    
                    // App Version
                    Text(
                      'Version ${AppConstants.appVersion}',
                      style: AppConstants.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
