// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState {
  final List<Message> messages;

  ChatSuccess({
    required this.messages,
  });
}
