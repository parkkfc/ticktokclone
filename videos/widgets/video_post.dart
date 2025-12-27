import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ticktokclone/model/video_model.dart';
import 'package:ticktokclone/setting/gaps.dart';
import 'package:ticktokclone/setting/sizes.dart';
import 'package:ticktokclone/viewmodel/playback_config_vm.dart';
import 'package:ticktokclone/viewmodel/video_post_view_model.dart';
import 'package:ticktokclone/widgets/button/videosidebutton.dart';
import 'package:ticktokclone/widgets/inheritige.dart';
import 'package:ticktokclone/widgets/talktab.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  const VideoPost({
    super.key,
    required this.videoData,
    required this.index,
    required this.onVideoFinished, 
  });
  final VideoModel videoData;
  final int index;
  final Function onVideoFinished;

  @override
  ConsumerState<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends ConsumerState<VideoPost>
    with TickerProviderStateMixin {
  bool _isLiked = false;
  late bool _isVolumeon;
  late AnimationController _animationController;
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset('assets/videos/background.mp4');
  // Example index, can be replaced with actual index

  void _initVideoPlayer() async {
    if (kIsWeb) {
      setState(() {
        _isVolumeon = false;
      });
      await _videoPlayerController.setVolume(0);
    }
    await _videoPlayerController.initialize();

    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  void _playTap() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initVideoPlayer();
    _isLikedHeart();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: Duration(milliseconds: 300),
    );
  }

  void _isLikedHeart() {
    if (widget.videoData.like > 0) {
      _isLiked = true;
    }
    setState(() {});
  }

  void _onPlaybackConfigChanged() {
    if (!mounted) return;
    if (false) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;

    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      if (false) {
        _videoPlayerController.play();
      }
    }
    if (info.visibleFraction == 0 && _videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    }
  }

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _onTalkTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      setState(() {});
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TalkTab(),
      barrierColor: Colors.transparent,
    );
  }

  void _onVolumeTap() {
    _isVolumeon = false;
    if (!_isVolumeon) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1.0);
    }
  }

  void _onLikeTap() {
    ref.read(videoPostProvider.notifier).initId(widget.videoData.id);
    ref.read(videoPostProvider.notifier).likeVideo();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      onVisibilityChanged: _onVisibilityChanged,
      key: Key('${widget.index}'),
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(color: Colors.black),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _playTap,
              child: Container(color: Colors.transparent),
            ),
          ),

          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animationController.value,
                    child: child,
                  );
                },
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _videoPlayerController.value.isPlaying ? 0.0 : 1.0,
                  child: Center(
                    child: FaIcon(
                      _videoPlayerController.value.isPlaying
                          ? FontAwesomeIcons.circlePause
                          : FontAwesomeIcons.circlePlay,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@${widget.videoData.creatorUid}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v16,
                Text(
                  "this is my future island.....",
                  style: TextStyle(fontSize: Sizes.size14, color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            top: 50,
            child: IconButton(
              onPressed: () {},

              icon: FaIcon(
                false
                    ? FontAwesomeIcons.volumeHigh
                    : FontAwesomeIcons.volumeOff,
                color: Colors.white,
                size: Sizes.size44,
              ),
            ),
          ),

          Positioned(
            right: 20,
            bottom: 30,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/newworld-e5f58.firebasestorage.app/o/avartars%2F${widget.videoData.creatorUid}?alt=media",
                  ),
                  radius: 25,
                  child: Text(widget.videoData.creatorUid),
                ),
                Gaps.v14,
                GestureDetector(
                  onTap: _onLikeTap,
                  child: sidecolumnicon(
                    icon: FontAwesomeIcons.solidHeart,
                    isLiked: _isLiked,
                    text: "${widget.videoData.like}",
                  ),
                ),
                Icon(FontAwesomeIcons.share),
                GestureDetector(
                  onTap: () => _onTalkTap(context),
                  child: Icon(FontAwesomeIcons.walkieTalkie),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
