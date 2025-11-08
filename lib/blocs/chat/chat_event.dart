import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_event.freezed.dart';

@freezed
class ChatEvent with _$ChatEvent {
  const factory ChatEvent.loadMessages() = LoadMessages;
  const factory ChatEvent.sendMessage(String message, {
    String? filePath,
    String? fileName,
    String? fileType,
  }) = SendMessage;
  const factory ChatEvent.confirmTransaction(Map<String, dynamic> transactionData) = ConfirmTransaction;
  const factory ChatEvent.cancelTransaction() = CancelTransaction;
  const factory ChatEvent.clearChat() = ClearChat;
  
  // Internal event for dismissing upgrade dialog
  const factory ChatEvent.dismissUpgradeDialog() = DismissUpgradeDialog;
}

