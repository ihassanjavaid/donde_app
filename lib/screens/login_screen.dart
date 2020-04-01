import 'package:flutter/material.dart';
import 'package:donde_app/utilities/constants.dart';
import 'package:donde_app/components/rounded_button.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:donde_app/services/firestore_service.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:donde_app/screens/password_entry_screen.dart';
import 'package:donde_app/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  String countryCode;
  String phoneNumber;
  bool _showSpinner = false;

  @override
  void initState() {
    super.initState();
    _getPermissions();
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

  void _getPermissions() async {
    await Permission.location.request();
    await Permission.contacts.request();
  }

  void decideLoginRoute(String completePhoneNumber) async {
    if (completePhoneNumber != null) {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      setState(() {
        _showSpinner = true;
      });
      try {
        final userExists =
            await FirestoreService().userExists(completePhoneNumber);
        await pref.setString('phoneNumber', completePhoneNumber);
        if (userExists) {
          // Returning user
          print('Returning User');
          Navigator.pushNamed(context, PasswordEntryScreen.id);
        } else {
          // New user
          print('New User');
          Navigator.pushNamed(context, RegistrationScreen.id);
        }
      } catch (e) {
        pref.remove('phoneNumber');
        Alert(
          context: context,
          type: AlertType.error,
          title: "Error",
          desc: e,
          buttons: [
            DialogButton(
              color: Colors.redAccent,
              child: Text(
                "Okay",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              width: 120,
            )
          ],
        ).show();
      }
      setState(() {
        _showSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: SizedBox(
                    height: 50.0,
                  ),
                ),
                Flexible(
                  child: Text(
                    'Hello!',
                    style: kWelcomeTextStyle.copyWith(
                        fontSize: animation.value * 48),
                  ),
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
                            Flexible(
                              flex: 1,
                              child: CountryCodePicker(
                                initialSelection: 'us',
                                onInit: (countryCode) {
                                  this.countryCode = countryCode.toString();
                                },
                                onChanged: (countryCode) {
                                  // Store user country code
                                  this.countryCode = countryCode.toString();
                                },
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                onChanged: (value) {
                                  // Store user phone number
                                  this.phoneNumber = value;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
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
                      RoundedButton(
                        buttonLabel: 'Next',
                        onTap: () {
                          // Process number
                          String completePhoneNumber =
                              this.countryCode + this.phoneNumber;
                          decideLoginRoute(completePhoneNumber);
                        },
                        colour: Color(kButtonContainerColour),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
