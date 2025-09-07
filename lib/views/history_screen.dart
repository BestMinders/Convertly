import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/converter_viewmodel.dart';
import '../repository/converter_repository.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversion History'),
        actions: [
          Consumer<ConverterViewModel>(
            builder: (context, viewModel, child) {
              return IconButton(
                icon: const Icon(Icons.clear_all),
                onPressed: viewModel.conversionHistory.isNotEmpty
                    ? () => _showClearHistoryDialog(context, viewModel)
                    : null,
                tooltip: 'Clear history',
              );
            },
          ),
        ],
      ),
      body: Consumer<ConverterViewModel>(
        builder: (context, viewModel, child) {
          final history = viewModel.conversionHistory;
          
          if (history.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No conversion history',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your recent conversions will appear here',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: history.length,
            itemBuilder: (context, index) {
              final conversion = history[index];
              return _HistoryItem(
                conversion: conversion,
                onTap: () {
                  viewModel.loadFromHistory(conversion);
                  Navigator.pushNamed(context, '/conversion');
                },
              );
            },
          );
        },
      ),
    );
  }

  void _showClearHistoryDialog(BuildContext context, ConverterViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear History'),
        content: const Text('Are you sure you want to clear all conversion history?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              viewModel.clearHistory();
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final ConversionResult conversion;
  final VoidCallback onTap;

  const _HistoryItem({
    Key? key,
    required this.conversion,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.swap_horiz,
            color: theme.colorScheme.primary,
            size: 20,
          ),
        ),
        title: Text(
          '${conversion.fromUnit.name} → ${conversion.toUnit.name}',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${conversion.formattedValue} ${conversion.toUnit.symbol}',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${conversion.fromUnit.category.toUpperCase()} • ${conversion.fromUnit.symbol} to ${conversion.toUnit.symbol}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: theme.colorScheme.onSurface.withOpacity(0.4),
        ),
      ),
    );
  }
}
