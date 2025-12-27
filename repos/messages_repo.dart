import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktokclone/model/messages_model.dart';

class MessagesRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMessage(MessagesModel message) async {
    await _db
        .collection("chatrooms")
        .doc("chatrooms_id")
        .collection("texts")
        .add(message.toJson());
  }
}

final messageRepo = Provider((ref) => MessagesRepo());
