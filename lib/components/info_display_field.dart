import 'package:flutter/material.dart';
import 'package:donde_app/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoDisplayField extends StatelessWidget {
  final String label;

  InfoDisplayField({
    @required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Icon(
                  FontAwesomeIcons.hotel,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  this.label,
                  style: kSettingWidgetTextStyle,
                ),
              ),
            ],
          ),
          Expanded(
            child: Divider(
              thickness: 1.0,
            ),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 6),
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Color(kDefaultBackgroundColour),
      ),
    );
  }
}
