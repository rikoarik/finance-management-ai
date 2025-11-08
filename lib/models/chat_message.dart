class ChatMessage {
  final String id;
  final String userId;
  final String message;
  final bool isUser;
  final DateTime timestamp;
  final Map<String, dynamic>? transactionData;
  final String? filePath;
  final String? fileName;
  final String? fileType; // 'image', 'document', etc.
  final String? fileUrl; // For uploaded files
  
  ChatMessage({
    required this.id,
    required this.userId,
    required this.message,
    required this.isUser,
    required this.timestamp,
    this.transactionData,
    this.filePath,
    this.fileName,
    this.fileType,
    this.fileUrl,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'message': message,
      'isUser': isUser,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'transactionData': transactionData,
      'filePath': filePath,
      'fileName': fileName,
      'fileType': fileType,
      'fileUrl': fileUrl,
    };
  }
  
  factory ChatMessage.fromMap(String id, Map<dynamic, dynamic> map) {
    return ChatMessage(
      id: id,
      userId: map['userId'] ?? '',
      message: map['message'] ?? '',
      isUser: map['isUser'] ?? false,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] ?? 0),
      transactionData: map['transactionData'] != null
          ? Map<String, dynamic>.from(map['transactionData'])
          : null,
      filePath: map['filePath'],
      fileName: map['fileName'],
      fileType: map['fileType'],
      fileUrl: map['fileUrl'],
    );
  }
  
  bool get hasAttachment => filePath != null || fileUrl != null;
  bool get isImage => fileType == 'image';
  bool get isDocument => fileType == 'document';
}

