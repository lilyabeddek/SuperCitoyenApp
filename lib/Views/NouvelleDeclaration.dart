import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlng/latlng.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:dropdown_search/dropdown_search.dart' as dropdownList;
import 'package:path/path.dart' as Path;
import 'package:supercitoyen/Services/CategorieService.dart';
import 'package:supercitoyen/Services/SignalementService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:supercitoyen/globals.dart' as globals;
import '../locale/app_localization.dart';
import 'package:intl/intl.dart';
import 'package:supercitoyen/NewWidgets/Dialogs.dart';
import 'package:supercitoyen/Views/MesSignalements.dart';
import 'package:supercitoyen/Views/Brouillons.dart';

const kGoogleApiKey = "AIzaSyCcDtfELFjKgq0-3Sp0MBLTAJA0mltI9JI";

// ignore: must_be_immutable
class NouvelleDeclaration extends StatefulWidget {
  List data;
  int iTId;
  NouvelleDeclaration({this.data, this.iTId});
  @override
  AttachmentState createState() => new AttachmentState();
}

class AttachmentState extends State<NouvelleDeclaration> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final formKey = GlobalKey<FormState>();
  TextEditingController _categController = new TextEditingController();
  TextEditingController _descriptController = new TextEditingController();

  String lieu = "", description = "";
  DocumentSnapshot categ;
  File _image;
  String _url = "";
  LatLng _center;
  String currentAddress;

  @override
  void initState() {
    super.initState();
    getUserLocation();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  getUrl() async {
    String url = await uploadFile(_image);
    setState(() {
      _url = url;
    });
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (_image != null || description != "") {
      getUrl();
      SignalementService().setSignalement(
        _url,
        categ != null ? categ.id : "B0YrHxsn3kJ1gEHo8ygI",
        description,
        GeoPoint(
          _center.latitude,
          _center.longitude,
        ),
        Timestamp.now(),
        true,
      );
    }
    if (globals.selectedListTile == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MesSignalements(),
        ),
      ).then((value) => setState(() {}));
    } else if (globals.selectedListTile == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Brouillons(),
        ),
      ).then((value) => setState(() {}));
    } else {
      Navigator.of(context).pop();
    }
    return true;
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    Position currentLocation = await locateUser();
    final coordinates =
        new Coordinates(currentLocation.latitude, currentLocation.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    print("${first.featureName} : ${first.addressLine}");
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
      currentAddress = "${first.featureName} : ${first.addressLine}";
    });
    print('position $currentLocation');
  }

  void _getLatLng(Prediction prediction) async {
    GoogleMapsPlaces _places = new GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
    ); //Same API_KEY as above
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(prediction.placeId);
    double latitude = detail.result.geometry.location.lat;
    double longitude = detail.result.geometry.location.lng;
    setState(() {
      _center = LatLng(latitude, longitude);
      currentAddress = prediction.description;
    });
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    //String url = await uploadFile(image);
    setState(() {
      _image = image;
      //_url = url;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    //String url = await uploadFile(image);
    setState(() {
      _image = image;
      //_url = url;
    });
  }

  void _clearImage() {
    setState(() {
      _image = null;
      _url = "";
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(AppLocalization.of(context).galerie),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(AppLocalization.of(context).appareilPhoto),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.delete),
                    title: new Text(AppLocalization.of(context).supprimerPhoto),
                    onTap: () {
                      _clearImage();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<String> uploadFile(File _image) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Photo/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    String returnURL;
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    print(returnURL);
    return returnURL;
  }

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
                    AppLocalization.of(context).signalementEnregistre,
                    //'Votre signalement à bien été enregistré et sera tarité dés que possible !',
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

        //App Bar
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Color.fromRGBO(34, 43, 69, 1),
            onPressed: () async {
              print(_image != null || description != "");
              if (_image != null || description != "") {
                Dialogs.showLoadingDialog(context, _keyLoader);
                String url = await uploadFile(_image);
                print('envoie en cours');
                print(url);
                await SignalementService().setSignalement(
                  url,
                  categ != null ? categ.id : "B0YrHxsn3kJ1gEHo8ygI",
                  description,
                  GeoPoint(
                    _center.latitude,
                    _center.longitude,
                  ),
                  Timestamp.now(),
                  true,
                );
                Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                    .pop();
              }
              if (globals.selectedListTile == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MesSignalements(),
                  ),
                ).then((value) => setState(() {}));
              } else if (globals.selectedListTile == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Brouillons(),
                  ),
                ).then((value) => setState(() {}));
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
          centerTitle: true,
          title: Text(
            AppLocalization.of(context).nouvelleDeclaration,
            //'Nouvelle Déclaration',
            style: TextStyle(
              color: Color.fromRGBO(34, 43, 69, 1),
              fontSize: 17,
            ),
          ),
        ),

        //Body de la page
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: Container(
                      width: 150,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _image,
                                width: 150,
                                height: 200,
                                fit: BoxFit.fill,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              width: 200,
                              height: 200,
                              child: Icon(
                                Icons.add,
                                color: Colors.grey[800],
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalization.of(context).localisation,
                        //'Localisation',
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
                          controller: new TextEditingController(
                            text: currentAddress != null ? currentAddress : "",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocalization.of(context)
                                  .champObligatoire;
                              //"Champ obligatoire";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              currentAddress = value;
                            });
                          },
                          readOnly: true,
                          onTap: () async {
                            Prediction prediction =
                                await PlacesAutocomplete.show(
                              context: context,
                              apiKey: kGoogleApiKey,
                              mode: Mode.fullscreen, // Mode.overlay
                              language: "fr",
                              components: [Component(Component.country, "DZ")],
                              location:
                                  Location(_center.latitude, _center.longitude),
                              radius: 1000000000000000000,
                              types: ["(cities)"],
                            );
                            _getLatLng(prediction);
                          },
                          decoration: InputDecoration(
                            hintText:
                                currentAddress != "null" ? currentAddress : "",
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.only(left: 8.0, top: 16.0),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      //Message à envoyer
                      Text(
                        AppLocalization.of(context).categorieChoix,
                        //'Categorie',
                        style: TextStyle(
                          color: Color.fromRGBO(34, 43, 69, 1),
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10),
                      StreamBuilder(
                        stream: CategorieService().getCategories(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Text('chargement');
                          } else {
                            List<DocumentSnapshot> categories = [];
                            for (int i = 0;
                                i < snapshot.data.documents.length;
                                i++) {
                              DocumentSnapshot snap =
                                  snapshot.data.documents[i];
                              //categories.add(snap.data()['nom']);
                              categories.add(snap);
                            }
                            return Theme(
                              data: Theme.of(context).copyWith(
                                // override textfield's icon color when selected
                                primaryColor: Color.fromRGBO(78, 120, 236, 1),
                              ),
                              child:
                                  dropdownList.DropdownSearch<DocumentSnapshot>(
                                validator: (v) => v == null
                                    ? AppLocalization.of(context)
                                        .champObligatoire
                                    : null,
                                hint: AppLocalization.of(context)
                                    .hintTextCategorieChoix, //"Choisissez une catégorie",
                                mode: dropdownList.Mode.MENU,
                                items: categories,
                                searchBoxController: _categController,
                                itemAsString: (DocumentSnapshot u) =>
                                    Intl.defaultLocale == "fr"
                                        ? u.data()['nom']
                                        : Intl.defaultLocale == "ar"
                                            ? u.data()['nomAr']
                                            : u.data()['nomEn'],

                                onChanged: (DocumentSnapshot value) {
                                  setState(() {
                                    categ = value;
                                    print(categ.data()['nom']);
                                    print(categ.data()['couleur']);
                                    print(categ.data()['icone']);
                                    print(categ.id);
                                  });
                                },
                              ),
                            );
                          }
                        },
                      ),

                      SizedBox(height: 10),
                      Text(
                        AppLocalization.of(context).descriptionSaisie,
                        //'Description',
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
                          controller: _descriptController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: AppLocalization.of(context)
                                .hintTextDescriptionSaisie, //"Décrivez l'incident...",
                          ),
                          onChanged: (value) {
                            setState(() {
                              description = value;
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
                            if (_image != null) {
                              try {
                                Dialogs.showLoadingDialog(context, _keyLoader);
                                String url = await uploadFile(_image);
                                print('envoie en cours');
                                print(url);

                                await SignalementService().setSignalement(
                                  url,
                                  categ.id,
                                  description,
                                  GeoPoint(
                                    _center.latitude,
                                    _center.longitude,
                                  ),
                                  Timestamp.now(),
                                  false,
                                );
                                setState(() {
                                  _image = null;
                                  _url = "";
                                  description = "";
                                  //categ = null;
                                  _categController.clear();
                                  _descriptController.clear();
                                  getUserLocation();
                                });
                                Navigator.of(_keyLoader.currentContext,
                                        rootNavigator: true)
                                    .pop();
                                print(_url != "" || description != "");
                                print('rani hna ' + _url);
                                print('rani hna ' + description);
                                validationEnvoie(context);
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
