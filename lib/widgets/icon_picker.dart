import 'package:flutter/material.dart';
import '../utils/constants.dart';

class IconPicker extends StatelessWidget {
  final IconData selectedIcon;
  final Function(IconData) onIconSelected;
  
  const IconPicker({
    super.key,
    required this.selectedIcon,
    required this.onIconSelected,
  });
  
  static final List<IconData> availableIcons = [
    // Finance & Money
    Icons.attach_money,
    Icons.account_balance_wallet,
    Icons.credit_card,
    Icons.savings,
    Icons.payments,
    Icons.currency_exchange,
    
    // Food & Dining
    Icons.restaurant,
    Icons.local_cafe,
    Icons.fastfood,
    Icons.local_pizza,
    Icons.lunch_dining,
    Icons.dinner_dining,
    Icons.breakfast_dining,
    
    // Shopping
    Icons.shopping_bag,
    Icons.shopping_cart,
    Icons.store,
    Icons.local_grocery_store,
    Icons.local_mall,
    
    // Transport
    Icons.directions_car,
    Icons.directions_bus,
    Icons.directions_subway,
    Icons.train,
    Icons.local_taxi,
    Icons.flight,
    Icons.two_wheeler,
    Icons.directions_bike,
    
    // Entertainment
    Icons.movie,
    Icons.theaters,
    Icons.sports_esports,
    Icons.music_note,
    Icons.headphones,
    Icons.sports_soccer,
    Icons.casino,
    
    // Health
    Icons.local_hospital,
    Icons.medical_services,
    Icons.medication,
    Icons.fitness_center,
    Icons.spa,
    Icons.healing,
    
    // Education
    Icons.school,
    Icons.menu_book,
    Icons.library_books,
    Icons.computer,
    
    // Bills & Services
    Icons.receipt_long,
    Icons.receipt,
    Icons.electric_bolt,
    Icons.water_drop,
    Icons.phone_android,
    Icons.wifi,
    Icons.router,
    
    // Work & Income
    Icons.work,
    Icons.business_center,
    Icons.trending_up,
    Icons.show_chart,
    Icons.analytics,
    
    // Gifts & Social
    Icons.card_giftcard,
    Icons.redeem,
    Icons.cake,
    Icons.celebration,
    Icons.favorite,
    
    // Home
    Icons.home,
    Icons.house,
    Icons.chair,
    Icons.bed,
    Icons.kitchen,
    
    // Other
    Icons.more_horiz,
    Icons.category,
    Icons.label,
    Icons.bookmark,
    Icons.star,
    Icons.build,
    Icons.handyman,
    Icons.pets,
    Icons.child_care,
    Icons.local_laundry_service,
  ];
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pilih Icon',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            
            // Icon Grid
            SizedBox(
              width: double.maxFinite,
              height: 400,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: AppSpacing.sm,
                  mainAxisSpacing: AppSpacing.sm,
                ),
                itemCount: availableIcons.length,
                itemBuilder: (context, index) {
                  final icon = availableIcons[index];
                  final isSelected = icon.codePoint == selectedIcon.codePoint;
                  
                  return InkWell(
                    onTap: () {
                      onIconSelected(icon);
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withOpacity(0.1)
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.grey.withOpacity(0.3),
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Icon(
                        icon,
                        color: isSelected ? AppColors.primary : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

