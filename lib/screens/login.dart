import 'package:donde_app/components/customIconButton.dart';
import 'package:donde_app/screens/home.dart';
import 'package:donde_app/screens/password.dart';
import 'package:donde_app/screens/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';
import '../components/customButton.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../components/dividerWithText.dart';
import 'index.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  String countryCode;
  String phoneNo;
  String completePhoneNo;
  String smsCode;
  String verificationId;

  AnimationController controller;
  Animation animation;
  final _auth = FirebaseAuth.instance;

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verID) {
      this.verificationId = verID;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        for (int i = 0; i < 50; i++) print('signed in\n');
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
        phoneNumber: this.completePhoneNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifiFailed);
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
                  signIn();
                /*  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed(Password.id);

                      //MaterialPageRoute(builder: (context) => Home()));
                    } else {
                      Navigator.of(context).pop();
                      signIn();
                    }
                  });*/
                },
              )
            ],
          );
        });
  }

  signIn() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );



    FirebaseAuth _auth = FirebaseAuth.instance;

    final user = await _auth.signInWithCredential(credential);

    user.user.linkWithCredential(credential);

    if (user != null && user.user.email != null) {
      Navigator.pushReplacementNamed(context, Password.id);
    }
    else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (value) => Registration(usercred: credential)
      ));
    }
  }

  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation =
        CurvedAnimation(parent: this.controller, curve: Curves.bounceOut);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Text(
                'Hello!',
                style:
                    kWelcomeTextStyle.copyWith(fontSize: animation.value * 48),
              ),
              AnimatedOpacity(
                opacity: controller.value,
                duration: Duration(milliseconds: 500),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        'Get started, Enter your phone number',
                        style: kSubtitleStyle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          CountryCodePicker(
                            onChanged: (countryCode) {
                              this.countryCode = countryCode.toString();
                            },
                          ),
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
                      onTap: () {
                        this.completePhoneNo = this.countryCode + this.phoneNo;
                        verifyPhone();
                      },
                      /*onTap: () {
                        Navigator.pushNamed(context, Index.id);
                      },*/
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
            ],
          ),
        ),
      ),
    );
  }




  Future<void> _handleGSignIn() async {
    try {
      await _googleSignIn.signIn();
//      await authService.googleSignIn();
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

/*class AuthService {
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

    */ /*FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );*/ /*

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.signInWithCredential(credential).then((user) {
      for (int i = 0; i < 10; i++) print('singned in');
    }).catchError((e) {
      print(e);
    });

    AuthResult _authResult =
        await _auth.signInWithCustomToken(token: googleAuth.idToken);
    FirebaseUser user = await _authResult.user;

    updateUserData(user);
    for (int i = 0; i < 50; i++) print("signed in " + user.displayName);

    loading.add(false);
    return user;
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

final AuthService authService = AuthService();*/
