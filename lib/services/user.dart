import 'package:cloud_firestore/cloud_firestore.dart';

import '../store.dart';
class User {
  static String phoneNumber;
  static StoreRetrieve store = StoreRetrieve();

  static QuerySnapshot getCurrentUserData() {
    return store.getUserData(phoneNumber);
  }

}