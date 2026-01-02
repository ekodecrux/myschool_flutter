import 'package:flutter/material.dart';
import '../../config/app_constants.dart';

class TemplatesScreen extends StatelessWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final templateTypes = [
      {'name': 'Certificate', 'icon': Icons.card_membership},
      {'name': 'ID Card', 'icon': Icons.badge},
      {'name': 'Poster', 'icon': Icons.image},
      {'name': 'Banner', 'icon': Icons.panorama},
      {'name': 'Invitation', 'icon': Icons.mail},
      {'name': 'Newsletter', 'icon': Icons.newspaper},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Templates'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // TODO: Navigate to my templates
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(AppConstants.spacingMedium),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppConstants.spacingMedium,
          mainAxisSpacing: AppConstants.spacingMedium,
          childAspectRatio: 1,
        ),
        itemCount: templateTypes.length,
        itemBuilder: (context, index) {
          final template = templateTypes[index];
          return Card(
            child: InkWell(
              onTap: () {
                // TODO: Navigate to template editor
              },
              borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    template['icon'] as IconData,
                    size: 48,
                    color: AppConstants.primaryColor,
                  ),
                  const SizedBox(height: AppConstants.spacingMedium),
                  Text(
                    template['name'] as String,
                    style: AppConstants.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
