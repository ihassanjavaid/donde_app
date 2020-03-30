import 'package:flutter/material.dart';
import 'package:donde/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsControl extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color colour;
  final String label;
  final bool canToggle;
  final bool toggle;

  SettingsControl({
    @required this.onTap,
    @required this.icon,
    @required this.colour,
    @required this.label,
    this.canToggle = false,
    this.toggle = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                    canToggle
                        ? FontAwesomeIcons.toggleOn
                        : FontAwesomeIcons.arrowRight,
                    color: toggle ? Colors.red : Colors.grey,
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
          color: this.colour,
        ),
      ),
    );
  }
}
