import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktokclone/model/user_view_model.dart';
import 'package:ticktokclone/repos/autentication_repo.dart';
import 'package:ticktokclone/screen/interests.dart';
import 'package:ticktokclone/screen/mainnavigation.dart';
import 'package:ticktokclone/sourcefile/interestssource.dart';
import 'package:ticktokclone/widgets/utils.dart';

class SignupViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signup(BuildContext context) async {
    state = AsyncValue.loading();
    final form = ref.read(signupForm);
    final users = ref.read(usersProvider.notifier);
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.signUp(
        form["email"],
        form["password"],
      );

      await users.createAccount(userCredential);
    });
    if (state.hasError) {
      
      showFirebaseErrorSnack(context, state.error);
    }
    context.goNamed(Interests.routeName);
  }
}

final signupForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignupViewModel, void>(
  () => SignupViewModel(),
);
