import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticktokclone/setting/gaps.dart';

class sidecolumnicon extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isLiked;
  const sidecolumnicon({
    super.key,
    required this.text,
    required this.icon,
    required this.isLiked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(icon, color: isLiked ? Colors.red : Colors.white, size: 40),
        Gaps.v6,
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
