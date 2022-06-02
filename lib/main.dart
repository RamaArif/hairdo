import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omahdilit/Api/shared_prefs_services.dart';
import 'package:omahdilit/View/Login/login.dart';
import 'package:omahdilit/View/Login/register.dart';
import 'package:omahdilit/bloc/activity/activity_bloc.dart';
import 'package:omahdilit/bloc/alamat/alamat_bloc.dart';
import 'package:omahdilit/bloc/harga/harga_bloc.dart';
import 'package:omahdilit/bloc/modelhair/modelhair_bloc.dart';
import 'package:omahdilit/bloc/profile/profile_bloc.dart';
import 'package:omahdilit/bloc/provcity/city_bloc.dart';
import 'package:omahdilit/bloc/provcity/province_bloc.dart';
import 'package:omahdilit/bloc/spotlight/spotlight_bloc.dart';
import 'package:omahdilit/bloc/transaksi/create_transaksi_bloc.dart';
import 'package:omahdilit/bloc/transaksi/transaksi_bloc.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/firebase_options.dart';
import 'package:omahdilit/model/customer.dart';
import 'package:omahdilit/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProvinceBloc>(
          create: (context) => ProvinceBloc(),
        ),
        BlocProvider<CityBloc>(
          create: (context) => CityBloc(),
        ),
        BlocProvider<TransaksiBloc>(
          create: (context) => TransaksiBloc(),
        ),
        BlocProvider<ActivityBloc>(
          create: (context) => ActivityBloc(),
        ),
        BlocProvider<CreateTransaksiBloc>(
          create: (context) => CreateTransaksiBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider<AlamatBloc>(
          create: (context) => AlamatBloc(),
        ),
        BlocProvider<ModelhairBloc>(
          create: (context) => ModelhairBloc(),
        ),
        BlocProvider<HargaBloc>(
          create: (context) => HargaBloc(),
        ),
        BlocProvider<SpotlightBloc>(
          create: (context) => SpotlightBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: Colors.blue,
        ),
        home: Splashscreen(title: 'Flutter Demo Home Page'),
        builder: EasyLoading.init(),
      ),
    );
  }
}

class Splashscreen extends StatefulWidget {
  Splashscreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 3000)).then((value) async {
      _initUser();
      // SharedPreferences sharedPreferences =
      //     await SharedPreferences.getInstance();
      // if (sharedPreferences.getString("user") != null &&
      //     sharedPreferences.getBool("loggedIn") == true) {
      // } else if (sharedPreferences.getString("user") == null &&
      //     sharedPreferences.getBool("loggedIn") == true) {
      //   Navigator.pushAndRemoveUntil(context,
      //       CupertinoPageRoute(builder: (_) => Register()), (route) => false);
      // } else {
      //   Navigator.pushAndRemoveUntil(context,
      //       CupertinoPageRoute(builder: (_) => Login()), (route) => false);
      // }
    });
    super.initState();
  }

  void _initUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // SharedPrefsServices().getFirstOpen().then((value) {
      //   print(value);
      //   if (value != null) {
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
            builder: (_) => Login(),
          ),
          (route) => false);
      //   } else {
      //     Navigator.pushAndRemoveUntil(
      //         context,
      //         CupertinoPageRoute(
      //           builder: (_) => Intro(),
      //         ),
      //         (route) => false);
      //   }
      // });
    } else {
      SharedPrefsServices().getUser().then((value) {
        print(value);
        if (value != null) {
          Customer customer = Customer.fromJson(jsonDecode(value));
          context.read<ProfileBloc>().add(SetUser(customer));
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (_) => BottomNav()),
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
  }

  @override
  Widget build(BuildContext context) {
    tinggi = MediaQuery.of(context).size.height;
    lebar = MediaQuery.of(context).size.width;

    marginHorizontal = lebar / 20;
    marginVertical = tinggi / 50;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Center(
        child: Container(
          child: Image.asset("assets/logo.png"),
          padding: EdgeInsets.symmetric(
            horizontal: marginHorizontal,
          ),
        ),
      ),
    );
  }
}
