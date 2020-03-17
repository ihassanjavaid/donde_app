import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  // Attributes
  Completer<GoogleMapController> _controller = Completer();
  Iterable markers = [];

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  // Methods
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    final GoogleMapController controller = await _controller.future;

    // Get device current location
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // Set restaurant markers around current locations
    getPlaces(position);

    // Set camera position at current position
    CameraPosition currentPosition = CameraPosition(
        bearing: 0,
        target: LatLng(position.latitude, position.longitude),
        zoom: 18.0);

    controller.animateCamera(CameraUpdate.newCameraPosition(currentPosition));
  }

  void getPlaces(Position position) async {
    var lat = position.latitude;
    var lng = position.longitude;
    try {
      final response = await http.get(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=5000&type=restaurant&key=AIzaSyD8HBaKJrre0xJWU_vl81psl03U76rlIlI');

      final int statusCode = response.statusCode;

      if (statusCode == 201 || statusCode == 200) {
        Map responseBody = json.decode(response.body);
        List results = responseBody["results"];

        Iterable _markers = Iterable.generate(results.length, (index) {
          Map result = results[index];
          Map location = result["geometry"]["location"];
          LatLng latLngMarker = LatLng(location["lat"], location["lng"]);

          return Marker(
            markerId: MarkerId("marker$index"),
            position: latLngMarker,
          );
        });

        setState(() {
          markers = _markers;
        });
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          initialCameraPosition: _kGooglePlex,
          myLocationEnabled: true,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _getLocation,
        label: Text('Center to my location'),
        icon: Icon(Icons.my_location),
      ),
    );
  }
}
