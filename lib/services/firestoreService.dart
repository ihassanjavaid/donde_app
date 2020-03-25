import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:donde_app/services/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contactsClass.dart';

class FirestoreService {
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

  Future<UserData> getCurrentUserData() async {
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

  void addRestaurantToPreference(
      String restaurantToBeStored, String preference) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String phoneNo = pref.getString('phoneNumber');
    final fireStore = Firestore();
    bool restaurantAlreadyInStore = false;

    // Get current user's documents from Firestore
    final userDocuments = await fireStore
        .collection('users')
        .where('phoneNo', isEqualTo: phoneNo)
        .getDocuments();

    for (var document in userDocuments.documents) {
      // Get the collection based on preference from the fetched document(s)
      CollectionReference restaurants = fireStore
          .collection('users')
          .document(document.documentID)
          .collection(preference);

      // Get the documents from the acquired collection
      print(restaurants.id);
      final restaurantsInPreference = await fireStore
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

      if (restaurantAlreadyInStore == false)
        if (preference == 'liked_restaurants') {
          restaurants.add({'restaurantName': restaurantToBeStored, 'notified': false});
        } else {
          restaurants.add({'restaurantName': restaurantToBeStored});
        }
    }
  }

  Future<List<String>> getCurrentUserLikedRestaurants() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String phoneNo = pref.getString('phoneNumber');
    final fireStore = Firestore();
    List<String> currentUserLikedRestaurants = [];

    final currentUserData = await fireStore
        .collection('users')
        .where('phoneNo', isEqualTo: phoneNo)
        .getDocuments();

    for (var document in currentUserData.documents) {
      CollectionReference restaurants = fireStore
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
  }

  Future<List> getCurrentUserFriends() async {
    List<Contact> contacts = await ContactsClass.getContacts();
    List<String> friendsDocumentReferencesList = [];

    for (var contact in contacts) {
      contact.phones.forEach((phoneNum) async {
        QuerySnapshot query = await Firestore.instance
            .collection('users')
            .where('phoneNo', isEqualTo: phoneNum.value.replaceAll(" ", ""))
            .getDocuments();

        for (var document in query.documents) {
          friendsDocumentReferencesList.add(document.documentID);
        }
      });
    }
    return friendsDocumentReferencesList;
  }

  void updateLikedRestaurantNotificationStatus() {

  }
}
