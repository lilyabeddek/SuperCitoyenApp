import 'package:flutter/material.dart';
import '../locale/app_localization.dart';
import 'package:supercitoyen/globals.dart' as globals;
import 'package:supercitoyen/Services/UserService.dart';
import 'package:supercitoyen/Views/SeConnecter.dart';
import 'package:supercitoyen/NewWidgets/collapsing_navigation_drawer_widget.dart';

class ModifMotPasse extends StatefulWidget {
  final bool oublie;
  ModifMotPasse(this.oublie);
  @override
  _ModifMotPasseState createState() => _ModifMotPasseState(this.oublie);
}

class _ModifMotPasseState extends State<ModifMotPasse> {
  final formKey = GlobalKey<FormState>();
  final bool oublie;
  _ModifMotPasseState(this.oublie);

  TextEditingController _mdpController = TextEditingController();
  TextEditingController _mdpConfirmController = TextEditingController();

  bool hasError = false;
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
          leading: BackButton(
            color: Color.fromRGBO(34, 43, 69, 1),
          ),
          //centerTitle: true,
          title: Text(
            //AppLocalization.of(context).modifierMesInfos,
            'Modifier le mot de passe',
            style: TextStyle(
              color: Color.fromRGBO(34, 43, 69, 1),
              fontSize: 17,
            ),
          ),
          actions: [
            FlatButton(
              child: Text(
                AppLocalization.of(context).valider,
                //'Valider',
                style: TextStyle(fontSize: 18),
              ),
              color: Colors.white,
              textColor: Color.fromRGBO(78, 120, 236, 1),
              onPressed: () async {
                if (!formKey.currentState.validate()) {
                  return;
                }
                if (_mdpConfirmController.text != _mdpController.text) {
                  setState(() {
                    hasError = true;
                  });

                  return;
                }
                setState(() {
                  hasError = false;
                });

                await UserService().updateUserPassword(_mdpController.text);

                if (oublie) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeConnecter(),
                    ),
                  );
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
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
                  //Nouveau mot de passe
                  Text(
                    'Nouveau mot de passe',
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

                  //Confirmation du mot de passe
                  Text(
                    AppLocalization.of(context).confirmationMotDePasse,
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
                          return AppLocalization.of(context).champObligatoire;
                          //"Champ obligatoire";
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
