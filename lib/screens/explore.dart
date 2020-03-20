import 'dart:async';
import 'package:donde_app/screens/restaurantDescription.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:donde_app/locationBrain.dart';
import 'package:google_maps_webservice/places.dart';

class Explore extends StatefulWidget {
  static const String id = 'explore_screen';
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  // Attributes
  LocationBrain locationBrain = LocationBrain();
  Completer<GoogleMapController> _controller = Completer();
  List placeMarkers = [];

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  // Methods
  void initState() {
    super.initState();
    _setupMap();
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

//    _setMarkers();
  }

  void _setMarkers() async {
    List markers = [];
    // Set restaurant markers around current locations
    List<PlacesSearchResult> places = await locationBrain.getNearbyPlaces();

    for (PlacesSearchResult place in places) {
      markers.add(
        Marker(
          markerId: MarkerId(place.id),
          position:
              LatLng(place.geometry.location.lat, place.geometry.location.lng),
          onTap: () async {
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
    return Scaffold(
      body: SafeArea(
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
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _setupMap,
        label: Text('Center to my location'),
        icon: Icon(Icons.my_location),
      ),*/
    );
  }
}
