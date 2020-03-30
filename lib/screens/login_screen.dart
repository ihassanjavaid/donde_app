import 'package:flutter/material.dart';
import 'package:donde/constants.dart';
import 'package:donde/components/rounded_button.dart';
import 'package:country_code_picker/country_code_picker.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
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
                          Expanded(
                            flex: 1,
                            child: CountryCodePicker(
                              initialSelection: 'pk',
                              onInit: (countryCode) {},
                              onChanged: (countryCode) {},
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {},
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
                      onTap: () {},
                      /*onTap: () {
                          Navigator.pushNamed(context, Index.id);
                        },*/
                      colour: Color(kButtonContainerColour),
                    ),
                    SizedBox(
                      height: 30.0,
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
}
