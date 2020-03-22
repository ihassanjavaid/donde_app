import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class LocationBrain {
  int _callCount = 0;
  static String kGoogleApiKey = 'AIzaSyA-uiBKbMxCqyMR6JqbfB-VnDAHL8tFx6U';
  List<PlacesSearchResult> _placesList = [];
  double searchRadius;
  Position position;

  LocationBrain({this.searchRadius = 5000});

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
    if (_callCount == 0) sleep(const Duration(seconds: 10));
    var element = _placesList[_random.nextInt(_placesList.length)];
    _callCount++;
    return element;
  }
}
