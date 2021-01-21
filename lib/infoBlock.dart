import 'package:flutter/material.dart';

class InfoBlock extends StatelessWidget {
  final int number;
  final Color color;
  final String title;
  const InfoBlock({
    Key key,
    this.number,
    this.color,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(6),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.26),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: color,
                width: 2,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          "$number",
          style: TextStyle(
            fontSize: 25,
            color: color,
          ),
        ),
        Text(title, style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
      ],
    );
  }
}


