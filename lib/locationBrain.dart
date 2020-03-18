import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class LocationBrain {
  static String kGoogleApiKey = 'AIzaSyBY3uVSwIDtVZ-V2LesfjEB5wN_tfqi_po';
  List<PlacesSearchResult> _placesList = [];
  double searchRadius;
  Position position;

  LocationBrain({this.searchRadius = 3500});

  void setSearchRadius(double radius) {
    this.searchRadius = radius;
  }

//  void _setLocation() async {
//    // Get device current location
//    position = await Geolocator()
//        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//  }

  Future<LatLng> getCurrentLocation() async {
    Position pos = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return LatLng(pos.latitude, pos.longitude);
  }

  Future<List> getNearbyPlaces() async {
    GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
    LatLng currentLocation = await getCurrentLocation();

    final location =
        Location(currentLocation.latitude, currentLocation.longitude);
    final result = await places.searchNearbyWithRadius(
        location, this.searchRadius,
        type: 'restaurant');

    if (result.status == "OK") {
      _placesList = result.results;
    }

    return _placesList;
  }

  Future<PlacesSearchResult> getRandomPlace() async {
    final _random = new Random();
    sleep(const Duration(seconds: 10));
    var element = _placesList[_random.nextInt(_placesList.length)];
    return element;
  }

  /*Future<List> getNearbyPlacesMarkers() async {
    List placeMarkers = [];
    List<PlacesSearchResult> places = await getNearbyPlaces();

    for (PlacesSearchResult place in places) {
      placeMarkers.add(
        Marker(
          markerId: MarkerId(place.id),
          position:
              LatLng(place.geometry.location.lat, place.geometry.location.lng),
        ),
      );
    }

    return placeMarkers;
  }*/
}
