import 'dart:async';

import 'package:donde_app/screens/restaurantDescription.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:donde_app/locationBrain.dart';
import 'package:google_maps_webservice/places.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  // Attributes
//  static String kGoogleApiKey = 'AIzaSyBY3uVSwIDtVZ-V2LesfjEB5wN_tfqi_po';
//  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
//  Completer<GoogleMapController> _controller = Completer();
////  Iterable markers = [];
//  List<PlacesSearchResult> places = [];
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
  }

  void _setupMap() async {
    final GoogleMapController controller = await _controller.future;

    // Get device current location
    Position position = await locationBrain.getLocation();

    // Set camera position at current position
    CameraPosition currentPosition = CameraPosition(
      bearing: 0,
      target: LatLng(position.latitude, position.longitude),
      zoom: 12.0,
    );

    controller.animateCamera(CameraUpdate.newCameraPosition(currentPosition));

    /*setState(() {
      this.placeMarkers = markers;
    });*/
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

  /*Future<PlacesSearchResult> getNearbyPlaces(Position position) async {
    final location = Location(position.latitude, position.longitude);
    final result = await _places.searchNearbyWithRadius(location, 2500,
        type: 'restaurant');

    setState(() {
      if (result.status == "OK") {
        this.places = result.results;
        for (PlacesSearchResult place in places) {
          placeMarkers.add(
            Marker(
              markerId: MarkerId(place.id),
              position: LatLng(
                  place.geometry.location.lat, place.geometry.location.lng),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(
                      place: place,
                    ),
                  ),
                );
              },
            ),
          );
        }
      }
    });
    return places[Random().nextInt(places.length)];
  }*/

/*  void getPlaces(Position position) async {
    var lat = position.latitude;
    var lng = position.longitude;
    try {
      final response = await http.get(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=10000&type=restaurant&key=AIzaSyBY3uVSwIDtVZ-V2LesfjEB5wN_tfqi_po');

      final int statusCode = response.statusCode;

      if (statusCode == 201 || statusCode == 200) {
        Map responseBody = json.decode(response.body);
        List results = responseBody["results"];

        print(results);

        Iterable _markers = Iterable.generate(results.length, (index) {
          Map result = results[index];
          Map location = result["geometry"]["location"];
          LatLng latLngMarker = LatLng(location["lat"], location["lng"]);

          return Marker(
            markerId: MarkerId("marker$index"),
            position: latLngMarker,
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Center(
                    child: Card(
                      child: Text(
                        result['name'],
                      ),
                    ),
                  ),
                ),
              );
            },
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
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            _setupMap();
            _setMarkers();
          },
          initialCameraPosition: _kGooglePlex,
          myLocationEnabled: true,
          markers: Set.from(placeMarkers),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _setupMap,
        label: Text('Center to my location'),
        icon: Icon(Icons.my_location),
      ),
    );
  }
}
