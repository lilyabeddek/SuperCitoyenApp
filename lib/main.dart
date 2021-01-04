import 'package:provider/provider.dart';
import 'package:supercitoyen/Services/AuthService.dart';
import 'package:supercitoyen/Views/APropos.dart';
import 'package:supercitoyen/Views/Aide.dart';
import 'package:supercitoyen/Views/Brouillons.dart';
import 'package:flutter/material.dart';
import 'package:supercitoyen/Views/CompteUtilisateur.dart';
import 'package:supercitoyen/Views/ContactezNous.dart';
import 'package:supercitoyen/Views/MesSignalements.dart';
import 'package:supercitoyen/Views/Ouverture.dart';
import 'package:supercitoyen/Views/Notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supercitoyen/Views/NouvelleDeclaration.dart';
import 'package:supercitoyen/DarkTheme/dark_theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supercitoyen/globals.dart' as globals;
import 'locale/app_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
  AppLocalizationDelegate _localeOverrideDelegate =
      AppLocalizationDelegate(Locale('fr', ''));

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            localizationsDelegates: [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              _localeOverrideDelegate,
            ],
            supportedLocales: [
              const Locale('fr', ''),
              const Locale('ar', ''),
              const Locale('en', ''),
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Roboto',
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            darkTheme: ThemeData.dark(),
            // home: MesSignalements(),
            home: Directionality(
              child: AuthService().handleAuth(),
              textDirection: globals.textDirectionValue,
            ),
            //initialRoute: '/',
            routes: {
              'Authentification': (_) => AuthService().handleAuth(),
              '/MesSignalements': (_) => MesSignalements(),
              '/Notifications': (_) => Notifications(),
              '/Brouillons': (_) => Brouillons(),
              '/APropos': (_) => APropos(),
              '/ContactezNous': (_) => ContactezNous(),
              '/NouvelleDeclaration': (_) => NouvelleDeclaration(),
              '/Compte': (_) => CompteUtilisateur(),
              '/Aide': (_) => Aide(),
            },
          );
        },
      ),
    );
  }
}
