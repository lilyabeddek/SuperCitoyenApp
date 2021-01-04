import 'package:supercitoyen/Views/SeConnecter.dart';

import '../custom_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:supercitoyen/globals.dart' as globals;
import 'package:supercitoyen/Services/AuthService.dart';
import 'package:supercitoyen/Views/Authentification.dart';
import 'package:supercitoyen/globals.dart' as globals;
import '../locale/app_localization.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  @override
  CollapsingNavigationDrawerState createState() {
    return new CollapsingNavigationDrawerState();
  }
}

class CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 300;
  double minWidth = 70;
  bool isCollapsed = false;
  AnimationController _animationController;
  Animation<double> widthAnimation;
  int currentSelectedIndex = globals.selectedListTile;
  int preSelectedIntex;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }

  Widget getWidget(context, widget) {
    List<NavigationModel> navigationItems = [
      NavigationModel(
          title:
              AppLocalization.of(context).mesSignalements, //"Mes Signalements",
          icon: Icons.home,
          chemin: '/MesSignalements'),
      NavigationModel(
          title: AppLocalization.of(context).notifications, // "Notifications",
          icon: Icons.notifications,
          chemin: '/Notifications'),
      NavigationModel(
        title: AppLocalization.of(context).brouillons,
        icon: Icons.drafts,
        chemin: '/Brouillons',
      ),
      NavigationModel(
        title: AppLocalization.of(context).aPropos, //"A propos",
        icon: Icons.info,
        chemin: '/APropos',
      ),
      NavigationModel(
          title: AppLocalization.of(context).contactezNous, //"Contactez Nous",
          icon: Icons.message,
          chemin: '/ContactezNous'),
      NavigationModel(
        title: AppLocalization.of(context).deconnexion, //"Se deconnecter",
        icon: Icons.exit_to_app,
        chemin: '',
      ),
    ];
    return Material(
      elevation: 80.0,
      child: Container(
        width: widthAnimation.value,
        color: drawerBackgroundColor,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/LogoBleu.png'),
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(width: 5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Super',
                        style: TextStyle(
                          color: Color.fromRGBO(78, 120, 236, 1),
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Citoyen',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, counter) {
                  return Divider(
                    height: 12.0,
                    color: Colors.white,
                  );
                },
                itemBuilder: (context, counter) {
                  return CollapsingListTile(
                    onTap: () {
                      preSelectedIntex = currentSelectedIndex;
                      setState(() {
                        currentSelectedIndex = counter;
                      });
                      globals.selectedListTile = counter;
                      if (navigationItems[counter].title !=
                          AppLocalization.of(context).deconnexion) {
                        Navigator.of(context)
                            .pushNamed(navigationItems[counter].chemin);
                      } else {
                        showAlertDialog(context);
                        setState(() {
                          currentSelectedIndex = preSelectedIntex;
                        });
                        globals.selectedListTile = preSelectedIntex;
                      }
                    },
                    isSelected: currentSelectedIndex == counter,
                    title: navigationItems[counter].title,
                    icon: navigationItems[counter].icon,
                    animationController: _animationController,
                  );
                },
                itemCount: navigationItems.length,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          globals.selectedListTile = 7;
                          Navigator.of(context).pushNamed('/Compte');
                        },
                        child: CircleAvatar(
                          backgroundColor: Color.fromRGBO(78, 120, 236, 1),
                          child: globals.photoUser != ""
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        globals.photoUser,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  width: 100,
                                  height: 100,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(100)),
                                  width: 100,
                                  height: 100,
                                  child: Icon(
                                    Icons.person,
                                    color: Color.fromRGBO(34, 43, 69, 1),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(globals.prenomUser,
                              style: listTitleDefaultTextStyle),
                          Text(globals.nomUser, style: sousTitre),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.help,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/Aide');
                    },
                  ),
                ],
              ),
            ),
            /* Checkbox(
                value: themeChange.darkTheme,
                onChanged: (bool value) {
                  themeChange.darkTheme = value;
                })*/
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
            height: 350,
            width: 200,
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.exit_to_app,
                  color: Color.fromRGBO(78, 120, 236, 1),
                  size: 80,
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    AppLocalization.of(context).msgDeDeconnexion,
                    //'Etes-vous sûr de vouloir vous déconnecter ?',
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
                        if (AuthService().signOut()) {
                        } else
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeConnecter(),
                            ),
                          );
                      },
                      child: Text(
                        AppLocalization.of(context).oui,
                        //"Oui",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Color.fromRGBO(78, 120, 236, 1),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalization.of(context).non,
                        //"Non",
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
}
