import 'package:flutter/material.dart';
import '../../config/app_constants.dart';

class CategoryScreen extends StatefulWidget {
  final Map<String, dynamic> category;

  const CategoryScreen({
    super.key,
    required this.category,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _loadCategoryContent();
  }

  Future<void> _loadCategoryContent() async {
    setState(() => _isLoading = true);
    
    // TODO: Load from API
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock data for now
    setState(() {
      _items = List.generate(
        10,
        (index) => {
          'id': index,
          'title': '${widget.category['name']} Item ${index + 1}',
          'description': 'Description for item ${index + 1}',
          'imageUrl': null,
        },
      );
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.category['color'] as Color;
    final name = widget.category['name'] as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _items.isEmpty
              ? _buildEmptyState()
              : _buildContentList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox,
            size: 64,
            color: AppConstants.textSecondaryColor,
          ),
          const SizedBox(height: AppConstants.spacingMedium),
          Text(
            'No content available',
            style: AppConstants.bodyLarge.copyWith(
              color: AppConstants.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.spacingMedium),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        return Card(
          margin: const EdgeInsets.only(bottom: AppConstants.spacingMedium),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: (widget.category['color'] as Color).withOpacity(0.2),
              child: Icon(
                Icons.article,
                color: widget.category['color'] as Color,
              ),
            ),
            title: Text(item['title']),
            subtitle: Text(item['description']),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Navigate to item detail
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening: ${item['title']}')),
              );
            },
          ),
        );
      },
    );
  }
}
