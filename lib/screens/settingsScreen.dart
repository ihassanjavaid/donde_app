import 'package:donde_app/components/settingsWidget.dart';
import 'package:donde_app/screens/resetPassword.dart';
import 'package:donde_app/services/userData.dart';
import 'package:donde_app/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

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

  Future<void> _acquireUserData() async {
    print('Entering Test area');
    /*SharedPreferences prefs = await SharedPreferences.getInstance();
    final phoneNo = prefs.getString('phoneNumber'); */
    final data = await StoreFunc.getCurrentUserData(this.phoneNumber);

    setState(() {
      userData = data;
    });

    print(phoneNumber);
    print(userData);
  }

  void acquireUserData() {
    _acquireUserData();
  }

  @override
  void initState() {
    super.initState();
    acquireUserData();
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
              margin: EdgeInsets.only(bottom: 25.0),
              child: Text(
                userData != null ? userData.displayName : 'Anonymous',
                style: kSettingsTextStyle,
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
}
