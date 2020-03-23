import 'dart:math';

/// The page housing the restaurant card and associated controls
import 'package:donde_app/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../locationBrain.dart';

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

  // for pictures
  static final img1 = AssetImage('images/resImages/01.jpg');
  static final img2 = AssetImage('images/resImages/02.jpg');
  static final img3 = AssetImage('images/resImages/03.jpg');
  static final img4 = AssetImage('images/resImages/04.jpg');
  static final img5 = AssetImage('images/resImages/05.jpg');

  static final img6 = AssetImage('images/resImages/06.jpg');
  static final img7 = AssetImage('images/resImages/07.jpg');
  static final img8 = AssetImage('images/resImages/08.jpg');
  static final img9 = AssetImage('images/resImages/09.jpg');
  static final img10 = AssetImage('images/resImages/10.jpg');

  static final img11 = AssetImage('images/resImages/11.jpg');
  static final img12 = AssetImage('images/resImages/12.jpg');
  static final img13 = AssetImage('images/resImages/13.jpg');
  static final img14 = AssetImage('images/resImages/14.jpg');
  static final img15 = AssetImage('images/resImages/15.jpg');

  final List<AssetImage> resImages = [
    img1,
    img2,
    img3,
    img4,
    img5,
    img6,
    img7,
    img8,
    img9,
    img10,
    img11,
    img12,
    img13,
    img14,
    img15
  ];

  // Methods
  void setRestaurantData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await _getPlaces();
    await prefs.setString('restaurant', 'Tehzeeb');
    if (places.length != 0) {
      print('Found Restaurants');
      // Get one of the indexes
      try {
        /*final int randomIndex = Random().nextInt(widget.places.length - 1);
        print(randomIndex);*/
        for (var place in places) {
          await prefs.setString('restaurant', place.name);
          setState(() {
            this.restaurantName = place.name;
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

  @override
  initState() {
    super.initState();
    _locationBrain = LocationBrain();
    setRestaurantData();
  }

  Future<void> _getPlaces() async {
    final temp = await this._locationBrain.getNearbyPlaces();
    setState(() {
      this.places = temp;
    });
  }

  void setRestaurantPreference(String preference) {
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
          setState(() {
            this.restaurantName = this.places.elementAt(randomIndex).name;
          });
          StoreFunc.addRestaurantToPreference(this.restaurantName, preference);
        } catch (e) {
          print(e);
        }
      } else {
        final int randomIndex = Random().nextInt(this.places.length - 1);
        try {
          setState(() {
            this.restaurantName = this.places.elementAt(randomIndex).name;
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
                        borderRadius: BorderRadius.circular(10.0)),
                    borderOnForeground: true,
                    elevation: 18.0,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: resImages[Random().nextInt(14)],
                              ),
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
                              /*Expanded(
                                flex: 1,
                                child: Text(
                                  '0.0 KMs',
                                  style: kNormalTextStyle,
                                ),
                              ),*/
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
                        height: 36,
                        width: 36,
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
                        height: 36,
                        width: 36,
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
