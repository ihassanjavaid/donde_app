import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {

  Completer<GoogleMapController> _controller = Completer();

  Position _pos;
  void _getlocation() async {
    _pos = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }


  @override
  Widget build(BuildContext context) {
    _getlocation();
    return Scaffold(
        body: SafeArea(
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(_pos.latitude, _pos.longitude),
              zoom: 12.0,
            ),
          ),
        ),
    );
  }
}

