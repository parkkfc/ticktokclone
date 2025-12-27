import 'package:flutter/material.dart';
import 'package:ticktokclone/setting/sizes.dart';

class change_bio_button extends StatelessWidget {
  const change_bio_button({
    super.key,
    required this.isMan,
    required this.mytext,
  });

  final bool isMan;
  final String mytext;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      alignment: Alignment.center,
      height: Sizes.size48,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isMan ? Theme.of(context).primaryColor : Colors.grey[350],
      ),
      child: Text(
        mytext,
        style: TextStyle(color: Colors.white, fontSize: Sizes.size28),
      ),
    );
  }
}
