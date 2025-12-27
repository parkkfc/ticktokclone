import 'package:flutter/material.dart';
import 'package:ticktokclone/setting/sizes.dart';

class FormButton extends StatelessWidget {
  FormButton({super.key, required this.isInput, required this.disabled});
  final bool isInput;
  late bool disabled;

  @override
  Widget build(BuildContext context) {
    if (disabled) {
      return Text("Disabled");
    } else {
      return AnimatedContainer(
        duration: Duration(seconds: 1),
        alignment: Alignment.center,
        height: Sizes.size48,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: isInput ? Theme.of(context).primaryColor : Colors.white,
        ),
        child: AnimatedDefaultTextStyle(
          duration: Duration(seconds: 1),
          style: TextStyle(
            fontSize: Sizes.size24,
            color: isInput ? Colors.white : Colors.grey,
          ),
          child: Text("Next"),
        ),
      );
    }
  }
}
