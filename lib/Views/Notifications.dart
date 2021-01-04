import 'package:flutter/cupertino.dart';

//import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../NewWidgets/collapsing_navigation_drawer_widget.dart';
import '../NewWidgets/WidgetNotification.dart';
import 'package:supercitoyen/globals.dart' as globals;
import '../locale/app_localization.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: globals.textDirectionValue,
      child: Scaffold(
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
            AppLocalization.of(context).notifications,
            //'Notifications',
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: Color.fromRGBO(34, 43, 69, 1),
                fontSize: 17,
              ),
            ),
          ),
        ),

        // Contenu de la page
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                AppLocalization.of(context).nouveau,
                //'Nouveau',
                style: TextStyle(
                  color: Color.fromRGBO(78, 120, 236, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            WidgetNotification(true),
            WidgetNotification(true),
            WidgetNotification(true),
            WidgetNotification(true),
            Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 15),
              child: Text(
                AppLocalization.of(context).plusTot,
                //'Plus tôt',
                style: TextStyle(
                  color: Color.fromRGBO(34, 43, 69, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            WidgetNotification(false),
            WidgetNotification(false),
            WidgetNotification(false),
            WidgetNotification(false),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text(
            AppLocalization.of(context).nouvelleDeclaration,
            //'Nouvelle Déclaration',
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          icon: Icon(Icons.add),
          backgroundColor: Color.fromRGBO(255, 104, 16, 1),
        ),
      ),
    );
  }
}
