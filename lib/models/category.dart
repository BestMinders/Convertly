import 'package:flutter/material.dart';

class Category {
  final String name;
  final String description;
  final IconData icon;
  final String id;

  const Category({
    required this.name,
    required this.description,
    required this.icon,
    required this.id,
  });

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id;

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}

