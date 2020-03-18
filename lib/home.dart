/*
* Dart file housing the landing page of the app
* */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'constants.dart';

class Home extends StatelessWidget {
  final PlacesSearchResult place;

  Home({this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Title with icon
            Container(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.fastfood,
                    size: 36,
                  ),
                  SizedBox(
                    width: 10.0,
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
                onTap: () {},
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
                            Text(
                              place != null ? place.name : 'Restaurant Name',
                              style: kCardTitleTextStyle,
                            ),
                            Text(
                              '0.0 KMs',
                              style: kNormalTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
//          Container(
//            margin: EdgeInsets.symmetric(horizontal: 10.0),
//            width: double.infinity,
//            child: GestureDetector(
//              //this.onHorizontalDragDown
//              child: Card(
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(10),
//                ),
//                // Card properties
//                borderOnForeground: true,
//                elevation: 18.0,
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: <Widget>[
//                    Card(
//                      elevation: 10,
//                      borderOnForeground: true,
//                      child: ClipRRect(
//                        borderRadius: BorderRadius.circular(6.5),
//                        child: Container(
//                          width: 330,
//                          height: 310,
//                          decoration: BoxDecoration(
//                            shape: BoxShape.rectangle,
//                            image: DecorationImage(
//                              fit: BoxFit.fill,
//                              image: NetworkImage(
//                                  'https://www.thenews.com.pk//assets/uploads/akhbar/2019-04-22/461156_2369726_Islamabad-hotel_akhbar.jpg'),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: <Widget>[
//                        Text(
//                          'Restaurant Name',
//                          textAlign: TextAlign.left,
//                          style: TextStyle(
//                            fontSize: 28.0,
//                            fontWeight: FontWeight.normal,
//                            color: Colors.redAccent,
//                          ),
//                        ),
//                        Text(
//                          '0.0 kms',
//                          textAlign: TextAlign.end,
//                          style: TextStyle(color: Colors.grey),
//                        ),
//                      ],
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: () {}, // Dislike
                    child: Image(
                      image: AssetImage('images/crossicon.png'),
                      height: 36,
                      width: 36,
                    ),
                  ),
                  InkWell(
                    onTap: () {}, // Dislike
                    child: Image(
                      image: AssetImage('images/refreshicon.png'),
                      height: 30,
                      width: 30,
                    ),
                  ),
                  InkWell(
                    onTap: () {}, // Like
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
    );
  }
}
