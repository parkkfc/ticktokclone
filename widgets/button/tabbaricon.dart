import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticktokclone/setting/sizes.dart';

class TabbarIcon extends StatelessWidget {
  bool isHome = false;
  bool isSelected = false;
  late final IconData icon;
  late final String label;
  IconData selectedIcon;
  Function onTap;

  TabbarIcon({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.onTap,
    required this.label,
    required this.selectedIcon,
    required this.isHome,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: AnimatedOpacity(
          opacity: isSelected ? 1.0 : 0.6,
          duration: Duration(milliseconds: 300),
          child: Container(
            color: isHome ? Colors.black : Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? icon : selectedIcon,
                  size: Sizes.size24,
                  color: isHome ? Colors.white : Colors.black,
                ),
                Text(
                  label,
                  style: TextStyle(color: isHome ? Colors.white : Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
