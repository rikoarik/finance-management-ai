import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/chat_message.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.initial() = ChatInitial;
  const factory ChatState.loading() = ChatLoading;
  const factory ChatState.loaded({
    required List<ChatMessage> messages,
    Map<String, dynamic>? pendingTransaction,
    @Default(false) bool isAiTyping,
    @Default(false) bool showUpgradeDialog,
  }) = ChatLoaded;
  const factory ChatState.error(String message) = ChatError;
}

