/// Abstract interface for AI services
abstract class AIService {
  /// Send a message to the AI and get a response
  /// Returns the AI response as a string
  Future<String> sendMessage(String message, {String? systemPrompt});
  
  /// Send a message with file content (extracted text)
  /// For images: imagePath untuk Gemini vision, atau extractedFileContent untuk text-based
  /// For documents: extractedFileContent untuk text content
  /// Returns the AI response as a string
  Future<String> sendMessageWithFile(
    String message, {
    String? extractedFileContent,
    String? systemPrompt,
    String? imagePath,
    String? documentPath,
  });
  
  /// Test the connection to the AI service
  /// Returns true if connection is successful
  Future<bool> testConnection();
  
  /// Get the name of the AI service
  String get serviceName;
  
  /// Check if the service requires an API key
  bool get requiresApiKey;
}

