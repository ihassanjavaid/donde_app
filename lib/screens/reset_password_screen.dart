import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donde_app/services/auth_service.dart';
import 'package:donde_app/utilities/constants.dart';
import 'package:donde_app/utilities/user_data.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/custom_text_field.dart';
import '../services/firestore_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset_password_screen';

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showSpinner = false;
  UserData userData;
  String oldPassword;
  String newPassword1;
  String newPassword2;

  bool _ifPasswordsMatch() {
    return this.newPassword1 == this.newPassword2;
  }

  Future<void> _authenticateAndUpdatePassword() async {
    if (_ifPasswordsMatch()) {
      print("passwords match yay!");
      print(this.newPassword2);

      setState(() {
        this.showSpinner = true;
      });
      final updateStatus = await Auth().updateUserPassword(newPassword1);
      if (updateStatus) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Success!",
          desc: "Your password has been changed successfully.",
          buttons: [
            DialogButton(
              color: Colors.redAccent,
              child: Text(
                "Great",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              width: 120,
            )
          ],
        ).show();
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Error!",
          desc:
              "Unable to update the password\nKindly logout and then login again to update the password",
          buttons: [
            DialogButton(
              color: Colors.redAccent,
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              width: 120,
            )
          ],
        ).show();
      }
      setState(() {
        this.showSpinner = false;
      });
      /*QuerySnapshot docs = await FirestoreService()
          .authenticatePhoneWithPassword(phoneNumber, this.oldPassword);
      setState(() {
        this.showSpinner = false;
      });

      if (docs.documents.isNotEmpty) {
        // firebase query to change password
        print(phoneNumber);
        QuerySnapshot query = await Firestore.instance
            .collection('users')
            .where('phoneNo', isEqualTo: phoneNumber)
            .getDocuments();
        CollectionReference ref = Firestore.instance.collection('users');

        for (var document in query.documents) {
          print(document.documentID);
          print(document.data);
          ref
              .document(document.documentID)
              .updateData({'password': newPassword1});
        }

        Alert(
          context: context,
          type: AlertType.success,
          title: "Success!",
          desc: "Your password has been changed successfully.",
          buttons: [
            DialogButton(
              color: Colors.redAccent,
              child: Text(
                "Retry",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              width: 120,
            )
          ],
        ).show();
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Invalid Password!",
          desc: "You have written an invalid password! Please try again.",
          buttons: [
            DialogButton(
              color: Colors.redAccent,
              child: Text(
                "Retry",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }*/
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Passwords don't match!",
        desc:
            "The passwords you've written don't match with each other! Please try again.",
        buttons: [
          DialogButton(
            color: Colors.redAccent,
            child: Text(
              "Retry",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image(
                image: AssetImage(
                  'images/logo.png',
                ),
                fit: BoxFit.cover,
              ),
              height: 86,
              width: 86,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: AutoSizeText(
                'Reset your password',
                maxLines: 1,
                style:
                    kWelcomeTextStyle /*TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          fontSize: 40)*/
                ,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CustomTextField(
                placeholder: 'New password',
                isPassword: true,
                onChanged: (value) {
                  this.newPassword1 = value;
                }),
            SizedBox(
              height: 25,
            ),
            CustomTextField(
                placeholder: 'Confirm new password',
                isPassword: true,
                onChanged: (value) {
                  this.newPassword2 = value;
                }),
            SizedBox(
              height: 25,
            ),
            Container(
                height: 60,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  child: Text(' Reset '),
                  onPressed: () {
                    _authenticateAndUpdatePassword();
                  },
                )),
          ],
        ),
      ),
    );
  }
}
