import 'dart:async';
import 'package:donde_app/screens/restaurantDescription.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:donde_app/services/locationBrain.dart';
import 'package:google_maps_webservice/places.dart';

import '../ads.dart';

class Explore extends StatefulWidget {
  static const String id = 'explore_screen';
  final List<PlacesSearchResult> places;

  Explore({this.places});

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  // Attributes
  LocationBrain locationBrain = LocationBrain();
  Completer<GoogleMapController> _controller = Completer();
  List placeMarkers = [];
  InterstitialAd _interstitialAd;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  // Methods
  void initState() {
    super.initState();
    _setupMap();
    //_interstitialAd..load()..show();
  }

  @override
  void dispose(){
    super.dispose();
    _interstitialAd.dispose();
  }

  void showAdonExploreScreen(){
    _interstitialAd = Ads().createInterstitialAd()..load()..show();
  }

  void _setupMap() async {
    final GoogleMapController controller = await _controller.future;

    LatLng position = await locationBrain.getCurrentLocation();

    // Set camera position at current position
    CameraPosition currentPosition = CameraPosition(
      bearing: 0,
      target: position,
      zoom: 12.0,
    );

    controller.animateCamera(CameraUpdate.newCameraPosition(currentPosition));

    _setMarkers();
  }

  void _setMarkers() async {
    List markers = [];
    //final places = await this.locationBrain.getNearbyPlaces();

    for (PlacesSearchResult place in await this.locationBrain.getNearbyPlaces()) {
      markers.add(
        Marker(
          markerId: MarkerId(place.id),
          position:
              LatLng(place.geometry.location.lat, place.geometry.location.lng),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Center(
                  child: RestaurantDescription(place: place),
                ),
              ),
            );
          },
        ),
      );
    }

    setState(() {
      this.placeMarkers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          /*PageStorage.of(context).writeState(context, this,
                identifier: ValueKey(this.widget.key));*/
        },
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        markers: Set.from(placeMarkers),
      ),
    );
  }
}
