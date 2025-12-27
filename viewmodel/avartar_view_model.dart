import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktokclone/model/user_view_model.dart';
import 'package:ticktokclone/repos/autentication_repo.dart';
import 'package:ticktokclone/repos/user_repo.dart';

class AvartarViewModel extends AsyncNotifier<void> {
  late final UserRepository _repository;

  Future<void> upLoadAvatar(File file) async {
    state = AsyncValue.loading();
    final fileName = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(() async {
      await _repository.uploadAvartar(file, fileName);
      await ref.read(usersProvider.notifier).onAvatarUpdate();
    });
  }

  @override
  FutureOr<void> build() {
    _repository = ref.read(userRepo);
  }
}

final avatarProvider = AsyncNotifierProvider<AvartarViewModel, void>(
  () => AvartarViewModel(),
);
