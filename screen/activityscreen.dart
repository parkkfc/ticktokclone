import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticktokclone/setting/gaps.dart';
import 'package:ticktokclone/setting/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});
  static const routeUrl = "/activity";
  static const routeName = "activity";

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 300),
  );

  bool _barier = false;

  late final Animation<double> _animation = Tween(
    begin: -0.5,
    end: 0.0,
  ).animate(_animationController);
  final List<String> _notifications = List.generate(20, (index) => "$index");

  late final Animation<Offset> _tileanimation = Tween(
    begin: Offset(0, -1),
    end: Offset(0, 0),
  ).animate(_animationController);

  late final Animation<Color?> _coloranimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black12,
  ).animate(_animationController);

  void _onDismissed(String notifiaction) {
    _notifications.remove(notifiaction);

    setState(() {});
  }

  void _onAppTap() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _barier = !_barier;
    });
  }

  final List<Map<String, dynamic>> _activitylist = [
    {"title": "All activity", "icon": FontAwesomeIcons.solidMessage},
    {"title": "Likes", "icon": FontAwesomeIcons.solidHeart},
    {"title": "Comments", "icon": FontAwesomeIcons.solidComment},
    {"title": "Mentions", "icon": FontAwesomeIcons.at},
    {"title": "Followers", "icon": FontAwesomeIcons.solidUser},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: GestureDetector(
          onTap: _onAppTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("All Activity"),
              Gaps.h10,
              RotationTransition(
                turns: _animation,
                child: FaIcon(FontAwesomeIcons.chevronDown),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              for (var notification in _notifications)
                Dismissible(
                  onDismissed: (Notification) => _onDismissed(notification),
                  key: Key(notification),
                  background: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    color: Colors.teal,
                    child: FaIcon(
                      FontAwesomeIcons.checkDouble,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: FaIcon(
                      FontAwesomeIcons.trashCan,
                      color: Colors.white,
                    ),
                  ),
                  child: ListTile(
                    tileColor: Colors.white,
                    minVerticalPadding: Sizes.size12,
                    leading: Container(
                      alignment: Alignment.center,
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: BoxBorder.all(color: Colors.grey),
                      ),
                      child: FaIcon(FontAwesomeIcons.house),
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: "$notification is good",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: Sizes.size16,
                        ),
                        children: [
                          TextSpan(
                            text: "Welcome to your Business Account",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.normal,
                            ),
                            children: [
                              TextSpan(
                                text: "   53m",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (_barier)
            AnimatedModalBarrier(
              color: _coloranimation,
              dismissible: true,
              onDismiss: _onAppTap,
            ),

          SlideTransition(
            position: _tileanimation,
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var tab in _activitylist)
                    ListTile(
                      leading: FaIcon(tab["icon"]),
                      title: Text(tab["title"]),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
