import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Small helper class to describe each menu entry.
class _MenuEntry {
  final IconData icon;
  final String label;

  const _MenuEntry(this.icon, this.label);
}

/// Left navigation bar.
/// The parent (HomeScreen) keeps track of which item is selected.
class SideMenu extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const SideMenu({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  static const List<_MenuEntry> _entries = [
    _MenuEntry(Icons.home_rounded, 'Home'),
    _MenuEntry(Icons.download_rounded, 'Import'),
    _MenuEntry(Icons.fact_check_outlined, 'Tests'),
    _MenuEntry(Icons.table_chart_outlined, 'Mapping'),
    _MenuEntry(Icons.show_chart_rounded, 'Charts'),
    _MenuEntry(Icons.shield_outlined, 'Data Health'),
    _MenuEntry(Icons.compare_arrows_rounded, 'Comparisons'),
    _MenuEntry(Icons.settings_outlined, 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: AppColors.sidebar,
      child: Column(
        children: [
          const SizedBox(height: 24),
          const _Logo(),
          const SizedBox(height: 24),
          for (int i = 0; i < _entries.length; i++)
            _MenuItem(
              entry: _entries[i],
              isSelected: i == selectedIndex,
              onTap: () => onItemSelected(i),
            ),
        ],
      ),
    );
  }
}

/// Placeholder logo. Replace it with the real GM logo image later
/// (put the file in assets/ and use Image.asset).
class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'gm',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final _MenuEntry entry;
  final bool isSelected;
  final VoidCallback onTap;

  const _MenuItem({
    required this.entry,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        color: isSelected ? AppColors.primary : Colors.transparent,
        child: Row(
          children: [
            Icon(entry.icon, color: Colors.white, size: 22),
            const SizedBox(width: 14),
            Text(
              entry.label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
