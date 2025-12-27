import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Stfscreen extends StatefulWidget {
  const Stfscreen({super.key});

  @override
  State<Stfscreen> createState() => _StfscreenState();
}

class _StfscreenState extends State<Stfscreen> {
  int i = 0;

  void onTap() {
    setState(() {
      i++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "This is the STFScreen",
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
          Text("$i", style: TextStyle(fontSize: 24, color: Colors.black)),
          GestureDetector(
            onTap: onTap,
            child: FaIcon(FontAwesomeIcons.plus, size: 24, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
