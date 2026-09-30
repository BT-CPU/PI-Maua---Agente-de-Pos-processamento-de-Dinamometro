import 'package:flutter/material.dart';

import '../models/import_file.dart';
import '../theme/app_colors.dart';

/// Card that lists the files chosen by the user, each one with a
/// button to remove it.
class SelectedFilesList extends StatelessWidget {
  final List<ImportFile> files;
  final ValueChanged<ImportFile> onRemove;

  const SelectedFilesList({
    super.key,
    required this.files,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected files (${files.length})',
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          for (final file in files) _buildFileRow(file),
        ],
      ),
    );
  }

  Widget _buildFileRow(ImportFile file) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.insert_drive_file_outlined,
            color: AppColors.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              file.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.textDark),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            file.formattedSize,
            style: const TextStyle(color: AppColors.textGrey),
          ),
          IconButton(
            onPressed: () => onRemove(file),
            tooltip: 'Remove file',
            icon: const Icon(Icons.close, color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }
}
