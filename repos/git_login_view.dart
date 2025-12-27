import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktokclone/repos/autentication_repo.dart';
import 'package:ticktokclone/widgets/utils.dart';

class GitLoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> githubSignin(BuildContext context) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _repository.signInWithGitHub(),
    );
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.go("/home");
      // Navigate to home or main screen after successful login
    }
  }
}

final gitSigninProvider = AsyncNotifierProvider<GitLoginViewModel, void>(
  () => GitLoginViewModel(),
);
