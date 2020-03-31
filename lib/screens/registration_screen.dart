import 'package:flutter/material.dart';
import 'package:donde_app/components/custom_text_field.dart';
import 'package:donde_app/screens/login_screen.dart';
import 'package:donde_app/services/firestore_service.dart';
import 'package:donde_app/services/auth_service.dart';
import 'package:donde_app/screens/dashboard_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _name;
  String _email;
  String _password;
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
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
      height: MediaQuery.of(context).size.height / 2,
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
        height: MediaQuery.of(context).size.height / 2,
        color: Color(0xFFECF0F3),
      ),
    );
  }

  Widget signUpCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
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
                      this._name = value;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    placeholder: 'Your E-Mail',
                    onChanged: (value) {
                      this._email = value;
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
                      this._password = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Password must be at least 6 characters and include a special character and number",
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
                          setState(() {
                            _showSpinner = true;
                          });
                          try {
                            await Auth().registerUser(
                                email: this._email, password: this._password);
                            FirestoreService().registerNewUser(
                                name: this._name, email: this._email);

                            Navigator.pop(context);
                            Navigator.popAndPushNamed(context, Dashboard.id);
                          } catch (e) {
                            print(e);
                            final SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.remove('phoneNumber');
                          }
                          setState(() {
                            _showSpinner = false;
                          });
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
                Navigator.popAndPushNamed(context, LoginScreen.id);
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
