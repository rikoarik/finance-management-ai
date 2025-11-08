import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import '../blocs/export_import/export_import_bloc.dart';
import '../blocs/export_import/export_import_event.dart';
import '../blocs/export_import/export_import_state.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../widgets/glass_card.dart';
import '../widgets/gradient_button.dart';

class ExportImportScreen extends StatefulWidget {
  const ExportImportScreen({super.key});

  @override
  State<ExportImportScreen> createState() => _ExportImportScreenState();
}

class _ExportImportScreenState extends State<ExportImportScreen> {
  DateTimeRange? _dateRange;
  
  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _dateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() => _dateRange = picked);
    }
  }
  
  Future<void> _exportCSV() async {
    context.read<ExportImportBloc>().add(
      ExportImportEvent.exportToCsv(
        startDate: _dateRange?.start,
        endDate: _dateRange?.end,
      ),
    );
  }
  
  Future<void> _exportPDF() async {
    context.read<ExportImportBloc>().add(
      ExportImportEvent.exportToPdf(
        startDate: _dateRange?.start,
        endDate: _dateRange?.end,
      ),
    );
  }
  
  Future<void> _importCSV() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    
    if (result != null && result.files.single.path != null && mounted) {
      context.read<ExportImportBloc>().add(
        const ExportImportEvent.importFromCsv(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ekspor & Impor Data'),
      ),
      body: BlocConsumer<ExportImportBloc, ExportImportState>(
        listener: (context, state) {
          state.whenOrNull(
            exported: (message) {
              showSuccessSnackbar(context, message);
            },
            imported: (count) {
              showSuccessSnackbar(context, '$count transaksi berhasil diimport');
            },
            error: (message) {
              showErrorSnackbar(context, message);
            },
          );
        },
        builder: (context, state) {
          final isExporting = state.maybeWhen(
            exporting: () => true,
            orElse: () => false,
          );
          
          final isImporting = state.maybeWhen(
            importing: () => true,
            orElse: () => false,
          );
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date Range Selection
                _buildDateRangeSection(),
                const SizedBox(height: AppSpacing.lg),
                
                // Export Section
                _buildExportSection(isExporting),
                const SizedBox(height: AppSpacing.lg),
                
                // Import Section
                _buildImportSection(isImporting),
                
                const SizedBox(height: AppSpacing.lg),
                
                // Info Section
                _buildInfoSection(),
                
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildDateRangeSection() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  gradient: AppGradients.primary,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(
                  Icons.date_range_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rentang Tanggal',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Filter data berdasarkan tanggal',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (_dateRange != null)
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _dateRange = null),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          
          InkWell(
            onTap: _selectDateRange,
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: _dateRange != null 
                      ? AppColors.primary.withOpacity(0.3)
                      : Theme.of(context).colorScheme.outline.withOpacity(0.1),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    color: _dateRange != null ? AppColors.primary : AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      _dateRange == null
                          ? 'Semua Transaksi'
                          : '${DateFormat('dd MMM yyyy').format(_dateRange!.start)} - ${DateFormat('dd MMM yyyy').format(_dateRange!.end)}',
                      style: TextStyle(
                        fontWeight: _dateRange != null ? FontWeight.w600 : FontWeight.normal,
                        color: _dateRange != null ? AppColors.primary : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildExportSection(bool isExporting) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Export Data',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      gradient: AppGradients.success,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: const Icon(
                      Icons.upload_file_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Backup Transaksi',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Export data ke file CSV atau PDF',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              if (isExporting) ...[
                const SizedBox(height: AppSpacing.lg),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.success),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          'Sedang mengexport data...',
                          style: TextStyle(
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              const SizedBox(height: AppSpacing.md),
              
              // CSV Export
              GradientButton(
                text: 'Export ke CSV',
                icon: Icons.description_rounded,
                onPressed: isExporting ? null : _exportCSV,
                gradient: AppGradients.success,
                borderRadius: AppRadius.md,
              ),
              
              const SizedBox(height: AppSpacing.sm),
              
              // PDF Export
              OutlineGradientButton(
                text: 'Export ke PDF',
                icon: Icons.picture_as_pdf_rounded,
                onPressed: isExporting ? null : _exportPDF,
                gradient: AppGradients.success,
                borderRadius: AppRadius.md,
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildImportSection(bool isImporting) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Import Data',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      gradient: AppGradients.warning,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: const Icon(
                      Icons.download_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Restore Transaksi',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Import data dari file CSV',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              if (isImporting) ...[
                const SizedBox(height: AppSpacing.lg),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.warning),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          'Sedang mengimport data...',
                          style: TextStyle(
                            color: AppColors.warning,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              const SizedBox(height: AppSpacing.md),
              
              GradientButton(
                text: 'Pilih File CSV',
                icon: Icons.upload_rounded,
                onPressed: isImporting ? null : _importCSV,
                gradient: AppGradients.warning,
                borderRadius: AppRadius.md,
              ),
              
              const SizedBox(height: AppSpacing.md),
              
              // Warning Info
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: AppColors.warning.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_rounded,
                      size: 20,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Format CSV harus sesuai dengan hasil export dari aplikasi ini',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.warning,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildInfoSection() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  gradient: AppGradients.info,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(
                  Icons.help_outline_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Informasi',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          
          _buildInfoItem(
            icon: Icons.check_circle_rounded,
            color: AppColors.success,
            title: 'Export CSV',
            description: 'Data dalam format spreadsheet yang bisa dibuka di Excel/Google Sheets',
          ),
          
          const SizedBox(height: AppSpacing.sm),
          
          _buildInfoItem(
            icon: Icons.picture_as_pdf_rounded,
            color: AppColors.error,
            title: 'Export PDF',
            description: 'Laporan keuangan dalam format PDF yang siap dicetak',
          ),
          
          const SizedBox(height: AppSpacing.sm),
          
          _buildInfoItem(
            icon: Icons.cloud_upload_rounded,
            color: AppColors.info,
            title: 'Backup Rutin',
            description: 'Disarankan untuk backup data secara berkala untuk keamanan',
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoItem({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.xs),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(
            icon,
            size: 16,
            color: color,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
