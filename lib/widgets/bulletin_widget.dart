import 'package:flutter/material.dart';

class BulletinWidget extends StatelessWidget {
  final String title;
  final int caseCount;
  final Color dotColor;

  BulletinWidget({this.title, this.caseCount, this.dotColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 1.0, right: 1.0, top: 8.0),
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.fiber_manual_record,
              size: 20,
              color: dotColor,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: Text(
          '$caseCount',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),
      ),
    );
  }
}
