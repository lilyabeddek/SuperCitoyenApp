import 'package:flutter/material.dart';
import 'package:supercitoyen/NewWidgets/collapsing_navigation_drawer_widget.dart';
import 'package:readmore/readmore.dart';
import 'package:share/share.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:supercitoyen/globals.dart' as globals;
import '../locale/app_localization.dart';

class APropos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String text = 'https://netfersmartsolutions.dz/';
    String subject = AppLocalization.of(context)
        .textMessagePartage; //"J'utilise SuperCitoyen pour signaler les incidents en temps réel, rejoins moi et télécharge SuperCitoyen :";

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
            AppLocalization.of(context).aPropos,
            //'À propos',
            style: TextStyle(
              color: Color.fromRGBO(34, 43, 69, 1),
              fontSize: 17,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.share,
                color: Color.fromRGBO(34, 43, 69, 1),
              ),
              onPressed: () {
                RenderBox box = context.findRenderObject();
                Share.share(text,
                    subject: subject,
                    sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size);
              },
            ),
          ],
        ),

        // Contenu de la page
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                color: Color.fromRGBO(255, 104, 16, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Image(
                          image: AssetImage('assets/images/LogoBleu.png'),
                          height: 40,
                          width: 40,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('(3.2)'),
                        SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (v) {},
                          starCount: 5,
                          rating: 3,
                          size: 20.0,
                          isReadOnly: true,
                          color: Colors.yellow,
                          borderColor: Colors.yellow,
                          spacing: 0.0,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      AppLocalization.of(context).nouveautes,
                      //"Nouveautés",
                      style: TextStyle(
                        color: Color.fromRGBO(34, 43, 69, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Mis à jours le 13/12/2020 ",
                      style: TextStyle(
                        color: Color.fromRGBO(34, 43, 69, 1),
                        fontSize: 14,
                        //fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      AppLocalization.of(context).aProposDeApplication,
                      //"À propos de l'application ",
                      style: TextStyle(
                        color: Color.fromRGBO(34, 43, 69, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 15),
                    ReadMoreText(
                      AppLocalization.of(context).descriptionApp,
                      //"Il s’agit d’une application citoyenne de signalement conçue pour rendre plus aisé le signalement de tout incident sur la voie publique et établir un lien entre citoyens et services de gestion de la collectivité. En reportant les différents problèmes rencontrés dans la ville, chaque individu peut agir directement sur la qualité des infrastructures et le bon développement de la cité. Elle permet d’intervenir plus rapidement lorsqu’une anomalie est rencontrée sur la voie publique. Elle offre la possibilité de faire remonter des informations géo localisées en quelques secondes auprès de la municipalité, ce qui représente un atout considérable dans la gestion d'une commune. Cela permet de mobiliser le côté citoyen des habitants qui peuvent signaler en temps réel tout dysfonctionnement ou problème rencontré dans la ville.",
                      trimLines: 5,
                      colorClickableText: Colors.blue,
                      trimMode: TrimMode.Length,
                      trimExpandedText:
                          AppLocalization.of(context).voirMoins, //'Voir moins',
                      trimCollapsedText:
                          AppLocalization.of(context).voirPlus, //'Voir plus',
                      moreStyle: TextStyle(fontSize: 14),
                      style: TextStyle(
                        color: Color.fromRGBO(34, 43, 69, 1),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalization.of(context).donnerUneNoteAppli,
                              //"Donnez une note à l'application",
                              style: TextStyle(
                                color: Color.fromRGBO(34, 43, 69, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              AppLocalization.of(context).partagezAvis,
                              //"Partagez votre avis et aidez d'autre utilisateurs",
                              style: TextStyle(
                                color: Color.fromRGBO(34, 43, 69, 1),
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            RatingBar.builder(
                              initialRating: 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 4,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              Text(
                AppLocalization.of(context).coordoneesDeveloppeur,
                //"Coordonnées du développeur",
                style: TextStyle(
                  color: Color.fromRGBO(34, 43, 69, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),

              //Netfer Infos
              Container(
                margin: EdgeInsets.all(20),
                padding:
                    EdgeInsets.only(right: 30, left: 30, top: 30, bottom: 40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Netfer",
                              style: TextStyle(
                                color: Color(0xff3386d9),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Smart Solutions",
                              style: TextStyle(
                                color: Color(0xff3386d9),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image(
                              image: AssetImage('assets/images/NetferLogo.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    iconSection(context, text),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.place_rounded,
                          size: 30,
                          color: Color(0xff3386d9),
                        ),
                        Container(
                          width: 200,
                          margin: EdgeInsets.only(left: 20, right: 10),
                          child: Text(
                            AppLocalization.of(context).adresseNetfer,
                            //'CA-E2-06 Cyber Parc, Sidi Abdellah، Rahmania',
                            style: TextStyle(
                              color: Color.fromRGBO(34, 43, 69, 1),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 30,
                          color: Color(0xff3386d9),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalization.of(context).joursOuverture,
                                //"Ouvert de dimache à jeudi",
                                style: TextStyle(
                                  color: Color.fromRGBO(34, 43, 69, 1),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                AppLocalization.of(context).tempsOuverture,
                                //"de 09:00 jusqu'à 17:00",
                                style: TextStyle(
                                  color: Color.fromRGBO(34, 43, 69, 1),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.call,
                          size: 30,
                          color: Color(0xff3386d9),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "05 60 57 85 86",
                            style: TextStyle(
                              color: Color.fromRGBO(34, 43, 69, 1),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      AppLocalization.of(context).quiSommesNous,
                      //'Qui sommes-nous ?',
                      style: TextStyle(
                        color: Color.fromRGBO(34, 43, 69, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 15),
                    ReadMoreText(
                      AppLocalization.of(context).descriptionNetfer,
                      //"NETFER SMART SOLUTIONS est une entreprise spécialisée dans le développement mobile et web et des Solutions Digitales.  Notre département de développement vous aidera à digitaliser vos processus métiers, vous gagnerez en temps, vous serez efficient et vous réduisez vos coûts.Nous mettons à votre disposition notre savoir faire acquis durant un parcours très riche dans les TICs, et traduit par des services et solutions entreprises et grand public dans le but de résoudre des problématiques réelles avec une expérience utilisateur la plus simple.",
                      trimLines: 5,
                      colorClickableText: Colors.blue,
                      trimMode: TrimMode.Length,
                      trimExpandedText:
                          AppLocalization.of(context).voirMoins, //'Voir moins',
                      trimCollapsedText:
                          AppLocalization.of(context).voirPlus, //'Voir plus',
                      moreStyle: TextStyle(fontSize: 14),
                      style: TextStyle(
                        color: Color.fromRGBO(34, 43, 69, 1),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconSection(BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    // color: Color(0xff3386d9),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Color(0xff3386d9),
                      width: 2.5,
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.link,
                      color: Color(0xff3386d9),
                      size: 30,
                    ),
                    onPressed: () async {
                      if (await UrlLauncher.canLaunch(text)) {
                        await UrlLauncher.launch(text);
                      } else {
                        throw 'Could not launch $text';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  AppLocalization.of(context).site,
                  //'Site',
                  style: TextStyle(
                    color: Color(0xff3386d9),
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    //color: Color(0xff3386d9),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Color(0xff3386d9),
                      width: 2.5,
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.map,
                      color: Color(0xff3386d9),
                      size: 30,
                    ),
                    onPressed: () async {
                      String lat = "36.68113";
                      String long = "2.90016";
                      var urlmap =
                          'https://www.google.com/maps/search/?api=1&query=$lat,$long';
                      if (await UrlLauncher.canLaunch(urlmap)) {
                        await UrlLauncher.launch(urlmap);
                      } else {
                        throw 'Could not launch $urlmap';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  AppLocalization.of(context).itineraire,
                  //'Itineraire',
                  style: TextStyle(
                    color: Color(0xff3386d9),
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    //color: Color(0xff3386d9),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Color(0xff3386d9),
                      width: 2.5,
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.phone,
                      color: Color(0xff3386d9),
                      size: 30,
                    ),
                    onPressed: () {
                      UrlLauncher.launch('tel:+213560518586');
                    },
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  AppLocalization.of(context).appeler,
                  //'Appeler',
                  style: TextStyle(
                    color: Color(0xff3386d9),
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
