/*

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class AuthService {

  final GoogleSignIn _googleSignIn  = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Observable<FirebaseUser> user; // firebase user
  Observable<Map<String, dynamic>> profile; // custom user data in Firestore

  PublishSubject loading = PublishSubject(); //observable that we can push new values to

  AuthService(){
    user = Observable(_auth.onAuthStateChanged); // from firebase as a stream by default - changes every time a user signs in or out

    profile = user.switchMap((FirebaseUser u) {
      if (u != null){
        return _db.collection('users').document(u.uid).snapshots().map((snap) => snap.data);
      }
      else {
        return Observable.just({});
      }
    });

  }

  Future<FirebaseUser> googleSignIn() async {
    loading.add(true);
    // follow steps required to get the user signed in
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    // trigger process which will give id token
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

     // at this time user will be signed in google not firebase, take the token pass it to firebase to do so


   */
/*FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );*//*


    final AuthCredential credential =  GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken);

    FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.signInWithCredential(credential).then((user) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home()
        ),
      );
    }).catchError((e) {
      print(e);
    });


   AuthResult _authResult = await _auth.signInWithCustomToken(token: googleAuth.idToken);
   FirebaseUser user = await _authResult.user;

    updateUserData(user);
    for (int i = 0 ; i < 50 ; i++ )
      print("signed in " + user.displayName);

    loading.add(false);
    return user;
  }

  void updateUserData(FirebaseUser user) async { // update userdata in firestore
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  void signOut(){
    _auth.signOut();
  }

}

final AuthService authService = AuthService();
*/
