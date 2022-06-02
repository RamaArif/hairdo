import 'dart:ffi';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omahdilit/View/History/history.dart';
import 'package:omahdilit/View/Profile/profile.dart';
import 'package:omahdilit/bloc/harga/harga_bloc.dart';
import 'package:omahdilit/constant.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'View/Home/home.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  var _currentIndex = 0;
  late List<Widget> _children;

  void view() {
    _children = <Widget>[
      Home(),
      History(),
      Profile(),
    ];
  }

  @override
  void initState() {
    super.initState();
    this.view();
    context.read<HargaBloc>().add(FetchHarga());
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      message: "Tap 2 kali untuk keluar",
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
          body: _children.elementAt(_currentIndex),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              vertical: marginVertical / 2,
            ),
            child: SalomonBottomBar(
              margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
              currentIndex: _currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
              items: [
                SalomonBottomBarItem(
                    icon: Icon(Icons.home),
                    title: Text("Home"),
                    selectedColor: primary),
                SalomonBottomBarItem(
                  icon: Icon(Icons.history),
                  title: Text("History"),
                  selectedColor: primary,
                ),
                SalomonBottomBarItem(
                  icon: Icon(Icons.person_outline),
                  title: Text("Profil"),
                  selectedColor: primary,
                )
              ],
            ),
          )),
    );
  }
}
