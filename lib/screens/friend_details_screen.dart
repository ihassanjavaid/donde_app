import 'package:flutter/material.dart';

import '../components/info_display_field.dart';
import '../services/firestore_service.dart';

class FriendDetails extends StatefulWidget {
  FriendDetails({this.phoneNumber, this.name});

  static const String id = 'friend_detail_screen';
  final String phoneNumber;
  final String name;

  @override
  _FriendDetailsState createState() => _FriendDetailsState();
}

class _FriendDetailsState extends State<FriendDetails> {
  final FirestoreService _firestoreService = FirestoreService();
  List _restaurants = ['Populating list...'];

  @override
  void initState() {
    getFriendRestaurants();
    super.initState();
  }

  void getFriendRestaurants() async {
    final temp =
        await _firestoreService.getFriendLikedRestaurants(widget.phoneNumber);
    if (temp.length > 0)
      setState(() {
        this._restaurants = temp;
      });
    else {
      final friendName = widget.name;
      setState(() {
        this._restaurants = [
          '$friendName has not liked any restaurants as of yet, stay tuned!'
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _restaurants.length,
                itemBuilder: (context, index) {
                  return InfoDisplayField(label: _restaurants[index]);
                }),
          ),
        ],
      ),
    );
  }
}
