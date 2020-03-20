import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class Index extends StatefulWidget {
  static const String id = 'index_screen';
  static const Tag = "Tabbar";
  final List<Widget> screens;

  Index({this.screens});

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _selectedIndex = 0;

  static const Icon homeicon = Icon(
    Icons.home,
    size: 30,
    color: Colors.redAccent,
  );

  static const Icon exploreicon = Icon(
    Icons.explore,
    size: 30,
    color: Colors.redAccent,
  );

  static const Icon friendsicon = Icon(
    Icons.chat,
    size: 30,
    color: Colors.redAccent,
  );

  static const Icon settingsicon = Icon(
    Icons.settings,
    size: 30,
    color: Colors.redAccent,
  );

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

/*  static final List<Widget> _widgetOptions = <Widget>[
    SafeArea(
      child: Home(),
    ),
    SafeArea(
      child: Explore(),
    ),
    Text(
      'Index 2: Friends',
      style: optionStyle,
    ),
    SafeArea(
      child: Settings(),
    ),
  ];*/

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: const Text('Press home button to exit'),
          ),
        );
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        body: DoubleBackToCloseApp(
          child: IndexedStack(
            index: _selectedIndex,
            children: widget.screens,
          ),
          snackBar: SnackBar(content: Text('Tap again to close the app')),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 24,
                color: Colors.grey,
              ),
              title: Text(
                'Home',
                style: kBottomNavTextStyle,
              ),
              activeIcon: homeicon,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.explore,
                size: 24,
                color: Colors.grey,
              ),
              title: Text(
                'Explore',
                style: kBottomNavTextStyle,
              ),
              activeIcon: exploreicon,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                size: 24,
                color: Colors.grey,
              ),
              title: Text(
                'Friends',
                style: kBottomNavTextStyle,
              ),
              activeIcon: friendsicon,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 24,
                color: Colors.grey,
              ),
              title: Text(
                'Settings',
                style: kBottomNavTextStyle,
              ),
              activeIcon: settingsicon,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.redAccent,
          onTap: _onItemTapped,
          //backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}
