import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticktokclone/setting/sizes.dart';

class PostVideoButton extends StatelessWidget {
  bool isHome;
  PostVideoButton({super.key, required this.isHome});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 10,
          child: Container(
            width: 40,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size10),
              color: Colors.blue,
            ),

            child: Text(""),
          ),
        ),
        Positioned(
          left: 10,
          child: Container(
            width: 40,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size10),
              color: Colors.red,
            ),

            child: Text(""),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            alignment: Alignment.center,
            width: 40,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size10),
              color: isHome ? Colors.white : Colors.black,
            ),
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: isHome ? Colors.black : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
