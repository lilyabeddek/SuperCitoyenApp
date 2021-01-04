import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CategorieService {
  final CollectionReference categories =
      FirebaseFirestore.instance.collection('Categorie');
  getCategories() {
    return categories
        .orderBy(Intl.defaultLocale == "fr"
            ? 'nom'
            : Intl.defaultLocale == "ar"
                ? 'nomAr'
                : 'nomEn')
        .snapshots();
  }

  getIdCategorie(String categorieID) {
    return categories.doc(categorieID).get();
  }
}
