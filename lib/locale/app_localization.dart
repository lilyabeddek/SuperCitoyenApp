import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/messages_all.dart';

class AppLocalization {
  static Future<AppLocalization> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  //Pages informatives
  String get infoSlide1 {
    return Intl.message(
      "Signalez les dysfonctionnements avec SyperCitoyen !",
      name: 'infoSlide1',
      desc: 'infoSlide1',
    );
  }

  String get sousTitreInfoSlide1 {
    return Intl.message(
      "Localisez, Catégorisez, prenez en photo et suivez vos signalements ",
      name: 'sousTitreInfoSlide1',
      desc: 'sousTitreInfoSlide1',
    );
  }

  String get infoSlide2 {
    return Intl.message(
      "Gestion des signalements au niveau des mairies",
      name: 'infoSlide2',
      desc: 'infoSlide2',
    );
  }

  String get sousTitreInfoSlide2 {
    return Intl.message(
      "Un service adapté à tous !",
      name: 'sousTitreInfoSlide2',
      desc: 'sousTitreInfoSlide2',
    );
  }

  String get infoSlide3 {
    return Intl.message(
      "Suivi des interventions techniques",
      name: 'infoSlide3',
      desc: 'infoSlide3',
    );
  }

  String get sousTitreInfoSlide3 {
    return Intl.message(
      "Un suivi du dépôt du signalement jusqu'à son traitement",
      name: 'sousTitreInfoSlide3',
      desc: 'sousTitreInfoSlide3',
    );
  }

  String get creerCompteOuSeConnecter {
    return Intl.message(
      'Créez un compte, ou connectez-vous!',
      name: 'creerCompteOuSeConnecter',
      desc: 'creerCompteOuSeConnecter',
    );
  }

  String get suivant {
    return Intl.message(
      'Suivant',
      name: 'suivant',
      desc: 'suivant',
    );
  }

  //Se Connecter
  String get seConnecter {
    return Intl.message(
      'Se Connecter',
      name: 'seConnecter',
      desc: 'word form signing up',
    );
  }

  String get sInscrire {
    return Intl.message(
      "S'inscrire",
      name: 'sInscrire',
      desc: "s'inscrire dans superCitoyen",
    );
  }

  String get hintTextNumTelephone {
    return Intl.message(
      'Numéro de téléphone',
      name: 'hintTextNumTelephone',
      desc: "hint Text Numéro de Telephone",
    );
  }

  String get hintTextMotDePasse {
    return Intl.message(
      'Mot de passe',
      name: 'hintTextMotDePasse',
      desc: "hint Text Mot De Passe",
    );
  }

  String get motDePasseOublie {
    return Intl.message(
      'Mot de passe oublié',
      name: 'motDePasseOublie',
      desc: 'boutton Mot de passe oublié',
    );
  }

  //Creer un compte

  String get creerUnCompte {
    return Intl.message(
      'Créer un compte',
      name: 'creerUnCompte',
      desc: 'creerUnCompte',
    );
  }

  String get continuer {
    return Intl.message(
      "Continuer",
      name: 'continuer',
      desc: 'continuer',
    );
  }

  String get finirInscription {
    return Intl.message(
      'Finissez votre inscription',
      name: 'finirInscription',
      desc: "finir Inscription d'un nouvel utilisateur",
    );
  }

  String get nom {
    return Intl.message(
      'Nom',
      name: 'nom',
      desc: "nom de l'utilisateur",
    );
  }

  String get prenom {
    return Intl.message(
      'Prénom',
      name: 'prenom',
      desc: "prenom de l'utilisateur",
    );
  }

  String get hintTextSaisissezMotDePasse {
    return Intl.message(
      'saisissez votre mot de passe',
      name: 'hintTextSaisissezMotDePasse',
      desc: 'hint text saisissez votre mot de passe',
    );
  }

  String get confirmationMotDePasse {
    return Intl.message(
      'Confirmation du mot de passe',
      name: 'confirmationMotDePasse',
      desc: 'confirmationMotDePasse',
    );
  }

  String get termesEtConditions {
    return Intl.message(
      "En continuant, je confirme avoir lu et accepté les Termes et conditions et politiques de confidentialité",
      name: 'termesEtConditions',
      desc: 'termesEtConditions',
    );
  }

  String get commencer {
    return Intl.message(
      'Commencer',
      name: 'commencer',
      desc: "entrer à l'application",
    );
  }

  //Prendre une photo
  String get galerie {
    return Intl.message(
      'Galerie',
      name: 'galerie',
      desc: 'galerie',
    );
  }

  String get appareilPhoto {
    return Intl.message(
      'Appareil photo',
      name: 'appareilPhoto',
      desc: 'Appareil photo',
    );
  }

  String get supprimerPhoto {
    return Intl.message(
      'Supprimer la photo',
      name: 'supprimerPhoto',
      desc: "supprimerPhoto",
    );
  }

  //Detail signalement
  String get categorie {
    return Intl.message(
      'Catégorie : ',
      name: 'categorie',
      desc: "categorie",
    );
  }

  String get traite {
    return Intl.message(
      'Traité',
      name: 'traite',
      desc: "traite",
    );
  }

  String get enCoursTraitement {
    return Intl.message(
      'En cours de traitement',
      name: 'enCoursTraitement',
      desc: "enCoursTraitement",
    );
  }

  String get etat {
    return Intl.message(
      'Etat : ',
      name: 'etat',
      desc: "etat",
    );
  }

  String get dateDeSignalement {
    return Intl.message(
      'Date de signalement : ',
      name: 'dateDeSignalement',
      desc: "dateDeSignalement",
    );
  }

  String get lieu {
    return Intl.message(
      'Lieu : ',
      name: 'lieu',
      desc: "lieu",
    );
  }

  String get detailDuSignalement {
    return Intl.message(
      'Détails du signalement',
      name: 'detailDuSignalement',
      desc: "detailDuSignalement",
    );
  }

  String get description {
    return Intl.message(
      'Description : ',
      name: 'description',
      desc: "description",
    );
  }

  //Detail brouillon / signalement
  String get envoyer {
    return Intl.message(
      'Envoyer',
      name: 'envoyer',
      desc: "envoyer",
    );
  }

  String get hintTextDescriptionSaisie {
    return Intl.message(
      "Décrivez l'incident...",
      name: 'hintTextDescriptionSaisie',
      desc: "hintTextDescriptionSaisie",
    );
  }

  String get descriptionSaisie {
    return Intl.message(
      'Description',
      name: 'descriptionSaisie',
      desc: "descriptionSaisie",
    );
  }

  String get hintTextCategorieChoix {
    return Intl.message(
      "Choisissez une catégorie",
      name: 'hintTextCategorieChoix',
      desc: "hintTextCategorieChoix",
    );
  }

  String get categorieChoix {
    return Intl.message(
      'Categorie',
      name: 'categorieChoix',
      desc: "categorieChoix",
    );
  }

  String get localisation {
    return Intl.message(
      'Localisation',
      name: 'localisation',
      desc: "localisation",
    );
  }

  String get detailUnBrouillon {
    return Intl.message(
      "Détail d'un Brouillon",
      name: 'detailUnBrouillon',
      desc: "detailUnBrouillon",
    );
  }

  String get detailSignalement {
    return Intl.message(
      'Détails du signalement',
      name: 'detailSignalement',
      desc: "detailSignalement",
    );
  }

  //Mes Signalements
  String get mesSignalements {
    return Intl.message(
      'Mes Signalements',
      name: 'mesSignalements',
      desc: 'Titre de la page mes signalements',
    );
  }

  String get actifs {
    return Intl.message(
      'ACTIFS',
      name: 'actifs',
      desc: 'signalements actifs',
    );
  }

  String get fermes {
    return Intl.message(
      'FERMÉS',
      name: 'fermes',
      desc: 'signalements tarités',
    );
  }

  String get nouvelleDeclaration {
    return Intl.message(
      'Nouvelle Déclaration',
      name: 'nouvelleDeclaration',
      desc: 'nouvelle declaration',
    );
  }

  //Brouillons

  String get brouillons {
    return Intl.message(
      'Brouillons',
      name: 'brouillons',
      desc: 'brouillons',
    );
  }
  //Notifications

  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: 'notifications',
    );
  }

  String get nouveau {
    return Intl.message(
      'Nouveau',
      name: 'nouveau',
      desc: 'nouveau',
    );
  }

  String get plusTot {
    return Intl.message(
      'Plus tôt',
      name: 'plusTot',
      desc: 'plusTot',
    );
  }

  //A propos
  String get aPropos {
    return Intl.message(
      'À propos',
      name: 'aPropos',
      desc: 'titre page à propos',
    );
  }

  String get nouveautes {
    return Intl.message(
      'Nouveautés',
      name: 'nouveautes',
      desc: "nouveautés par rapport à l'appli",
    );
  }

  String get aProposDeApplication {
    return Intl.message(
      "À propos de l'application",
      name: 'aProposDeApplication',
      desc: "infos sur l'appli",
    );
  }

  String get descriptionApp {
    return Intl.message(
      "Il s’agit d’une application citoyenne de signalement conçue pour rendre plus aisé le signalement de tout incident sur la voie publique et établir un lien entre citoyens et services de gestion de la collectivité. En reportant les différents problèmes rencontrés dans la ville, chaque individu peut agir directement sur la qualité des infrastructures et le bon développement de la cité. Elle permet d’intervenir plus rapidement lorsqu’une anomalie est rencontrée sur la voie publique. Elle offre la possibilité de faire remonter des informations géo localisées en quelques secondes auprès de la municipalité, ce qui représente un atout considérable dans la gestion d'une commune. Cela permet de mobiliser le côté citoyen des habitants qui peuvent signaler en temps réel tout dysfonctionnement ou problème rencontré dans la ville.",
      name: 'descriptionApp',
      desc: "description sur l'application",
    );
  }

  String get donnerUneNoteAppli {
    return Intl.message(
      "Donnez une note à l'application",
      name: 'donnerUneNoteAppli',
      desc: "noter app",
    );
  }

  String get partagezAvis {
    return Intl.message(
      "Partagez votre avis et aidez d'autre utilisateurs",
      name: 'partagezAvis',
      desc: "sous titre de noter l'app",
    );
  }

  String get coordoneesDeveloppeur {
    return Intl.message(
      "Coordonnées du développeur",
      name: 'coordoneesDeveloppeur',
      desc: "Infos netfer smart solutions",
    );
  }

  String get adresseNetfer {
    return Intl.message(
      "CA-E2-06 Cyber Parc, Sidi Abdellah، Rahmania",
      name: 'adresseNetfer',
      desc: "adresse netfer smart solutions",
    );
  }

  String get joursOuverture {
    return Intl.message(
      "Ouvert de dimache à jeudi",
      name: 'joursOuverture',
      desc: "jours ouverture netfer ",
    );
  }

  String get tempsOuverture {
    return Intl.message(
      "de 09:00 jusqu'à 17:00",
      name: 'tempsOuverture',
      desc: "temps ouverture netfer ",
    );
  }

  String get quiSommesNous {
    return Intl.message(
      'Qui sommes-nous ?',
      name: 'quiSommesNous',
      desc: "titre description netfer ",
    );
  }

  String get descriptionNetfer {
    return Intl.message(
      "NETFER SMART SOLUTIONS est une entreprise spécialisée dans le développement mobile et web et des Solutions Digitales.  Notre département de développement vous aidera à digitaliser vos processus métiers, vous gagnerez en temps, vous serez efficient et vous réduisez vos coûts.Nous mettons à votre disposition notre savoir faire acquis durant un parcours très riche dans les TICs, et traduit par des services et solutions entreprises et grand public dans le but de résoudre des problématiques réelles avec une expérience utilisateur la plus simple.",
      name: 'descriptionNetfer',
      desc: "description netfer ",
    );
  }

  String get site {
    return Intl.message(
      'Site',
      name: 'site',
      desc: "Site Internet Netfer",
    );
  }

  String get itineraire {
    return Intl.message(
      'Itineraire',
      name: 'itineraire',
      desc: "itineraire pour aller à netfer",
    );
  }

  String get appeler {
    return Intl.message(
      'Appeler',
      name: 'appeler',
      desc: "Appeler netfer smart solutions",
    );
  }

  //Contactez Nous
  String get contactezNous {
    return Intl.message(
      'Contactez Nous',
      name: 'contactezNous',
      desc: "contactez les admins de l'application",
    );
  }

  String get objet {
    return Intl.message(
      'Objet',
      name: 'objet',
      desc: "objet du feedback",
    );
  }

  String get hintTextObjet {
    return Intl.message(
      'Objet de votre message',
      name: 'hintTextObjet',
      desc: 'hint text de Objet de votre message',
    );
  }

  String get champObligatoire {
    return Intl.message(
      "Champ obligatoire",
      name: 'champObligatoire',
      desc: "msg d'erreur champ obligatoire",
    );
  }

  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: "titre message feedback",
    );
  }

  String get hintTextMessage {
    return Intl.message(
      'Saisissez votre message...',
      name: 'hintTextMessage',
      desc: "hint text du corp du message feedback",
    );
  }

  //Compte utilisateur
  String get ajustezImage {
    return Intl.message(
      "Ajustez l'image",
      name: 'ajustezImage',
      desc: "ajustezImage",
    );
  }

  String get gererMonCompte {
    return Intl.message(
      'Gérer mon Compte',
      name: 'gererMonCompte',
      desc: "gererMonCompte",
    );
  }

  String get modifierMonProfil {
    return Intl.message(
      'Modifier mon profil',
      name: 'modifierMonProfil',
      desc: "modifierMonProfil",
    );
  }

  String get langues {
    return Intl.message(
      'Langues',
      name: 'langues',
      desc: "langues",
    );
  }

  String get textMessagePartage {
    return Intl.message(
      "J'utilise SuperCitoyen pour signaler les incidents en temps réel, rejoins moi et télécharge SuperCitoyen :",
      name: 'textMessagePartage',
      desc: "textMessagePartage",
    );
  }

  String get inviterUnAmi {
    return Intl.message(
      'Inviter un ami',
      name: 'inviterUnAmi',
      desc: "inviterUnAmi",
    );
  }

  String get sonEtNotification {
    return Intl.message(
      'Son et notifications',
      name: 'sonEtNotification',
      desc: "sonEtNotification",
    );
  }

  String get confidentialite {
    return Intl.message(
      'Confidentialité',
      name: 'confidentialite',
      desc: "confidentialite",
    );
  }

  String get aideEtSupport {
    return Intl.message(
      'Aide et Support',
      name: 'aideEtSupport',
      desc: "aideEtSupport",
    );
  }

  String get deconnexion {
    return Intl.message(
      'Déconnexion',
      name: 'deconnexion',
      desc: "deconnexion",
    );
  }

  //Message Box : Dialog
  String get msgDeDeconnexion {
    return Intl.message(
      'Etes-vous sûr de vouloir vous déconnecter ?',
      name: 'msgDeDeconnexion',
      desc: "msgDeDeconnexion",
    );
  }

  String get oui {
    return Intl.message(
      'Oui',
      name: 'oui',
      desc: "oui",
    );
  }

  String get non {
    return Intl.message(
      'Non',
      name: 'non',
      desc: "non",
    );
  }

  //MasgBox Merci
  String get merci {
    return Intl.message(
      'Merci',
      name: 'merci',
      desc: "merci",
    );
  }

  String get feedbackEnregistre {
    return Intl.message(
      'Votre Feedback à bien été enregistré et sera pris en consideration dés que possible !',
      name: 'feedbackEnregistre',
      desc: "feedbackEnregistre",
    );
  }

  String get supprimerbrouillon {
    return Intl.message(
      'Etes-vous sûr de vouloir supprimer ce brouillon ?',
      name: 'supprimerbrouillon',
      desc: "supprimerbrouillon",
    );
  }

  String get date {
    return Intl.message(
      'date: ',
      name: 'date',
      desc: "date",
    );
  }

  String get adresse {
    return Intl.message(
      'Adresse',
      name: 'adresse',
      desc: "adresse",
    );
  }

  String get signalementEnregistre {
    return Intl.message(
      'Votre signalement à bien été enregistré et sera pris en compte !',
      name: 'signalementEnregistre',
      desc: "signalementEnregistre",
    );
  }

  //Parametres
  String get choisirUneLangue {
    return Intl.message(
      'Choisir une langue',
      name: 'choisirUneLangue',
      desc: "choisirUneLangue",
    );
  }

  String get modifierMesInfos {
    return Intl.message(
      'Modifier mes informations',
      name: 'modifierMesInfos',
      desc: "modifierMesInfos",
    );
  }

  String get valider {
    return Intl.message(
      'Valider',
      name: 'valider',
      desc: "Valider",
    );
  }

  String get voirPlus {
    return Intl.message(
      'Voir plus',
      name: 'voirPlus',
      desc: "voirPlus",
    );
  }

  String get voirMoins {
    return Intl.message(
      'Voir moins',
      name: 'voirMoins',
      desc: "voirMoins",
    );
  }

  //opt verification
  String get verifier {
    return Intl.message(
      "Vérifier",
      name: 'verifier',
      desc: "verifier",
    );
  }

  String get authAvecSucces {
    return Intl.message(
      "Authentifié avec succès",
      name: 'authAvecSucces',
      desc: "authAvecSucces",
    );
  }

  String get renvoyer {
    return Intl.message(
      " RENVOYER",
      name: 'renvoyer',
      desc: "renvoyer",
    );
  }

  String get vousNavezPasRecuLeCode {
    return Intl.message(
      "Vous n'avez pas reçu le code ? ",
      name: 'vousNavezPasRecuLeCode',
      desc: "vousNavezPasRecuLeCode",
    );
  }

  String get msgerreurRemplissezCorrectement {
    return Intl.message(
      "*Remplissez les cases correctement s'il vous plait",
      name: 'msgerreurRemplissezCorrectement',
      desc: "msgerreurRemplissezCorrectement",
    );
  }

  String get entrerLeCode {
    return Intl.message(
      "Entez le Code envoyé au  ",
      name: 'entrerLeCode',
      desc: "entrerLeCode",
    );
  }

  String get verifNumTel {
    return Intl.message(
      'Verification du Numéro de téléphone',
      name: 'verifNumTel',
      desc: "verifNumTel",
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  final Locale overriddenLocale;

  const AppLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) =>
      ['fr', 'ar', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
