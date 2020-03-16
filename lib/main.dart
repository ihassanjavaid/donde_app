import 'package:donde_app/explore.dart';
import 'package:donde_app/index.dart';
import 'package:donde_app/login.dart';
import 'package:donde_app/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(Donde());

class Donde extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        backgroundColor: Color(0xfff8f8f8),
      ),
      home: Login(),
    );
  }
}
