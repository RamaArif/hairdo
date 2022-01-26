import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/View/Home/home.dart';
import 'package:omahdilit/View/Login/login.dart';
import 'package:omahdilit/View/Login/register.dart';

import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/loginresponse.dart';
import 'package:omahdilit/navbar.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

class verification extends StatefulWidget {
  verification({Key? key, required this.code, required this.phone})
      : super(key: key);
  final String code, phone;
  int _start = 60;
  @override
  verificationState createState() => verificationState();
}

class verificationState extends State<verification> {
  Timer? _timer;
  var textTimer = "60 Detik";
  int _detik = 60;
  TextEditingController _otpController = TextEditingController();

  final scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "scaffold-verify-phone");

  String? _verificationId;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      color: secondary,
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_detik == 0) {
          setState(() {
            timer.cancel();
            textTimer = "Kirim Ulang";
          });
        } else {
          setState(() {
            _detik--;
            textTimer = _detik.toString() + " Detik";
          });
        }
      },
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    startTimer();
    _verifyPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: tinggi / 10,
        child: Column(
          children: [
            Container(
              width: lebar,
              alignment: Alignment.center,
              child: Text("Nomor Telepon Salah ?"),
            ),
            Container(
              width: lebar,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => Login(),
                      ),
                      (route) => false);
                },
                child: Text(
                  "Ubah Nomor",
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          width: lebar,
          height: tinggi,
          padding: EdgeInsets.symmetric(
            horizontal: marginHorizontal,
            vertical: marginVertical,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: tinggi / 10,
              ),
              Container(
                alignment: Alignment.center,
                width: lebar,
                child: Text(
                  "Verifikasi OTP",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: tinggi / lebar * 9,
                  ),
                ),
              ),
              SizedBox(
                height: tinggi / 45,
              ),
              Container(
                alignment: Alignment.center,
                width: lebar,
                child: Text(
                    "Masukkan OTP yang dikirim ke ${widget.code}${widget.phone}"),
              ),
              SizedBox(
                height: tinggi / 25,
              ),
              Container(
                alignment: Alignment.center,
                width: lebar,
                child: PinPut(
                  controller: _otpController,
                  onChanged: (val) {
                    if (val.length == 6) {
                      _signedIn(val);
                    }
                  },
                  fieldsCount: 6,
                  eachFieldPadding: EdgeInsets.symmetric(
                    horizontal: marginHorizontal,
                    vertical: marginVertical / 2,
                  ),
                  submittedFieldDecoration: _pinPutDecoration,
                  selectedFieldDecoration: _pinPutDecoration,
                  followingFieldDecoration: _pinPutDecoration,
                  pinAnimationType: PinAnimationType.scale,
                  textStyle: TextStyle(
                    color: primary,
                    fontSize: tinggi / lebar * 9,
                  ),
                ),
              ),
              SizedBox(
                height: tinggi / 30,
              ),
              Container(
                width: lebar,
                alignment: Alignment.center,
                child: Text(
                  "Tidak menerima kode OTP ?",
                ),
              ),
              Container(
                width: lebar,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    if (_detik == 0) {
                      startTimer();
                      _verifyPhoneNumber();
                    }
                  },
                  child: Text(
                    textTimer,
                    style: TextStyle(
                        fontSize: tinggi / lebar * 7,
                        fontWeight: FontWeight.w600,
                        color: primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _verifyPhoneNumber() async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: widget.code + widget.phone,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            _otpController.text = credential.smsCode ?? "";
            _signedIn(credential.smsCode);
          },
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              EasyLoading.showToast(
                  "Pastikan nomor sudah dalam format yang benar");
            } else if (e.code == 'quota-exceeded') {
              EasyLoading.showToast(
                  "Terlalu banyak percobaan, ulangi dalam beberapa jam");
            }
          },
          codeSent: (String verificationId, int? resendToken) {
            _verificationId = verificationId;
            EasyLoading.showToast("Kode OTP Terkirim");
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {
      EasyLoading.showError("Gagal verifikasi OTP");
    }
  }

  _signedIn(smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId ?? "", smsCode: smsCode);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await _auth.signInWithCredential(credential).catchError((error) {
      if (error.code == 'invalid-verification-code') {
        EasyLoading.showError("Kode OTP salah atau sudah expired");
      }
    }).then((value) {
      sharedPreferences.setBool("loggedIn", true);
      sharedPreferences.setString(
          "number", widget.code.toString() + widget.phone);
      // var _currentUser = FirebaseAuth.instance.currentUser;
      sharedPreferences.setString("uid", value.user!.uid);
    });

    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then((value) async {

      sharedPreferences.setString("pushToken", value.toString());
      var response =
          await ApiProvider().login(widget.code + widget.phone, value);
      if (response.error == false) {
        var _number = sharedPreferences.getString("number");

        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
              builder: (_) => BottomNav(),
            ),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
              builder: (_) => Register(),
            ),
            (route) => false);
      }
    });
  }

  _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text('$text'),
      duration: Duration(seconds: 2),
    );
    scaffoldKey.currentState!.showSnackBar(snackBar);
  }
}
