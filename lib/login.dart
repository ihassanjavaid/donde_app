import 'package:donde_app/customIconButton.dart';
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
                height: 90.0,
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
                      color: Colors.red,
                      thickness: 1.0,
                    ),
                    Text('Enter your mobile number'),
                  ],
                ),
                margin: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              CustomButton(
                buttonLabel: 'Next',
                onTap: () {},
                colour: Color(kButtonContainerColour),
              ),
              SizedBox(
                height: 30.0,
              ),
              DividerWithText(),
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

class DividerWithText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            thickness: 1.0,
            color: Color(0xffa9a9a9),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Or connect with',
            style: kNormalTextStyle,
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1.0,
            color: Color(0xffa9a9a9),
          ),
        ),
      ],
    );
  }
}
