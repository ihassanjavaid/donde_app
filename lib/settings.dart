import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'customIconButton.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Settings',
                style: kWelcomeTextStyle,
              ),
              Container(
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
              Text(
                'NAME',
                style: kWelcomeTextStyle,
              ),
              CustomIconButton(
                onTap: () {},
                colour: Color(0xff00dd00),
                icon: FontAwesomeIcons.filter,
                buttonLabel: 'Filter',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
