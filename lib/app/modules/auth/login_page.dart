import 'package:authentication_in_flutter/app/modules/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum MobileVerificationState { SHOW_MOBILE_FORM_STATE, SHOW_OTP_FORM_STATE }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;

  bool showLoading = false;

  String prefix = '+55';

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential?.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  getMobileFormWidget(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 100),
          Text('Insira o seu número de telefone'),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              child: Row(
                children: [
                  Text('+55', style: TextStyle(fontSize: 18)),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                        controller: phoneController,
                        decoration:
                            InputDecoration(hintText: '(00) 0 0000-0000'),
                        keyboardType: TextInputType.phone),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          TextButton(
              onPressed: () async {
                setState(() {
                  showLoading = true;
                });
                await _auth.verifyPhoneNumber(
                    phoneNumber: '$prefix' + phoneController.text,
                    verificationCompleted: (phoneAuthCredential) async {
                      setState(() {
                        showLoading = false;
                      });
                    },
                    verificationFailed: (verificationFailed) async {
                      setState(() {
                        showLoading = false;
                      });
                      _scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Text(verificationFailed.message)));
                    },
                    codeSent: (verificationId, resendingToken) async {
                      setState(() {
                        showLoading = false;
                        currentState =
                            MobileVerificationState.SHOW_OTP_FORM_STATE;
                        this.verificationId = verificationId;
                      });
                    },
                    codeAutoRetrievalTimeout: (verificationId) async {});
              },
              child: Text('Verificar número')),
        ],
      ),
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(30),
          child: TextField(
              controller: otpController,
              decoration: InputDecoration(hintText: 'Número do  OTP')),
        ),
        SizedBox(height: 16),
        TextButton(
            onPressed: () {
              PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: otpController.text);
              signInWithPhoneAuthCredential(phoneAuthCredential);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text('Verificar OTP')),
        Spacer()
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: showLoading
            ? Center(child: CircularProgressIndicator())
            : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                ? getMobileFormWidget(context)
                : getOtpFormWidget(context),
      ),
    );
  }
}
