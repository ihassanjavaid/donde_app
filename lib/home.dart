/*
* Dart file housing the landing page of the app
* */

import 'package:flutter/material.dart';
import 'constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(''), // for a little space from the top
            Center(
              child: Container(
                height: 470.0,
                width: 390,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // Card properties
                  borderOnForeground: true,
                  elevation: 18.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.fastfood,
                          ),
                          Text(
                            'Restaurant Matcher',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.normal,
                              color: Color(0xff262522),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 280,
                        height: 280,
                        margin: EdgeInsets.all(33),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                'https://www.thenews.com.pk//assets/uploads/akhbar/2019-04-22/461156_2369726_Islamabad-hotel_akhbar.jpg'),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'Restaurant Name',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.redAccent,
                            ),
                          ),
                          Text(
                            '0.0 kms',
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    '',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {}, // Dislike
                        child: Image(
                          image: AssetImage('images/crossicon.png'),
                          height: 50,
                          width: 50,
                        ),
                      ),
                      InkWell(
                        onTap: () {}, // Like
                        child: Image(
                          image: AssetImage('images/hearticon.png'),
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
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
