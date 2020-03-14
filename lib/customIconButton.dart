import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';

class CustomIconButton extends StatelessWidget {
  final String buttonLabel;
  final Function onTap;
  final Color colour;
  final IconData icon;

  CustomIconButton(
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
        margin: EdgeInsets.symmetric(vertical: 15.0),
//      width: double.infinity,
        height: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: this.colour,
        ),
      ),
    );
  }
}
