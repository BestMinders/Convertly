import 'package:flutter/material.dart';
import '../models/unit.dart';

class UnitSelector extends StatelessWidget {
  final List<Unit> units;
  final Unit? selectedUnit;
  final String label;
  final ValueChanged<Unit?> onChanged;
  final String? searchQuery;
  final ValueChanged<String>? onSearchChanged;

  const UnitSelector({
    Key? key,
    required this.units,
    required this.selectedUnit,
    required this.label,
    required this.onChanged,
    this.searchQuery,
    this.onSearchChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.5),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonFormField<Unit>(
            value: selectedUnit,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            hint: Text(
              'Select $label',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            items: units.map((unit) {
              return DropdownMenuItem<Unit>(
                value: unit,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        unit.name,
                        style: theme.textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      unit.symbol,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: onChanged,
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
      ],
    );
  }
}

class UnitSearchField extends StatelessWidget {
  final String? searchQuery;
  final ValueChanged<String> onChanged;
  final String hintText;

  const UnitSearchField({
    Key? key,
    this.searchQuery,
    required this.onChanged,
    this.hintText = 'Search units...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          Icons.search,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        suffixIcon: searchQuery?.isNotEmpty == true
            ? IconButton(
                icon: Icon(
                  Icons.clear,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                onPressed: () => onChanged(''),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
