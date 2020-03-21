import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donde_app/components/settingsWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';
import 'package:donde_app/services/user.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  QuerySnapshot data = User.getCurrentUserData();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                'Settings',
                style: kSettingsTextStyle,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15.0),
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
            Container(
              margin: EdgeInsets.only(bottom: 25.0),
              child: Text(
                'AMIR JAFRI',
                style: kSettingsTextStyle,
              ),
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
    );
  }
}
