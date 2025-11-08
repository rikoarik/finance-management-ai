import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'ai_service_interface.dart';
import '../utils/constants.dart';
import '../exceptions/quota_exceeded_exception.dart';

class GeminiService implements AIService {
  final String apiKey;
  late final GenerativeModel _model;
  
  GeminiService(this.apiKey) {
    _model = GenerativeModel(
      model: AppConstants.geminiModel,
      apiKey: apiKey,
    );
  }
  
  @override
  String get serviceName => 'Google Gemini';
  
  @override
  bool get requiresApiKey => true;
  
  @override
  Future<String> sendMessage(String message, {String? systemPrompt}) async {
    try {
      final prompt = systemPrompt != null
          ? '$systemPrompt\n\nUser: $message'
          : message;
      
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      
      final responseText = response.text ?? 'No response from AI';
      return responseText;
    } catch (e) {
      if (_isQuotaError(e)) {
        throw QuotaExceededException(
          message: 'Quota limit exceeded. Please upgrade to continue using the service.',
          originalError: e.toString(),
        );
      }
      throw Exception('Gemini error: $e');
    }
  }
  
  @override
  Future<String> sendMessageWithFile(
    String message, {
    String? extractedFileContent,
    String? systemPrompt,
    String? imagePath,
    String? documentPath,
  }) async {
    try {
      final prompt = systemPrompt != null
          ? '$systemPrompt\n\nUser: $message'
          : message;
      
      List<Content> content = [];
      
      // Handle image dengan vision API
      if (imagePath != null) {
        final imageFile = File(imagePath);
        if (await imageFile.exists()) {
          // Deteksi MIME type berdasarkan extension
          final extension = imagePath.split('.').last.toLowerCase();
          final mimeType = extension == 'png' 
              ? 'image/png' 
              : extension == 'gif'
                  ? 'image/gif'
                  : 'image/jpeg';
          
          // Read image bytes and create DataPart
          final imageBytes = await imageFile.readAsBytes();
          final imageData = DataPart(mimeType, imageBytes);
          
          content.add(Content.multi([
            TextPart(prompt),
            imageData,
          ]));
        } else {
          content.add(Content.text(prompt));
        }
      }
      // Handle document dengan extracted content
      else if (documentPath != null || extractedFileContent != null) {
        final combinedMessage = extractedFileContent != null
            ? '$prompt\n\n--- Isi Dokumen ---\n$extractedFileContent\n--- Akhir Dokumen ---'
            : '$prompt\n\nFile dokumen terlampir. Ekstrak informasi transaksi dari dokumen ini.';
        content.add(Content.text(combinedMessage));
      }
      // Default text only
      else {
        content.add(Content.text(prompt));
      }
      
      final response = await _model.generateContent(content);
      final responseText = response.text ?? 'No response from AI';
      return responseText;
    } catch (e) {
      if (_isQuotaError(e)) {
        throw QuotaExceededException(
          message: 'Quota limit exceeded. Please upgrade to continue using the service.',
          originalError: e.toString(),
        );
      }
      throw Exception('Gemini error: $e');
    }
  }

  /// Check if error is a quota/limit related error
  bool _isQuotaError(dynamic error) {
    final errorString = error.toString().toLowerCase();
    final quotaKeywords = [
      'resource_exhausted',
      'quota',
      'rate limit',
      '429',
      'limit exceeded',
      'quota exceeded',
      'too many requests',
      'insufficient quota',
    ];
    
    return quotaKeywords.any((keyword) => errorString.contains(keyword));
  }
  
  @override
  Future<bool> testConnection() async {
    try {
      final response = await sendMessage('Hello');
      return response.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}

