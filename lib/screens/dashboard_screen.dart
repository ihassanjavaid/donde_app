import 'package:flutter/material.dart';
import 'package:donde_app/utilities/constants.dart';
import 'package:donde_app/screens/home_tab.dart';
import 'package:donde_app/screens/explore_tab.dart';
import 'package:donde_app/screens/friends_tab.dart';
import 'package:donde_app/screens/settings_tab.dart';
import 'package:google_maps_webservice/places.dart';
import 'explore_tab.dart';
import 'friends_tab.dart';
import 'package:donde_app/services/location_service.dart';

class Dashboard extends StatefulWidget {
  static const String id = 'dashboard_screen';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  List<PlacesSearchResult> places;
  Home _home;
  Explore _explore;
  Friends _friends;
  Settings _settings;

  @override
  void initState() {
    getNearByPlaces();
    super.initState();
    _friends = Friends();
    _settings = Settings();
  }

  void getNearByPlaces() async {
    final temp = await LocationService().getNearbyPlaces();
    setState(() {
      this.places = temp;
    });
  }

  Widget _getTab({String tabID}) {
    switch (tabID) {
      case Home.id:
        if (_home == null) {
          print('Found null on home object');
          setState(() {
            _home = Home(places: this.places);
          });
        }
        return _home;
      case Explore.id:
        if (_explore == null) {
          print('Found null on explore object');
          setState(() {
            _explore = Explore(places: this.places);
          });
        }
        return _explore;
      case Friends.id:
        if (_friends == null) {
          print('Found null on friends object');
          _friends = Friends();
        }
        return _friends;
      case Settings.id:
        if (_settings == null) {
          print('Found null on settings object');
          _settings = Settings();
        }
        return _settings;
      default:
        return null;
    }
  }

  Widget _getTabView() {
    switch (this._selectedIndex) {
      case 0:
        return _getTab(tabID: Home.id);
      case 1:
        return _getTab(tabID: Explore.id);
      case 2:
        return _getTab(tabID: Friends.id);
      case 3:
        return _getTab(tabID: Settings.id);
      default:
        return null;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
//      _interstitialAd = Ads().createInterstitialAd()..load()..show();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: _getTabView(),
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
