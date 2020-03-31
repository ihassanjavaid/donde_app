import 'package:flutter/cupertino.dart';

class UserData {
  final String phoneNumber;
  final String displayName;
  final String email;

  UserData(
      {@required this.phoneNumber,
      @required this.displayName,
      @required this.email});

  @override
  String toString() {
    String data =
        "Display name: $displayName\nPhone Number: $phoneNumber\nEmail: $email";
    return data;
  }
}
