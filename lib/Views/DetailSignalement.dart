import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supercitoyen/Views/NouvelleDeclaration.dart';
import 'package:supercitoyen/globals.dart' as globals;
import '../locale/app_localization.dart';
import 'package:intl/intl.dart';

enum ConfirmOrNot { yes, no }

class DetailSignalement extends StatefulWidget {
  final String url, adresse, date, dateReglement, description;
  final Map<String, dynamic> categorie;
  final bool etat;
  DetailSignalement(this.url, this.adresse, this.date, this.dateReglement,
      this.categorie, this.description, this.etat);
  @override
  _DetailSignalementState createState() => _DetailSignalementState(
      this.url,
      this.adresse,
      this.date,
      this.dateReglement,
      this.categorie,
      this.description,
      this.etat);
}

class _DetailSignalementState extends State<DetailSignalement> {
  final String url, adresse, date, dateReglement, description;
  final Map<String, dynamic> categorie;
  final bool etat;
  //final DocumentSnapshot document;
  _DetailSignalementState(this.url, this.adresse, this.date, this.dateReglement,
      this.categorie, this.description, this.etat);

  ConfirmOrNot _character;

  Widget getDescriptionOrNot(BuildContext context) {
    if (description != "") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalization.of(context).description,
            //'Description : ',
            style: TextStyle(
              color: Color.fromRGBO(34, 43, 69, 1),
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              fontSize: 15,
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Text(
              description,
              //" Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: TextStyle(
                color: Color.fromRGBO(34, 43, 69, 1).withOpacity(0.8),
                fontFamily: 'Roboto',
                fontSize: 15,
              ),
            ),
          ),
        ],
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    String couleur = categorie['couleur'];
    return Directionality(
      textDirection: globals.textDirectionValue,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Color.fromRGBO(34, 43, 69, 1),
          ),
          centerTitle: true,
          title: Text(
            AppLocalization.of(context).detailDuSignalement,
            //'Détails du signalement',
            style: TextStyle(
              color: Color.fromRGBO(34, 43, 69, 1),
              fontSize: 17,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(right: 25, left: 25, top: 20),
          child: ListView(
            children: [
              //photo
              Container(
                height: 200,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(
                      url,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //Lieu
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.place_rounded,
                    color: Color.fromRGBO(34, 43, 69, 1),
                  ),
                  SizedBox(width: 5),
                  Text(
                    AppLocalization.of(context).lieu,
                    //'Lieu : ',
                    style: TextStyle(
                      color: Color.fromRGBO(34, 43, 69, 1),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      fontSize: 15,
                    ),
                  ),
                ],
              ),

              Container(
                child: Text(
                  adresse, //'Cité 250 lgt, Douera Algerie',
                  //overflow: TextOverflow.ellipsis,
                  //softWrap: false,
                  style: TextStyle(
                    color: Color.fromRGBO(34, 43, 69, 1).withOpacity(0.8),
                    fontFamily: 'Roboto',
                    fontSize: 15,
                  ),
                ),
              ),

              SizedBox(height: 20),
              //Date
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalization.of(context).dateDeSignalement,
                    //'Date de signalement : ',
                    style: TextStyle(
                      color: Color.fromRGBO(34, 43, 69, 1),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      color: Color.fromRGBO(34, 43, 69, 1).withOpacity(0.8),
                      fontFamily: 'Roboto',
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              //Etat
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalization.of(context).etat,
                    //'Etat : ',
                    style: TextStyle(
                      color: Color.fromRGBO(34, 43, 69, 1),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    etat
                        ? AppLocalization.of(context).traite
                        : AppLocalization.of(context)
                            .enCoursTraitement, //'En cours de traitement',
                    style: TextStyle(
                      color:
                          etat ? Colors.green : Color.fromRGBO(78, 120, 236, 1),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              etat
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Date de réglement : ',
                          //'Date de signalement : ',
                          style: TextStyle(
                            color: Color.fromRGBO(34, 43, 69, 1),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          dateReglement,
                          style: TextStyle(
                            color:
                                Color.fromRGBO(34, 43, 69, 1).withOpacity(0.8),
                            fontFamily: 'Roboto',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  : Container(),

              //Categorie
              Text(
                AppLocalization.of(context).categorie,
                //'Catégorie : ',
                style: TextStyle(
                  color: Color.fromRGBO(34, 43, 69, 1),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  fontSize: 15,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 10),
                height: 40,
                decoration: BoxDecoration(
                  color: Color(int.parse("0xff$couleur")).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color(int.parse("0xff$couleur")),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Icon(
                        IconData(
                          int.parse(categorie['icone']),
                          fontFamily: 'MaterialIcons',
                        ),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      Intl.defaultLocale == "fr"
                          ? categorie['nom']
                          : Intl.defaultLocale == "ar"
                              ? categorie['nomAr']
                              : categorie['nomEn'],
                      //'Dechets',
                      style: TextStyle(
                        color: Color.fromRGBO(34, 43, 69, 1),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              //Description
              getDescriptionOrNot(context),
            ],
          ),
        ),

        //Nouvelle declaration
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NouvelleDeclaration(),
              ),
            );
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

/*Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text('Oui, je confirme'),
                            leading: Radio(
                              value: ConfirmOrNot.yes,
                              groupValue: _character,
                              onChanged: (ConfirmOrNot value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Non, le problème persiste'),
                            leading: Radio(
                              value: ConfirmOrNot.no,
                              groupValue: _character,
                              onChanged: (ConfirmOrNot value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    )*/
