import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktokclone/repos/autentication_repo.dart';
import 'package:ticktokclone/screen/chatscreen.dart';

class NotificationsProvider extends AsyncNotifier {
  NotificationsProvider(this.context);
  final BuildContext context;

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> updateToken(String token) async {
    final token = await _messaging.getToken();
    final user = ref.read(authRepo).user;
    _db.collection("users").doc(user!.uid).update({"token": token});
  }

  Future<void> initListeners(BuildContext context) async {
    final permission = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (permission.authorizationStatus == AuthorizationStatus.denied) {
      return;
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      context.goNamed(Chatscreen.routeName);
    });
  }

  @override
  FutureOr<void> build() async {
    // Initialization logic if needed
    final token = await _messaging.getToken();
    if (token == null) {
      return null;
    }
    await updateToken(token);
    _messaging.onTokenRefresh.listen((newToken) async {
      await updateToken(newToken);
    });
  }
}

final notificationsProvider = AsyncNotifierProvider.family
    .autoDispose<NotificationsProvider, void, BuildContext>(
      NotificationsProvider.new,
    );
