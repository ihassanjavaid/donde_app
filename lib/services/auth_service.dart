import 'package:firebase_auth/firebase_auth.dart';
import 'package:donde_app/services/firestore_service.dart';

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

  Future<bool> updateUserPassword(String newPassword) async {
    FirebaseUser user = await _auth.currentUser();

    try {
      await user.updatePassword(newPassword);
      return true;
    } catch (e) {
      return false;
    }

    /*await user.updatePassword(newPassword).then((_) {
      print('Password change successful');
      return true;
    }).catchError((error) {
      print('Could not update the password' + error.toString());
      return false;
    });*/
  }
}
