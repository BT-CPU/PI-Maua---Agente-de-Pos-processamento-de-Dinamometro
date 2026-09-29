/// Possible states of a dyno test.
enum TestStatus { processed, hasIssues }

/// Represents one dynamometer test shown in the "Latest tests" table.
class TestItem {
  final String name;
  final DateTime date;
  final TestStatus status;

  const TestItem({
    required this.name,
    required this.date,
    required this.status,
  });

  /// Returns the date in the international format: "yyyy-MM-dd HH:mm".
  String get formattedDate {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${date.year}-${two(date.month)}-${two(date.day)} '
        '${two(date.hour)}:${two(date.minute)}';
  }
}
