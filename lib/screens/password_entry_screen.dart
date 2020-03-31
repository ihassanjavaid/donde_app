import 'package:flutter/material.dart';
import 'package:donde_app/constants.dart';
import 'package:donde_app/components/custom_text_field.dart';
import 'package:donde_app/components/rounded_button.dart';
import 'package:donde_app/services/auth_service.dart';

String password;

class PasswordEntryScreen extends StatelessWidget {
  static const String id = 'password_entry_screen';

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
                  password = value;
                },
              ),
              SizedBox(
                height: 40.0,
              ),
              RoundedButton(
                buttonLabel: 'Next',
                onTap: () async {
                  await Auth().loginUserWithEmailAndPassword();
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
