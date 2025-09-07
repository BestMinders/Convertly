import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../viewmodels/converter_viewmodel.dart';
import '../widgets/unit_selector.dart';
import '../widgets/result_box.dart';

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({Key? key}) : super(key: key);

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  final TextEditingController _inputController = TextEditingController();
  final FocusNode _inputFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inputFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _inputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ConverterViewModel>(
          builder: (context, viewModel, child) {
            return Text(viewModel.selectedCategory?.name ?? 'Conversion');
          },
        ),
        actions: [
          Consumer<ConverterViewModel>(
            builder: (context, viewModel, child) {
              return IconButton(
                icon: const Icon(Icons.swap_horiz),
                onPressed: viewModel.fromUnit != null && viewModel.toUnit != null
                    ? viewModel.swapUnits
                    : null,
                tooltip: 'Swap units',
              );
            },
          ),
        ],
      ),
      body: Consumer<ConverterViewModel>(
        builder: (context, viewModel, child) {
          // Update controller when viewModel input changes
          if (_inputController.text != viewModel.inputValue) {
            _inputController.text = viewModel.inputValue;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Input section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter Value',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _inputController,
                          focusNode: _inputFocusNode,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.,\-]')),
                          ],
                          decoration: InputDecoration(
                            hintText: 'Enter value to convert',
                            suffixIcon: _inputController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      _inputController.clear();
                                      viewModel.updateInputValue('');
                                    },
                                  )
                                : null,
                          ),
                          onChanged: viewModel.updateInputValue,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Unit selectors
                Row(
                  children: [
                    Expanded(
                      child: UnitSelector(
                        units: viewModel.getFilteredUnits(),
                        selectedUnit: viewModel.fromUnit,
                        label: 'From',
                        onChanged: (unit) => viewModel.selectFromUnit(unit!),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: UnitSelector(
                        units: viewModel.getFilteredUnits(),
                        selectedUnit: viewModel.toUnit,
                        label: 'To',
                        onChanged: (unit) => viewModel.selectToUnit(unit!),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Search field
                if (viewModel.selectedCategory != null)
                  UnitSearchField(
                    searchQuery: viewModel.searchQuery,
                    onChanged: viewModel.updateSearchQuery,
                    hintText: 'Search ${viewModel.selectedCategory!.name.toLowerCase()} units...',
                  ),
                
                const SizedBox(height: 24),
                
                // Result box
                ResultBox(
                  result: viewModel.convertedValue,
                  fromUnit: viewModel.fromUnit,
                  toUnit: viewModel.toUnit,
                  conversionRateInfo: viewModel.getConversionRateInfo(),
                  isValid: viewModel.hasValidInput,
                ),
                
                const SizedBox(height: 24),
                
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: viewModel.canConvert
                            ? () {
                                _inputController.clear();
                                viewModel.clearConversion();
                              }
                            : null,
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: viewModel.canConvert
                            ? () {
                                // Copy result to clipboard
                                Clipboard.setData(ClipboardData(text: viewModel.convertedValue));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Result copied to clipboard'),
                                    duration: Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            : null,
                        icon: const Icon(Icons.copy),
                        label: const Text('Copy Result'),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Popular units
                if (viewModel.selectedCategory != null) ...[
                  Text(
                    'Popular ${viewModel.selectedCategory!.name} Units',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: viewModel.getFilteredUnits().take(6).map((unit) {
                      return ActionChip(
                        label: Text('${unit.name} (${unit.symbol})'),
                        onPressed: () {
                          if (viewModel.fromUnit == null) {
                            viewModel.selectFromUnit(unit);
                          } else if (viewModel.toUnit == null) {
                            viewModel.selectToUnit(unit);
                          } else {
                            // Cycle through: from -> to -> from
                            if (viewModel.fromUnit == unit) {
                              viewModel.selectToUnit(unit);
                            } else {
                              viewModel.selectFromUnit(unit);
                            }
                          }
                        },
                        backgroundColor: (viewModel.fromUnit == unit || viewModel.toUnit == unit)
                            ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                            : null,
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
