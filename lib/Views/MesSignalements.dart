import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supercitoyen/Services/SignalementService.dart';
import 'package:supercitoyen/Views/NouvelleDeclaration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../NewWidgets/collapsing_navigation_drawer_widget.dart';
import 'package:supercitoyen/NewWidgets/WidgetSignalement.dart';
import '../locale/app_localization.dart';
import 'package:supercitoyen/globals.dart' as globals;

class MesSignalements extends StatefulWidget {
  @override
  _MesSignalementsState createState() => _MesSignalementsState();
}

class _MesSignalementsState extends State<MesSignalements> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: globals.textDirectionValue,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          drawer: CollapsingNavigationDrawer(),
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
              AppLocalization.of(context).mesSignalements,
              //'Mes Signalements',
              style: TextStyle(
                color: Color.fromRGBO(34, 43, 69, 1),
                fontSize: 17,
              ),
            ),
            bottom: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              indicatorPadding: EdgeInsets.only(left: 20, right: 20),
              indicatorWeight: 2,
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  text: AppLocalization.of(context).actifs, //'ACTIF',
                ),
                Tab(
                  text: AppLocalization.of(context).fermes, //'FERME',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              actifSection(),
              fermeSection(),
            ],
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
      ),
    );
  }
}

Widget actifSection() {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
    child: StreamBuilder(
      stream: SignalementService().getSignalementsActifs(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("");
        } else if (snapshot.data.size != 0) {
          print('heeeeeey' + snapshot.data.size.toString());
          return ListView.builder(
            itemCount: snapshot.data.size,
            itemBuilder: (context, index) =>
                Signalement(snapshot.data.documents[index]),
          );
        }
        return Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
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
  );
}

Widget fermeSection() {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
    child: StreamBuilder(
      stream: SignalementService().getSignalementsFermes(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          print("salut makach ferme");
          return Text("");
        } else if (snapshot.data.size != 0) {
          return ListView.builder(
            itemCount: snapshot.data.size,
            itemBuilder: (context, index) =>
                Signalement(snapshot.data.documents[index]),
          );
        }
        return Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
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
                Icons.folder,
                size: 70,
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
          ),
        );
      },
    ),
  );
}
