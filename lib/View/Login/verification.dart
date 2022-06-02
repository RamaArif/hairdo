import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/Api/shared_prefs_services.dart';
import 'package:omahdilit/View/Login/login.dart';
import 'package:omahdilit/View/Login/register.dart';
import 'package:omahdilit/bloc/profile/profile_bloc.dart';
import 'package:omahdilit/bloc/provcity/province_bloc.dart';

import 'package:omahdilit/constant.dart';
import 'package:omahdilit/loading.dart';
import 'package:omahdilit/model/customer.dart';
import 'package:omahdilit/navbar.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Verification extends StatefulWidget {
  final bool isEdit;
  Customer? customer;
  Verification({
    Key? key,
    required this.code,
    required this.phone,
    this.isEdit = false,
    this.customer,
  }) : super(key: key);
  final String code, phone;
  @override
  VerificationState createState() => VerificationState();
}

class VerificationState extends State<Verification> {
  Timer? _timer;
  var textTimer = "60 Detik";
  int _detik = 60;
  TextEditingController _otpController = TextEditingController();

  final scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "scaffold-verify-phone");

  String? _verificationId;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_detik == 0) {
          timer.cancel();
          setState(() {
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
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      height: lebar / 8,
      width: lebar / 8,
      margin: EdgeInsets.symmetric(horizontal: 2),
      textStyle: textStyle.copyWith(
        color: primary,
        fontSize: tinggi / lebar * 10,
        fontWeight: FontWeight.w500,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: secondary,
      ),
    );

    final focusedPinTheme =
        defaultPinTheme.copyDecorationWith(color: Colors.transparent);

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
        EasyLoading.showSuccess("Login Berhasil");
        if (state is ProfileSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (_) => BottomNav()),
              (route) => false);
        } else if (state is Unregistered) {
          Navigator.pushAndRemoveUntil(context,
              CupertinoPageRoute(builder: (_) => Register()), (route) => false);
        }
      },
      builder: (context, state) {
        if (state is ProvinceLoading) {
          return LoadingBuilder();
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            bottomSheet: Container(
              color: Colors.white,
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
                      child: Pinput(
                        autofocus: true,
                        controller: _otpController,
                        onCompleted: (val) {
                          _signedIn(val);
                        },
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        showCursor: true,
                        cursor: Container(
                          height: lebar / 8,
                          width: lebar / 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: secondary,
                          ),
                        ),

                        // eachFieldPadding: EdgeInsets.symmetric(
                        //   horizontal: marginHorizontal,
                        //   vertical: marginVertical / 2,
                        // ),
                        // submittedFieldDecoration: _pinPutDecoration,
                        // selectedFieldDecoration: _pinPutDecoration,
                        // followingFieldDecoration: _pinPutDecoration,
                        // pinAnimationType: PinAnimationType.scale,
                        // textStyle: TextStyle(
                        //   color: primary,
                        //   fontSize: tinggi / lebar * 9,
                        // ),
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
                            setState(() {
                              _detik = 30;
                            });
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
      },
    );
  }

  Future<void> _verifyPhoneNumber() async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: widget.code + widget.phone,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            _otpController.text = credential.smsCode ?? "";
            // _signedIn(credential.smsCode);
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
      print(error);
      if (error.code == 'invalid-verification-code') {
        print("OTP salah");
        EasyLoading.showError("Kode OTP salah atau sudah expired");
      }
    }).then((user) {
      print("Otp benar");
      if (widget.isEdit) {
        context.read<ProfileBloc>().add(UpdateProfile(widget.customer!));
        Navigator.pop(context);
      } else {
        FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
        firebaseMessaging.getToken().then((value) async {
          if (value != null) {
            print(value);
            SharedPrefsServices().savePushToken(value);
            SharedPrefsServices().saveUid(user.user!.uid);
            context
                .read<ProfileBloc>()
                .add(SignIn(widget.phone, widget.code, value, user.user!.uid));
          }
        });
      }
    });
  }
}
