import 'package:flutter/material.dart';
import '../utils/constants.dart';

class UpgradeDialog extends StatelessWidget {
  final String? message;
  final VoidCallback? onUpgrade;

  const UpgradeDialog({
    super.key,
    this.message,
    this.onUpgrade,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      title: Row(
        children: [
          Icon(
            Icons.star_rounded,
            color: AppColors.warning,
            size: 28,
          ),
          const SizedBox(width: AppSpacing.sm),
          const Text('Upgrade Required'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message ??
                'Anda telah mencapai batas quota. Upgrade ke akun premium untuk melanjutkan menggunakan layanan AI.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle, color: AppColors.success, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    const Text('Akses unlimited ke AI'),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Icon(Icons.check_circle, color: AppColors.success, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    const Text('Prioritas dukungan'),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Icon(Icons.check_circle, color: AppColors.success, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    const Text('Fitur premium lainnya'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Nanti'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onUpgrade?.call();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: const Text('Upgrade Sekarang'),
        ),
      ],
    );
  }

  static void show(BuildContext context, {String? message, VoidCallback? onUpgrade}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => UpgradeDialog(
        message: message,
        onUpgrade: onUpgrade,
      ),
    );
  }
}

