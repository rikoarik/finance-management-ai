import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/export_service.dart';
import '../../services/database_service.dart';
import 'export_import_event.dart';
import 'export_import_state.dart';

class ExportImportBloc extends Bloc<ExportImportEvent, ExportImportState> {
  final ExportService _exportService;
  final DatabaseService _databaseService;
  final FirebaseAuth _firebaseAuth;

  ExportImportBloc({
    ExportService? exportService,
    DatabaseService? databaseService,
    FirebaseAuth? firebaseAuth,
  })  : _exportService = exportService ?? ExportService(),
        _databaseService = databaseService ?? DatabaseService(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(const ExportImportState.initial()) {
    on<ExportToCsv>(_onExportToCsv);
    on<ExportToPdf>(_onExportToPdf);
    on<ImportFromCsv>(_onImportFromCsv);
  }

  Future<void> _onExportToCsv(
    ExportToCsv event,
    Emitter<ExportImportState> emit,
  ) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      emit(const ExportImportState.error('User not authenticated'));
      return;
    }

    emit(const ExportImportState.exporting());

    try {
      final transactions = await _databaseService
          .getTransactions(user.uid)
          .first;

      await _exportService.exportTransactionsToCsv(
        transactions,
        event.startDate,
        event.endDate,
      );

      emit(const ExportImportState.exported('Transactions exported to CSV successfully'));
    } catch (e) {
      emit(ExportImportState.error(e.toString()));
    }
  }

  Future<void> _onExportToPdf(
    ExportToPdf event,
    Emitter<ExportImportState> emit,
  ) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      emit(const ExportImportState.error('User not authenticated'));
      return;
    }

    emit(const ExportImportState.exporting());

    try {
      final transactions = await _databaseService
          .getTransactions(user.uid)
          .first;

      await _exportService.exportTransactionsToPdf(
        transactions,
        event.startDate,
        event.endDate,
      );

      emit(const ExportImportState.exported('Report exported to PDF successfully'));
    } catch (e) {
      emit(ExportImportState.error(e.toString()));
    }
  }

  Future<void> _onImportFromCsv(
    ImportFromCsv event,
    Emitter<ExportImportState> emit,
  ) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      emit(const ExportImportState.error('User not authenticated'));
      return;
    }

    emit(const ExportImportState.importing());

    try {
      final transactions = await _exportService.importTransactionsFromCsv();

      if (transactions.isEmpty) {
        emit(const ExportImportState.error('No transactions found in CSV file'));
        return;
      }

      // Import transactions
      for (var transaction in transactions) {
        final transactionWithUserId = transaction.copyWith(userId: user.uid);
        await _databaseService.addTransaction(transactionWithUserId);
      }

      emit(ExportImportState.imported(transactions.length));
    } catch (e) {
      emit(ExportImportState.error(e.toString()));
    }
  }
}

