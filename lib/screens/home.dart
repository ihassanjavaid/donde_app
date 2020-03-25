import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donde_app/notifcationData.dart';
/// The page housing the restaurant card and associated controls
import 'package:donde_app/services/firestoreService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../services/locationBrain.dart';
import 'package:donde_app/ads.dart';
import 'package:firebase_admob/firebase_admob.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  static const String id = 'home_screen';
  final List<PlacesSearchResult> places;

  Home({this.places});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Attributes
  bool showSpinner = false;
  PlacesSearchResult place;
  List<PlacesSearchResult> places = [];
  String restaurantName;
  LocationBrain _locationBrain;
  int counter = 1;
  String genericRestaurantName = 'Restaurant Name';
  List<NotificationData> _notifications;
  final FirestoreService _firestoreService = FirestoreService();

  InterstitialAd _interstitialAd;
  String photoRef;
  double ratingOfRes = 0;
  String ratingStars = "No Rating!";

/*  void getSharedRestaurants() async {
    final _firestore = Firestore.instance;

    await for (var snapshot in _firestore.collection('liked_restaurants').where().snapshots()) {
      for (var likedRestaurant in snapshot.documents) {
        String matchFriendName = '';
        final likedRestaurantTemp = likedRestaurant['restaurantName'];
        // Get the friend for whom the match was found
        final friend = await _firestore.collection('users').where('phoneNo', isEqualTo: likedRestaurant['userID']).getDocuments();
        for (var userData in friend.documents) {
          matchFriendName = userData['displayName'];
          break;
        }

        // Mark the restaurant as notified in firestore
//        _firestoreService.updateLikedRestaurantNotificationStatus(userID: likedRestaurant['userID'], restaurantToBeUpdated: likedRestaurantTemp);

        // Display alert
        Alert(
          context: context,
          type: AlertType.success,
          title: "It's a Match! ♥",
          desc:
          "$matchFriendName just liked a restaurant on your like list\n $likedRestaurantTemp",
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

    */ /*for (var friend in friendsList) {
      // Get the friend's liked restaurants
      await for (var snapshot in _firestore
          .collection('users')
          .document(friend)
          .collection('liked_restaurants')
          .where('notified', isEqualTo: false)
          .snapshots()) {
        // Compare friend's each restaurant with current user's restaurant for match
        for (var friendLikedRestaurant in snapshot.documents) {
          for (var likedRestaurant in currentUserLikedRestaurants) {
            if (likedRestaurant == friendLikedRestaurant['restaurantName']) {
              final friendData =
                  await _firestore.collection('users').document(friend).get();
              final matchFriendName = friendData['displayName'];
              _firestoreService.updateLikedRestaurantNotificationStatus(friend: friendData, restaurantToBeUpdated: likedRestaurant);
              Alert(
                context: context,
                type: AlertType.success,
                title: "It's a Match! ♥",
                desc:
                    "$matchFriendName just liked a restaurant on your like list\n $likedRestaurant",
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
    }*/ /*
  }*/

  // Methods
  void setRestaurantData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();


    await _getPlaces();
    await prefs.setString('restaurant', 'Tehzeeb');
    if (places.length != 0) {
      // Get one of the indexes
      try {
        /*final int randomIndex = Random().nextInt(widget.places.length - 1);
        print(randomIndex);*/
        for (var place in places) {
          await prefs.setString('restaurant', place.name);
          setState(() {
            this.restaurantName = place.name;
            this.ratingStars = getRatingStars(this.place.rating);
            place.photos.forEach((photo){
              this.photoRef = photo.photoReference;
            });
          });
          break;
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('Restaurants not found');
    }
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print('Device Token: $deviceToken');
    });
  }

  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('onMessage: $message');
          setState(() {
            Alert(
              context: context,
              type: AlertType.success,
              title: "Test notification",
              desc: 'Just got the test notification',
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
          });
          _setNotification(message);
        }, onLaunch: (Map<String, dynamic> message) async {
      print('onLaunch: $message');
      _setNotification(message);
    }, onResume: (Map<String, dynamic> message) async {
      print('onResume: $message');
      _setNotification(message);
    });
  }

  _setNotification(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    final String mMessage = data['message'];
    setState(() {
      NotificationData n = NotificationData(title: title, body: body, message: mMessage);
      _notifications.add(n);
    });
  }

  @override
  initState() {
    super.initState();
    _getToken();
    _configureFirebaseListeners();
    _notifications = List<NotificationData>();
    _locationBrain = LocationBrain();
    setRestaurantData();

//    getSharedRestaurants();
    _interstitialAd = Ads().createInterstitialAd()..load()..show();
    //_interstitialAd..load()..show();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd.dispose();
  }

  Future<void> _getPlaces() async {
    final temp = await this._locationBrain.getNearbyPlaces();
    setState(() {
      this.places = temp;
    });
  }

  void setRestaurantPreference(String preference) {
    String temp = '';
    if (this.restaurantName != null) {
      if (preference != 'refresh') {
        final int randomIndex = Random().nextInt(this.places.length - 1);
        try {
          if (preference == "disliked_restaurants") {
            // Remove all instances of the disliked restaurants
            this.places.forEach(
                  (restaurant) {
                if (restaurant.name == this.restaurantName) {
                  this.places.remove(restaurant);
                }
              },
            );
          }
          temp = this.restaurantName;
          setState(() {
            this.restaurantName = this.places.elementAt(randomIndex).name;
            this.ratingStars = getRatingStars(this.places.elementAt(randomIndex).rating);
            this.places.elementAt(randomIndex).photos.forEach((photo){
              this.photoRef = photo.photoReference;
              return;
            });
          });
          _firestoreService.addRestaurantToPreference(temp, preference);
        } catch (e) {
          print(e);
        }
      } else {
        final int randomIndex = Random().nextInt(this.places.length - 1);
        try {
          setState(() {
            this.restaurantName = this.places.elementAt(randomIndex).name;
            this.ratingStars = getRatingStars(this.places.elementAt(randomIndex).rating);
            this.places.elementAt(randomIndex).photos.forEach((photo){
              this.photoRef = photo.photoReference;
              return;
            });
          });
        } catch (e) {
          print(e);
        }
      }
    } else {
      setState(() {
        this.counter++;
        String temp = 'Restaurant Name $counter';
        this.genericRestaurantName = temp;
      });
    }
  }

  getRatingStars(double ratingDouble){
    if (ratingDouble <= 0.0 )
      return "No Ratings yet!";
    if (ratingDouble < 2.0)
      return "★";
    if (ratingDouble < 3.0)
      return "★★";
    if (ratingDouble < 4.0)
      return "★★★";
    if (ratingDouble < 4.9)
      return "★★★★";
    else
      return "★★★★★";
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Tab(
                      icon: Container(
                        child: Image(
                          image: AssetImage(
                            'images/logo.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                        height: 45,
                        width: 45,
                      ),
                    ),
                    Text(
                      '  ',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'Restaurants',
                      style: kTitleTextStyle,
                    ),
                  ],
                ),
              ),

              // Restaurant card
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Center(
                            child: RestaurantDescription(place: place),
                          ),
                        ));*/
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    borderOnForeground: true,
                    elevation: 58.0,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          /*child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: resImages[Random().nextInt(14)],
                              ),
                            ),
                          ),*/
                          child: Container(
                            child: Image.network(
                              'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoRef&key=AIzaSyA-uiBKbMxCqyMR6JqbfB-VnDAHL8tFx6U',
                              width: double.maxFinite,
                              height: double.maxFinite,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: AutoSizeText(
                                    this.restaurantName != null
                                        ? this.restaurantName
                                        : this.genericRestaurantName,
                                    style: kCardTitleTextStyle,
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  ratingStars,
                                  style:  TextStyle(
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xffebca46),
                                    fontSize: 20
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setRestaurantPreference('disliked_restaurants');
                      }, // Dislike
                      child: Image(
                        image: AssetImage('images/crossicon.png'),
                        height: 58,
                        width: 58,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setRestaurantPreference('refresh');
                      }, // Refresh
                      child: Image(
                        image: AssetImage('images/refreshicon.png'),
                        height: 30,
                        width: 30,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setRestaurantPreference('liked_restaurants');
                      }, // Like
                      child: Image(
                        image: AssetImage('images/hearticon.png'),
                        height: 58,
                        width: 58,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}