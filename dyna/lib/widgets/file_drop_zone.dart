import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'dashed_border.dart';

/// Big dashed area where the user can drag files or click "Select files".
/// It does not store the files: it just tells the parent which files
/// were chosen using [onFilesAdded].
class FileDropZone extends StatefulWidget {
  final ValueChanged<List<XFile>> onFilesAdded;

  const FileDropZone({super.key, required this.onFilesAdded});

  @override
  State<FileDropZone> createState() => _FileDropZoneState();
}

class _FileDropZoneState extends State<FileDropZone> {
  // True while the user is dragging files over the area.
  bool _isDragging = false;

  Future<void> _selectFiles() async {
    // Only show .xlsx and .csv files in the file dialog.
    final typeGroup = XTypeGroup(
      label: 'Spreadsheets',
      extensions: ['xlsx', 'csv'],
    );

    final files = await openFiles(acceptedTypeGroups: [typeGroup]);

    if (files.isNotEmpty) {
      widget.onFilesAdded(files);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragEntered: (_) => setState(() => _isDragging = true),
      onDragExited: (_) => setState(() => _isDragging = false),
      onDragDone: (details) {
        setState(() => _isDragging = false);
        widget.onFilesAdded(details.files);
      },
      child: DashedBorder(
        color: _isDragging ? AppColors.primary : AppColors.textGrey,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
          decoration: BoxDecoration(
            // The area changes color when files are over it.
            color: _isDragging ? AppColors.blueLight : AppColors.card,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.cloud_upload_outlined,
                size: 64,
                color: AppColors.textDark,
              ),
              const SizedBox(height: 16),
              const Text(
                'Drag files here',
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'or',
                style: TextStyle(color: AppColors.textDark, fontSize: 16),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _selectFiles,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.sidebar,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Select files',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
