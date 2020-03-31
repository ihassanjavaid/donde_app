import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static String kGoogleApiKey = 'AIzaSyA-uiBKbMxCqyMR6JqbfB-VnDAHL8tFx6U';
  List<PlacesSearchResult> _placesList = [];
  int searchRadius;
  Position position;

  LocationService({this.searchRadius = 10000});

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
}
