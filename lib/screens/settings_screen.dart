import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/settings/settings_bloc.dart';
import '../blocs/settings/settings_event.dart';
import '../blocs/settings/settings_state.dart';
import '../blocs/theme/theme_bloc.dart';
import '../blocs/theme/theme_event.dart';
import '../blocs/theme/theme_state.dart';
import '../utils/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
          if (settingsState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  context,
                  title: 'Pengaturan Bahasa',
                  children: [
                    _buildLanguageTile(context, settingsState),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                
                _buildSection(
                  context,
                  title: 'Pengaturan Tema',
                  children: [
                    _buildThemeTile(context),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                
                _buildSection(
                  context,
                  title: 'Notifikasi',
                  children: [
                    _buildNotificationTile(
                      context,
                      title: 'Pengingat Harian',
                      subtitle: 'Dapatkan pengingat harian untuk mencatat transaksi',
                      value: settingsState.dailyNotification,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                          SettingsEvent.updateDailyNotification(value),
                        );
                      },
                    ),
                    const Divider(),
                    _buildNotificationTile(
                      context,
                      title: 'Peringatan Budget',
                      subtitle: 'Dapatkan notifikasi saat mendekati limit budget',
                      value: settingsState.budgetAlert,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                          SettingsEvent.updateBudgetAlert(value),
                        );
                      },
                    ),
                    const Divider(),
                    _buildNotificationTile(
                      context,
                      title: 'Ringkasan Mingguan',
                      subtitle: 'Dapatkan ringkasan pengeluaran setiap minggu',
                      value: settingsState.weeklySummary,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                          SettingsEvent.updateWeeklySummary(value),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                
                _buildSection(
                  context,
                  title: 'Lainnya',
                  children: [
                    ListTile(
                      leading: const Icon(Icons.category),
                      title: const Text('Kelola Kategori'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.pushNamed(context, '/category-management'),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.import_export),
                      title: const Text('Export/Import Data'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.pushNamed(context, '/export-import'),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.repeat),
                      title: const Text('Transaksi Berulang'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.pushNamed(context, '/recurring-transactions'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildSection(BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.sm, bottom: AppSpacing.sm),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }
  
  Widget _buildLanguageTile(BuildContext context, SettingsState state) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: const Text('Bahasa'),
      subtitle: Text(state.language == 'id' ? 'Indonesia' : 'English'),
      trailing: DropdownButton<String>(
        value: state.language,
        underline: const SizedBox(),
        items: const [
          DropdownMenuItem(value: 'id', child: Text('ID')),
          DropdownMenuItem(value: 'en', child: Text('EN')),
        ],
        onChanged: (value) {
          if (value != null) {
            context.setLocale(Locale(value));
            context.read<SettingsBloc>().add(
              SettingsEvent.updateLanguage(value),
            );
          }
        },
      ),
    );
  }
  
  Widget _buildThemeTile(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return ListTile(
          leading: const Icon(Icons.brightness_6),
          title: const Text('Tema'),
          subtitle: Text(
            themeState.themeMode == ThemeMode.light
                ? 'Terang'
                : themeState.themeMode == ThemeMode.dark
                    ? 'Gelap'
                    : 'Sistem',
          ),
          trailing: DropdownButton<ThemeMode>(
            value: themeState.themeMode,
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(value: ThemeMode.system, child: Text('Sistem')),
              DropdownMenuItem(value: ThemeMode.light, child: Text('Terang')),
              DropdownMenuItem(value: ThemeMode.dark, child: Text('Gelap')),
            ],
            onChanged: (value) {
              if (value != null) {
                context.read<ThemeBloc>().add(ThemeEvent.setThemeMode(value));
              }
            },
          ),
        );
      },
    );
  }
  
  Widget _buildNotificationTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: const Icon(Icons.notifications),
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}
