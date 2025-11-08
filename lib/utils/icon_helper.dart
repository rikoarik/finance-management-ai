import 'package:flutter/material.dart';

/// Helper class for safely creating IconData instances
/// This ensures compatibility with Flutter's tree-shaking in release builds
/// 
/// NOTE: To support tree-shaking in release builds, we use a mapping of
/// const IconData instances instead of creating them dynamically.
class IconHelper {
  /// Map of codePoints to const IconData instances
  /// This allows tree-shaking to work properly in release builds
  static final Map<int, IconData> _iconMap = {
    // Common expense icons
    Icons.restaurant.codePoint: Icons.restaurant,
    Icons.directions_car.codePoint: Icons.directions_car,
    Icons.shopping_bag.codePoint: Icons.shopping_bag,
    Icons.movie.codePoint: Icons.movie,
    Icons.medical_services.codePoint: Icons.medical_services,
    Icons.school.codePoint: Icons.school,
    Icons.receipt_long.codePoint: Icons.receipt_long,
    Icons.more_horiz.codePoint: Icons.more_horiz,
    Icons.category.codePoint: Icons.category,
    Icons.home.codePoint: Icons.home,
    Icons.lightbulb.codePoint: Icons.lightbulb,
    Icons.phone.codePoint: Icons.phone,
    Icons.wifi.codePoint: Icons.wifi,
    Icons.pets.codePoint: Icons.pets,
    Icons.fitness_center.codePoint: Icons.fitness_center,
    Icons.beach_access.codePoint: Icons.beach_access,
    Icons.flight.codePoint: Icons.flight,
    Icons.hotel.codePoint: Icons.hotel,
    Icons.local_cafe.codePoint: Icons.local_cafe,
    Icons.local_gas_station.codePoint: Icons.local_gas_station,
    Icons.local_grocery_store.codePoint: Icons.local_grocery_store,
    Icons.local_hospital.codePoint: Icons.local_hospital,
    Icons.local_taxi.codePoint: Icons.local_taxi,
    Icons.sports_esports.codePoint: Icons.sports_esports,
    Icons.checkroom.codePoint: Icons.checkroom,
    
    // Common income icons
    Icons.work.codePoint: Icons.work,
    Icons.business_center.codePoint: Icons.business_center,
    Icons.trending_up.codePoint: Icons.trending_up,
    Icons.card_giftcard.codePoint: Icons.card_giftcard,
    Icons.account_balance.codePoint: Icons.account_balance,
    Icons.attach_money.codePoint: Icons.attach_money,
    Icons.savings.codePoint: Icons.savings,
    Icons.volunteer_activism.codePoint: Icons.volunteer_activism,
    
    // Additional common icons
    Icons.fastfood.codePoint: Icons.fastfood,
    Icons.local_pizza.codePoint: Icons.local_pizza,
    Icons.coffee.codePoint: Icons.coffee,
    Icons.restaurant_menu.codePoint: Icons.restaurant_menu,
    Icons.directions_bus.codePoint: Icons.directions_bus,
    Icons.directions_subway.codePoint: Icons.directions_subway,
    Icons.train.codePoint: Icons.train,
    Icons.two_wheeler.codePoint: Icons.two_wheeler,
    Icons.sports_soccer.codePoint: Icons.sports_soccer,
    Icons.music_note.codePoint: Icons.music_note,
    Icons.videogame_asset.codePoint: Icons.videogame_asset,
    Icons.book.codePoint: Icons.book,
    Icons.laptop.codePoint: Icons.laptop,
    Icons.smartphone.codePoint: Icons.smartphone,
    Icons.watch.codePoint: Icons.watch,
    Icons.headphones.codePoint: Icons.headphones,
    Icons.camera.codePoint: Icons.camera,
    Icons.brush.codePoint: Icons.brush,
    Icons.color_lens.codePoint: Icons.color_lens,
    Icons.build.codePoint: Icons.build,
    Icons.shopping_cart.codePoint: Icons.shopping_cart,
    Icons.local_mall.codePoint: Icons.local_mall,
    Icons.favorite.codePoint: Icons.favorite,
    Icons.child_care.codePoint: Icons.child_care,
    Icons.spa.codePoint: Icons.spa,
    Icons.cake.codePoint: Icons.cake,
    Icons.celebration.codePoint: Icons.celebration,
  };
  
  /// Creates an IconData from a codePoint using const icon mapping
  /// 
  /// This method looks up the codePoint in our const icon map to ensure
  /// compatibility with Flutter's tree-shaking optimization.
  /// 
  /// [codePoint] - The Unicode code point for the icon
  /// [fontFamily] - Ignored, kept for backwards compatibility
  /// [fontPackage] - Ignored, kept for backwards compatibility
  static IconData fromCodePoint(
    int codePoint, {
    String? fontFamily,
    String? fontPackage,
  }) {
    // Look up the icon in our const map
    return _iconMap[codePoint] ?? Icons.more_horiz;
  }
  
  /// Safely extracts icon data for storage
  /// Returns a map with codePoint and fontFamily
  static Map<String, dynamic> toMap(IconData icon) {
    return {
      'codePoint': icon.codePoint,
      'fontFamily': icon.fontFamily ?? 'MaterialIcons',
      'fontPackage': icon.fontPackage,
    };
  }
  
  /// Creates IconData from a stored map
  /// This is the preferred method for deserializing icons from the database
  static IconData fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return Icons.more_horiz;
    }
    
    final codePoint = map['codePoint'] as int? ?? Icons.more_horiz.codePoint;
    final fontFamily = map['fontFamily'] as String? ?? 'MaterialIcons';
    final fontPackage = map['fontPackage'] as String?;
    
    return fromCodePoint(
      codePoint,
      fontFamily: fontFamily,
      fontPackage: fontPackage,
    );
  }
  
  /// Common Material Icons for categories
  /// Pre-defined constants for better tree-shaking
  static const Map<String, IconData> commonCategoryIcons = {
    // Expense icons
    'food': Icons.restaurant,
    'transport': Icons.directions_car,
    'shopping': Icons.shopping_bag,
    'entertainment': Icons.movie,
    'health': Icons.medical_services,
    'education': Icons.school,
    'bills': Icons.receipt_long,
    'other': Icons.more_horiz,
    
    // Income icons
    'salary': Icons.work,
    'business': Icons.business_center,
    'investment': Icons.trending_up,
    'gift': Icons.card_giftcard,
  };
  
  /// Get icon by category name
  static IconData getIconByName(String name, {IconData? fallback}) {
    return commonCategoryIcons[name.toLowerCase()] ?? 
           fallback ?? 
           Icons.more_horiz;
  }
}

