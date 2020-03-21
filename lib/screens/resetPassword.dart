import 'package:donde_app/components/customTextField.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _State createState() => _State();
  static String id = 'reset_password';
}

class _State extends State<ResetPassword> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Reset your password',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),

                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(placeholder:'new password'),

                SizedBox(
                  height: 25,
                ),
                CustomTextField(
                    placeholder: 'confirm new password'),

                SizedBox(
                  height: 25,
                ),

                Container(
                    height: 60,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.redAccent,
                      child: Text('Reset'),
                      onPressed: () {

                      },
                    )),

              ],
            )));
  }
}
