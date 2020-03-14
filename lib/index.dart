import 'package:flutter/material.dart';
import 'constants.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _selectedIndex = 0;

  static const Icon homeicon = Icon(Icons.home,
    size: 30,
    color: Colors.redAccent,
  );

  static const Icon exploreicon = Icon(Icons.explore,
    size: 30,
    color: Colors.redAccent,
  );

  static const Icon friendsicon = Icon(Icons.chat,
    size: 30,
    color: Colors.redAccent,
  );

  static const Icon settingsicon = Icon(Icons.settings,
    size: 30,
    color: Colors.redAccent,
  );

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Explore',
      style: optionStyle,
    ),
    Text(
      'Index 2: Friends',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    )
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: _widgetOptions.elementAt(_selectedIndex),

      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                size: 30,
              color: Colors.grey,
            ),
            title: Text('Home',
              style: kbottomNavIcons,
            ),
            activeIcon: homeicon,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore, size: 30,
              color: Colors.grey,
            ),
            title: Text('Explore',
              style: kbottomNavIcons,
            ),
            activeIcon: exploreicon,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, size: 30,
              color: Colors.grey,
            ),
            title: Text('Friends',
              style: kbottomNavIcons,
            ),
            activeIcon: friendsicon,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 30,
              color: Colors.grey,
            ),
            title: Text('Settings',
              style: kbottomNavIcons,
            ),
            activeIcon: settingsicon,
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