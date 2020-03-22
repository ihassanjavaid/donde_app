import 'dart:io';

import 'package:donde_app/components/settingsWidget.dart';
import 'package:donde_app/screens/login.dart';
import 'package:donde_app/screens/resetPassword.dart';
import 'package:donde_app/services/userData.dart';
import 'package:donde_app/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

// setting file
class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';
  final String phoneNumber;

  SettingsScreen({this.phoneNumber});

  @override
  _SettingsScreenState createState() => _SettingsScreenState(phoneNumber: this.phoneNumber);
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserData userData;
  String phoneNumber;

  _SettingsScreenState({this.phoneNumber});

  void _acquireUserData() async {
    final data = await StoreFunc.getCurrentUserData();
    setState(() {
      userData = data;
    });
  }


  @override
  void initState() {
    super.initState();
    _acquireUserData();
  }

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
              margin: EdgeInsets.only(bottom: 35.0, right: 10.0, left: 10.0/*, top: 25.0*/),
              child: AutoSizeText(
                userData != null ? userData.displayName : 'Anonymous',
                style: kSettingsTextStyle,
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
            /*SettingWidget(
              onTap: () {},
              icon: FontAwesomeIcons.filter,
              label: 'Filter',
              colour: Color(kDefaultBackgroundColour),
            ),*/
            SettingWidget(
              onTap: () {
                Navigator.pushNamed(context, ResetPassword.id);
              },
              icon: FontAwesomeIcons.lock,
              label: 'Security',
              colour: Color(kDefaultBackgroundColour),
            ),
            SettingWidget(
              onTap: () {
                // TODO Add notification toggle
              },
              icon: FontAwesomeIcons.solidBell,
              label: 'Notification',
              colour: Color(kDefaultBackgroundColour),
              canToggle: true,
              toggle: true,
            ),
            SettingWidget(
              onTap: () {
                logOutUser();
                //Navigator.pushNamed();
              },
              icon: FontAwesomeIcons.doorOpen,
              label: 'Logout',
              colour: Color(kDefaultBackgroundColour),
            ),
            /*SettingWidget(
              onTap: () {
              },
              icon: FontAwesomeIcons.language,
              label: 'Language',
              colour: Color(kDefaultBackgroundColour),
            ),*/
          ],
        ),
      ),
    );
  }

  logOutUser(){
    return Alert(
      context: context,
      type: AlertType.warning,
      title: "Logout?",
      desc: "Are you sure to want to logout?",
      buttons: [
        DialogButton(
          color: Colors.redAccent,
          child: Text(
            "Logout",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed : () {
            _logOutAndRemoveUser();
          },
          width: 120,
        )
      ],
    ).show();
  }

  void _logOutAndRemoveUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('phoneNumber');
    Navigator.pop(context);
    Navigator.popAndPushNamed(context, Login.id);
  }

}
