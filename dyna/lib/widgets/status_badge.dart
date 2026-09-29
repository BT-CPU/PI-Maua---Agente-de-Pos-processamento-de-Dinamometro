import 'package:flutter/material.dart';

import '../../models/test_item.dart';
import '../../theme/app_colors.dart';

/// Small colored label that shows the status of a test.
class StatusBadge extends StatelessWidget {
  final TestStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Choose text, icon and colors depending on the status.
    final bool isOk = status == TestStatus.processed;
    final String label = isOk ? 'Processed' : 'With issues';
    final IconData icon =
        isOk ? Icons.check_circle_outline : Icons.warning_amber_rounded;
    final Color color = isOk ? AppColors.green : AppColors.red;
    final Color background = isOk ? AppColors.greenLight : AppColors.redLight;

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
