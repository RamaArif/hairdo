import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:omahdilit/View/Home/home.dart';
import 'package:omahdilit/View/Login/login.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/navbar.dart';
import 'package:pinput/pin_put/pin_put.dart';

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

  @override
  void initState() {
    startTimer();
    super.initState();
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
                  onChanged: (val) {
                    if (val.length == 6) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => BottomNav(),
                          ),
                          (route) => false);
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
                child: Text(
                  textTimer,
                  style: TextStyle(
                      fontSize: tinggi / lebar * 7,
                      fontWeight: FontWeight.w600,
                      color: primary),
                ),
              ),
              SizedBox(
                height: tinggi / 2.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
