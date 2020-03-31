import 'package:flutter/material.dart';
import 'package:donde_app/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:math';

import '../services/firestore_service.dart';

class Home extends StatefulWidget {
  static const String id = 'home_tab';
  final List places;

  Home({this.places});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String restaurantName;
  String genericRestaurantName = 'Restaurant Name';
  String ratingStars;
  String photoRef;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    updateRestaurant();
  }

  void updateRestaurant() {
    final int randomIndex = Random().nextInt(widget.places.length - 1);
    try {
      setState(() {
        this.restaurantName = widget.places.elementAt(randomIndex).name;
        this.ratingStars = getRatingStars(
            widget.places.elementAt(randomIndex).rating.toDouble());
        widget.places.elementAt(randomIndex).photos.forEach((photo) {
          this.photoRef = photo.photoReference;
          return;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void setRestaurantPreference(String preference) {
    if (this.restaurantName != null) {
      try {
        if (preference == "disliked_restaurants") {
          // Remove all instances of the disliked restaurants
          widget.places.forEach(
            (restaurant) {
              if (restaurant.name == this.restaurantName) {
                widget.places.remove(restaurant);
              }
            },
          );
        }
        FirestoreService()
            .addRestaurantToPreference(this.restaurantName, preference);
        updateRestaurant();
      } catch (e) {
        print(e);
      }
    } else {
      setState(() {
        this.counter++;
        String temp = 'Restaurant Name $counter';
        this.genericRestaurantName = temp;
      });
    }
  }

  getRatingStars(double ratingDouble) {
    if (ratingDouble <= 0.0) return "No Ratings yet!";
    if (ratingDouble < 2.0) return "★";
    if (ratingDouble < 3.0) return "★★";
    if (ratingDouble < 4.0) return "★★★";
    if (ratingDouble < 4.9)
      return "★★★★";
    else
      return "★★★★★";
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              FontAwesomeIcons.ban,
              color: Colors.white,
            ),
            Text(
              " Dislike",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.heart,
              color: Colors.white,
            ),
            Text(
              " Like",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Dismissible(
                key: Key(this.restaurantName),
                background: slideRightBackground(),
                secondaryBackground: slideLeftBackground(),
                // ignore: missing_return
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    // User liked the restaurant
                    setRestaurantPreference('liked_restaurants');
                  } else {
                    // User disliked the restaurant
                    setRestaurantPreference('disliked_restaurants');
                  }
                },
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    borderOnForeground: true,
                    elevation: 58.0,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
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
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xffebca46),
                                    fontSize: 22,
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
                      updateRestaurant();
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
    );
  }
}
