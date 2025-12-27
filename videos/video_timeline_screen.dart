import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktokclone/model/timelineviewmodel.dart';
import 'package:ticktokclone/videos/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  int _itemCount = 0; // Example item count, can be dynamic

  final PageController _pageController = PageController();

  void onPageChanged(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(microseconds: 200),
      curve: Curves.linear,
    );
    if (index == _itemCount - 1) {
      ref.watch(timelineProvider.notifier).fetchNextPage();
      // Last page reached, perform an action if needed
      setState(() {
        // Load more items
      });
    }
  }

  Future<void> _onFresh() async {
    return ref.watch(timelineProvider.notifier).refresh();
  }

  void _onVideoFinished() {
    _pageController.nextPage(
      duration: Duration(microseconds: 300),
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _onRefresh() {
    // Simulate a network call or any asynchronous operation
    return ref.watch(timelineProvider.notifier).refresh();
    // You can add your refresh logic here
  }

  @override
  Widget build(BuildContext contelxt) {
    return ref
        .watch(timelineProvider)
        .when(
          data: (data) {
            _itemCount = data.length;
            return RefreshIndicator(
              displacement: 40,
              edgeOffset: 20,
              onRefresh: _onFresh,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: onPageChanged,
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final videoData = data[index];
                  return VideoPost(
                    index: index,
                    onVideoFinished: _onVideoFinished,
                    videoData: videoData,
                  );
                },
              ),
            );
          },
          error: (error, StackTrace) =>
              Center(child: Text("could not load videos.")),
          loading: () => Center(child: CircularProgressIndicator()),
        );
  }
}
