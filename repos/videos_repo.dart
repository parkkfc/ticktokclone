import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktokclone/model/video_model.dart';

class VideoRepositoty {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> savaVideo(VideoModel data) async {
    await _db.collection("videos").add(data.toJson());
  }

  UploadTask uploadVideoFile(File video, String uid) {
    final fileRef = _storage.ref().child(
      "/videos/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}",
    );
    return fileRef.putFile(video);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchvideos({
    int? lastItem,
  }) async {
    final query = _db
        .collection("videos")
        .orderBy("createdAt", descending: true)
        .limit(2);
    if (lastItem == null) {
      return await query.get();
    }
    return await query.startAfter([lastItem]).get();
  }

  Future<void> likeVideo(String videoId, String userId) async {
    final query = _db.collection("likes").doc("${videoId}000$userId");

    final like = await query.get();

    if (!like.exists) {
      await query.set({"createdAt": DateTime.now().millisecondsSinceEpoch});
    } else {
      await query.delete();
    }
  }
}

final videoRepo = Provider((ref) => VideoRepositoty());
