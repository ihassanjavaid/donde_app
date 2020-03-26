import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import '../services/ads.dart';
import '../constants.dart';
import 'explore.dart';

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
  static Explore _explore;
  static String phoneNo;
  static List<PlacesSearchResult> places = [];
  InterstitialAd _interstitialAd;

  /*void getSharedRestaurants() async {
    final friendsList = await _firestoreService.getCurrentUserFriends();
    final currentUserLikedRestaurants = await _firestoreService.getCurrentUserLikedRestaurants();
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
      *//*final friendRestaurants = await documents.getDocuments();
        for (var friendLikedRes in friendRestaurants.documents) {

        }*//*

    }
  }*/

  static Widget acquireExploreWidget() {
    if (_explore == null) {
      _explore = Explore();
    }
    return _explore;
  }

  /*final List<Widget> _widgetOptions = <Widget>[
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
  ];*/

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _interstitialAd = Ads().createInterstitialAd()..load()..show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
