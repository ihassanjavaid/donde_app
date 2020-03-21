import 'package:cloud_firestore/cloud_firestore.dart';

class StoreRetrieve{

  getUserPhoneNo(String phoneNo) {
    return Firestore
        .instance
        .collection('users')
        .where('phoneNo', isEqualTo: phoneNo).getDocuments();
  }

  authenticatePhoneWithPassword(String phoneNo, String password) {
    return Firestore
        .instance
        .collection('users')
        .where('phoneNo', isEqualTo: phoneNo)
        .where('password', isEqualTo: password)
        .getDocuments();
  }

  registerNewUser({String name, String phoneNo, String email, String password}) {
    DocumentReference ref = Firestore.instance.collection('users').document();
    ref.setData({
      'displayName': name,
      'email': email,
      'password': password,
      'phoneNo': phoneNo
    }, merge: true);
  }

  getUserData(String phoneNo) {
    return Firestore
        .instance
        .collection('users')
        .where('phoneNo', isEqualTo: phoneNo)
        .getDocuments();
  }
}