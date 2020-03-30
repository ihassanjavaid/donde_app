import 'package:flutter/material.dart';
import 'package:donde_app/constants.dart';

class DividerWithText extends StatelessWidget {
  final String text;

  DividerWithText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            thickness: 1.0,
            color: Color(0xffa9a9a9),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            this.text,
            style: kNormalTextStyle,
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1.0,
            color: Color(0xffa9a9a9),
          ),
        ),
      ],
    );
  }
}
