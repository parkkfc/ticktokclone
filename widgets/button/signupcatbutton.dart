import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticktokclone/setting/sizes.dart';

class signupcatbutton extends StatelessWidget {
  final String signUpCat;
  final IconData icon;
  final Color? colorData;
  final void Function(BuildContext) func;

  const signupcatbutton({
    super.key,
    required this.signUpCat,
    required this.icon,
    this.colorData,
    required this.func,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: GestureDetector(
        onTap: () => func(context),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: BoxBorder.all(color: Colors.black45),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: FaIcon(icon, size: Sizes.size24),
              ),
              Text(
                signUpCat,
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
