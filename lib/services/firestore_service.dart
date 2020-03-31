import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreService {
  final _firestore = Firestore();

  Future<bool> userExists(String phoneNumber) async {
    var userData = await _firestore
        .collection('users')
        .where('phoneNo', isEqualTo: phoneNumber)
        .getDocuments();

    return userData.documents.length > 0;
  }

  Future<QuerySnapshot> getUserDocuments(String phoneNo) {
    return _firestore
        .collection('users')
        .where('phoneNo', isEqualTo: phoneNo)
        .getDocuments();
  }

  Future<String> getUserEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String phoneNo = pref.getString('phoneNumber');
    String email = '';

    final userDocuments = await getUserDocuments(phoneNo);

    for (var document in userDocuments.documents) {
      email = document['email'];
    }

    return email;
  }

  authenticatePhoneWithPassword(String phoneNo, String password) {
    return _firestore
        .collection('users')
        .where('phoneNo', isEqualTo: phoneNo)
        .where('password', isEqualTo: password)
        .getDocuments();
  }

  registerNewUser({String name, String email}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String phoneNo = pref.getString('phoneNumber');
    DocumentReference ref = _firestore.collection('users').document();

    ref.setData({'displayName': name, 'email': email, 'phoneNo': phoneNo},
        merge: true);
  }

  void addRestaurantToPreference(
      String restaurantToBeStored, String preference) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String phoneNo = pref.getString('phoneNumber');
    bool restaurantAlreadyInStore = false;

    // Get current user's documents from Firestore
    final userDocuments = await _firestore
        .collection('users')
        .where('phoneNo', isEqualTo: phoneNo)
        .getDocuments();

    for (var document in userDocuments.documents) {
      // Get the collection based on preference from the fetched document(s)
      CollectionReference restaurants = _firestore
          .collection('users')
          .document(document.documentID)
          .collection(preference);

      // Get the documents from the acquired collection
      print(restaurants.id);
      final restaurantsInPreference = await _firestore
          .collection('users')
          .document(document.documentID)
          .collection(restaurants.id)
          .getDocuments();

      // Check in the documents if the restaurant already exists
      for (var restaurant in restaurantsInPreference.documents) {
        if (restaurantToBeStored == restaurant['restaurantName']) {
          restaurantAlreadyInStore = true;
          break;
        }
      }

      // Add the restaurant to the user store
      if (!restaurantAlreadyInStore) {
        restaurants.add({'restaurantName': restaurantToBeStored});
      }
    }
  }

  void updateLikedRestaurantNotificationStatus(
      {String userID, String restaurantToBeUpdated}) async {
    // Get the collection reference for the user's required restaurant
    final CollectionReference restaurantUpdateReference = _firestore
        .collection('liked_restaurants')
        .where('userID', isEqualTo: userID)
        .where('restaurantName', isEqualTo: restaurantToBeUpdated);

    // Update the notified status
    restaurantUpdateReference.add({'notified': true});
  }

  getFriendLikedRestaurants(String friendNumber) async {
    List likedRestaurantsList = [];
    // Get user data
    final friendDocuments = await getUserDocuments(friendNumber);

    // Look up liked restaurants
    for (var document in friendDocuments.documents) {
      final likedRestaurants = await _firestore
          .collection('users')
          .document(document.documentID)
          .collection('liked_restaurants')
          .getDocuments();
      for (var restaurant in likedRestaurants.documents) {
        likedRestaurantsList.add(restaurant['restaurantName']);
      }
    }
    return likedRestaurantsList;
  }
}
