import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<void> loginUserWithPhoneNumber(String password) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var phoneNumber = pref.getString('phoneNumber');
  }
}
