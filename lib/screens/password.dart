import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants.dart';
import '../components/customButton.dart';
import '../components/customTextField.dart';
import 'package:donde_app/store.dart';
import 'index.dart';

class Password extends StatefulWidget {
  final phoneNumber;

  Password({this.phoneNumber});

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool showSpinner = false;
  static const String id = 'password_screen';
  String email;
  String password;

  final phoneNumber;
  _PasswordState({this.phoneNumber});

  Future<void> authenticatePassword() async {
    setState(() {
      this.showSpinner = true;
    });
    StoreRetrieve().authenticatePhoneWithPassword(phoneNumber, password)
        // ignore: missing_return
        .then((QuerySnapshot docs) {
          setState(() {
            this.showSpinner = false;
          });
      if (docs.documents.isNotEmpty) {
        print('authenticated from firestore');
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Index(phoneNumber: this.phoneNumber,)));
        return true;
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Invalid Password!",
          desc: "You have written an invalid password! Please try again.",
          buttons: [
            DialogButton(
              color: Colors.redAccent,
              child: Text(
                "Retry",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: this.showSpinner,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  'Welcome Back!',
                  style: kWelcomeTextStyle,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Please enter your pasword to continue',
                  style: kSubtitleStyle,
                ),
                SizedBox(
                  height: 40.0,
                ),
                CustomTextField(
                  placeholder: 'Password',
                  isPassword: true,
                  onChanged: (value) {
                    this.password = value;
                  },
                ),
                SizedBox(
                  height: 40.0,
                ),
                CustomButton(
                  buttonLabel: 'Next',
                  onTap: () {
                    authenticatePassword();
                    /* _auth.currentUser().then((user) {
                      this.email = user.email;
                      _auth.signInWithEmailAndPassword(
                          email: null, password: this.password);
                    });
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, Home.id);*/
                  },
                  colour: Color(kButtonContainerColour),
                ),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
