import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supercitoyen/NewWidgets/WidgetSignalement.dart';
import 'package:supercitoyen/Services/SignalementService.dart';
import 'package:supercitoyen/Views/NouvelleDeclaration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../NewWidgets/collapsing_navigation_drawer_widget.dart';
import 'package:supercitoyen/globals.dart' as globals;
import '../locale/app_localization.dart';
import 'package:intl/intl.dart';

class Brouillons extends StatefulWidget {
  @override
  _BrouillonsState createState() => _BrouillonsState();
}

class _BrouillonsState extends State<Brouillons> {
  @override
  Widget build(BuildContext context) {
    print(Intl.defaultLocale);
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
            AppLocalization.of(context).brouillons,
            //'Brouillons',
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: Color.fromRGBO(34, 43, 69, 1),
                fontSize: 17,
              ),
            ),
          ),
        ),

        // Contenu de la page
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          child: StreamBuilder(
            stream: SignalementService().getBrouillons(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('');
              } else if (snapshot.data.size != 0) {
                print('heeeeeey' + snapshot.data.size.toString());
                return ListView.builder(
                  itemCount: snapshot.data.size,
                  itemBuilder: (context, index) =>
                      Signalement(snapshot.data.documents[index]),
                );
              }
              return Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                child: Align(
                  alignment: Alignment(0, -0.5),
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      Icons.note_add_rounded,
                      size: 70,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NouvelleDeclaration(),
              ),
            ).then((value) => setState(() {}));
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
          icon: Icon(Icons.add, color: Colors.white),
          backgroundColor: Color.fromRGBO(255, 104, 16, 1),
        ),
      ),
    );
  }
}
