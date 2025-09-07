import '../models/unit.dart';
import '../core/constants.dart';

class ConversionResult {
  final double value;
  final String formattedValue;
  final Unit fromUnit;
  final Unit toUnit;

  ConversionResult({
    required this.value,
    required this.formattedValue,
    required this.fromUnit,
    required this.toUnit,
  });
}

class ConverterRepository {
  static const int _maxHistoryItems = 10;
  static final List<ConversionResult> _conversionHistory = [];

  // Convert between units
  static ConversionResult convert({
    required double value,
    required Unit fromUnit,
    required Unit toUnit,
  }) {
    double convertedValue;

    // Special handling for temperature conversions
    if (fromUnit.category == 'temperature') {
      convertedValue = _convertTemperature(value, fromUnit, toUnit);
    } else {
      // Standard conversion using conversion factors
      // Convert to base unit first, then to target unit
      double baseValue = value * fromUnit.conversionFactor;
      convertedValue = baseValue / toUnit.conversionFactor;
    }

    // Format the result
    String formattedValue = _formatValue(convertedValue);

    final result = ConversionResult(
      value: convertedValue,
      formattedValue: formattedValue,
      fromUnit: fromUnit,
      toUnit: toUnit,
    );

    // Add to history
    _addToHistory(result);

    return result;
  }

  // Temperature conversion logic
  static double _convertTemperature(double value, Unit fromUnit, Unit toUnit) {
    // Convert to Celsius first
    double celsius;
    switch (fromUnit.symbol) {
      case '°C':
        celsius = value;
        break;
      case '°F':
        celsius = (value - 32) * 5 / 9;
        break;
      case 'K':
        celsius = value - 273.15;
        break;
      default:
        celsius = value;
    }

    // Convert from Celsius to target unit
    switch (toUnit.symbol) {
      case '°C':
        return celsius;
      case '°F':
        return celsius * 9 / 5 + 32;
      case 'K':
        return celsius + 273.15;
      default:
        return celsius;
    }
  }

  // Format the converted value
  static String _formatValue(double value) {
    if (value == 0) return '0';
    
    // Handle very large or very small numbers
    if (value.abs() >= 1e9) {
      return '${(value / 1e9).toStringAsFixed(2)}B';
    } else if (value.abs() >= 1e6) {
      return '${(value / 1e6).toStringAsFixed(2)}M';
    } else if (value.abs() >= 1e3) {
      return '${(value / 1e3).toStringAsFixed(2)}K';
    } else if (value.abs() < 0.001) {
      return value.toStringAsExponential(3);
    } else if (value.abs() < 1) {
      return value.toStringAsFixed(6).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    } else {
      return value.toStringAsFixed(6).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }
  }

  // Add conversion to history
  static void _addToHistory(ConversionResult result) {
    _conversionHistory.insert(0, result);
    
    // Keep only the last _maxHistoryItems
    if (_conversionHistory.length > _maxHistoryItems) {
      _conversionHistory.removeRange(_maxHistoryItems, _conversionHistory.length);
    }
  }

  // Get conversion history
  static List<ConversionResult> getConversionHistory() {
    return List.unmodifiable(_conversionHistory);
  }

  // Clear conversion history
  static void clearHistory() {
    _conversionHistory.clear();
  }

  // Search units by name or symbol
  static List<Unit> searchUnits(String query, {String? categoryId}) {
    if (query.isEmpty) {
      return categoryId != null 
          ? AppConstants.getUnitsByCategory(categoryId)
          : AppConstants.allUnits;
    }

    final lowercaseQuery = query.toLowerCase();
    final units = categoryId != null 
        ? AppConstants.getUnitsByCategory(categoryId)
        : AppConstants.allUnits;

    return units.where((unit) {
      return unit.name.toLowerCase().contains(lowercaseQuery) ||
             unit.symbol.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  // Get popular units for a category (first 4 units)
  static List<Unit> getPopularUnits(String categoryId) {
    final units = AppConstants.getUnitsByCategory(categoryId);
    return units.take(4).toList();
  }

  // Validate conversion input
  static bool isValidInput(String input) {
    if (input.isEmpty) return false;
    
    try {
      final value = double.parse(input);
      return value.isFinite;
    } catch (e) {
      return false;
    }
  }

  // Get conversion rate between two units
  static double getConversionRate(Unit fromUnit, Unit toUnit) {
    if (fromUnit.category == 'temperature') {
      // For temperature, we can't provide a simple rate
      return 1.0;
    }
    
    return fromUnit.conversionFactor / toUnit.conversionFactor;
  }
}
