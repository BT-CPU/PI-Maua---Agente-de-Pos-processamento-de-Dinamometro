import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

import '../models/import_file.dart';
import '../theme/app_colors.dart';
import '../widgets/file_drop_zone.dart';
import '../widgets/selected_files_list.dart';

/// Import page: the user chooses the .xlsx / .csv files to be processed.
class ImportScreen extends StatefulWidget {
  const ImportScreen({super.key});

  @override
  State<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  // Files chosen by the user so far.
  final List<ImportFile> _files = [];

  /// Called when the user drops files or picks them in the file dialog.
  Future<void> _addFiles(List<XFile> pickedFiles) async {
    final List<ImportFile> accepted = [];
    int rejectedCount = 0;

    for (final file in pickedFiles) {
      // 1. Accept only .xlsx and .csv (the drag and drop can bring anything).
      final lowerName = file.name.toLowerCase();
      final isSupported =
          lowerName.endsWith('.xlsx') || lowerName.endsWith('.csv');
      if (!isSupported) {
        rejectedCount++;
        continue;
      }

      // 2. Ignore files with the same name that are already in the list.
      final alreadyAdded = _files.any((f) => f.name == file.name) ||
          accepted.any((f) => f.name == file.name);
      if (alreadyAdded) {
        continue;
      }

      final size = await file.length();
      accepted.add(
        ImportFile(name: file.name, path: file.path, sizeInBytes: size),
      );
    }

    // The screen may have been closed while we were waiting.
    if (!mounted) return;

    setState(() {
      _files.addAll(accepted);
    });

    if (rejectedCount > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Only .xlsx and .csv files are supported.'),
        ),
      );
    }
  }

  void _removeFile(ImportFile file) {
    setState(() {
      _files.remove(file);
    });
  }

  void _processFiles() {
    // TODO: send the files to the processing module (ingest + mapping).
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Processing ${_files.length} file(s)...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Import Tests',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Select the .xlsx or .csv files to process.',
            style: TextStyle(color: AppColors.textGrey, fontSize: 16),
          ),
          const SizedBox(height: 24),
          FileDropZone(onFilesAdded: _addFiles),
          const SizedBox(height: 8),
          const Text(
            'Supported formats: .xlsx, .csv',
            style: TextStyle(color: AppColors.textGrey, fontSize: 13),
          ),
          // Show the list only when there is at least one file.
          if (_files.isNotEmpty) ...[
            const SizedBox(height: 24),
            SelectedFilesList(files: _files, onRemove: _removeFile),
          ],
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              // null disables the button (nothing to process yet).
              onPressed: _files.isEmpty ? null : _processFiles,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Process',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
