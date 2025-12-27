import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktokclone/model/video_model.dart';
import 'package:ticktokclone/repos/videos_repo.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> list = [];
  late final VideoRepositoty _repository;

  @override
  FutureOr<List<VideoModel>> build() async {
    _repository = ref.read(videoRepo);

    final list = await _fetchVideos(lastItem: null);

    return list;
  }

  Future<List<VideoModel>> _fetchVideos({int? lastItem}) async {
    final result = await _repository.fetchvideos(lastItem: lastItem);
    final newList = result.docs.map(
      (video) => VideoModel.fromJson(video.data(), video.id),
    );
    return newList.toList();
  }

  Future<void> fetchNextPage() async {
    final nextPage = await _fetchVideos(lastItem: list.last.createdAt);
    state = AsyncValue.data([...list, ...nextPage]);
  }

  Future<void> refresh() async {
    final videos = await _fetchVideos(lastItem: null);
    list = videos;
    state = AsyncValue.data(videos);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
      () => TimelineViewModel(),
    );
