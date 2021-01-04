import 'package:flutter/cupertino.dart';

//import 'dart:ui';
import 'package:flutter/material.dart';

class WidgetNotification extends StatelessWidget {
  final bool nouvelle;
  WidgetNotification(this.nouvelle);
  Color getColor() {
    if (nouvelle) return Color.fromRGBO(78, 120, 236, 1);
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 5, bottom: 5),
      height: 70,
      decoration: BoxDecoration(
        color: getColor().withOpacity(0.05),
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://cdn.futura-sciences.com/buildsv6/images/wide1920/d/f/c/dfc11669c2_124425_devenir-dechets.jpg'),
              ),
            ),
          ),
          Container(
            height: 10,
            width: 10,
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.redAccent,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Signelement Numero 2 : Traité',
                style: TextStyle(
                  color: Color.fromRGBO(34, 43, 69, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Cité 250 lgt, Douera Alger',
                style: TextStyle(
                  color: Color.fromRGBO(34, 43, 69, 1),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
