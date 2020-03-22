import 'package:donde_app/screens/settingsScreen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'explore.dart';
import 'home.dart';
import 'friends.dart';



class Index extends StatefulWidget {
  static const String id = 'index_screen';
  static const Tag = "Tabbar";
  final String phoneNumber;

  Index({this.phoneNumber});

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _selectedIndex = 0;
  static Explore _explore;
  final String phoneNumber;
  static String phoneNo;

  _IndexState({this.phoneNumber}) {
    phoneNo = this.phoneNumber;
  }

  static Widget acquireExploreWidget() {
    if (_explore == null) {
      _explore = Explore();
    }
    return _explore;
  }

  final List<Widget> _widgetOptions = <Widget>[
    SafeArea(
      child: Home(),
    ),
    SafeArea(
      child: acquireExploreWidget(),
    ),
    SafeArea(
      child: Friends(),
    ),
    SafeArea(
      child: SettingsScreen(phoneNumber: phoneNo),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      //bottomNavigationBar: _bottomNavigationBar(_selectedPage),
      body: _widgetOptions[_selectedIndex],
      /*body: PageStorage(
        child: pages[_selectedPage],
        bucket: this.bucket,
      ),*/
      /*body: IndexedStack(
        index: _selectedIndex,
        children: widget.screens,
      ),*/
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
    );
  }
}
