import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ProductSearchBar extends StatefulWidget {
  final Function(String) onSearchChanged;
  final VoidCallback? onFilterPressed;
  final TextEditingController? controller;

  const ProductSearchBar({
    super.key,
    required this.onSearchChanged,
    this.onFilterPressed,
    this.controller,
  });

  @override
  State<ProductSearchBar> createState() => _ProductSearchBarState();
}

class _ProductSearchBarState extends State<ProductSearchBar> {
  late TextEditingController _controller;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_onSearchChanged);
    }
    super.dispose();
  }

  void _onSearchChanged() {
    widget.onSearchChanged(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isActive ? AppColors.primary : AppColors.border,
              ),
            ),
            child: TextField(
              controller: _controller,
              onChanged: (_) {},
              onTap: () {
                setState(() => _isActive = true);
              },
              onEditingComplete: () {
                setState(() => _isActive = false);
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
                hintStyle: const TextStyle(
                  color: AppColors.textLight,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textLight,
                ),
                suffixIcon: _controller.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _controller.clear();
                          widget.onSearchChanged('');
                        },
                        child: const Icon(
                          Icons.close,
                          color: AppColors.textLight,
                        ),
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: widget.onFilterPressed,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.tune,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
