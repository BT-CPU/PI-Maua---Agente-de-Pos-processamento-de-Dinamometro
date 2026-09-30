import 'package:flutter/material.dart';

import '../models/engineering_variable.dart';
import '../models/variable_mapping.dart';
import '../theme/app_colors.dart';
import 'mapping_status_badge.dart';

/// Table with one row for each tag found in the files.
/// The engineering variable is a dropdown, so the user can fix a wrong
/// mapping or map a tag that was not recognized.
class MappingTable extends StatelessWidget {
  final List<VariableMapping> mappings;
  final List<EngineeringVariable> availableVariables;
  final void Function(VariableMapping mapping, EngineeringVariable? variable)
      onVariableChanged;

  // On very narrow screens the table keeps this width and scrolls sideways.
  static const double _minTableWidth = 640;

  const MappingTable({
    super.key,
    required this.mappings,
    required this.availableVariables,
    required this.onVariableChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: LayoutBuilder(
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
                  for (final mapping in mappings) _buildRow(mapping),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRow(VariableMapping mapping) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          // Column 1: raw tag
          Expanded(
            flex: 2,
            child: Text(
              mapping.tag,
              style: const TextStyle(color: AppColors.textDark),
            ),
          ),
          // Column 2: engineering variable (dropdown)
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _buildDropdown(mapping),
            ),
          ),
          // Column 3: unit (comes from the chosen variable)
          Expanded(
            flex: 1,
            child: Text(
              mapping.variable?.unit ?? '-',
              style: const TextStyle(color: AppColors.textDark),
            ),
          ),
          // Column 4: status
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: MappingStatusBadge(isMapped: mapping.isMapped),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(VariableMapping mapping) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<EngineeringVariable>(
        isExpanded: true,
        value: mapping.variable,
        hint: const Text(
          'Select variable',
          style: TextStyle(color: AppColors.textGrey),
        ),
        style: const TextStyle(color: AppColors.textDark, fontSize: 16),
        items: [
          for (final variable in availableVariables)
            DropdownMenuItem(value: variable, child: Text(variable.name)),
        ],
        onChanged: (variable) => onVariableChanged(mapping, variable),
      ),
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
          Expanded(flex: 2, child: Text('Tag (file)', style: style)),
          Expanded(flex: 3, child: Text('Engineering variable', style: style)),
          Expanded(flex: 1, child: Text('Unit', style: style)),
          Expanded(flex: 2, child: Text('Status', style: style)),
        ],
      ),
    );
  }
}
