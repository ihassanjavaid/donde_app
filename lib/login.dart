import 'package:donde_app/customIconButton.dart';
import 'package:donde_app/registration.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'customButton.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dividerWithText.dart';
import 'password.dart';

class Login extends StatelessWidget {
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
                    MobileNumberInputField(),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Password(),
                    ),
                  );
                },
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
                onTap: () {},
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
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }
}

class MobileNumberInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.number,
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
    );
  }
}
