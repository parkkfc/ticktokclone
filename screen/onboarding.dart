import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktokclone/screen/mainnavigation.dart';
import 'package:ticktokclone/setting/gaps.dart';
import 'package:ticktokclone/setting/sizes.dart';

enum ScrollDirection { right, left }

enum Page { first, second }

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  ScrollDirection _direction = ScrollDirection.right;
  Page _currentPage = Page.first;
  void onPanEnd(DragEndDetails details) {
    if (_direction == ScrollDirection.right) {
      // Navigate to the next page or perform an action
      setState(() {
        _currentPage = Page.first;
      });
    } else {
      // Navigate to the previous page or perform an action
      setState(() {
        _currentPage = Page.second;
      });
    }
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      //right

      setState(() {
        _direction = ScrollDirection.right;
      });
    } else {
      setState(() {
        _direction = ScrollDirection.left;
      });
      //left
    }
  }

  void _onNext() {
    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(builder: (context) => MainnavigationScreen()),
    //   (route) => false,
    // );
    context.goNamed(MainnavigationScreen.routeName);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _currentPage = Page.first;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: Scaffold(
        body: SafeArea(
          child: AnimatedCrossFade(
            duration: Duration(milliseconds: 300),
            firstChild: Column(
              children: [
                Column(
                  children: [
                    Text(
                      "Follow the steps to get started",
                      style: TextStyle(
                        fontSize: Sizes.size28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v28,
                    Text(
                      "videos are personalized for you based on what you watch, like, and share.",
                      style: TextStyle(fontSize: Sizes.size20),
                    ),
                  ],
                ),
              ],
            ),
            secondChild: Column(
              children: [
                Column(
                  children: [
                    Text(
                      "Hello, welcome to TikTok Clone",
                      style: TextStyle(
                        fontSize: Sizes.size28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v28,
                    Text(
                      "Thanks for joining us! Let's get started.",
                      style: TextStyle(fontSize: Sizes.size20),
                    ),
                  ],
                ),
              ],
            ),
            crossFadeState: _currentPage == Page.first
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: _currentPage == Page.first ? 0.0 : 1.0,
            child: CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: Sizes.size60),
              onPressed: _onNext,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  "get start",
                  style: TextStyle(color: Colors.white, fontSize: Sizes.size20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
