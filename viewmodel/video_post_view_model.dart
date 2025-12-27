import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktokclone/repos/autentication_repo.dart';
import 'package:ticktokclone/repos/videos_repo.dart';

class VideoPostViewModel extends AsyncNotifier<void> {
  late final VideoRepositoty _repositoty;
  late final String _videoId;

  @override
  FutureOr<void> build() async {
    _repositoty = ref.read(videoRepo);
    _videoId = "";
    // Initialize with actual video ID
    return;
  }

  void initId(String videoId) {
    _videoId = videoId;
  }

  Future<void> likeVideo() async {
    final userId = ref.read(authRepo).user!.uid;
    await _repositoty.likeVideo(_videoId, userId);
  }
}

final videoPostProvider = AsyncNotifierProvider<VideoPostViewModel, void>(
  () => VideoPostViewModel(),
);
