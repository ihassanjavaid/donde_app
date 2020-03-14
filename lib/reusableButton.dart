import 'package:flutter/material.dart';
import 'constants.dart';

class ReusableButton extends StatelessWidget {
  final String buttonLabel;
  final Function onTap;

  ReusableButton({@required this.buttonLabel, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            buttonLabel,
          ),
        ),
        color: Color(kButtonContainerColour),
        margin: EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: 10.0,
      ),
    );
  }
}
