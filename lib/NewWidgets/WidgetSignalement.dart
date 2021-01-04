import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:supercitoyen/Services/SignalementService.dart';
import 'package:supercitoyen/Views/DetailBrouillon.dart';
import 'package:supercitoyen/Views/DetailSignalement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:supercitoyen/Services/CategorieService.dart';
import 'package:supercitoyen/globals.dart' as globals;
import '../locale/app_localization.dart';
import 'package:intl/intl.dart';
import 'package:supercitoyen/NewWidgets/Dialogs.dart';
import 'package:supercitoyen/Views/Brouillons.dart';

class Signalement extends StatefulWidget {
  final DocumentSnapshot objetSignalement;
  Signalement(this.objetSignalement);
  @override
  _SignalementState createState() => _SignalementState(this.objetSignalement);
}

class _SignalementState extends State<Signalement> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final DocumentSnapshot objetSignalement;
  _SignalementState(this.objetSignalement);

  String adresse = '';
  String date = '';
  String dateReglement = '';

  @override
  void initState() {
    super.initState();
    getLocation();
    getDates();
  }

  getDates() {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy ");
    setState(() {
      date =
          dateFormat.format(objetSignalement.data()['dateEmission']?.toDate());
      dateReglement =
          dateFormat.format(objetSignalement.data()['dateReglement']?.toDate());
    });
  }

  getLocation() async {
    GeoPoint position = objetSignalement.data()['localisation'];
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      adresse = '${first.featureName} : ${first.addressLine}';
    });
    print("${first.featureName} : ${first.addressLine}");
  }

  Widget getWidget(DocumentSnapshot objetCategorie) {
    if (objetSignalement.data()['status']) {
      return Row(
        //crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Color.fromRGBO(34, 43, 69, 1),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailBrouillon(
                    objetSignalement: objetSignalement,
                    objetcategorie: objetCategorie,
                  ),
                ),
              ).then((value) => setState(() {}));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Color.fromRGBO(34, 43, 69, 1),
            ),
            onPressed: () {
              validationSuppression(context);
            },
          ),
        ],
      );
    } else {
      if (objetSignalement.data()['etat'])
        return IconButton(
          icon: Icon(
            Icons.check_circle,
            color: Color.fromRGBO(14, 153, 37, 1),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailSignalement(
                  objetSignalement.data()['image'],
                  adresse,
                  date,
                  dateReglement,
                  objetCategorie.data(),
                  objetSignalement.data()['description'],
                  objetSignalement.data()['etat'],
                ),
              ),
            ).then((value) => setState(() {}));
          },
        );

      return IconButton(
        icon: Icon(
          Icons.navigate_next,
          color: Color.fromRGBO(34, 43, 69, 1),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailSignalement(
                objetSignalement.data()['image'],
                adresse,
                date,
                dateReglement,
                objetCategorie.data(),
                objetSignalement.data()['description'],
                objetSignalement.data()['etat'],
              ),
            ),
          ).then((value) => setState(() {}));
        },
      );
    }
  }

  validationSuppression(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
            height: 340,
            width: 200,
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.blue,
                  size: 80,
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    AppLocalization.of(context).supprimerbrouillon,
                    //'Etes-vous sûr de vouloir supprimer ce brouillon ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalization.of(context).non,
                        //"Non",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Colors.blue,
                    ),
                    FlatButton(
                      onPressed: () async {
                        Dialogs.showLoadingDialog(context, _keyLoader);
                        await SignalementService()
                            .deleteBouillon(objetSignalement.id);
                        Navigator.of(_keyLoader.currentContext,
                                rootNavigator: true)
                            .pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Brouillons(),
                          ),
                        ).then((value) => setState(() {}));
                      },
                      child: Text(
                        AppLocalization.of(context).oui,
                        //"Oui",
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: globals.textDirectionValue,
      child: FutureBuilder<DocumentSnapshot>(
        future: CategorieService()
            .getIdCategorie(objetSignalement.data()['categorie']),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> categorie = snapshot.data.data();

            String couleur = categorie['couleur'];

            return InkWell(
              onTap: () {
                if (objetSignalement.data()['status']) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailBrouillon(
                        objetSignalement: objetSignalement,
                        objetcategorie: snapshot.data,
                      ),
                    ),
                  ).then((value) => setState(() {}));
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailSignalement(
                        objetSignalement.data()['image'],
                        adresse,
                        date,
                        dateReglement,
                        snapshot.data.data(),
                        objetSignalement.data()['description'],
                        objetSignalement.data()['etat'],
                      ),
                    ),
                  ).then((value) => setState(() {}));
                }
              },
              child: Container(
                height: 150,
                margin: EdgeInsets.only(bottom: 20),
                decoration: objetSignalement.data()['image'] != null &&
                        objetSignalement.data()['image'] != ""
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        image: DecorationImage(
                          image: NetworkImage(
                            objetSignalement.data()['image'],
                          ),
                          fit: BoxFit.cover,
                        ),
                      )
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey[100],
                      ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(210, 210, 210, 1),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 3, right: 10),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Color(int.parse("0xff$couleur")),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Icon(
                                IconData(
                                  int.parse(categorie['icone']),
                                  fontFamily: 'MaterialIcons',
                                ),
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          Intl.defaultLocale == "fr"
                                              ? categorie['nom']
                                              : Intl.defaultLocale == "ar"
                                                  ? categorie['nomAr']
                                                  : categorie['nomEn'],
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          AppLocalization.of(context).date +
                                              date,
                                          //'date: ' + date,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                        ),
                                      ],
                                    ),
                                  ),
                                  getWidget(snapshot.data),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      AppLocalization.of(context).adresse,
                                      //'Adresse',
                                      style: TextStyle(
                                        color: Color.fromRGBO(192, 192, 192, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      adresse,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return Text("loading");
        },
      ),
    );
  }
}
