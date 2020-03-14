import 'package:flutter/material.dart';
import 'constants.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                'Settings',
                style: kWelcomeText,
              ),
            ),
            Center(
              child: Container(
                width: 190.0,
                height: 190.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage("https://i.imgur.com/BoN9kdC.png"),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                'NAME',
                style: kWelcomeText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
