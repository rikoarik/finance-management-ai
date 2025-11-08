import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/settings/settings_bloc.dart';
import '../blocs/settings/settings_event.dart';
import '../blocs/settings/settings_state.dart';
import '../utils/constants.dart';
import '../widgets/glass_card.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Notifikasi'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNotificationTile(
                  context: context,
                  icon: Icons.notifications_active_rounded,
                  iconColor: Colors.orange,
                  title: 'Pengingat Harian',
                  subtitle: 'Pengingat harian untuk mencatat transaksi',
                  value: settingsState.dailyNotification,
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                      SettingsEvent.updateDailyNotification(value),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                
                _buildNotificationTile(
                  context: context,
                  icon: Icons.warning_rounded,
                  iconColor: Colors.red,
                  title: 'Peringatan Budget',
                  subtitle: 'Notifikasi saat mendekati limit budget',
                  value: settingsState.budgetAlert,
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                      SettingsEvent.updateBudgetAlert(value),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                
                _buildNotificationTile(
                  context: context,
                  icon: Icons.summarize_rounded,
                  iconColor: Colors.blue,
                  title: 'Ringkasan Mingguan',
                  subtitle: 'Ringkasan pengeluaran setiap minggu',
                  value: settingsState.weeklySummary,
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                      SettingsEvent.updateWeeklySummary(value),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationTile({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return GlassCard(
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        secondary: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
