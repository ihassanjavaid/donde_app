import 'package:auto_size_text/auto_size_text.dart';
import 'package:donde_app/services/ads_service.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:donde_app/utilities/constants.dart';
import 'package:google_maps_webservice/places.dart';

class Dashboard extends StatefulWidget {
  Dashboard({this.screens});
  static const String id = 'dashboard_screen';
  final List<Widget> screens;
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  List<PlacesSearchResult> places;
  InterstitialAd _interstitialAd;

  @override
  void dispose() {
    super.dispose();
    _interstitialAd.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _interstitialAd = Ads().createInterstitialAd()..load()..show();
    });
  }

  BottomNavigationBarItem getNavigationBarItem({String label, IconData icon}) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        size: 24,
        color: Colors.grey,
      ),
      title: Text(
        label,
        style: kBottomNavTextStyle,
      ),
      activeIcon: Icon(
        icon,
        size: 30,
        color: Colors.redAccent,
      ),
    );
  }

  AppBar getAppBar() {
    AppBar appBar = AppBar(
      iconTheme: IconThemeData(
        color: Colors.redAccent,
      ),
      backgroundColor: Colors.white,
      title: AutoSizeText(
        'Friends',
        overflow: TextOverflow.clip,
        maxLines: 1,
        style: TextStyle(
          fontSize: 30,
          fontStyle: FontStyle.italic,
          color: Colors.redAccent,
        ),
      ),
      centerTitle: false,
    );

    return this._selectedIndex == 2 ? appBar : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      appBar: getAppBar(),
      body: IndexedStack(
        index: _selectedIndex,
        children: widget.screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          getNavigationBarItem(label: 'Home', icon: Icons.home),
          getNavigationBarItem(label: 'Explore', icon: Icons.explore),
          getNavigationBarItem(label: 'Friends', icon: Icons.chat),
          getNavigationBarItem(label: 'Settings', icon: Icons.settings),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.redAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
