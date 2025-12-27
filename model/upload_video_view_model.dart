import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktokclone/model/user_view_model.dart';
import 'package:ticktokclone/model/video_model.dart';
import 'package:ticktokclone/repos/autentication_repo.dart';
import 'package:ticktokclone/repos/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideoRepositoty _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(videoRepo);
  }

  Future<void> uploadVideo(File video, BuildContext context) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(usersProvider).value;
    if (userProfile != null) {
      state = AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final task = await _repository.uploadVideoFile(video, user!.uid);
        if (task.metadata != null) {
          await _repository.savaVideo(
            VideoModel(
              id: "",
              description: "first video",
              fileUrl: await task.ref.getDownloadURL(),
              thumbnailUrl: "",
              creatorUid: user.uid,
              like: 0,
              comments: 0,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              title: "from flutter",
            ),
          );
          context.pushReplacement("/home");
        }
      });
    }
  }
}

final UploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
