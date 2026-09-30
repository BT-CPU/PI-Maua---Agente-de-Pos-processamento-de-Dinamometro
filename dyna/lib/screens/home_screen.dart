import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../widgets/latest_tests_card.dart';
import '../widgets/summary_card.dart';

/// Home (dashboard) page: summary of the tests.
/// It only has the page content. The menu and the top bar are in AppShell.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Content width from which the 3 summary cards stay side by side.
  static const double _cardsRowWidth = 700;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome!',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Here is a summary of your tests.',
            style: TextStyle(color: AppColors.textGrey, fontSize: 16),
          ),
          const SizedBox(height: 24),
          _buildSummaryCards(),
          const SizedBox(height: 24),
          LatestTestsCard(
            tests: mockLatestTests,
            onViewAll: () {
              // TODO: open the Tests screen.
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    const cards = [
      SummaryCard(
        icon: Icons.insert_chart_outlined_rounded,
        iconColor: AppColors.primary,
        iconBackground: AppColors.blueLight,
        title: 'Total tests',
        value: mockTotalTests,
      ),
      SummaryCard(
        icon: Icons.check_circle_rounded,
        iconColor: AppColors.green,
        iconBackground: AppColors.greenLight,
        title: 'Processed tests',
        value: mockProcessedTests,
      ),
      SummaryCard(
        icon: Icons.warning_amber_rounded,
        iconColor: AppColors.red,
        iconBackground: AppColors.redLight,
        title: 'With issues',
        value: mockTestsWithIssues,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // Enough space: 3 cards side by side.
        if (constraints.maxWidth >= _cardsRowWidth) {
          return Row(
            children: [
              Expanded(child: cards[0]),
              const SizedBox(width: 16),
              Expanded(child: cards[1]),
              const SizedBox(width: 16),
              Expanded(child: cards[2]),
            ],
          );
        }

        // Small screen: cards stacked vertically.
        return Column(
          children: [
            for (int i = 0; i < cards.length; i++) ...[
              if (i > 0) const SizedBox(height: 16),
              SizedBox(width: double.infinity, child: cards[i]),
            ],
          ],
        );
      },
    );
  }
}
