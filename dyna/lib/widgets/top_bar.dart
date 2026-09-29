import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Top bar with the app name.
/// On small screens the side menu becomes a drawer, so we show a menu
/// button on the left. To show it, pass [onMenuPressed].
class TopBar extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  const TopBar({super.key, this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.card,
      child: Row(
        children: [
          // Only show the menu button when a callback was given.
          if (onMenuPressed != null)
            IconButton(
              onPressed: onMenuPressed,
              icon: const Icon(Icons.menu, color: AppColors.textDark),
            ),
          const SizedBox(width: 8),
          const Text(
            'Dynamometer Analytics',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}