import '../../models/test_item.dart';

// Fake data just to build the UI.
// Later this will come from the backend / local database.

const int mockTotalTests = 12;
const int mockProcessedTests = 10;
const int mockTestsWithIssues = 2;

final List<TestItem> mockLatestTests = [
  TestItem(
    name: 'Test_001',
    date: DateTime(2026, 9, 17, 10, 30),
    status: TestStatus.processed,
  ),
  TestItem(
    name: 'Test_002',
    date: DateTime(2026, 9, 16, 14, 22),
    status: TestStatus.processed,
  ),
  TestItem(
    name: 'Test_003',
    date: DateTime(2026, 9, 15, 9, 18),
    status: TestStatus.hasIssues,
  ),
  TestItem(
    name: 'Test_004',
    date: DateTime(2026, 9, 14, 16, 45),
    status: TestStatus.processed,
  ),
  TestItem(
    name: 'Test_005',
    date: DateTime(2026, 9, 13, 11, 7),
    status: TestStatus.processed,
  ),
];
