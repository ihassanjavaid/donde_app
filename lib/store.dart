import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donde_app/services/userData.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreFunc {
  getUserPhoneNo(String phoneNo) {
    return Firestore.instance
        .collection('users')
        .where('phoneNo', isEqualTo: phoneNo)
        .getDocuments();
  }

  authenticatePhoneWithPassword(String phoneNo, String password) {
    return Firestore.instance
        .collection('users')
        .where('phoneNo', isEqualTo: phoneNo)
        .where('password', isEqualTo: password)
        .getDocuments();
  }

  registerNewUser(
      {String name, String phoneNo, String email, String password}) {
    DocumentReference ref = Firestore.instance.collection('users').document();
    ref.setData({
      'displayName': name,
      'email': email,
      'password': password,
      'phoneNo': phoneNo
    }, merge: true);
  }

  static Future<UserData> getCurrentUserData() async {
    String phoneNumber;
    String displayName;
    String email;
    UserData userData;

    SharedPreferences pref = await SharedPreferences.getInstance();
    final String phoneNo = pref.getString('phoneNumber');

    // final documents = store.getUserData(phoneNumber);
    final documents = await Firestore()
        .collection('users')
        .where('phoneNo', isEqualTo: phoneNo)
        .getDocuments();

    for (var document in documents.documents) {
      phoneNumber = document.data['phoneNo'];
      displayName = document.data['displayName'];
      email = document.data['email'];
      userData = UserData(
          phoneNumber: phoneNumber, displayName: displayName, email: email);
    }

    return userData;
  }

  static void addRestaurantToPreference(
      PlacesSearchResult place, String preference) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String phoneNo = pref.getString('phoneNumber');
    final String restaurant = pref.getString('restaurant');
    final fireStore = Firestore();

    final documents = await fireStore
        .collection('users')
        .where('phoneNo', isEqualTo: phoneNo)
        .getDocuments();

    for (var document in documents.documents) {
      print(document.data);
      CollectionReference restaurants = fireStore
          .collection('users')
          .document(document.documentID)
          .collection(preference);
      restaurants.add({'restaurantName': place != null ? place.name : restaurant});
    }
  }
}
