import 'package:flutter/material.dart';
import '../../config/app_constants.dart';
import '../../services/auth_service.dart';
import '../../models/user_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: AppConstants.errorColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Navigate to notifications
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Card
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppConstants.spacingLarge),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back,',
                              style: AppConstants.bodyMedium.copyWith(
                                color: AppConstants.textSecondaryColor,
                              ),
                            ),
                            const SizedBox(height: AppConstants.spacingSmall),
                            Text(
                              _user?.name ?? 'User',
                              style: AppConstants.headingMedium,
                            ),
                            const SizedBox(height: AppConstants.spacingSmall),
                            Chip(
                              label: Text(_user?.role ?? 'INDIVIDUAL'),
                              backgroundColor: AppConstants.primaryColor.withOpacity(0.1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: AppConstants.spacingLarge),
                    
                    // Credits Card
                    Card(
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(AppConstants.spacingMedium),
                          decoration: BoxDecoration(
                            color: AppConstants.successColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet_outlined,
                            color: AppConstants.successColor,
                          ),
                        ),
                        title: const Text('Available Credits'),
                        subtitle: Text(
                          '${_user?.credits ?? 0} credits',
                          style: AppConstants.headingSmall,
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            // TODO: Navigate to buy credits
                          },
                          child: const Text('Buy More'),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: AppConstants.spacingLarge),
                    
                    // Quick Actions
                    Text(
                      'Quick Actions',
                      style: AppConstants.headingSmall,
                    ),
                    
                    const SizedBox(height: AppConstants.spacingMedium),
                    
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: AppConstants.spacingMedium,
                      crossAxisSpacing: AppConstants.spacingMedium,
                      children: [
                        _buildQuickActionCard(
                          icon: Icons.image_outlined,
                          title: 'Image Bank',
                          color: AppConstants.primaryColor,
                          onTap: () {
                            // Navigate to image bank (handled by bottom nav)
                          },
                        ),
                        _buildQuickActionCard(
                          icon: Icons.design_services_outlined,
                          title: 'Templates',
                          color: AppConstants.secondaryColor,
                          onTap: () {
                            // Navigate to templates (handled by bottom nav)
                          },
                        ),
                        _buildQuickActionCard(
                          icon: Icons.search,
                          title: 'Search',
                          color: AppConstants.accentColor,
                          onTap: () {
                            // TODO: Navigate to search
                          },
                        ),
                        _buildQuickActionCard(
                          icon: Icons.upload_outlined,
                          title: 'Upload',
                          color: AppConstants.infoColor,
                          onTap: () {
                            // TODO: Navigate to upload
                          },
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: AppConstants.spacingLarge),
                    
                    // Recent Activity
                    Text(
                      'Recent Activity',
                      style: AppConstants.headingSmall,
                    ),
                    
                    const SizedBox(height: AppConstants.spacingMedium),
                    
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppConstants.spacingLarge),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.history,
                                size: 48,
                                color: AppConstants.textSecondaryColor,
                              ),
                              const SizedBox(height: AppConstants.spacingSmall),
                              Text(
                                'No recent activity',
                                style: AppConstants.bodyMedium.copyWith(
                                  color: AppConstants.textSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingMedium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.spacingMedium),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: AppConstants.spacingMedium),
              Text(
                title,
                style: AppConstants.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
