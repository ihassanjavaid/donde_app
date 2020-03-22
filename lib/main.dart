import 'package:donde_app/screens/explore.dart';
import 'package:donde_app/screens/home.dart';
import 'package:donde_app/screens/index.dart';
import 'package:donde_app/screens/registration.dart';
import 'package:donde_app/screens/resetPassword.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/settingsScreen.dart';

void main() => runApp(Donde());

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
        Login.id: (context) => Login(),
        //Password.id: (context) => Password(),
        Registration.id: (context) => Registration(),
        Index.id: (context) => Index(),
        Home.id: (context) => Home(),
        Explore.id: (context) => Explore(),
        SettingsScreen.id: (context) => SettingsScreen(),
        ResetPassword.id:(context)=> ResetPassword(),
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
      Navigator.popAndPushNamed(context, Index.id);
      return;
    } else {
      print('First time sign in');
      Navigator.popAndPushNamed(context, Login.id);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

