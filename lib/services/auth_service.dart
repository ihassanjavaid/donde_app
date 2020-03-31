import 'package:firebase_auth/firebase_auth.dart';
import 'package:donde_app/services/firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<void> loginUserWithEmailAndPassword({String userPassword}) async {
    // Get user email
    final userEmail = await FirestoreService().getUserEmail();

    // Use the email and password to sign-in the user
    try {
      await _auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
    } catch (e) {
      print(e);
      throw 'Invalid username or password';
    }
  }

  Future<void> registerUser({String email, String password}) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
