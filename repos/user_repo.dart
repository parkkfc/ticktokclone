import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktokclone/model/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //create

  Future<void> createProfile(UserProfileModel user) async {
    await _db.collection("users").doc(user.uid).set(user.toJson());
  }
  //data.doc.set--data insert

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }
  //data.doc.get--data get

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).update({"hasAvatar": true});
  }

  Future<void> uploadAvartar(File file, String fileName) async {
    final fileRef = _storage.ref().child("avartars/$fileName");
    //find storage, set path
    await fileRef.putFile(file);
  }

  //
  //get
  //update
  //delete
}

final userRepo = Provider((ref) => UserRepository());
