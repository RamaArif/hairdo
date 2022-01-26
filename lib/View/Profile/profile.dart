import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:omahdilit/View/Login/login.dart';
import 'package:omahdilit/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        height: tinggi / 10,
        padding: EdgeInsets.symmetric(vertical: marginVertical),
        margin: EdgeInsets.only(bottom: marginVertical),
        child: MaterialButton(
          onPressed: () async {
            FirebaseAuth.instance.signOut();
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.remove("loggedIn");
            sharedPreferences.remove("uid");
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => Login(),
              ),
            );
          },
          child: Container(
            width: lebar,
            decoration: BoxDecoration(
                color: primary, borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              "Logout",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: tinggi / lebar * 7.5),
            )),
          ),
        ),
      ),
    );
  }
}
