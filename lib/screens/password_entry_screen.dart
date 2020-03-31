import 'package:flutter/material.dart';
import 'package:donde_app/utilities/constants.dart';
import 'package:donde_app/components/custom_text_field.dart';
import 'package:donde_app/components/rounded_button.dart';
import 'package:donde_app/services/auth_service.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard_screen.dart';

class PasswordEntryScreen extends StatefulWidget {
  static const String id = 'password_entry_screen';

  @override
  _PasswordEntryScreenState createState() => _PasswordEntryScreenState();
}

class _PasswordEntryScreenState extends State<PasswordEntryScreen> {
  String _password;
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: _showSpinner,
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
                    _password = value;
                  },
                ),
                SizedBox(
                  height: 40.0,
                ),
                RoundedButton(
                  buttonLabel: 'Next',
                  onTap: () async {
                    setState(() {
                      _showSpinner = true;
                    });
                    try {
                      await Auth().loginUserWithEmailAndPassword(
                          userPassword: _password);
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
