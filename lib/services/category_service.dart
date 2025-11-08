import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/category.dart';
import '../utils/constants.dart';

class CategoryService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  /// Get current user's categories path
  String? get _userPath {
    final userId = _auth.currentUser?.uid;
    return userId != null ? 'users/$userId/categories' : null;
  }
  
  /// Get default categories
  List<Category> _getDefaultCategories() {
    final categories = <Category>[];
    
    // Add default expense categories
    for (var cat in PredefinedCategories.expenseCategoriesWithData) {
      categories.add(Category(
        id: 'default_${cat['name']}',
        name: cat['name'] as String,
        type: 'expense',
        icon: _getIconFromString(cat['icon'] as String),
        color: Color(cat['color'] as int),
        isDefault: true,
      ));
    }
    
    // Add default income categories
    for (var cat in PredefinedCategories.incomeCategoriesWithData) {
      categories.add(Category(
        id: 'default_income_${cat['name']}',
        name: cat['name'] as String,
        type: 'income',
        icon: _getIconFromString(cat['icon'] as String),
        color: Color(cat['color'] as int),
        isDefault: true,
      ));
    }
    
    return categories;
  }

  /// Stream of all categories (default + custom)
  Stream<List<Category>> getCategories(String userId) {
    // Create a stream controller to ensure we always emit at least once
    final controller = StreamController<List<Category>>.broadcast();
    
    // Helper function to combine default + custom categories
    List<Category> combineCategoriesFromSnapshot(DataSnapshot? snapshot) {
      final categories = List<Category>.from(_getDefaultCategories());
      
      // Add custom categories from Firebase
      if (snapshot != null && snapshot.exists) {
        final data = snapshot.value;
        if (data is Map) {
          data.forEach((key, value) {
            if (value is Map) {
              try {
                categories.add(Category.fromMap(value));
              } catch (e) {
                // Skip invalid category entries
                print('Error parsing category: $e');
              }
            }
          });
        }
      }
      
      return categories;
    }
    
    // First, try to get current value immediately to emit right away
    _database.child('users/$userId/categories').get().then((snapshot) {
      if (!controller.isClosed) {
        controller.add(combineCategoriesFromSnapshot(snapshot));
      }
    }).catchError((error) {
      // If get fails, still emit default categories
      if (!controller.isClosed) {
        controller.add(combineCategoriesFromSnapshot(null));
      }
    });
    
    // Then listen for updates
    final subscription = _database.child('users/$userId/categories').onValue.listen(
      (event) {
        if (!controller.isClosed) {
          controller.add(combineCategoriesFromSnapshot(event.snapshot));
        }
      },
      onError: (error) {
        // On error, still emit default categories if not already emitted
        if (!controller.isClosed) {
          controller.add(combineCategoriesFromSnapshot(null));
        }
      },
    );
    
    // Cancel subscription when stream is closed
    controller.onCancel = () {
      subscription.cancel();
    };
    
    return controller.stream;
  }

  /// Get all categories (default + custom)
  Future<List<Category>> getAllCategories() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];
    return await getCategories(userId).first;
  }
  
  /// Get custom categories only
  Future<List<Category>> getCustomCategories() async {
    if (_userPath == null) return [];
    
    final snapshot = await _database.child(_userPath!).get();
    if (!snapshot.exists) return [];
    
    final categories = <Category>[];
    final data = snapshot.value as Map<dynamic, dynamic>;
    
    data.forEach((key, value) {
      if (value is Map) {
        categories.add(Category.fromMap(value));
      }
    });
    
    return categories;
  }
  
  /// Get categories by type
  Future<List<Category>> getCategoriesByType(String type) async {
    final allCategories = await getAllCategories();
    return allCategories.where((cat) => cat.type == type).toList();
  }
  
  /// Add custom category
  Future<void> addCategory(Category category) async {
    if (_userPath == null) throw Exception('User not authenticated');
    
    final categoryWithId = category.copyWith(
      id: category.id.isEmpty ? const Uuid().v4() : category.id,
      isDefault: false,
    );
    
    await _database
        .child(_userPath!)
        .child(categoryWithId.id)
        .set(categoryWithId.toMap());
  }
  
  /// Update custom category
  Future<void> updateCategory(Category category) async {
    if (_userPath == null) throw Exception('User not authenticated');
    if (category.isDefault) throw Exception('Cannot edit default category');
    
    await _database
        .child(_userPath!)
        .child(category.id)
        .update(category.toMap());
  }
  
  /// Delete custom category
  Future<void> deleteCategory(String categoryId) async {
    if (_userPath == null) throw Exception('User not authenticated');
    
    // Check if it's a default category
    if (categoryId.startsWith('default_')) {
      throw Exception('Cannot delete default category');
    }
    
    await _database.child(_userPath!).child(categoryId).remove();
  }
  
  /// Get icon from string name
  IconData _getIconFromString(String iconName) {
    final icons = {
      'restaurant': Icons.restaurant,
      'directions_car': Icons.directions_car,
      'shopping_bag': Icons.shopping_bag,
      'movie': Icons.movie,
      'local_hospital': Icons.local_hospital,
      'school': Icons.school,
      'receipt': Icons.receipt,
      'receipt_long': Icons.receipt_long,
      'attach_money': Icons.attach_money,
      'account_balance_wallet': Icons.account_balance_wallet,
      'trending_up': Icons.trending_up,
      'card_giftcard': Icons.card_giftcard,
      'more_horiz': Icons.more_horiz,
    };
    
    return icons[iconName] ?? Icons.more_horiz;
  }
  
  /// Get category by name (for chat parsing)
  Future<Category?> getCategoryByName(String name) async {
    final categories = await getAllCategories();
    try {
      return categories.firstWhere(
        (cat) => cat.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }
}

