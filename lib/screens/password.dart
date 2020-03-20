import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../components/customButton.dart';
import 'home.dart';
import 'registration.dart';
import '../components/customTextField.dart';

// ignore: must_be_immutable
class Password extends StatelessWidget {
  static const String id = 'password_screen';
  String email;
  String password;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  _auth.currentUser().then((user) {
                    this.email = user.email;
                    _auth.signInWithEmailAndPassword(
                        email: null, password: this.password);
                  });
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, Home.id);
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
    );
  }
}
