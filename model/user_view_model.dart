import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktokclone/model/user_profile_model.dart';
import 'package:ticktokclone/repos/autentication_repo.dart';
import 'package:ticktokclone/repos/signup_view_model.dart';
import 'package:ticktokclone/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authenticationRepository;
  @override
  FutureOr<UserProfileModel> build() async {
    _userRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _userRepository.findProfile(
        _authenticationRepository.user!.uid,
      );
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }

    return UserProfileModel.empty();
  }

  Future<void> onAvatarUpdate() async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    print(
      "${state.value!.bio},${state.value!.email},${state.value!.hasAvatar},${state.value!.link},${state.value!.name},${state.value!.uid}",
    );
    await _userRepository.updateUser(ref.read(authRepo).user!.uid, {
      "hasAvatar": true,
    });
  }
  // User-related properties and methods

  Future<void> createAccount(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception("error");
    }
    state = AsyncValue.loading();
    final profile = UserProfileModel(
      hasAvatar: false,
      email: credential.user!.email ?? "anon",
      bio: "${ref.read(signupForm.notifier).state["bio"]}",
      link: "undefind",
      uid: credential.user!.uid,
      name: credential.user!.displayName ?? "anon",
    );
    await _userRepository.createProfile(profile);

    state = AsyncValue.data(profile);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () {
    return UsersViewModel();
  },
);
