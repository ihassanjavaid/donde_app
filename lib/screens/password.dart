import 'package:flutter/material.dart';
import '../constants.dart';
import '../components/customButton.dart';
import 'registration.dart';
import '../components/customTextField.dart';

class Password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              ),
              SizedBox(
                height: 40.0,
              ),
              CustomButton(
                buttonLabel: 'Next',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Registration(),
                    ),
                  );
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
