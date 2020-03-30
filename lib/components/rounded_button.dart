import 'package:flutter/material.dart';
import 'package:donde_app/constants.dart';

class RoundedButton extends StatelessWidget {
  final String buttonLabel;
  final Function onTap;
  final Color colour;

  RoundedButton(
      {@required this.buttonLabel,
      @required this.onTap,
      @required this.colour});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        child: Center(
          child: Text(
            this.buttonLabel,
            style: kButtonTextStyle,
          ),
        ),
        margin: EdgeInsets.symmetric(vertical: 15.0),
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: this.colour,
        ),
      ),
    );
  }
}
