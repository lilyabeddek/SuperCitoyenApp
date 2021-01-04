import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supercitoyen/globals.dart' as globals;

class UserService {
  final CollectionReference citoyens =
      FirebaseFirestore.instance.collection('Citoyen');
  setUser(
      String id, String nom, String prenom, String mdp, String phonenumber) {
    return citoyens.doc(id).set({
      'motDePasse': mdp,
      'nom': nom,
      'numTel': phonenumber,
      'photo': "",
      'prenom': prenom,
    }).then((value) {
      print("User Added");
    }).catchError((error) {
      print("Failed to add User: $error");
    });
  }

  Future<QueryDocumentSnapshot> getUser(String numTel) async {
    QueryDocumentSnapshot user;
    await citoyens.where('numTel', isEqualTo: numTel).get().then((value) {
      if (value.docs.length == 0) {
        print('makaaaach');
        return null;
      } else {
        print(value.docs.first.id);
        user = value.docs.first;
      }
    }).catchError((error) => print("Failed  User: $error"));
    return user;
  }

  updateUserInfos(String nom, String prenom) {
    return citoyens
        .doc(globals.idUser)
        .update({
          'nom': nom,
          'prenom': prenom,
        })
        .then((value) => print("User Infos Updated"))
        .catchError((error) => print("Failed to update User Infos: $error"));
  }

  updateUserPhoto(String url) {
    return citoyens
        .doc(globals.idUser)
        .update({
          'photo': url,
        })
        .then((value) => print("User photo Updated"))
        .catchError((error) => print("Failed to update User photo: $error"));
  }

  updateUserPassword(String mdp) {
    return citoyens
        .doc(globals.idUser)
        .update({
          'motDePasse': mdp,
        })
        .then((value) => print("User password Updated"))
        .catchError((error) => print("Failed to update User password: $error"));
  }
}
