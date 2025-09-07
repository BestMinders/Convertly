import '../models/unit.dart';
import '../models/category.dart';
import 'package:flutter/material.dart';

class AppConstants {
  // App Information
  static const String appName = 'UniCalc';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Ultimate All-in-One Unit Converter';

  // Categories
  static const List<Category> categories = [
    Category(
      id: 'length',
      name: 'Length',
      description: 'Convert between different length units',
      icon: Icons.straighten,
    ),
    Category(
      id: 'weight',
      name: 'Weight',
      description: 'Convert between different weight units',
      icon: Icons.monitor_weight,
    ),
    Category(
      id: 'temperature',
      name: 'Temperature',
      description: 'Convert between different temperature units',
      icon: Icons.thermostat,
    ),
    Category(
      id: 'time',
      name: 'Time',
      description: 'Convert between different time units',
      icon: Icons.access_time,
    ),
    Category(
      id: 'area',
      name: 'Area',
      description: 'Convert between different area units',
      icon: Icons.crop_square,
    ),
    Category(
      id: 'volume',
      name: 'Volume',
      description: 'Convert between different volume units',
      icon: Icons.local_drink,
    ),
    Category(
      id: 'speed',
      name: 'Speed',
      description: 'Convert between different speed units',
      icon: Icons.speed,
    ),
    Category(
      id: 'pressure',
      name: 'Pressure',
      description: 'Convert between different pressure units',
      icon: Icons.compress,
    ),
    Category(
      id: 'energy',
      name: 'Energy',
      description: 'Convert between different energy units',
      icon: Icons.flash_on,
    ),
    Category(
      id: 'power',
      name: 'Power',
      description: 'Convert between different power units',
      icon: Icons.electrical_services,
    ),
    Category(
      id: 'currency',
      name: 'Currency',
      description: 'Convert between different currencies',
      icon: Icons.attach_money,
    ),
  ];

  // All Units with conversion factors
  static const List<Unit> allUnits = [
    // Length Units (base: meter)
    Unit(name: 'Meter', symbol: 'm', conversionFactor: 1.0, category: 'length'),
    Unit(name: 'Kilometer', symbol: 'km', conversionFactor: 1000.0, category: 'length'),
    Unit(name: 'Centimeter', symbol: 'cm', conversionFactor: 0.01, category: 'length'),
    Unit(name: 'Millimeter', symbol: 'mm', conversionFactor: 0.001, category: 'length'),
    Unit(name: 'Inch', symbol: 'in', conversionFactor: 0.0254, category: 'length'),
    Unit(name: 'Foot', symbol: 'ft', conversionFactor: 0.3048, category: 'length'),
    Unit(name: 'Yard', symbol: 'yd', conversionFactor: 0.9144, category: 'length'),
    Unit(name: 'Mile', symbol: 'mi', conversionFactor: 1609.344, category: 'length'),

    // Weight Units (base: kilogram)
    Unit(name: 'Kilogram', symbol: 'kg', conversionFactor: 1.0, category: 'weight'),
    Unit(name: 'Gram', symbol: 'g', conversionFactor: 0.001, category: 'weight'),
    Unit(name: 'Pound', symbol: 'lb', conversionFactor: 0.453592, category: 'weight'),
    Unit(name: 'Ounce', symbol: 'oz', conversionFactor: 0.0283495, category: 'weight'),
    Unit(name: 'Ton', symbol: 't', conversionFactor: 1000.0, category: 'weight'),
    Unit(name: 'Stone', symbol: 'st', conversionFactor: 6.35029, category: 'weight'),

    // Temperature Units (special handling required)
    Unit(name: 'Celsius', symbol: '°C', conversionFactor: 1.0, category: 'temperature'),
    Unit(name: 'Fahrenheit', symbol: '°F', conversionFactor: 1.0, category: 'temperature'),
    Unit(name: 'Kelvin', symbol: 'K', conversionFactor: 1.0, category: 'temperature'),

    // Time Units (base: second)
    Unit(name: 'Second', symbol: 's', conversionFactor: 1.0, category: 'time'),
    Unit(name: 'Minute', symbol: 'min', conversionFactor: 60.0, category: 'time'),
    Unit(name: 'Hour', symbol: 'h', conversionFactor: 3600.0, category: 'time'),
    Unit(name: 'Day', symbol: 'd', conversionFactor: 86400.0, category: 'time'),
    Unit(name: 'Week', symbol: 'wk', conversionFactor: 604800.0, category: 'time'),
    Unit(name: 'Month', symbol: 'mo', conversionFactor: 2629746.0, category: 'time'),
    Unit(name: 'Year', symbol: 'yr', conversionFactor: 31556952.0, category: 'time'),

    // Area Units (base: square meter)
    Unit(name: 'Square Meter', symbol: 'm²', conversionFactor: 1.0, category: 'area'),
    Unit(name: 'Square Kilometer', symbol: 'km²', conversionFactor: 1000000.0, category: 'area'),
    Unit(name: 'Square Centimeter', symbol: 'cm²', conversionFactor: 0.0001, category: 'area'),
    Unit(name: 'Square Inch', symbol: 'in²', conversionFactor: 0.00064516, category: 'area'),
    Unit(name: 'Square Foot', symbol: 'ft²', conversionFactor: 0.092903, category: 'area'),
    Unit(name: 'Square Yard', symbol: 'yd²', conversionFactor: 0.836127, category: 'area'),
    Unit(name: 'Acre', symbol: 'ac', conversionFactor: 4046.86, category: 'area'),
    Unit(name: 'Hectare', symbol: 'ha', conversionFactor: 10000.0, category: 'area'),

    // Volume Units (base: liter)
    Unit(name: 'Liter', symbol: 'L', conversionFactor: 1.0, category: 'volume'),
    Unit(name: 'Milliliter', symbol: 'mL', conversionFactor: 0.001, category: 'volume'),
    Unit(name: 'Cubic Meter', symbol: 'm³', conversionFactor: 1000.0, category: 'volume'),
    Unit(name: 'Cubic Centimeter', symbol: 'cm³', conversionFactor: 0.001, category: 'volume'),
    Unit(name: 'Gallon (US)', symbol: 'gal', conversionFactor: 3.78541, category: 'volume'),
    Unit(name: 'Quart (US)', symbol: 'qt', conversionFactor: 0.946353, category: 'volume'),
    Unit(name: 'Pint (US)', symbol: 'pt', conversionFactor: 0.473176, category: 'volume'),
    Unit(name: 'Cup (US)', symbol: 'cup', conversionFactor: 0.236588, category: 'volume'),
    Unit(name: 'Fluid Ounce (US)', symbol: 'fl oz', conversionFactor: 0.0295735, category: 'volume'),

    // Speed Units (base: meter per second)
    Unit(name: 'Meter per Second', symbol: 'm/s', conversionFactor: 1.0, category: 'speed'),
    Unit(name: 'Kilometer per Hour', symbol: 'km/h', conversionFactor: 0.277778, category: 'speed'),
    Unit(name: 'Mile per Hour', symbol: 'mph', conversionFactor: 0.44704, category: 'speed'),
    Unit(name: 'Foot per Second', symbol: 'ft/s', conversionFactor: 0.3048, category: 'speed'),
    Unit(name: 'Knot', symbol: 'kn', conversionFactor: 0.514444, category: 'speed'),

    // Pressure Units (base: pascal)
    Unit(name: 'Pascal', symbol: 'Pa', conversionFactor: 1.0, category: 'pressure'),
    Unit(name: 'Kilopascal', symbol: 'kPa', conversionFactor: 1000.0, category: 'pressure'),
    Unit(name: 'Bar', symbol: 'bar', conversionFactor: 100000.0, category: 'pressure'),
    Unit(name: 'Atmosphere', symbol: 'atm', conversionFactor: 101325.0, category: 'pressure'),
    Unit(name: 'PSI', symbol: 'psi', conversionFactor: 6894.76, category: 'pressure'),
    Unit(name: 'Torr', symbol: 'Torr', conversionFactor: 133.322, category: 'pressure'),

    // Energy Units (base: joule)
    Unit(name: 'Joule', symbol: 'J', conversionFactor: 1.0, category: 'energy'),
    Unit(name: 'Kilojoule', symbol: 'kJ', conversionFactor: 1000.0, category: 'energy'),
    Unit(name: 'Calorie', symbol: 'cal', conversionFactor: 4.184, category: 'energy'),
    Unit(name: 'Kilocalorie', symbol: 'kcal', conversionFactor: 4184.0, category: 'energy'),
    Unit(name: 'Watt Hour', symbol: 'Wh', conversionFactor: 3600.0, category: 'energy'),
    Unit(name: 'Kilowatt Hour', symbol: 'kWh', conversionFactor: 3600000.0, category: 'energy'),
    Unit(name: 'BTU', symbol: 'BTU', conversionFactor: 1055.06, category: 'energy'),

    // Power Units (base: watt)
    Unit(name: 'Watt', symbol: 'W', conversionFactor: 1.0, category: 'power'),
    Unit(name: 'Kilowatt', symbol: 'kW', conversionFactor: 1000.0, category: 'power'),
    Unit(name: 'Megawatt', symbol: 'MW', conversionFactor: 1000000.0, category: 'power'),
    Unit(name: 'Horsepower', symbol: 'hp', conversionFactor: 745.7, category: 'power'),
    Unit(name: 'BTU per Hour', symbol: 'BTU/h', conversionFactor: 0.293071, category: 'power'),

    // Currency Units (base: USD)
    Unit(name: 'US Dollar', symbol: 'USD', conversionFactor: 1.0, category: 'currency'),
    Unit(name: 'Euro', symbol: 'EUR', conversionFactor: 1.08, category: 'currency'),
    Unit(name: 'British Pound', symbol: 'GBP', conversionFactor: 1.27, category: 'currency'),
    Unit(name: 'Japanese Yen', symbol: 'JPY', conversionFactor: 0.0067, category: 'currency'),
    Unit(name: 'Canadian Dollar', symbol: 'CAD', conversionFactor: 0.74, category: 'currency'),
    Unit(name: 'Australian Dollar', symbol: 'AUD', conversionFactor: 0.66, category: 'currency'),
    Unit(name: 'Swiss Franc', symbol: 'CHF', conversionFactor: 1.12, category: 'currency'),
    Unit(name: 'Chinese Yuan', symbol: 'CNY', conversionFactor: 0.14, category: 'currency'),
    Unit(name: 'Indian Rupee', symbol: 'INR', conversionFactor: 0.012, category: 'currency'),
    Unit(name: 'Brazilian Real', symbol: 'BRL', conversionFactor: 0.20, category: 'currency'),
  ];

  // Get units by category
  static List<Unit> getUnitsByCategory(String categoryId) {
    return allUnits.where((unit) => unit.category == categoryId).toList();
  }

  // Get category by ID
  static Category? getCategoryById(String categoryId) {
    try {
      return categories.firstWhere((category) => category.id == categoryId);
    } catch (e) {
      return null;
    }
  }
}
