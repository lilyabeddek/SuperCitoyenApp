import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supercitoyen/globals.dart' as globals;

class SignalementService {
  final CollectionReference signalements =
      FirebaseFirestore.instance.collection('Signalement');
  getSignalementsActifs() {
    return signalements
        .where('citoyen', isEqualTo: globals.idUser)
        .where('status', isEqualTo: false) // status nom brouillon
        .where('etat', isEqualTo: false) // etat ouvert non fermé
        .orderBy('dateEmission', descending: true)
        .snapshots();
  }

  getSignalementsFermes() {
    return signalements
        .where('citoyen', isEqualTo: globals.idUser)
        .where('status', isEqualTo: false) // status non brouillon
        .where('etat', isEqualTo: true) // etat ouvert non fermé
        .orderBy('dateEmission', descending: true)
        .snapshots();
  }

  getBrouillons() {
    return signalements
        .where('citoyen', isEqualTo: globals.idUser)
        .where('status', isEqualTo: true) // status brouillon
        .orderBy('dateEmission', descending: true)
        .snapshots();
  }

  deleteBouillon(String idBrouillon) {
    return signalements
        .doc(idBrouillon)
        .delete()
        .then((value) => print("brouillon Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  updateImageBrouillon(String idBrouillon, String image) {
    return signalements
        .doc(idBrouillon)
        .update({
          'image': image,
          'dateEmission': Timestamp.now(),
        })
        .then((value) => print("Brouillon Updated"))
        .catchError((error) => print("Failed to update Brouillon: $error"));
  }

  updateLocalisationBrouillon(String idBrouillon, GeoPoint point) {
    return signalements
        .doc(idBrouillon)
        .update({
          'localisation': point,
          'dateEmission': Timestamp.now(),
        })
        .then((value) => print("Brouillon Updated"))
        .catchError((error) => print("Failed to update Brouillon: $error"));
  }

  updateCategorieBrouillon(String idBrouillon, String categorie) {
    return signalements
        .doc(idBrouillon)
        .update({
          'categorie': categorie,
          'dateEmission': Timestamp.now(),
        })
        .then((value) => print("Brouillon Updated"))
        .catchError((error) => print("Failed to update Brouillon: $error"));
  }

  updateDescriptionBrouillon(String idBrouillon, String description) {
    return signalements
        .doc(idBrouillon)
        .update({
          'description': description,
          'dateEmission': Timestamp.now(),
        })
        .then((value) => print("Brouillon Updated"))
        .catchError((error) => print("Failed to update Brouillon: $error"));
  }

  updateBrouillon(
      String idBrouillon,
      String image,
      String categorie,
      String description,
      GeoPoint point,
      Timestamp dateEsmission,
      bool status) {
    return signalements
        .doc(idBrouillon)
        .update({
          'categorie': categorie,
          'dateEmission': dateEsmission,
          'description': description,
          'image': image,
          'localisation': point,
          'status': status,
        })
        .then((value) => print("Brouillon Updated"))
        .catchError((error) => print("Failed to update Brouillon: $error"));
  }

  setSignalement(String image, String categorie, String description,
      GeoPoint point, Timestamp dateEsmission, bool status) {
    return signalements
        .add({
          'categorie': categorie,
          'citoyen': globals.idUser,
          'dateEmission': dateEsmission,
          'dateReglement': dateEsmission,
          'description': description,
          'etat': false,
          'image': image,
          'localisation': point,
          'status': status,
        })
        .then((value) => print("Signalement Added"))
        .catchError((error) => print("Failed to add Signalement: $error"));
  }
}
