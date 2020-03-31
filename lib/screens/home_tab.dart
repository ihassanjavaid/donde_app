import 'package:donde_app/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:donde_app/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:math';

import '../services/firestore_service.dart';

class Home extends StatefulWidget {
  static const String id = 'home_tab';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String restaurantName;
  String genericRestaurantName = 'Restaurant Name';
  String ratingStars;
  String photoRef;
  int counter = 0;
  List<PlacesSearchResult> places;

  @override
  void initState() {
    super.initState();
    updateRestaurant();
  }

  Future<void> getNearByPlaces() async {
    final temp = await LocationService().getNearbyPlaces();
    setState(() {
      this.places = temp;
    });
  }

  void updateRestaurant() async {
    await getNearByPlaces();
    try {
      final int randomIndex = Random().nextInt(this.places.length - 1);
      setState(() {
        this.restaurantName = this.places.elementAt(randomIndex).name;
        this.ratingStars = getRatingStars(
            this.places.elementAt(randomIndex).rating.toDouble());
        this.places.elementAt(randomIndex).photos.forEach((photo) {
          this.photoRef = photo.photoReference;
          return;
        });
      });
    } catch (e) {
      print(e);
      this.restaurantName = genericRestaurantName;
      this.photoRef =
          'CnRtAAAATLZNl354RwP_9UKbQ_5Psy40texXePv4oAlgP4qNEkdIrkyse7rPXYGd9D_Uj1rVsQdWT4oRz4QrYAJNpFX7rzqqMlZw2h2E2y5IKMUZ7ouD_SlcHxYq1yL4KbKUv3qtWgTK0A6QbGh87GB3sscrHRIQiG2RrmU_jF4tENr9wGS_YxoUSSDrYjWmrNfeEHSGSc3FyhNLlBU';
      this.ratingStars = 'No Ratings yet!';
    }
  }

  void setRestaurantPreference(String preference) {
    if (this.restaurantName != null) {
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

  getImage() {
    try {
      final photo = Image.network(
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoRef&key=AIzaSyA-uiBKbMxCqyMR6JqbfB-VnDAHL8tFx6U',
        width: double.maxFinite,
        height: double.maxFinite,
        fit: BoxFit.fill,
      );
      return photo;
    } catch (e) {
      print(e);
      final photo = Image.network(
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CnRtAAAATLZNl354RwP_9UKbQ_5Psy40texXePv4oAlgP4qNEkdIrkyse7rPXYGd9D_Uj1rVsQdWT4oRz4QrYAJNpFX7rzqqMlZw2h2E2y5IKMUZ7ouD_SlcHxYq1yL4KbKUv3qtWgTK0A6QbGh87GB3sscrHRIQiG2RrmU_jF4tENr9wGS_YxoUSSDrYjWmrNfeEHSGSc3FyhNLlBU&key=AIzaSyA-uiBKbMxCqyMR6JqbfB-VnDAHL8tFx6U',
        width: double.maxFinite,
        height: double.maxFinite,
        fit: BoxFit.fill,
      );
      return photo;
    }
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
                    elevation: 3.5,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: getImage(),
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
                                  ratingStars != null
                                      ? this.ratingStars
                                      : 'No Rating Available',
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
            ),
          ],
        ),
      ),
    );
  }
}
