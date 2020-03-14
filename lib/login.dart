import 'package:donde_app/registerButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'customButton.dart';
import 'package:country_code_picker/country_code_picker.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 120.0,
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
              CountryCodePicker(),
              CustomButton(
                buttonLabel: 'Next',
                onTap: () {},
                colour: Color(kButtonContainerColour),
              ),
              RegisterButton(
                buttonLabel: 'LOGIN WITH FACEBOOK',
                onTap: () {},
                colour: Color(0xff2d3c9b),
                icon: FontAwesomeIcons.facebook,
              ),
              RegisterButton(
                icon: FontAwesomeIcons.google,
                buttonLabel: 'LOGIN WITH GOOGLE',
                onTap: () {},
                colour: Color(0xffeb4e3f),
              )
            ],
          ),
        ),
      ),
    );
  }
}
