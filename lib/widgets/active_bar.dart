import 'package:flutter/material.dart';

class ActiveColorBar extends StatelessWidget {
  final Color activeColor;
  final Color bgColor;
  final double activeColorWidth;
  ActiveColorBar({
    this.activeColor,
    this.activeColorWidth,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: activeColorWidth,
      height: 8.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: activeColor,
      ),
    );
  }
}
