import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<Message> messagesList = [];
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kmessagesCollection);
  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        kMessage: messages,
        kCreatedAt: DateTime.now(),
        'id': email,
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  void getMessage() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messagesList.clear();
      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc as Map<String, dynamic>));
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }

  @override
  void onChange(Change<ChatState> change) {
    super.onChange(change);
  }
}
