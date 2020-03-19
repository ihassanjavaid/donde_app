import 'package:donde_app/components/customIconButton.dart';
import 'package:donde_app/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';
import '../components/customButton.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../components/dividerWithText.dart';
import 'password.dart';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:donde_app/auth.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String phoneNo;
  String smsCode;
  String verificationId;

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verID) {
      this.verificationId = verID;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
       for ( int i = 0 ; i < 50 ; i++)
         print('signed in\n');
      });
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential user) {
      print('verified');
      print(user.toString());
    };

    final PhoneVerificationFailed verifiFailed = (AuthException authEx) {
      print('${authEx.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifiFailed
    );
  }

    Future<bool> smsCodeDialog(BuildContext context) {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter SMS Code'),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              FlatButton(
                child: Text('Proceed'),
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then( (user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
                    }
                    else {
                      Navigator.of(context).pop();
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        }
      );
    }

    signIn() async {

      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

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
    }


  void initState() {
    super.initState();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Text(
                'Hello',
                style: kWelcomeTextStyle,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Get started, Enter your phone number',
                style: kSubtitleStyle,
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    CountryCodePicker(),
                    VerticalDivider(
                      color: Colors.redAccent,
                      thickness: 1.0,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          this.phoneNo = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter Number',
                          hasFloatingPlaceholder: true,
                          labelStyle: TextStyle(
                            color: Colors.redAccent,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.redAccent,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                margin: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              CustomButton(
                buttonLabel: 'Next',
                onTap: verifyPhone,/*() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Password(),
                    ),
                  );
                }, */
                colour: Color(kButtonContainerColour),
              ),
              SizedBox(
                height: 30.0,
              ),
              DividerWithText(
                text: 'Or connect with',
              ),
              SizedBox(
                height: 15.0,
              ),
              CustomIconButton(
                buttonLabel: 'LOGIN WITH FACEBOOK',
                onTap: _handleFbSignIn,
                colour: Color(0xff2d3c9b),
                icon: FontAwesomeIcons.facebook,
              ),
              CustomIconButton(
                icon: FontAwesomeIcons.google,
                buttonLabel: 'LOGIN WITH GOOGLE',
                onTap: _handleGSignIn,
                colour: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleGSignIn() async {
    try {
      //await _googleSignIn.signIn();
      //authService.googleSignIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleFbSignIn() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        //_sendTokenToServer(result.accessToken.token);
        //_showLoggedInUI();
        break;
      case FacebookLoginStatus.cancelledByUser:
        //_showCancelledMessage();
        break;
      case FacebookLoginStatus.error:
        //_showErrorOnUI(result.errorMessage);
        break;
    }
  }
}

/*
class MobileNumberInputField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Expanded(

    );
  }
}
*/
