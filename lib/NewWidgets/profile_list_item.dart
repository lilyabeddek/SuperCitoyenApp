import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10 * 5.5,
      margin: EdgeInsets.symmetric(
        horizontal: 10.0 * 4,
      ).copyWith(
        bottom: 20,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color.fromRGBO(78, 120, 236, 0.01),
        border: Border.all(
          color: Color.fromRGBO(34, 43, 69, 0.5),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.icon,
            size: 10 * 2.5,
          ),
          SizedBox(width: 10 * 1.5),
          Text(
            this.text,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          if (this.hasNavigation)
            Icon(
              Icons.arrow_right,
              size: 10 * 2.5,
            ),
        ],
      ),
    );
  }
}
