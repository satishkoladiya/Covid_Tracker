import 'package:flutter/material.dart';

import 'active_bar.dart';

class ColorBar extends StatelessWidget {
  final double colorBarWidth;
  final Color color;

  ColorBar({this.colorBarWidth, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - 40.0,
            height: 8.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: color.withOpacity(0.2),
            ),
          ),
          ActiveColorBar(
            activeColor: color,
            bgColor: color.withOpacity(0.5),
            activeColorWidth: colorBarWidth,
          ),
        ],
      ),
    );
  }
}
