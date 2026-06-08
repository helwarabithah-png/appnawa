import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class TopBar extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  const TopBar({
    super.key,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'THE HN',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        GestureDetector(
          onTap: onMenuPressed,
          child: const Icon(
            Icons.menu,
            color: AppColors.icon,
          ),
        ),
      ],
    );
  }
}
