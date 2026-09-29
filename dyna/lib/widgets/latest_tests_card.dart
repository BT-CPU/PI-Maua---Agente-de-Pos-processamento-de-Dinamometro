import 'package:flutter/material.dart';

import '../models/test_item.dart';
import '../theme/app_colors.dart';
import 'status_badge.dart';

/// White card with the table of the most recent tests.
class LatestTestsCard extends StatelessWidget {
  final List<TestItem> tests;
  final VoidCallback onViewAll;

  // On very narrow screens the table keeps this width and scrolls sideways.
  static const double _minTableWidth = 520;

  const LatestTestsCard({
    super.key,
    required this.tests,
    required this.onViewAll,
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
          // Card title + "View all" button
          Row(
            children: [
              const Text(
                'Latest tests',
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(onPressed: onViewAll, child: const Text('View all')),
            ],
          ),
          const SizedBox(height: 12),
          _buildTable(),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use all the available width, but never less than the minimum.
        final double tableWidth = constraints.maxWidth < _minTableWidth
            ? _minTableWidth
            : constraints.maxWidth;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: tableWidth,
            child: Column(
              children: [
                const _HeaderRow(),
                // One row for each test in the list
                for (final test in tests) _TestRow(test: test),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow();

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.bold,
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      color: AppColors.background,
      child: const Row(
        children: [
          Expanded(flex: 3, child: Text('Name', style: style)),
          Expanded(flex: 3, child: Text('Date', style: style)),
          Expanded(flex: 2, child: Text('Status', style: style)),
        ],
      ),
    );
  }
}

class _TestRow extends StatelessWidget {
  final TestItem test;

  const _TestRow({required this.test});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              test.name,
              style: const TextStyle(color: AppColors.textDark),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              test.formattedDate,
              style: const TextStyle(color: AppColors.textDark),
            ),
          ),
          Expanded(
            flex: 2,
            // Align keeps the badge from stretching to the full width.
            child: Align(
              alignment: Alignment.centerLeft,
              child: StatusBadge(status: test.status),
            ),
          ),
        ],
      ),
    );
  }
}