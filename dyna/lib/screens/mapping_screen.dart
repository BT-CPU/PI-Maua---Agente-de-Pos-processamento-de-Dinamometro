import 'package:flutter/material.dart';

import '../data/mock_mappings.dart';
import '../models/engineering_variable.dart';
import '../models/variable_mapping.dart';
import '../theme/app_colors.dart';
import '../widgets/mapping_table.dart';

/// Mapping page: the user checks if each tag of the files is linked to the
/// right engineering variable.
class MappingScreen extends StatefulWidget {
  const MappingScreen({super.key});

  @override
  State<MappingScreen> createState() => _MappingScreenState();
}

class _MappingScreenState extends State<MappingScreen> {
  final List<VariableMapping> _mappings = createMockMappings();

  int get _mappedCount => _mappings.where((m) => m.isMapped).length;
  int get _unmappedCount => _mappings.length - _mappedCount;

  void _onVariableChanged(
    VariableMapping mapping,
    EngineeringVariable? variable,
  ) {
    setState(() {
      mapping.variable = variable;
    });
  }

  Future<void> _onContinue() async {
    // If something is not mapped, ask the user before going on.
    if (_unmappedCount > 0) {
      final bool? confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Unmapped tags'),
          content: Text(
            '$_unmappedCount tag(s) are not mapped and will not be '
            'available for plotting. Continue anyway?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Continue'),
            ),
          ],
        ),
      );

      if (confirmed != true) return;
    }

    // The screen may have been closed while the dialog was open.
    if (!mounted) return;

    // TODO: save the mapping and go to the Charts screen.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mapping confirmed.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool allMapped = _unmappedCount == 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Variable Mapping',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Check if the file tags are correctly mapped.',
            style: TextStyle(color: AppColors.textGrey, fontSize: 16),
          ),
          const SizedBox(height: 16),
          // Small summary, e.g. "6 of 7 tags mapped"
          Row(
            children: [
              Icon(
                allMapped ? Icons.check_circle : Icons.warning_amber_rounded,
                size: 20,
                color: allMapped ? AppColors.green : AppColors.red,
              ),
              const SizedBox(width: 8),
              Text(
                '$_mappedCount of ${_mappings.length} tags mapped',
                style: TextStyle(
                  color: allMapped ? AppColors.green : AppColors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          MappingTable(
            mappings: _mappings,
            availableVariables: availableVariables,
            onVariableChanged: _onVariableChanged,
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _onContinue,
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
                'Continue',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
