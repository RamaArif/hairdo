import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:omahdilit/View/Login/login.dart';
import 'package:omahdilit/View/Login/register.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/firebase_options.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: Colors.blue,
      ),
      home: Splashscreen(title: 'Flutter Demo Home Page'),
      builder: EasyLoading.init(),
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

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("user")!=null&&sharedPreferences.getBool("loggedIn")==true){
      Navigator.pushAndRemoveUntil(context,
          CupertinoPageRoute(builder: (_) => BottomNav()), (route) => false);
    } else if(sharedPreferences.getString("user")==null&&sharedPreferences.getBool("loggedIn")==true){
      Navigator.pushAndRemoveUntil(context,
          CupertinoPageRoute(builder: (_) => Register()), (route) => false);
    }else{
      Navigator.pushAndRemoveUntil(context,
          CupertinoPageRoute(builder: (_) => Login()), (route) => false);
    }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    tinggi = MediaQuery.of(context).size.height;
    lebar = MediaQuery.of(context).size.width;

    marginHorizontal = lebar / 20;
    marginVertical = tinggi / 50;
    
    return Scaffold(
      backgroundColor: Colors.white,
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
