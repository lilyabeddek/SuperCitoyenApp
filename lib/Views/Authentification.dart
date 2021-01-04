import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supercitoyen/Services/AuthService.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:supercitoyen/Views/OptVerification.dart';
import 'package:supercitoyen/Views/SeConnecter.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:supercitoyen/globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supercitoyen/Services/UserService.dart';
import '../locale/app_localization.dart';
import 'package:supercitoyen/NewWidgets/Dialogs.dart';

class Authentification extends StatefulWidget {
  @override
  _AuthentificationState createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
  final formKey = new GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final TextEditingController phonecontroller = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final SmsAutoFill _autoFill = SmsAutoFill();
  String initialCountry = 'DZ';
  PhoneNumber number = PhoneNumber(isoCode: 'DZ');

  bool valide = false;
  String verificationId, smsCode;
  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: globals.textDirectionValue,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Color.fromRGBO(34, 43, 69, 1),
          ),
          //centerTitle: true,
          title: Text(
            AppLocalization.of(context).creerUnCompte,
            //'Créer un compte',
            style: TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color.fromRGBO(34, 43, 69, 1),
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeConnecter(),
                  ),
                );
              },
              child: Text(
                AppLocalization.of(context).seConnecter,
                //"Se Connecter",
                style: TextStyle(
                  color: Color.fromRGBO(78, 120, 236, 1),
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Theme(
                    data: Theme.of(context).copyWith(
                      // override textfield's icon color when selected
                      primaryColor: Color.fromRGBO(78, 120, 236, 1),
                    ),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber val) {
                        print(val.phoneNumber);
                        setState(() {
                          this.number = val;
                        });
                      },
                      onInputValidated: (bool value) {
                        print(value);
                        setState(() {
                          this.valide = value;
                        });
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG,
                        backgroundColor: Colors.white,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: PhoneNumber(isoCode: 'DZ'),
                      textFieldController: phonecontroller,
                      inputBorder: OutlineInputBorder(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30.0,
                      bottom: 5,
                    ),
                    height: 40,
                    child: ButtonTheme(
                      height: 50,
                      child: FlatButton(
                        onPressed: () async {
                          if (!formKey.currentState.validate()) {
                            return;
                          }
                          print(number.phoneNumber);
                          print(valide);
                          if (valide) {
                            Dialogs.showLoadingDialog(context, _keyLoader);
                            QueryDocumentSnapshot user =
                                await UserService().getUser(number.phoneNumber);
                            Navigator.of(_keyLoader.currentContext,
                                    rootNavigator: true)
                                .pop();
                            if (user != null) {
                              print("User existe");
                              setState(() {
                                scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(
                                      "Un compte existe déjà avec ce numéro esssayez de vous connecter"),
                                  duration: Duration(seconds: 2),
                                ));
                              });
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OptVerification(number.phoneNumber, true),
                                ),
                              );
                            }
                          } else {}
                        },
                        child: Center(
                            child: Text(
                          AppLocalization.of(context).continuer,
                          //"Continuer".toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 104, 16, 1),
                      borderRadius: BorderRadius.circular(50),
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

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 120),
      verificationCompleted: verified,
      verificationFailed: verificationfailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }

  @override
  void dispose() {
    phonecontroller?.dispose();
    super.dispose();
  }
}
