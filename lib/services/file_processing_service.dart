import 'dart:io';
import 'package:csv/csv.dart';

/// Service untuk memproses file (extract text dari PDF, Excel, dll)
/// Untuk Groq yang text-based, kita perlu extract text dari file dulu
class FileProcessingService {
  /// Extract text dari file berdasarkan file type
  /// Returns extracted text content atau null jika tidak bisa diproses
  static Future<String?> extractTextFromFile({
    required File file,
    required String fileType,
  }) async {
    try {
      switch (fileType) {
        case 'image':
          // Untuk image, kita akan return placeholder karena Groq text-based
          // Di masa depan bisa ditambahkan OCR
          return 'File gambar terlampir. Mohon deskripsikan isi gambar untuk transaksi.';
        
        case 'document':
          // Cek extension untuk menentukan tipe dokumen
          final extension = file.path.split('.').last.toLowerCase();
          
          switch (extension) {
            case 'pdf':
              return 'File PDF terlampir. Mohon deskripsikan isi PDF untuk transaksi (misalnya: total pengeluaran, daftar transaksi, dll).';
            case 'csv':
              return await _extractTextFromCSV(file);
            case 'txt':
              return await file.readAsString();
            case 'xlsx':
            case 'xls':
              return 'File Excel terlampir. Mohon deskripsikan isi Excel untuk transaksi (misalnya: total pengeluaran, daftar transaksi, dll).';
            default:
              return 'File dokumen terlampir (tipe: $extension). Mohon deskripsikan isi dokumen untuk transaksi.';
          }
        
        default:
          return null;
      }
    } catch (e) {
      // Jika error, return placeholder
      return 'File terlampir tetapi tidak bisa dibaca. Mohon deskripsikan isi file untuk transaksi. Error: $e';
    }
  }
  
  
  /// Extract text dari CSV file
  static Future<String> _extractTextFromCSV(File file) async {
    try {
      final input = await file.readAsString();
      final rows = const CsvToListConverter().convert(input);
      
      final buffer = StringBuffer();
      buffer.writeln('Data CSV:');
      
      for (var row in rows) {
        buffer.writeln(row.join(', '));
      }
      
      return buffer.toString();
    } catch (e) {
      return 'File CSV terlampir. Mohon deskripsikan isi CSV untuk transaksi. (Error: $e)';
    }
  }
  
  /// Generate combined message dengan file content untuk dikirim ke AI
  static Future<String> prepareMessageWithFile({
    required String userMessage,
    required File? file,
    String? fileType,
    String? fileName,
  }) async {
    final buffer = StringBuffer();
    
    // Tambahkan pesan user jika ada
    if (userMessage.isNotEmpty && userMessage != '[Foto]' && !userMessage.startsWith('[File:')) {
      buffer.writeln(userMessage);
    }
    
    // Jika ada file, extract text dan tambahkan
    if (file != null && fileType != null) {
      buffer.writeln('\n--- File terlampir: $fileName ---');
      final extractedText = await extractTextFromFile(
        file: file,
        fileType: fileType,
      );
      
      if (extractedText != null) {
        buffer.writeln(extractedText);
      }
      
      buffer.writeln('--- Akhir file ---');
    }
    
    return buffer.toString();
  }
}
