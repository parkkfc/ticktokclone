import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticktokclone/setting/sizes.dart';
import 'package:ticktokclone/videorecording.dart';

class FlashButton extends StatelessWidget {
  FlashButton({
    super.key,
    required this.flashIcon,
    required this.color,
    required this.onPressed,
  });

  IconData flashIcon;
  Color color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: FaIcon(flashIcon, color: color, size: Sizes.size40),
    );
  }
}
