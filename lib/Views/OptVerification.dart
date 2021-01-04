import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supercitoyen/Services/AuthService.dart';
import 'package:flutter/gestures.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:supercitoyen/Views/CreationCompte.dart';
import 'package:supercitoyen/Views/ModifMotPasse.dart';
import 'package:supercitoyen/globals.dart' as globals;
import '../locale/app_localization.dart';

class OptVerification extends StatefulWidget {
  final String phoneNumber;
  final bool auth;

  OptVerification(this.phoneNumber, this.auth);

  @override
  _OptVerificationState createState() =>
      _OptVerificationState(this.phoneNumber, this.auth);
}

class _OptVerificationState extends State<OptVerification> {
  final String phoneNumber;
  final bool auth;
  _OptVerificationState(this.phoneNumber, this.auth);

  var onTapRecognizer;
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;
  String verificationId, smsCode;
  bool codeSent = false;
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        verifyPhone(phoneNumber);
      };
    errorController = StreamController<ErrorAnimationType>();
    verifyPhone(phoneNumber);
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: globals.textDirectionValue,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Color.fromRGBO(34, 43, 69, 1),
          ),
          centerTitle: true,
          title: Text(
            AppLocalization.of(context).verifNumTel,
            //'Verification du Numéro de téléphone',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        body: GestureDetector(
          onTap: () {},
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                  child: RichText(
                    text: TextSpan(
                      text: AppLocalization.of(context)
                          .entrerLeCode, //"Entez le Code envoyé au  ",
                      children: [
                        TextSpan(
                            text: widget.phoneNumber,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: false,
                        obscuringCharacter: '*',
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v.length < 6) {
                            return "";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          selectedColor: Color.fromRGBO(255, 104, 16, 1),
                          inactiveColor: Colors.grey[200],
                          activeColor: Color.fromRGBO(78, 120, 236, 1),
                          selectedFillColor: Colors.grey[200],
                          inactiveFillColor: Colors.grey[200],
                          activeFillColor:
                              hasError ? Colors.grey : Colors.grey[200],
                        ),
                        cursorColor: Colors.black,
                        animationDuration: Duration(milliseconds: 300),
                        textStyle: TextStyle(fontSize: 20, height: 1.6),
                        backgroundColor: Colors.white,
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        /*boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],*/
                        onCompleted: (v) {
                          print("Complet");
                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Permettre le copier coller de $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    hasError
                        ? AppLocalization.of(context)
                            .msgerreurRemplissezCorrectement //"*Remplissez les cases correctement s'il vous plait"
                        : "",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: AppLocalization.of(context)
                          .vousNavezPasRecuLeCode, //"Vous n'avez pas reçu le code ? ",
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                      children: [
                        TextSpan(
                            text: AppLocalization.of(context)
                                .renvoyer, //" RENVOYER",
                            recognizer: onTapRecognizer,
                            style: TextStyle(
                                color: Color.fromRGBO(78, 120, 236, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 16))
                      ]),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 30),
                  height: 40,
                  child: ButtonTheme(
                    height: 50,
                    child: FlatButton(
                      onPressed: () {
                        formKey.currentState.validate();
                        // conditions for validating
                        print(currentText);
                        print(smsCode);

                        if (currentText.length != 6) {
                          errorController.add(ErrorAnimationType
                              .shake); // Triggering error shake animation
                          setState(() {
                            hasError = true;
                          });
                        } else {
                          AuthCredential authCreds =
                              PhoneAuthProvider.getCredential(
                                  verificationId: verificationId,
                                  smsCode: currentText);
                          if (auth) {
                            setState(() {
                              hasError = false;
                            });
                            FirebaseAuth.instance
                                .signInWithCredential(authCreds)
                                .then((value) {
                              print(value.user.uid);
                              globals.idUser = value.user.uid;
                              globals.numTel = phoneNumber;
                              setState(() {
                                scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(AppLocalization.of(context)
                                      .authAvecSucces),
                                  duration: Duration(seconds: 2),
                                ));
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreationCompte(),
                                ),
                              );
                            }).catchError((e) {
                              print(e);
                            });
                          } else {
                            setState(() {
                              hasError = false;
                            });

                            FirebaseAuth.instance
                                .signInWithCredential(authCreds)
                                .then((value) {
                              print(value.user.uid);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ModifMotPasse(true),
                                ),
                              );
                            }).catchError((e) {
                              print(e);
                            });
                          }
                        }
                      },
                      child: Center(
                          child: Text(
                        AppLocalization.of(context).verifier,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 104, 16, 1),
                    borderRadius: BorderRadius.circular(50),
                    /*boxShadow: [
                      BoxShadow(
                          color: Colors.blue.shade100,
                          offset: Offset(1, -2),
                          blurRadius: 5),
                      BoxShadow(
                          color: Colors.blue.shade100,
                          offset: Offset(-1, 2),
                          blurRadius: 5)
                    ],*/
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
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
}
