import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supercitoyen/NewWidgets/collapsing_navigation_drawer_widget.dart';
import 'package:supercitoyen/globals.dart' as globals;

class Aide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    globals.selectedListTile = 8;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CollapsingNavigationDrawer(),
      //App Bar avec le titre
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Color.fromRGBO(34, 43, 69, 1),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Aide',
          style: TextStyle(
            color: Color.fromRGBO(34, 43, 69, 1),
            fontSize: 17,
          ),
        ),
      ),

      // Contenu de la page
      body: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Comment pouvons nous vous aider ?',
              style: TextStyle(
                fontSize: 30,
                color: Color.fromRGBO(34, 43, 69, 1),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            //Guide d'utilisation lien
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                  color: Color.fromRGBO(34, 43, 69, 1).withOpacity(0.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.explore,
                    color: Color.fromRGBO(78, 120, 236, 1),
                    size: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Guide d'utilisation",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(34, 43, 69, 1),
                        ),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: Color.fromRGBO(34, 43, 69, 1),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //FAQ lien
            Container(
              margin: EdgeInsets.only(bottom: 2),
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                  color: Color.fromRGBO(34, 43, 69, 1).withOpacity(0.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.chat_bubble,
                    color: Color.fromRGBO(78, 120, 236, 1),
                    size: 40,
                  ),
                  Text(
                    "FAQ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(34, 43, 69, 1),
                    ),
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: Color.fromRGBO(34, 43, 69, 1),
                  ),
                ],
              ),
            ),

            //Guide utilisateur
            Container(),
            //FAQ
            Container(),
          ],
        ),
      ),
    );
  }
}
