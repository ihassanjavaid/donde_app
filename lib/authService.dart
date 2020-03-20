import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  String name;
  String email;
  String imageUrl;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Observable<FirebaseUser> user; // firebase user
  Observable<Map<String, dynamic>> profile; // custom user data in Firestore

  PublishSubject loading =
      PublishSubject(); //observable that we can push new values to

  AuthService() {
    user = Observable(_auth
        .onAuthStateChanged); // from firebase as a stream by default - changes every time a user signs in or out

    profile = user.switchMap((FirebaseUser u) {
      if (u != null) {
        return _db
            .collection('users')
            .document(u.uid)
            .snapshots()
            .map((snap) => snap.data);
      } else {
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

//     FirebaseUser user = await this._auth.signInWithGoogle(
//      accessToken: googleAuth.accessToken,
//      idToken: googleAuth.idToken
//    );

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    FirebaseAuth _auth = FirebaseAuth.instance;

    final authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    /*AuthResult _authResult =
        await _auth.signInWithCustomToken(token: googleAuth.idToken);
    FirebaseUser firebaseUser = _authResult.user;

    updateUserData(firebaseUser);
    for (int i = 0; i < 50; i++) print("signed in " + user.displayName);*/
    AuthResult _authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser firebaseUser = _authResult.user;

    assert(firebaseUser.email != null);
    assert(firebaseUser.displayName != null);
    assert(firebaseUser.photoUrl != null);

    name = firebaseUser.displayName;
    email = firebaseUser.email;
    imageUrl = firebaseUser.photoUrl;

    updateUserData(firebaseUser);

    loading.add(false);
    return user;
  }

  static void updateUserEmail(AuthResult authResult, String email) async {
    final FirebaseUser firebaseUser = authResult.user;
    DocumentReference ref =
        Firestore.instance.collection('users').document(firebaseUser.uid);

    return ref.setData({
      'uid': firebaseUser.uid,
      'email': email,
      'photoURL': firebaseUser.photoUrl,
      'displayName': firebaseUser.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  static Future<String> getData(AuthResult authResult) async {
    final FirebaseUser firebaseUser = authResult.user;
    DocumentReference ref =
        Firestore.instance.collection('users').document(firebaseUser.uid);

    StreamBuilder streamBuilder =
        Firestore.instance.collection('user').snapshots() as StreamBuilder;
  }

  void updateUserData(FirebaseUser user) async {
    // update userdata in firestore
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  void signOut() {
    _auth.signOut();
  }
}
