import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktokclone/model/messages_model.dart';
import 'package:ticktokclone/repos/autentication_repo.dart';
import 'package:ticktokclone/repos/messages_repo.dart';

class MessageViewModel extends AsyncNotifier<void> {
  late final MessagesRepo _repo;

  @override
  Future<void> build() async {
    _repo = ref.read(messageRepo);
  }

  Future<void> sendMessage(String text, BuildContext context) async {
    final user = ref.read(authRepo).user;
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final message = MessagesModel(
        text: text,
        userId: user!.uid,
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      await _repo.sendMessage(message);
    });
  }
}

final messageProvider = AsyncNotifierProvider<MessageViewModel, void>(
  () => MessageViewModel(),
);

final chatProvider = StreamProvider.autoDispose<List<MessagesModel>>((ref) {
  final db = FirebaseFirestore.instance;
  return db
      .collection("chatrooms")
      .doc("chatrooms_id")
      .collection("texts")
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map(
        (event) => event.docs
            .map((doc) => MessagesModel.fromJson(doc.data()))
            .toList(),
      );
});
