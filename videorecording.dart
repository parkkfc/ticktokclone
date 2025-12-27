import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ticktokclone/screen/video_preview_screen.dart';
import 'package:ticktokclone/setting/gaps.dart';
import 'package:ticktokclone/setting/sizes.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});
  static const routeUrl = "/videorecording";
  static const routeName = "videorecording";

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController _animationController;
  late final Animation<double> _buttonAnimation;
  bool isPicked = false;

  bool _hasPermission = false;
  CameraController? _cameraController;
  bool _isnotSelfieMode = true;
  bool _isRecording = false;

  late FlashMode _flashMode;

  late final AnimationController _progressAnimationController;

  void _onTapDown(TapDownDetails _) async {
    if (!_isRecording) return;
    _isRecording = true;
    _animationController.forward();
    _progressAnimationController.forward();
    if (_cameraController == null) return;
    await _cameraController!.startVideoRecording();
  }

  void _onTapUp(TapUpDetails _) async {
    _isRecording = false;
    _animationController.reverse();
    _progressAnimationController.reset();
    if (_cameraController == null) return;
    final file = await _cameraController!.stopVideoRecording();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            VideoPreviewScreen(file: file, isPicked: isPicked),
      ),
    );
  }

  void changeCamera() async {
    _isnotSelfieMode = !_isnotSelfieMode;
    await initCamera();

    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    if (_cameraController == null) return;
    await _cameraController!.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;
    _cameraController = CameraController(
      cameras[_isnotSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );
    await _cameraController!.initialize();
    _flashMode = _cameraController!.value.flashMode;
    if (mounted) setState(() {});
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      setState(() {
        _hasPermission = true;
      });
      await initCamera();
    }
  }

  void _stopRecording() {
    _animationController.reset();
    _progressAnimationController.reset();
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    initPermissions();
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _buttonAnimation = Tween(
      begin: 1.0,
      end: 1.3,
    ).animate(_animationController);

    _progressAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    _progressAnimationController.addListener(() {
      setState(() {});
    });

    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
    _cameraController!.dispose();
  }

  Future<void> _galleryButton() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (video == null) {
      return;
    }

    isPicked = true;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            VideoPreviewScreen(file: video, isPicked: isPicked),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_hasPermission) return;
    if (!_cameraController!.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      if (!_isRecording) _cameraController!.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (!_cameraController!.value.isInitialized) initCamera();
    }
  }

  Future<void> _drag(DragUpdateDetails details) async {
    final xZoom = await _cameraController!.getMaxZoomLevel();
    final mZoom = await _cameraController!.getMaxZoomLevel();
    final minZoom = mZoom;
    final maxZoom = xZoom;
    var curZoom = 1.0;

    if (!_cameraController!.value.isInitialized) return;

    curZoom -= details.delta.dy * 0.01;
    curZoom = curZoom.clamp(minZoom, maxZoom);
    _cameraController!.setZoomLevel(curZoom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: _hasPermission
          ? (_cameraController != null &&
                    _cameraController!.value.isInitialized)
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      CameraPreview(_cameraController!),
                      Positioned(
                        right: Sizes.size28,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () => changeCamera(),
                              icon: FaIcon(
                                FontAwesomeIcons.rotate,
                                color: Colors.white,
                                size: Sizes.size40,
                              ),
                            ),
                            Gaps.v16,
                            IconButton(
                              onPressed: () => _setFlashMode(FlashMode.auto),
                              icon: FaIcon(
                                FontAwesomeIcons.lightbulb,
                                color: _flashMode == FlashMode.auto
                                    ? Colors.amber
                                    : Colors.white,
                                size: Sizes.size40,
                              ),
                            ),
                            Gaps.v16,
                            IconButton(
                              onPressed: () => _setFlashMode(FlashMode.off),
                              icon: FaIcon(
                                FontAwesomeIcons.boltLightning,
                                color: _flashMode == FlashMode.off
                                    ? Colors.amber
                                    : Colors.white,
                                size: Sizes.size40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: Sizes.size20,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Spacer(),
                            Center(
                              child: GestureDetector(
                                onVerticalDragUpdate: (details) =>
                                    _drag(details),
                                onTapUp: _onTapUp,
                                onTapDown: _onTapDown,
                                child: ScaleTransition(
                                  scale: _buttonAnimation,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: Sizes.size80,
                                        height: Sizes.size80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                      ),

                                      SizedBox(
                                        width: Sizes.size80 + 20,
                                        height: Sizes.size80 + 20,
                                        child: CircularProgressIndicator(
                                          value: _progressAnimationController
                                              .value,
                                          strokeWidth: Sizes.size10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Center(
                                child: IconButton(
                                  onPressed: _galleryButton,
                                  icon: FaIcon(FontAwesomeIcons.photoFilm),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: Sizes.size10,
                        child: CloseButton(color: Colors.white),
                      ),
                    ],
                  )
                : const Center(child: CircularProgressIndicator())
          : Center(
              child: Text(
                "has not permitted",
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}
