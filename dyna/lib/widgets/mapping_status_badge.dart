import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Green "Mapped" or red "Not mapped" label.
class MappingStatusBadge extends StatelessWidget {
  final bool isMapped;

  const MappingStatusBadge({super.key, required this.isMapped});

  @override
  Widget build(BuildContext context) {
    final String label = isMapped ? 'Mapped' : 'Not mapped';
    final IconData icon =
        isMapped ? Icons.check_circle_outline : Icons.error_outline;
    final Color color = isMapped ? AppColors.green : AppColors.red;
    final Color background = isMapped ? AppColors.greenLight : AppColors.redLight;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: color, fontSize: 13)),
        ],
      ),
    );
  }
}
