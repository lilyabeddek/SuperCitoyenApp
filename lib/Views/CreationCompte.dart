import 'package:flutter/material.dart';
import 'package:supercitoyen/Services/UserService.dart';
import 'package:supercitoyen/NewWidgets/collapsing_navigation_drawer_widget.dart';
import 'package:supercitoyen/globals.dart' as globals;
import 'package:supercitoyen/Views/MesSignalements.dart';
import '../locale/app_localization.dart';

class CreationCompte extends StatefulWidget {
  @override
  _CreationCompteState createState() => _CreationCompteState();
}

class _CreationCompteState extends State<CreationCompte> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _mdpController = TextEditingController();
  final TextEditingController _mdpConfirmController = TextEditingController();
  bool hasError = false;
  bool checkboxstate = false;
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;

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
            AppLocalization.of(context).finirInscription,
            //'Finissez votre inscription',
            style: TextStyle(
              color: Color.fromRGBO(34, 43, 69, 1),
              fontSize: 17,
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
                  //Nom
                  Text(
                    AppLocalization.of(context).nom,
                    //'Nom',
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
                      controller: _nomController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: AppLocalization.of(context).nom, //'Nom',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalization.of(context)
                              .champObligatoire; //"Champ obligatoire";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10),

                  //Prenom
                  Text(
                    AppLocalization.of(context).prenom,
                    //'Prenom',
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
                      controller: _prenomController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText:
                            AppLocalization.of(context).prenom, //'Prenom',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalization.of(context).champObligatoire;
                          //"Champ obligatoire";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10),

                  //mdp
                  Text(
                    AppLocalization.of(context).hintTextMotDePasse,
                    //'Mot de passe',
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
                      obscureText: !passwordVisible,
                      controller: _mdpController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: AppLocalization.of(context)
                            .hintTextSaisissezMotDePasse,
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalization.of(context).champObligatoire;
                          //"Champ obligatoire";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 10),

                  //mdp confirmation
                  Text(
                    AppLocalization.of(context).confirmationMotDePasse,
                    //'Confirmation du mot de passe',
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
                      obscureText: !confirmPasswordVisible,
                      controller: _mdpConfirmController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: AppLocalization.of(context)
                            .hintTextSaisissezMotDePasse,
                        //'saisissez votre mot de passe',
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            confirmPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              confirmPasswordVisible = !confirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalization.of(context)
                              .champObligatoire; //"Champ obligatoire";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      hasError
                          ? "*Assurez-vous de bien confirmer votre mot de passe"
                          : "",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: checkboxstate,
                        onChanged: (bool value) {
                          setState(() {
                            checkboxstate = value;
                          });
                        },
                        activeColor: Color.fromRGBO(78, 120, 236, 1),
                        checkColor: Colors.white,
                      ),
                      Container(
                        width: 230,
                        child: Text(
                          AppLocalization.of(context).termesEtConditions,
                          //"En continuant, je confirme avoir lu et accepté les Termes et conditions et politiques de confidentialité",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ButtonTheme(
                    height: 40,
                    minWidth: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        AppLocalization.of(context).commencer,
                        //'Commencer',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Color.fromRGBO(255, 104, 16, 1),
                      textColor: Colors.white,
                      onPressed: !checkboxstate
                          ? null
                          : () {
                              if (!formKey.currentState.validate() ||
                                  !checkboxstate) {
                                return;
                              }
                              if (_mdpConfirmController.text !=
                                  _mdpController.text) {
                                setState(() {
                                  hasError = true;
                                });

                                return;
                              }
                              setState(() {
                                hasError = false;
                              });

                              try {
                                UserService().setUser(
                                  globals.idUser,
                                  _nomController.text,
                                  _prenomController.text,
                                  _mdpController.text,
                                  globals.numTel,
                                );
                                globals.nomUser = _nomController.text;
                                globals.prenomUser = _prenomController.text;
                                globals.photoUser = "";
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MesSignalements(),
                                  ),
                                );
                              } catch (e) {}
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
