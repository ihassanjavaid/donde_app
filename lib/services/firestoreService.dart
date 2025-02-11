import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donde_app/services/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreService {
  final _firestore = Firestore();

  getUserDocuments(String phoneNo) {
    return _firestore
        .collection('users')
        .where('phoneNo', isEqualTo: phoneNo)
        .getDocuments();
  }

  authenticatePhoneWithPassword(String phoneNo, String password) {
    return _firestore
        .collection('users')
        .where('phoneNo', isEqualTo: phoneNo)
        .where('password', isEqualTo: password)
        .getDocuments();
  }

  registerNewUser(
      {String name, String phoneNo, String email, String password}) {
    DocumentReference ref = _firestore.collection('users').document();
    ref.setData({
      'displayName': name,
      'email': email,
      'password': password,
      'phoneNo': phoneNo
    }, merge: true);
  }

  Future<UserData> getCurrentUserData() async {
    String phoneNumber;
    String displayName;
    String email;
    UserData userData;

    SharedPreferences pref = await SharedPreferences.getInstance();
    final String phoneNo = pref.getString('phoneNumber');

    // final documents = store.getUserData(phoneNumber);
    final documents = await _firestore
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

  void addRestaurantToPreference(
      String restaurantToBeStored, String preference) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String phoneNo = pref.getString('phoneNumber');
    bool restaurantAlreadyInStore = false;

    /* // Get the collection based on required preference
    final CollectionReference preferenceBasedRestaurants = _firestore.collection(preference);

    // Check in the collection documents if the restaurant already exists
    final restaurantsInPreference = await preferenceBasedRestaurants.getDocuments();
    for (var restaurant in restaurantsInPreference.documents) {
      if (restaurantToBeStored == restaurant['restaurantName']) {
        restaurantAlreadyInStore = true;
        break;
      }
    }

    // Store the restaurant as per the required preference
    if (!restaurantAlreadyInStore) {
      if (preference == 'liked_restaurants')
        preferenceBasedRestaurants.add({'restaurantName': restaurantToBeStored, 'notified': false, 'userID': phoneNo});
      else
        preferenceBasedRestaurants.add({'restaurantName': restaurantToBeStored, 'userID': phoneNo});
    }*/

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

  /*Future<List<String>> getCurrentUserLikedRestaurants() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String phoneNo = pref.getString('phoneNumber');
    List<String> currentUserLikedRestaurants = [];

    final currentUserData = await _firestore
        .collection('users')
        .where('phoneNo', isEqualTo: phoneNo)
        .getDocuments();

    for (var document in currentUserData.documents) {
      CollectionReference restaurants = _firestore
          .collection('users')
          .document(document.documentID)
          .collection('liked_restaurants');
      final likeRestaurants = await restaurants.getDocuments();
      for (var restaurant in likeRestaurants.documents) {
        currentUserLikedRestaurants.add(restaurant['restaurantName']);
      }
    }
    print(currentUserLikedRestaurants);
    return currentUserLikedRestaurants;
  }*/

  /*Future<List> getCurrentUserFriends() async {
    List<Contact> contacts = await ContactsClass.getContacts();
    List<String> friendsDocumentReferencesList = [];

    for (var contact in contacts) {
      contact.phones.forEach((phoneNum) async {
        QuerySnapshot query = await _firestore
            .collection('users')
            .where('phoneNo', isEqualTo: phoneNum.value.replaceAll(" ", ""))
            .getDocuments();

        for (var document in query.documents) {
          friendsDocumentReferencesList.add(document.documentID);
        }
      });
    }
    return friendsDocumentReferencesList;
  }*/

  void updateLikedRestaurantNotificationStatus(
      {String userID, String restaurantToBeUpdated}) async {
    /*final CollectionReference likedRestaurant = _firestore
        .collection('users')
        .document(friend.documentID)
        .collection('liked_restaurants')
        .where('restaurantName', isEqualTo: restaurantToBeUpdated);

    likedRestaurant.add({'notified': true});*/
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
