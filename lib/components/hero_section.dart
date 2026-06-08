import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onShopNowPressed;

  const HeroSection({
    super.key,
    this.onShopNowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=1200&q=80',
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 300,
              width: double.infinity,
              color: AppColors.border,
              child: const Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 48,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Minimal Luxury Fashion',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Discover elegant essentials with timeless style and neutral tones.',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.textMedium,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: onShopNowPressed,
          child: const Text('Shop Now'),
        ),
      ],
    );
  }
}
