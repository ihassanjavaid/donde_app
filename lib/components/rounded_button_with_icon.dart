import 'package:flutter/material.dart';
import 'package:donde/constants.dart';

class RoundedButtonWithIcon extends StatelessWidget {
  final String buttonLabel;
  final VoidCallback onTap;
  final Color colour;
  final IconData icon;

  RoundedButtonWithIcon(
      {@required this.buttonLabel,
      @required this.onTap,
      @required this.colour,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              this.icon,
              color: Colors.white,
            ),
            Text(
              this.buttonLabel,
              style: kButtonTextStyle,
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: this.colour,
        ),
      ),
    );
  }
}
