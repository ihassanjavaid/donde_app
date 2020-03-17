/*
* Dart file housing the landing page of the app
* */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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
            Container(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.fastfood,
                  ),
                  Text(
                    'Restaurant Matcher',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff262522),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                height: 420.0,
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // Card properties
                  borderOnForeground: true,
                  elevation: 18.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 325,
                        margin: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5.0,
                        ),
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
                          height: 32,
                          width: 32,
                        ),
                      ),
                      InkWell(
                        onTap: () {}, // Like
                        child: Image(
                          image: AssetImage('images/hearticon.png'),
                          height: 32,
                          width: 32,
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
