import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:funz_eventz/model/message.dart';
import 'package:funz_eventz/model/user.dart';

import '../utils.dart';

class FirebaseApi {
  // static Stream<List<User>> getUsers() => FirebaseFirestore.instance
  //     .collection('user')
  //     .orderBy(UserField.lastMessageTime, descending: true)
  //     .snapshots()
  //     .transform(Utils.transformer(User.fromJson));

  static Future uploadMessage(String idUser, String message, String url , String name ) async {
    final refMessages =
    FirebaseFirestore.instance.collection('chats/$idUser/messages');

    final newMessage = Message(
      idUser: idUser,
      urlAvatar: url,
      username: name,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('users');
    await refUsers
        .doc(idUser)
        .update({UserField.lastMessageTime: DateTime.now()});
  }

  // static Stream<List<Message>> getMessages(String idUser) =>
  //     FirebaseFirestore.instance
  //         .collection('chats/$idUser/messages')
  //         .orderBy(MessageField.createdAt, descending: true)
  //         .snapshots()
  //         .transform(Utils.transformer(Message.fromJson));


}