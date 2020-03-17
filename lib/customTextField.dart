import 'package:flutter/material.dart';

/*
* A widget housing bordered input box with text holder that moves on tap. The
* widget allows the customization of its text colour, placeholder colour and
* active border colour.
*
* */
class CustomTextField extends StatelessWidget {
  final String placeholder;
  final Color cursorColor;
  final Color placeholderColor;
  final Color focusedOutlineBorder;

  CustomTextField(
      {@required this.placeholder,
      this.cursorColor = Colors.red,
      this.placeholderColor = Colors.red,
      this.focusedOutlineBorder = Colors.redAccent});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: this.cursorColor,
      decoration: InputDecoration(
        labelText: this.placeholder,
        hasFloatingPlaceholder: true,
        labelStyle: TextStyle(
          color: this.placeholderColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: this.focusedOutlineBorder,
          ),
        ),
      ),
    );
  }
}
