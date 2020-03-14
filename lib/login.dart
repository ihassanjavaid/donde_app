import 'package:flutter/material.dart';
import 'constants.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(
              'Hello',
              style: kWelcomeText,
            ),
            Text(
              'Get started, Enter your phone number',
              style: kSubtitle,
            ),
          ],
        ),
      ),
    );
  }
}
