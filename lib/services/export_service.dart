import 'dart:io';
import 'package:csv/csv.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/transaction.dart' as app_transaction;
import '../utils/formatters.dart';

class ExportService {
  /// Export transactions to CSV
  Future<File> exportToCSV(List<app_transaction.Transaction> transactions) async {
    List<List<dynamic>> rows = [
      ['Date', 'Type', 'Amount', 'Category', 'Note'], // Header
    ];
    
    for (var transaction in transactions) {
      rows.add([
        formatDate(transaction.date),
        transaction.type,
        transaction.amount,
        transaction.category,
        transaction.note,
      ]);
    }
    
    String csv = const ListToCsvConverter().convert(rows);
    
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/transactions_${DateTime.now().millisecondsSinceEpoch}.csv';
    final file = File(path);
    
    await file.writeAsString(csv);
    return file;
  }
  
  /// Export transactions to PDF
  Future<File> exportToPDF(List<app_transaction.Transaction> transactions) async {
    final pdf = pw.Document();
    
    // Calculate totals
    final income = transactions
        .where((t) => t.type == 'income')
        .fold<double>(0, (sum, t) => sum + t.amount);
    final expense = transactions
        .where((t) => t.type == 'expense')
        .fold<double>(0, (sum, t) => sum + t.amount);
    final balance = income - expense;
    
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          return [
            // Header
            pw.Header(
              level: 0,
              child: pw.Text(
                'Finance Chat - Laporan Transaksi',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            
            // Summary
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey300),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Ringkasan',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 12),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total Pemasukan:'),
                      pw.Text(
                        formatCurrency(income),
                        style: pw.TextStyle(
                          color: PdfColors.green,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total Pengeluaran:'),
                      pw.Text(
                        formatCurrency(expense),
                        style: pw.TextStyle(
                          color: PdfColors.red,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Divider(),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Saldo:',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        formatCurrency(balance),
                        style: pw.TextStyle(
                          color: balance >= 0 ? PdfColors.green : PdfColors.red,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 24),
            
            // Transaction Table
            pw.Text(
              'Detail Transaksi (${transactions.length} transaksi)',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 12),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                // Header
                pw.TableRow(
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.grey200,
                  ),
                  children: [
                    _buildTableCell('Tanggal', isHeader: true),
                    _buildTableCell('Tipe', isHeader: true),
                    _buildTableCell('Jumlah', isHeader: true),
                    _buildTableCell('Kategori', isHeader: true),
                  ],
                ),
                // Data
                ...transactions.map((t) {
                  return pw.TableRow(
                    children: [
                      _buildTableCell(formatDate(t.date)),
                      _buildTableCell(
                        t.type == 'income' ? 'Masuk' : 'Keluar',
                        color: t.type == 'income' ? PdfColors.green : PdfColors.red,
                      ),
                      _buildTableCell(formatCurrency(t.amount)),
                      _buildTableCell(t.category),
                    ],
                  );
                }),
              ],
            ),
            pw.SizedBox(height: 24),
            
            // Footer
            pw.Text(
              'Digenerate pada: ${formatDateTime(DateTime.now())}',
              style: const pw.TextStyle(
                fontSize: 10,
                color: PdfColors.grey,
              ),
            ),
          ];
        },
      ),
    );
    
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/transactions_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File(path);
    
    await file.writeAsBytes(await pdf.save());
    return file;
  }
  
  pw.Widget _buildTableCell(String text, {bool isHeader = false, PdfColor? color}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
          fontSize: isHeader ? 12 : 10,
          color: color,
        ),
        textAlign: isHeader ? pw.TextAlign.center : pw.TextAlign.left,
      ),
    );
  }
  
  /// Share exported file
  Future<void> shareFile(File file, String subject) async {
    await Share.shareXFiles(
      [XFile(file.path)],
      subject: subject,
      text: 'Laporan transaksi dari Finance Chat',
    );
  }
  
  /// Import transactions from CSV
  Future<List<app_transaction.Transaction>> importFromCSV(File file) async {
    final csvString = await file.readAsString();
    final rows = const CsvToListConverter().convert(csvString);
    
    final transactions = <app_transaction.Transaction>[];
    
    // Skip header row
    for (int i = 1; i < rows.length; i++) {
      final row = rows[i];
      if (row.length >= 5) {
        try {
          // Parse date (format: dd MMM yyyy)
          DateTime? date;
          try {
            // Try to parse with different formats
            final dateStr = row[0].toString();
            date = DateTime.tryParse(dateStr);
            if (date == null) {
              // Try other date formats
              // For now, skip if can't parse
              continue;
            }
          } catch (e) {
            continue;
          }
          
          final transaction = app_transaction.Transaction(
            id: DateTime.now().millisecondsSinceEpoch.toString() + i.toString(),
            userId: '', // Will be set when saving
            amount: double.tryParse(row[2].toString()) ?? 0.0,
            type: row[1].toString().toLowerCase(),
            category: row[3].toString(),
            note: row[4].toString(),
            date: date,
          );
          
          transactions.add(transaction);
        } catch (e) {
          // Skip invalid rows
          continue;
        }
      }
    }
    
    return transactions;
  }

  // BLoC-compatible method names
  Future<void> exportTransactionsToCsv(
    List<app_transaction.Transaction> transactions,
    DateTime? startDate,
    DateTime? endDate,
  ) async {
    var filtered = transactions;
    if (startDate != null || endDate != null) {
      filtered = transactions.where((t) {
        if (startDate != null && t.date.isBefore(startDate)) return false;
        if (endDate != null && t.date.isAfter(endDate)) return false;
        return true;
      }).toList();
    }
    final file = await exportToCSV(filtered);
    await shareFile(file, 'Transaksi Export CSV');
  }

  Future<void> exportTransactionsToPdf(
    List<app_transaction.Transaction> transactions,
    DateTime? startDate,
    DateTime? endDate,
  ) async {
    var filtered = transactions;
    if (startDate != null || endDate != null) {
      filtered = transactions.where((t) {
        if (startDate != null && t.date.isBefore(startDate)) return false;
        if (endDate != null && t.date.isAfter(endDate)) return false;
        return true;
      }).toList();
    }
    final file = await exportToPDF(filtered);
    await shareFile(file, 'Laporan Transaksi PDF');
  }

  Future<List<app_transaction.Transaction>> importTransactionsFromCsv() async {
    // File picker would be used here, for now return empty
    // This method should use file_picker to let user select CSV file
    throw UnimplementedError('File picker integration needed');
  }
}

