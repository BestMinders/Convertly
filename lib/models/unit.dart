class Unit {
  final String name;
  final String symbol;
  final double conversionFactor; // Factor to convert to base unit
  final String category;

  const Unit({
    required this.name,
    required this.symbol,
    required this.conversionFactor,
    required this.category,
  });

  @override
  String toString() => '$name ($symbol)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Unit &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          symbol == other.symbol &&
          category == other.category;

  @override
  int get hashCode => name.hashCode ^ symbol.hashCode ^ category.hashCode;
}
