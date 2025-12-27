import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:ticktokclone/model/timelineviewmodel.dart';
import 'package:ticktokclone/model/upload_video_view_model.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
  final XFile file;
  bool isPicked;
  VideoPreviewScreen({super.key, required this.file, required this.isPicked});

  @override
  VideoPreviewScreenState createState() => VideoPreviewScreenState();
}

class VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;
  bool _savedVideo = false;

  Future<void> _initVideo() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.file.path));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initVideo();
  }

  Future<void> _saveToGallery() async {
    await GallerySaver.saveVideo(widget.file.path, albumName: "ticktok video");
    _savedVideo = false;
    setState(() {});
  }

  void _onUploadPressed(BuildContext context) async {
    ref
        .read(UploadVideoProvider.notifier)
        .uploadVideo(File(widget.file.path), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview video"),
        actions: [
          if (!widget.isPicked)
            IconButton(
              onPressed: _saveToGallery,
              icon: _savedVideo
                  ? FaIcon(FontAwesomeIcons.check)
                  : FaIcon(FontAwesomeIcons.download),
            ),

          IconButton(
            onPressed: ref.watch(UploadVideoProvider).isLoading
                ? () {}
                : _saveToGallery,
            icon: ref.watch(UploadVideoProvider).isLoading
                ? CircularProgressIndicator()
                : FaIcon(FontAwesomeIcons.cloudArrowUp),
          ),
        ],
      ),
      body: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController)
          : null,
    );
  }
}
