import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../widgets/latest_tests_card.dart';
import '../widgets/side_menu.dart';
import '../widgets/summary_card.dart';
import '../widgets/top_bar.dart';

/// Home (dashboard) screen: summary of the tests.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Index of the selected menu item (0 = Home).
  int _selectedMenuIndex = 0;

  // Lets us open/close the drawer (used on small screens).
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Screen width (in pixels) from which the side menu is always visible.
  static const double _wideScreenWidth = 900;

  // Content width from which the 3 summary cards stay side by side.
  static const double _cardsRowWidth = 700;

  void _onMenuItemSelected(int index) {
    setState(() {
      _selectedMenuIndex = index;
    });

    // If the menu is inside the drawer, close it after the tap.
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }
    // TODO: navigate to the other screens when they exist.
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWideScreen = constraints.maxWidth >= _wideScreenWidth;

        final sideMenu = SideMenu(
          selectedIndex: _selectedMenuIndex,
          onItemSelected: _onMenuItemSelected,
        );

        // Wide screen: menu always visible on the left.
        if (isWideScreen) {
          return Scaffold(
            body: Row(
              children: [
                sideMenu,
                Expanded(child: _buildMainArea(showMenuButton: false)),
              ],
            ),
          );
        }

        // Small screen: menu goes inside a drawer opened by the top bar button.
        return Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            width: 220,
            backgroundColor: AppColors.sidebar,
            shape: const RoundedRectangleBorder(),
            child: SafeArea(child: sideMenu),
          ),
          body: _buildMainArea(showMenuButton: true),
        );
      },
    );
  }

  Widget _buildMainArea({required bool showMenuButton}) {
    return Column(
      children: [
        TopBar(
          onMenuPressed: showMenuButton
              ? () => _scaffoldKey.currentState?.openDrawer()
              : null,
        ),
        Expanded(child: _buildContent()),
      ],
    );
  }

  Widget _buildContent() {
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