import 'package:donde_app/services/firestoreService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'index.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import '../components/customTextField.dart';

// ignore: must_be_immutable
class Registration extends StatelessWidget {
  AuthCredential userCred;
  AuthResult user;
  static const String id = 'registration_screen';
  double screenHeight;
  String email;
  String name;
  String password;
  final phoneNo;
  bool _showSpinner = false;

  Registration({this.userCred, this.user, this.phoneNo});

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              lowerHalf(context),
              upperHalf(context),
              signUpCard(context),
              pageTitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      child: Image.asset(
        'images/food.jpeg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: screenHeight / 2,
        color: Color(0xFFECF0F3),
      ),
    );
  }

  Widget signUpCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 5),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 18,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    placeholder: 'Your Name',
                    onChanged: (value) {
                      this.name = value;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    placeholder: 'Your E-Mail',
                    onChanged: (value) {
                      this.email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    placeholder: 'Your Password',
                    isPassword: true,
                    onChanged: (value) {
                      this.password = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Password must be at least 8 characters and include a special character and number",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      FlatButton(
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(fontSize: 16),
                        ),
                        color: Colors.redAccent,
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            left: 38, right: 38, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () async {
                          _showSpinner = true;
                          print('pressed register button');

                          FirestoreService().registerNewUser(
                              name: this.name,
                              email: this.email,
                              phoneNo: this.phoneNo,
                              password: this.password);

                          await SharedPreferences.getInstance().then(
                            (prefs) async {
                              await prefs.setString(
                                  'phoneNumber', this.phoneNo);
                            },
                          );
                          _showSpinner = false;
                          Alert(
                            context: context,
                            type: AlertType.success,
                            title: "Congtratulations!",
                            desc:
                                "You are now registered for Donde!\nHappy hoteling.",
                            buttons: [
                              DialogButton(
                                color: Colors.redAccent,
                                child: Text(
                                  "Go to Home!",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () {
                                  _showSpinner = true;
                                  Navigator.pushReplacementNamed(
                                      context, Index.id);
                                  _showSpinner = false;
                                },
                                width: 150,
                              )
                            ],
                          ).show();

                          /*try {
                            AuthService.updateUserEmail(user, this.email);
                            FirebaseUser temp = await _auth.currentUser();

                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: this.email, password: this.password);

                            if (newUser != null) {
                              newUser.user
                                  .updatePhoneNumberCredential(userCred);
//                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(context, Index.id);
                            }
                          } catch (e) {
                            print(e);
                          }*/
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Already have an account?",
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              textColor: Colors.black87,
              child: Text(
                "LOGIN",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FlatButton(
            child: Text(
              "Terms & Conditions",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget pageTitle() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.fastfood,
            size: 58,
            color: Colors.white,
          ),
          Text(
            "Donde",
            style: TextStyle(
                fontSize: 60,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal),
          )
        ],
      ),
    );
  }
}
