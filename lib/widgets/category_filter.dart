import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryFilter extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<String?> onCategorySelected;

  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // Tất cả
          _buildChip(
            context,
            label: 'Tất cả',
            icon: Icons.apps,
            color: Colors.grey,
            isSelected: selectedCategory == null,
            onTap: () => onCategorySelected(null),
          ),
          const SizedBox(width: 8),

          // Categories
          ...FoodCategory.defaultCategories.map((category) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildChip(
                context,
                label: category.name,
                icon: category.icon,
                color: category.color,
                isSelected: selectedCategory == category.id,
                onTap: () => onCategorySelected(category.id),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildChip(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: isSelected ? Colors.white : color,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : color,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: color,
      checkmarkColor: Colors.white,
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(
        color: isSelected ? color : color.withOpacity(0.3),
        width: 1,
      ),
    );
  }
}

// Storage location filter
class StorageLocationFilter extends StatelessWidget {
  final String? selectedLocation;
  final ValueChanged<String?> onLocationSelected;

  const StorageLocationFilter({
    super.key,
    required this.selectedLocation,
    required this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // Tất cả
          _buildChip(
            context,
            label: 'Tất cả',
            icon: Icons.apps,
            isSelected: selectedLocation == null,
            onTap: () => onLocationSelected(null),
          ),
          const SizedBox(width: 8),

          // Locations
          ...StorageLocation.defaultLocations.map((location) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildChip(
                context,
                label: location.name,
                icon: location.icon,
                isSelected: selectedLocation == location.id,
                onTap: () => onLocationSelected(location.id),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildChip(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: theme.colorScheme.primary,
      checkmarkColor: theme.colorScheme.onPrimary,
    );
  }
}
