import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:donde_app/utilities/user_data.dart';
import 'package:flutter/material.dart';
import 'package:donde_app/services/firestore_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:donde_app/screens/reset_password_screen.dart';
import 'package:donde_app/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../components/settings_control.dart';
import 'login_screen.dart';

class Settings extends StatefulWidget {
  static const String id = 'settings_screen';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  UserData userData;
  String phoneNumber;
  bool toggleNotification = true;
  final FirestoreService _firestoreService = FirestoreService();

  void _acquireUserData() async {
    final data = await _firestoreService.getCurrentUserData();
    setState(() {
      userData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _acquireUserData();
  }

  logOutUser() {
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
          onPressed: () {
            _logOutAndRemoveUser();
          },
          width: 120,
        )
      ],
    ).show();
  }

  shareApp() {
    return Alert(
      context: context,
      type: AlertType.success,
      title: "Share!",
      // TODO Add google drive link here after generating final version of APK
      desc: "Link will be added soon!",
      buttons: [
        DialogButton(
          color: Colors.redAccent,
          child: Text(
            "Done!",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
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
    Navigator.popAndPushNamed(context, LoginScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
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
                  child: CircularProfileAvatar(
                    "",
                    backgroundColor: Colors.grey,
                    initialsText: Text(
                      userData != null ? userData.displayName[0] : "A",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                    elevation: 8.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 5, right: 10.0, left: 10.0 /*, top: 25.0*/),
                  child: AutoSizeText(
                    userData != null ? userData.displayName : 'Anonymous',
                    style: kSettingsTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 35.0, right: 10.0, left: 10.0 /*, top: 25.0*/),
                  child: AutoSizeText(
                    userData != null ? userData.phoneNumber : '+-- -- -------',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.8,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView(
              children: <Widget>[
                SettingsControl(
                  onTap: () {
                    Navigator.pushNamed(context, ResetPasswordScreen.id);
                  },
                  icon: FontAwesomeIcons.lock,
                  label: 'Security',
                  colour: Color(kDefaultBackgroundColour),
                ),
                SettingsControl(
                  onTap: () {
                    setState(() {
                      this.toggleNotification = !this.toggleNotification;
                    });
                  },
                  icon: FontAwesomeIcons.solidBell,
                  label: 'Notifications',
                  colour: Color(kDefaultBackgroundColour),
                  canToggle: true,
                  toggle: this.toggleNotification,
                ),
                SettingsControl(
                  onTap: () {
                    logOutUser();
                  },
                  icon: FontAwesomeIcons.doorOpen,
                  label: 'Logout',
                  colour: Color(kDefaultBackgroundColour),
                ),
                SettingsControl(
                  onTap: () {
                    shareApp();
                  },
                  icon: FontAwesomeIcons.share,
                  label: 'Share',
                  colour: Color(kDefaultBackgroundColour),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              child: Text(
                'Made with love in Pakistan',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
