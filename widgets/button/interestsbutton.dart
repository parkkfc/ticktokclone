import 'package:flutter/material.dart';

class interestsbutton extends StatefulWidget {
  const interestsbutton({super.key, required this.interst});
  final String interst;

  @override
  State<interestsbutton> createState() => _interestsbuttonState();
}

class _interestsbuttonState extends State<interestsbutton> {
  void onPressed() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  // Variable to track selection state
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.white,
          border: Border.all(color: Colors.black26),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(widget.interst, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
