import 'package:flutter/material.dart';
import 'constants.dart';

class MainCard extends StatefulWidget {
  @override
  _MainCardState createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(''),
            Center(
              child: Container(
                height: 500.0,
                width: 390,
                child: Card(
                  // Card properties
                  borderOnForeground: true,
                  elevation: 15.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.fastfood),
                        title: Text(
                          'Restaurant Matcher', style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xfff44336),
                          ),
                        ),
                        subtitle: Text('Donde',
                          style: kSubtitleStyle,
                        ),
                      ),
                      Container(
                        width: 280.0,
                        height: 250.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage('https://www.thenews.com.pk//assets/uploads/akhbar/2019-04-22/461156_2369726_Islamabad-hotel_akhbar.jpg'),
                          ),
                        ),
                      )
                  ],
                ),
            ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
