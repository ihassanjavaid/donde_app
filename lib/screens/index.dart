import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donde_app/locationBrain.dart';
import 'package:donde_app/screens/settingsScreen.dart';
import 'package:donde_app/store.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants.dart';
import 'explore.dart';
import 'home.dart';
import 'friends.dart';

class Index extends StatefulWidget {
  static const String id = 'index_screen';

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _selectedIndex = 0;
  static Explore _explore;
  static String phoneNo;
  LocationBrain _locationBrain;
  static List<PlacesSearchResult> places = [];

  initState() {
    super.initState();
    this._locationBrain = LocationBrain();
    getSharedRestaurants();
  }

  void getSharedRestaurants() async {
    final friendsList = await StoreFunc.getCurrentUserFriends();
    final currentUserLikedRestaurants = await StoreFunc.getCurrentUserLikedRestaurants();
    final firestore = Firestore();
    String likedRestaurant = '';

    for (var friend in friendsList) {
      await for (var snapshot in firestore
          .collection('users')
          .document(friend)
          .collection('liked_restaurants')
          .snapshots()) {
        for (var friendLikedRestaurant in snapshot.documents) {
            for (var likedRestaurants in currentUserLikedRestaurants) {
              if (likedRestaurants == friendLikedRestaurant['restaurantName'] &&
                  (friendLikedRestaurant['restaurantName'] != likedRestaurant ||
                      likedRestaurant == '')) {
                        print(friendLikedRestaurant['restaurantName']);
                likedRestaurant = likedRestaurants;
                final sharedFriend =
                    await firestore.collection('users').document(friend).get();
                var sharedFriendName = sharedFriend['displayName'];

                print(
                    '$sharedFriendName just liked a restaurant on your like list\n $likedRestaurants');
                Alert(
                  context: context,
                  type: AlertType.success,
                  title: "It's a Match! ♥",
                  desc:
                      "$sharedFriendName just liked a restaurant on your like list\n $likedRestaurants",
                  buttons: [
                    DialogButton(
                      color: Colors.redAccent,
                      child: Text(
                        "Yayy!",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      width: 120,
                    )
                  ],
                ).show();
              }
            }
          
        }
      }
      /*final friendRestaurants = await documents.getDocuments();
        for (var friendLikedRes in friendRestaurants.documents) {

        }*/

    }
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
      body: _widgetOptions[_selectedIndex],
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
