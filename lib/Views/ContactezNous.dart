//import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supercitoyen/NewWidgets/collapsing_navigation_drawer_widget.dart';
import 'package:supercitoyen/Services/ContactService.dart';
import 'package:supercitoyen/globals.dart' as globals;
import '../locale/app_localization.dart';
import 'package:supercitoyen/NewWidgets/Dialogs.dart';

class ContactezNous extends StatefulWidget {
  @override
  _ContactezNousState createState() => _ContactezNousState();
}

class _ContactezNousState extends State<ContactezNous> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final formKey = GlobalKey<FormState>();
  String objet, message;

  validationEnvoie(BuildContext context) {
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
                  Icons.check_circle,
                  color: Color.fromRGBO(78, 120, 236, 1),
                  size: 80,
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    AppLocalization.of(context).merci,
                    //'Merci',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  width: 250,
                  height: 1,
                  color: Color.fromRGBO(255, 104, 16, 1),
                ),
                Center(
                  child: Text(
                    AppLocalization.of(context).feedbackEnregistre,
                    //'Votre Feedback à bien été enregistré et sera pris en consideration dés que possible !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
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
            AppLocalization.of(context).contactezNous,
            //'Contactez Nous',
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: Color.fromRGBO(34, 43, 69, 1),
                fontSize: 17,
              ),
            ),
          ),
        ),

        // Contenu de la page
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 40, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Objet du message
                  Text(
                    AppLocalization.of(context).objet,
                    //'Objet',
                    style: TextStyle(
                      color: Color.fromRGBO(34, 43, 69, 1),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 10),
                  Theme(
                    data: Theme.of(context).copyWith(
                      // override textfield's icon color when selected
                      primaryColor: Color.fromRGBO(78, 120, 236, 1),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: AppLocalization.of(context)
                            .hintTextObjet, //objet de votre message',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalization.of(context)
                              .champObligatoire; //"Champ obligatoire";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          this.objet = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),

                  //Message à envoyer
                  Text(
                    AppLocalization.of(context).message,
                    //'Message',
                    style: TextStyle(
                      color: Color.fromRGBO(34, 43, 69, 1),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 10),
                  Theme(
                    data: Theme.of(context).copyWith(
                      // override textfield's icon color when selected
                      primaryColor: Color.fromRGBO(78, 120, 236, 1),
                    ),
                    child: TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: AppLocalization.of(context)
                            .hintTextMessage, //'Saisissez votre message...',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalization.of(context).champObligatoire;
                          //"Champ obligatoire";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          this.message = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  ButtonTheme(
                    minWidth: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(AppLocalization.of(context).envoyer),
                      color: Color.fromRGBO(255, 104, 16, 1),
                      textColor: Colors.white,
                      onPressed: () async {
                        if (!formKey.currentState.validate()) {
                          return;
                        }
                        Dialogs.showLoadingDialog(context, _keyLoader);
                        await ContactService().setFeedback(objet, message);
                        Navigator.of(_keyLoader.currentContext,
                                rootNavigator: true)
                            .pop();
                        validationEnvoie(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
