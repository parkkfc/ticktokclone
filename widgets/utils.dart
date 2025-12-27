import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

bool isDarkMode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;

void showFirebaseErrorSnack(BuildContext context, Object? error) {
  final snack = SnackBar(
    content: Text(
      (error as FirebaseException).message ?? "Something wen't wroong",
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}
