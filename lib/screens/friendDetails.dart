import 'package:donde_app/services/firestoreService.dart';
import 'package:flutter/material.dart';

class FriendDetails extends StatelessWidget {
  static const String id = 'friend_detail_screen';
  final FirestoreService _firestoreService = FirestoreService();
  List restaurants;

  void getFriendRestaurants() {
    List restaurants = _firestoreService.getFriendLikedRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(''),
        ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return Text(restaurants[index]);
            }),
      ],
    );
  }
}
