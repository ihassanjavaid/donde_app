import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:donde_app/screens/login_screen.dart';
import 'package:donde_app/screens/registration_screen.dart';
import 'package:donde_app/screens/dashboard_screen.dart';
import 'package:donde_app/screens/reset_password_screen.dart';
import 'package:donde_app/screens/settings_tab.dart';

import 'screens/password_entry_screen.dart';
import 'screens/password_entry_screen.dart';

void main() {
  runApp(Donde());
}

class Donde extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        backgroundColor: Color(0xfff8f8f8),
      ),
      initialRoute: RouteDecider.id,
      routes: {
        RouteDecider.id: (context) => RouteDecider(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        PasswordEntryScreen.id: (context) => PasswordEntryScreen(),
        Dashboard.id: (context) => Dashboard(
            /*screens: <Widget>[
                SafeArea(
                  child: Home(),
                  //child: Ads(),
                ),
                SafeArea(
                  child: Explore(),
                ),
                SafeArea(
                  child: Center(
                    child: Friends(),
                  ),
                ),
                SafeArea(
                  child: SettingsScreen(),
                ),
              ],*/
            ),
        Settings.id: (context) => Settings(),
        ResetPasswordScreen.id: (context) => ResetPasswordScreen(),
      },
    );
  }
}

class RouteDecider extends StatefulWidget {
  static const String id = 'route_decider';
  @override
  _RouteDeciderState createState() => _RouteDeciderState();
}

class _RouteDeciderState extends State<RouteDecider> {
  bool isLoggedIn = false;

  @override
  void initState() {
    autoLogin();
    super.initState();
  }

  void autoLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String userId = pref.getString('phoneNumber');

    if (userId != null) {
      print('Logged in automatically');
      setState(() {
        this.isLoggedIn = true;
      });
      Navigator.popAndPushNamed(context, Dashboard.id);
      return;
    } else {
      print('First time sign in');
      Navigator.popAndPushNamed(context, LoginScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
