/// The page housing the restaurant card and associated controls

import 'dart:math';
import 'package:donde_app/screens/restaurantDescription.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_webservice/places.dart';
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

  // Methods
  void setRestaurantData() async {
    PlacesSearchResult place;
    await _getPlaces();
    if (places.length != 0) {
      print('Found Restaurants');
      // Get one of the indexes
      try {
        final int randomIndex = Random().nextInt(widget.places.length - 1);
        print(randomIndex);
        for (var place in places) {
          setState(() {
            this.restaurantName = place.name;
          });
        }
      } catch (e) {
        print('Error set restaurant information');
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Center(
                            child: RestaurantDescription(place: place),
                          ),
                        ));
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
                                image: NetworkImage(
                                    'https://wpcdn.us-east-1.vip.tn-cloud.net/www.abc6.com/content/uploads/2020/03/restaurants.jpg'),
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
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '0.0 KMs',
                                  style: kNormalTextStyle,
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
                        // TODO Add the current restaurant in the disliked list
                        setState(() {
                          this.counter++;
                          String temp = 'Restaurant Name $counter';
                          this.genericRestaurantName = temp;
                        });
                      }, // Dislike
                      child: Image(
                        image: AssetImage('images/crossicon.png'),
                        height: 36,
                        width: 36,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          this.counter++;
                          String temp = 'Restaurant Name $counter';
                          this.genericRestaurantName = temp;
                        });
                      }, // Referesh
                      child: Image(
                        image: AssetImage('images/refreshicon.png'),
                        height: 30,
                        width: 30,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // TODO Add the current restaurant in the liked list
                        setState(() {
                          this.counter++;
                          String temp = 'Restaurant Name $counter';
                          this.genericRestaurantName = temp;
                        });
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
