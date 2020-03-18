import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class LocationBrain {
  static String kGoogleApiKey = 'AIzaSyBY3uVSwIDtVZ-V2LesfjEB5wN_tfqi_po';
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  double searchRadius;

  LocationBrain({this.searchRadius = 3500});

  void setSearchRadius(double radius) {
    this.searchRadius = radius;
  }

  Future<Position> getLocation() async {
    // Get device current location
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  Future<List> getNearbyPlaces() async {
    List<PlacesSearchResult> places = [];
    Position position = await getLocation();

    final location = Location(position.latitude, position.longitude);
    final result = await _places.searchNearbyWithRadius(
        location, this.searchRadius,
        type: 'restaurant');

    if (result.status == "OK") {
      places = result.results;
    }

    return places;
  }

  Future<List> getNearbyPlacesMarkers() async {
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
  }
}
