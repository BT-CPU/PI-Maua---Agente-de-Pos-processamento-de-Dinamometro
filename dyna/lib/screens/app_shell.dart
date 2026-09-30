import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/side_menu.dart';
import '../widgets/top_bar.dart';
import 'home_screen.dart';
import 'import_screen.dart';
import 'mapping_screen.dart';

/// The "frame" of the app: side menu + top bar + the current screen.
/// Every screen of the app is shown inside this shell, so the menu and the
/// top bar are written only once.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  // Index of the selected menu item (0 = Home, 1 = Import, ...).
  int _selectedMenuIndex = 0;

  // Lets us open/close the drawer (used on small screens).
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Screen width (in pixels) from which the side menu is always visible.
  static const double _wideScreenWidth = 900;

  // The order of this list must be the same as the order of the menu items
  // in side_menu.dart.
  final List<Widget> _pages = const [
    HomeScreen(),
    ImportScreen(),
    _ComingSoon(title: 'Tests'),
    MappingScreen(),
    _ComingSoon(title: 'Charts'),
    _ComingSoon(title: 'Data Health'),
    _ComingSoon(title: 'Comparisons'),
    _ComingSoon(title: 'Settings'),
  ];

  void _onMenuItemSelected(int index) {
    setState(() {
      _selectedMenuIndex = index;
    });

    // If the menu is inside the drawer, close it after the tap.
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }
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
        Expanded(
          // IndexedStack keeps all pages alive, so the state of a page
          // (for example, the files selected on the Import screen) is not
          // lost when the user goes to another page and comes back.
          child: IndexedStack(
            index: _selectedMenuIndex,
            children: _pages,
          ),
        ),
      ],
    );
  }
}

/// Temporary screen for the pages we have not built yet.
class _ComingSoon extends StatelessWidget {
  final String title;

  const _ComingSoon({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$title - coming soon',
        style: const TextStyle(color: AppColors.textGrey, fontSize: 18),
      ),
    );
  }
}
