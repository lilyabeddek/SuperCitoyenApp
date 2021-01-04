import 'package:flutter/material.dart';
import '../locale/app_localization.dart';
import 'package:supercitoyen/globals.dart' as globals;
import 'package:supercitoyen/main.dart';
import 'package:supercitoyen/NewWidgets/collapsing_navigation_drawer_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Langues extends StatefulWidget {
  @override
  _LanguesState createState() => _LanguesState();
}

class _LanguesState extends State<Langues> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: globals.textDirectionValue,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: CollapsingNavigationDrawer(),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Color.fromRGBO(34, 43, 69, 1),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Text(
            AppLocalization.of(context).choisirUneLangue,
            //'Choisir une langue',
            style: TextStyle(
              color: Color.fromRGBO(34, 43, 69, 1),
              fontSize: 17,
            ),
          ),
        ),
        // Contenu de la page
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 40, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      AppLocalization.load(Locale('en', ''));
                      globals.textDirectionValue = TextDirection.ltr;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 15, right: 10, left: 10),
                    width: double.infinity,
                    height: 50,
                    child: Text(
                      'English',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      AppLocalization.load(Locale('fr', ''));
                      globals.textDirectionValue = TextDirection.ltr;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 15, right: 10, left: 10),
                    width: double.infinity,
                    height: 50,
                    child: Text(
                      'Français',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      AppLocalization.load(Locale('ar', ''));
                      globals.textDirectionValue = TextDirection.rtl;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 50,
                    child: Text(
                      'عربية',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      //PageSliderInfoApp(), //AuthService().handleAuth(),
    );
  }
}
