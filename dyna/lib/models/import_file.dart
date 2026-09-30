/// A file that the user chose to import (from the picker or by drag and drop).
class ImportFile {
  final String name;
  final String path;
  final int sizeInBytes;

  const ImportFile({
    required this.name,
    required this.path,
    required this.sizeInBytes,
  });

  /// Human readable size, like "850 B", "12.3 KB" or "4.5 MB".
  String get formattedSize {
    if (sizeInBytes < 1024) {
      return '$sizeInBytes B';
    }
    if (sizeInBytes < 1024 * 1024) {
      return '${(sizeInBytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(sizeInBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
