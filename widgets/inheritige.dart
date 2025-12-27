import 'package:flutter/material.dart';

// class VideoConfig extends ChangeNotifier {
//   bool autoMute = false;

//   void toggleAutoMute() {
//     autoMute = !autoMute;
//     notifyListeners();
//   }
// }

// final videoConfig = VideoConfig();

// class VideoConfig extends InheritedWidget {
//   final bool autoMute;
//   final Function toggleAutoMute;

//   const VideoConfig({
//     super.key,
//     required this.autoMute,
//     required this.toggleAutoMute,
//     required super.child,
//   });

//   static VideoConfig of(BuildContext context) {
//     final VideoConfig? result =
//         context.dependOnInheritedWidgetOfExactType<VideoConfig>();
//     assert(result != null, 'No VideoConfig found in context');
//     return result!;
//   }

//   @override
//   bool updateShouldNotify(VideoConfig oldWidget) {
//     return autoMute != oldWidget.autoMute;
//   }
// }

class VideoConfig extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoplay = false;

  void toggleIsMuted() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleIsAutoplay() {
    isAutoplay = !isAutoplay;
    notifyListeners();
  }
}
