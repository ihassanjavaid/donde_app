import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {


  Completer<GoogleMapController> _controller = Completer();

  //static const LatLng _center = const LatLng(45.521563, -122.677433);
  //Position position = await Geolocator

  /*var location = new Location();
  Map<String, double>userLocation;

  userLocation = location.getLocation();

  double latt = userLocation["latitude"];
  double longg = userLocation["longitude"];
   */

  static const LatLng _center = const LatLng(latt, long);


  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 12.0,
            ),
          ),
        ),
    );
  }
}

