import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:donde/screens/explore_screen.dart';
import 'package:donde/screens/friends_screen.dart';

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
        Login.id: (context) => Login(),
        //Password.id: (context) => Password(),
        Registration.id: (context) => Registration(),
        Index.id: (context) => Index(
              screens: <Widget>[
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
              ],
            ),
        Home.id: (context) => Home(),
        Explore.id: (context) => Explore(),
        SettingsScreen.id: (context) => SettingsScreen(),
        ResetPassword.id: (context) => ResetPassword(),
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
