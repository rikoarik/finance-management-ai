import 'package:freezed_annotation/freezed_annotation.dart';

part 'export_import_state.freezed.dart';

@freezed
class ExportImportState with _$ExportImportState {
  const factory ExportImportState.initial() = ExportImportInitial;
  const factory ExportImportState.exporting() = Exporting;
  const factory ExportImportState.exported(String message) = Exported;
  const factory ExportImportState.importing() = Importing;
  const factory ExportImportState.imported(int count) = Imported;
  const factory ExportImportState.error(String message) = ExportImportError;
}

