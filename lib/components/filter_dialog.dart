import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../controllers/product_controller.dart';

class FilterDialog extends StatefulWidget {
  final ProductController controller;

  const FilterDialog({
    super.key,
    required this.controller,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late double _minPrice;
  late double _maxPrice;
  late String _sortBy;

  @override
  void initState() {
    super.initState();
    _minPrice = widget.controller.minPrice.value;
    _maxPrice = widget.controller.maxPrice.value;
    _sortBy = widget.controller.sortBy.value;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close, color: AppColors.textDark),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Price Range Filter
              const Text(
                'Price Range',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${_minPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    '\$${_maxPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              RangeSlider(
                values: RangeValues(_minPrice, _maxPrice),
                min: 0,
                max: 200,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.border,
                onChanged: (RangeValues values) {
                  setState(() {
                    _minPrice = values.start;
                    _maxPrice = values.end;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Sort Options
              const Text(
                'Sort By',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              _buildSortOption('price_asc', 'Price: Low to High'),
              _buildSortOption('price_desc', 'Price: High to Low'),
              _buildSortOption('name_asc', 'Name: A to Z'),
              _buildSortOption('name_desc', 'Name: Z to A'),
              const SizedBox(height: 20),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        widget.controller.resetFilters();
                        Get.back();
                      },
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        widget.controller.updatePriceFilter(_minPrice, _maxPrice);
                        if (_sortBy.isNotEmpty) {
                          widget.controller.updateSort(_sortBy);
                        }
                        Get.back();
                      },
                      child: const Text(
                        'Apply',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSortOption(String value, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _sortBy = _sortBy == value ? '' : value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(
                  color: _sortBy == value ? AppColors.primary : AppColors.border,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: _sortBy == value
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: AppColors.primary,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textDark,
                fontWeight: _sortBy == value ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
