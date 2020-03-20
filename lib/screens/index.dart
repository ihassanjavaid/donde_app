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
        body: IndexedStack(
          index: _selectedIndex,
          children: widget.screens,
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
              activeIcon: Icon(
                Icons.home,
                size: 30,
                color: Colors.redAccent,
              ),
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
              activeIcon: Icon(
                Icons.explore,
                size: 30,
                color: Colors.redAccent,
              ),
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
              activeIcon: Icon(
                Icons.chat,
                size: 30,
                color: Colors.redAccent,
              ),
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
              activeIcon: Icon(
                Icons.settings,
                size: 30,
                color: Colors.redAccent,
              ),
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
