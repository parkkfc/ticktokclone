import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktokclone/screen/discover.dart';
import 'package:ticktokclone/screen/inbox.dart';
import 'package:ticktokclone/screen/stfscreen.dart';
import 'package:ticktokclone/screen/userprofile.dart';
import 'package:ticktokclone/setting/gaps.dart';
import 'package:ticktokclone/setting/sizes.dart';
import 'package:ticktokclone/videorecording.dart';
import 'package:ticktokclone/videos/video_timeline_screen.dart';
import 'package:ticktokclone/videos/widgets/video_post.dart';
import 'package:ticktokclone/widgets/button/post_video_button.dart';
import 'package:ticktokclone/widgets/button/tabbaricon.dart';

class MainnavigationScreen extends StatefulWidget {
  const MainnavigationScreen({super.key, required this.tab});
  final tab;
  static const String routeName = "Mainnavigation";
  @override
  State<MainnavigationScreen> createState() => _MainnavigationScreenState();
}

class _MainnavigationScreenState extends State<MainnavigationScreen> {
  final List<String> tabs = ["home", "discover", "xxxxxx", "inbox", "profile"];

  late int _selected = tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${tabs[index]}");
    setState(() {
      _selected = index;
    });
  }

  void _onPostVideoTap() {
    // Handle post video button tap
    context.pushNamed(VideoRecordingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(offstage: _selected != 0, child: VideoTimelineScreen()),
          Offstage(offstage: _selected != 1, child: DiscovoerScreen()),
          Offstage(offstage: _selected != 2, child: VideoRecordingScreen()),
          Offstage(offstage: _selected != 3, child: InboxScreen()),
          Offstage(
            offstage: _selected != 4,
            child: UserprofileScreen(username: "Lice"),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selected == 0 ? Colors.black : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabbarIcon(
              isHome: _selected == 0 ? true : false,
              selectedIcon: FontAwesomeIcons.houseChimney,
              onTap: () => _onTap(0),
              isSelected: _selected == 0,
              icon: FontAwesomeIcons.house,
              label: "Home",
            ),
            TabbarIcon(
              isHome: _selected == 0 ? true : false,
              selectedIcon: FontAwesomeIcons.magnifyingGlassArrowRight,
              onTap: () => _onTap(1),
              isSelected: _selected == 1,
              icon: FontAwesomeIcons.magnifyingGlass,
              label: "serch",
            ),
            Gaps.h16,
            GestureDetector(
              onTap: _onPostVideoTap,
              child: PostVideoButton(isHome: _selected == 0 ? true : false),
            ),
            Gaps.h16,
            TabbarIcon(
              isHome: _selected == 0 ? true : false,
              selectedIcon: FontAwesomeIcons.industry,
              onTap: () => _onTap(3),
              isSelected: _selected == 3,
              icon: FontAwesomeIcons.inbox,
              label: "inbox",
            ),
            TabbarIcon(
              isHome: _selected == 0 ? true : false,
              selectedIcon: FontAwesomeIcons.userAstronaut,
              onTap: () => _onTap(4),
              isSelected: _selected == 4,
              icon: FontAwesomeIcons.user,
              label: "profile",
            ),
          ],
        ),
      ),
    );
  }
}
