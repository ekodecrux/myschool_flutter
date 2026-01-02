import 'package:flutter/material.dart';
import '../../config/app_constants.dart';
import '../auth/login_screen.dart';
import '../category/category_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      // TODO: Navigate to search results
      print('Searching for: $query');
    }
  }

  void _handleVoiceSearch() {
    // TODO: Implement voice search
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Voice search coming soon')),
    );
  }

  void _handleSignIn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _handleCategoryTap(Map<String, dynamic> category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryScreen(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Navigation Bar
              _buildTopBar(),
              
              const SizedBox(height: AppConstants.spacingXLarge),
              
              // Logo
              _buildLogo(),
              
              const SizedBox(height: AppConstants.spacingXLarge),
              
              // Search Bar
              _buildSearchBar(),
              
              const SizedBox(height: AppConstants.spacingXLarge * 2),
              
              // Categories Grid
              _buildCategories(),
              
              const SizedBox(height: AppConstants.spacingXLarge),
              
              // Sections
              _buildSections(),
              
              const SizedBox(height: AppConstants.spacingXLarge),
              
              // Footer
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () {
              // TODO: Implement download app
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Download app coming soon')),
              );
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingLarge,
                vertical: AppConstants.spacingSmall,
              ),
            ),
            child: const Text('Download App'),
          ),
          const SizedBox(width: AppConstants.spacingMedium),
          ElevatedButton(
            onPressed: _handleSignIn,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingLarge,
                vertical: AppConstants.spacingSmall,
              ),
            ),
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        // Logo image
        Image.asset(
          'assets/logo/myschool_logo.png',
          height: 80,
          errorBuilder: (context, error, stackTrace) {
            // Fallback to text logo if image not found
            return RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'my',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryMagenta,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  TextSpan(
                    text: 'school',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryBlue,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  TextSpan(
                    text: '™',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: AppConstants.textSecondaryColor,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: AppConstants.spacingSmall),
        Text(
          AppConstants.appTagline,
          style: AppConstants.bodyMedium.copyWith(
            color: AppConstants.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingLarge),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          border: Border.all(color: AppConstants.accentOrange, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(AppConstants.spacingMedium),
              child: Icon(
                Icons.search,
                color: AppConstants.accentOrange,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search your wish here...',
                  border: InputBorder.none,
                  filled: false,
                ),
                onSubmitted: (_) => _handleSearch(),
              ),
            ),
            IconButton(
              onPressed: _handleVoiceSearch,
              icon: const Icon(
                Icons.mic,
                color: AppConstants.accentOrange,
              ),
              tooltip: 'Click to speak',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingLarge),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: AppConstants.spacingLarge,
          crossAxisSpacing: AppConstants.spacingLarge,
          childAspectRatio: 1.0,
        ),
        itemCount: AppConstants.categories.length,
        itemBuilder: (context, index) {
          final category = AppConstants.categories[index];
          return _buildCategoryCard(category);
        },
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    final color = category['color'] as Color;
    final name = category['name'] as String;
    final iconName = category['icon'] as String;
    
    IconData icon;
    switch (iconName) {
      case 'star':
        icon = Icons.star;
        break;
      case 'work':
        icon = Icons.work;
        break;
      case 'games':
        icon = Icons.games;
        break;
      case 'print':
        icon = Icons.print;
        break;
      case 'build':
        icon = Icons.build;
        break;
      case 'share':
        icon = Icons.share;
        break;
      default:
        icon = Icons.category;
    }

    return InkWell(
      onTap: () => _handleCategoryTap(category),
      borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
          border: Border.all(color: AppConstants.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingMedium),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: color,
              ),
            ),
            const SizedBox(height: AppConstants.spacingSmall),
            Text(
              name,
              style: AppConstants.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSections() {
    return Column(
      children: [
        _buildSectionTitle('ONE CLICK RESOURCE CENTRE'),
        const SizedBox(height: AppConstants.spacingSmall),
        _buildSectionTitle('CLASS WISE ACADEMIC RESOURCE'),
        const SizedBox(height: AppConstants.spacingSmall),
        _buildSectionTitle('GOVT. INITIATIVES FOR EDUCATORS'),
        const SizedBox(height: AppConstants.spacingSmall),
        _buildSectionTitle('SCHOOL\'S SERVICE CENTRE'),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppConstants.bodySmall.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingLarge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {},
            child: const Text('Privacy'),
          ),
          const Text('•'),
          TextButton(
            onPressed: () {},
            child: const Text('Terms'),
          ),
          const Text('•'),
          TextButton(
            onPressed: () {},
            child: const Text('Cookies'),
          ),
          const Text('•'),
          TextButton(
            onPressed: () {},
            child: const Text('Help'),
          ),
        ],
      ),
    );
  }
}
