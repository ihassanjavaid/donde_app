import 'package:donde_app/settingsWidget.dart';
import 'package:flutter/cupertino.dart';
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
                style: kSettingsTextStyle,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://i.ya-webdesign.com/images/funny-png-avatar-2.png"),
                  ),
                ),
              ),
              Text(
                'NAME',
                style: kSettingsTextStyle,
              ),
              SettingWidget(
                onTap: () {},
                icon: FontAwesomeIcons.filter,
                label: 'Filter',
                colour: Color(kDefaultBackgroundColour),
              ),
              SettingWidget(
                onTap: () {},
                icon: FontAwesomeIcons.lock,
                label: 'Security',
                colour: Color(kDefaultBackgroundColour),
              ),
              SettingWidget(
                onTap: () {},
                icon: FontAwesomeIcons.solidBell,
                label: 'Notification',
                colour: Color(kDefaultBackgroundColour),
                canToggle: true,
                toggle: true,
              ),
              SettingWidget(
                onTap: () {},
                icon: FontAwesomeIcons.language,
                label: 'Language',
                colour: Color(kDefaultBackgroundColour),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
