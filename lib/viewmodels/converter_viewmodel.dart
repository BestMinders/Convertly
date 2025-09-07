import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/unit.dart';
import '../models/category.dart';
import '../core/constants.dart';
import '../repository/converter_repository.dart';

class ConverterViewModel extends ChangeNotifier {
  // Current state
  Category? _selectedCategory;
  Unit? _fromUnit;
  Unit? _toUnit;
  String _inputValue = '';
  String _convertedValue = '';
  bool _isDarkMode = false;
  String _searchQuery = '';
  
  // Getters
  Category? get selectedCategory => _selectedCategory;
  Unit? get fromUnit => _fromUnit;
  Unit? get toUnit => _toUnit;
  String get inputValue => _inputValue;
  String get convertedValue => _convertedValue;
  bool get isDarkMode => _isDarkMode;
  String get searchQuery => _searchQuery;
  
  List<Category> get categories => AppConstants.categories;
  List<ConversionResult> get conversionHistory => ConverterRepository.getConversionHistory();
  
  // Initialize the view model
  Future<void> initialize() async {
    await _loadSettings();
    notifyListeners();
  }

  // Category selection
  void selectCategory(Category category) {
    _selectedCategory = category;
    _searchQuery = '';
    
    // Set default units for the category
    final units = AppConstants.getUnitsByCategory(category.id);
    if (units.isNotEmpty) {
      _fromUnit = units.first;
      _toUnit = units.length > 1 ? units[1] : units.first;
    }
    
    _clearConversion();
    notifyListeners();
  }

  // Unit selection
  void selectFromUnit(Unit unit) {
    _fromUnit = unit;
    _performConversion();
    notifyListeners();
  }

  void selectToUnit(Unit unit) {
    _toUnit = unit;
    _performConversion();
    notifyListeners();
  }

  // Swap units
  void swapUnits() {
    if (_fromUnit != null && _toUnit != null) {
      final temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
      _performConversion();
      notifyListeners();
    }
  }

  // Input handling
  void updateInputValue(String value) {
    _inputValue = value;
    _performConversion();
    notifyListeners();
  }

  // Search functionality
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Get filtered units based on search
  List<Unit> getFilteredUnits() {
    if (_selectedCategory == null) return [];
    
    return ConverterRepository.searchUnits(_searchQuery, categoryId: _selectedCategory!.id);
  }

  // Theme management
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveSettings();
    notifyListeners();
  }

  // Clear conversion
  void clearConversion() {
    _clearConversion();
    notifyListeners();
  }

  void _clearConversion() {
    _inputValue = '';
    _convertedValue = '';
  }

  // Perform conversion
  void _performConversion() {
    if (_fromUnit == null || _toUnit == null || _inputValue.isEmpty) {
      _convertedValue = '';
      return;
    }

    if (!ConverterRepository.isValidInput(_inputValue)) {
      _convertedValue = '';
      return;
    }

    try {
      final input = double.parse(_inputValue);
      final result = ConverterRepository.convert(
        value: input,
        fromUnit: _fromUnit!,
        toUnit: _toUnit!,
      );
      _convertedValue = result.formattedValue;
    } catch (e) {
      _convertedValue = '';
    }
  }

  // History management
  void clearHistory() {
    ConverterRepository.clearHistory();
    notifyListeners();
  }

  // Load conversion from history
  void loadFromHistory(ConversionResult result) {
    _selectedCategory = AppConstants.getCategoryById(result.fromUnit.category);
    _fromUnit = result.fromUnit;
    _toUnit = result.toUnit;
    _inputValue = result.value.toString();
    _convertedValue = result.formattedValue;
    notifyListeners();
  }

  // Settings persistence
  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    } catch (e) {
      _isDarkMode = false;
    }
  }

  Future<void> _saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDarkMode', _isDarkMode);
    } catch (e) {
      // Handle error silently
    }
  }

  // Validation
  bool get canConvert => 
      _fromUnit != null && 
      _toUnit != null && 
      _inputValue.isNotEmpty && 
      ConverterRepository.isValidInput(_inputValue);

  bool get hasValidInput => ConverterRepository.isValidInput(_inputValue);

  // Get conversion rate info
  String getConversionRateInfo() {
    if (_fromUnit == null || _toUnit == null) return '';
    
    if (_fromUnit!.category == 'temperature') {
      return 'Temperature conversion uses special formulas';
    }
    
    final rate = ConverterRepository.getConversionRate(_fromUnit!, _toUnit!);
    return '1 ${_fromUnit!.symbol} = ${rate.toStringAsFixed(6)} ${_toUnit!.symbol}';
  }
}
