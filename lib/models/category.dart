import 'package:flutter/material.dart';
import '../utils/icon_helper.dart';

class Category {
  final String id;
  final String name;
  final String type; // 'income' or 'expense'
  final IconData icon;
  final Color color;
  final bool isDefault;
  
  Category({
    required this.id,
    required this.name,
    required this.type,
    required this.icon,
    required this.color,
    this.isDefault = false,
  });
  
  Map<String, dynamic> toMap() {
    // Use IconHelper to properly serialize icon data
    final iconData = IconHelper.toMap(icon);
    
    return {
      'id': id,
      'name': name,
      'type': type,
      'icon': iconData['codePoint'],
      'iconFontFamily': iconData['fontFamily'],
      'iconFontPackage': iconData['fontPackage'],
      'color': color.value,
      'isDefault': isDefault,
    };
  }
  
  factory Category.fromMap(Map<dynamic, dynamic> map) {
    // Use IconHelper to safely create IconData
    // This handles both old format (just codePoint) and new format (with fontFamily)
    IconData icon;
    
    if (map['iconFontFamily'] != null || map['iconFontPackage'] != null) {
      // New format: has fontFamily stored
      icon = IconHelper.fromCodePoint(
        map['icon'] ?? Icons.more_horiz.codePoint,
        fontFamily: map['iconFontFamily'],
        fontPackage: map['iconFontPackage'],
      );
    } else if (map['icon'] is Map) {
      // Alternative new format: icon is stored as a map
      icon = IconHelper.fromMap(map['icon']);
    } else {
      // Old format: just codePoint, default to MaterialIcons
      icon = IconHelper.fromCodePoint(
        map['icon'] ?? Icons.more_horiz.codePoint,
        fontFamily: 'MaterialIcons',
      );
    }
    
    return Category(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? 'expense',
      icon: icon,
      color: Color(map['color'] ?? 0xFF9CA3AF),
      isDefault: map['isDefault'] ?? false,
    );
  }
  
  Category copyWith({
    String? id,
    String? name,
    String? type,
    IconData? icon,
    Color? color,
    bool? isDefault,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
