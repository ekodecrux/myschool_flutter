import 'package:flutter/material.dart';
import '../../config/app_constants.dart';

class ImageBankScreen extends StatefulWidget {
  const ImageBankScreen({super.key});

  @override
  State<ImageBankScreen> createState() => _ImageBankScreenState();
}

class _ImageBankScreenState extends State<ImageBankScreen> {
  final List<String> _categories = [
    'ACADEMIC',
    'CLASS',
    'GREAT',
    'IMAGE',
    'MENU',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Bank'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_outline),
            onPressed: () {
              // TODO: Navigate to favorites
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.spacingMedium),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: AppConstants.spacingMedium),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(AppConstants.spacingMedium),
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                ),
                child: const Icon(
                  Icons.folder_outlined,
                  color: AppConstants.primaryColor,
                ),
              ),
              title: Text(_categories[index]),
              subtitle: const Text('Browse images'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: Navigate to category images
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Upload image
        },
        child: const Icon(Icons.upload),
      ),
    );
  }
}
