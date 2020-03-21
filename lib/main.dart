import 'package:donde_app/screens/explore.dart';
import 'package:donde_app/screens/home.dart';
import 'package:donde_app/screens/index.dart';
import 'package:donde_app/screens/password.dart';
import 'package:donde_app/screens/registration.dart';
import 'package:donde_app/screens/resetPassword.dart';
import 'package:donde_app/screens/settings_screen.dart';

import 'constants.dart';
import 'screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(Donde());

class Donde extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        backgroundColor: Color(0xfff8f8f8),
      ),
      initialRoute: Login.id,
      routes: {
        Login.id: (context) => Login(),
        //Password.id: (context) => Password(),
        Registration.id: (context) => Registration(),
        Index.id: (context) {
          return Index(
              /*screens: <Widget>[
              SafeArea(
                child: Home(),
              ),
              SafeArea(
                child: Explore(),
              ),
              SafeArea(
                child: Center(
                  child: Text(
                    'Coming soon...',
                    textAlign: TextAlign.center,
                    style: kSettingsTextStyle,
                  ),
                ),
              ),
              SafeArea(
                child: SettingsScreen(),
              ),
            ],*/
              );
        },
        Home.id: (context) => Home(),
        Explore.id: (context) => Explore(),
        SettingsScreen.id: (context) => SettingsScreen(),
        ResetPassword.id:(context)=> ResetPassword(),
      },
    );
  }
}
