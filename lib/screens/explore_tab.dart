import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

class Explore extends StatefulWidget {
  static const String id = 'explore_tab';
  final List<PlacesSearchResult> places;

  Explore({this.places});

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
