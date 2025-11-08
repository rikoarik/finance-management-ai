import 'package:freezed_annotation/freezed_annotation.dart';

part 'export_import_event.freezed.dart';

@freezed
class ExportImportEvent with _$ExportImportEvent {
  const factory ExportImportEvent.exportToCsv({
    DateTime? startDate,
    DateTime? endDate,
  }) = ExportToCsv;
  const factory ExportImportEvent.exportToPdf({
    DateTime? startDate,
    DateTime? endDate,
  }) = ExportToPdf;
  const factory ExportImportEvent.importFromCsv() = ImportFromCsv;
}

