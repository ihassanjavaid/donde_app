import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';

class SettingWidget extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color colour;
  final String label;

  SettingWidget(
      {@required this.onTap, @required this.icon, this.colour, this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Icon(
                    this.icon,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    this.label,
                    style: kSettingWidgetTextStyle,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(
                    FontAwesomeIcons.arrowRight,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Divider(
                thickness: 1.0,
                height: 0.75,
              ),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 15.0),
//      width: double.infinity,
        height: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: this.colour,
        ),
      ),
    );
  }
}
