import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/bloc/profile/profile_bloc.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/loading.dart';
import 'package:omahdilit/model/customer.dart';
import 'package:omahdilit/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _sexController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<Text> _sex = [
    Text(
      "Laki-laki",
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: tinggi / lebar * 8.5,
      ),
    ),
    Text(
      "Perempuan",
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: tinggi / lebar * 8.5,
      ),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchNumber();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return LoadingBuilder();
          }
          return Scaffold(
            backgroundColor: Colors.white,
            bottomSheet: Container(
              color: Colors.white,
              height: tinggi / 15,
              margin: EdgeInsets.only(bottom: marginVertical),
              child: MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.

                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    Customer _customer = new Customer();
                    _customer.name = _nameController.text.toString();
                    _customer.email = _emailController.text.toString();
                    _customer.number = _numberController.text.toString();
                    _customer.jenkel = _sexController.text.toString();
                    _customer.pushtoken =
                        sharedPreferences.getString("pushToken");
                    _customer.uid = sharedPreferences.getString("uid");
                    context.read<ProfileBloc>().add(Registering(_customer));

                    // if (result.error == false) {
                    //   EasyLoading.showSuccess("Registrasi berhasil");
                    //   await sharedPreferences
                    //       .setString("user", jsonEncode(_customer.toJson()))
                    //       .then((value) {
                    //     Future.delayed(Duration(milliseconds: 1000)).then(
                    //       (value) {
                    //         Navigator.pushAndRemoveUntil(
                    //             context,
                    //             CupertinoPageRoute(
                    //               builder: (_) => BottomNav(),
                    //             ),
                    //             (route) => false);
                    //       },
                    //     );
                    //   });
                    // }
                  }
                },
                child: Container(
                  width: lebar,
                  decoration: BoxDecoration(
                      color: primary, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    "Lanjutkan",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: tinggi / lebar * 7.5),
                  )),
                ),
              ),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.only(bottom: marginVertical * 2),
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(
                    horizontal: marginHorizontal,
                    vertical: marginVertical * 3,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          width: lebar,
                          child: Text(
                            "Lengkapi Data Kamu",
                            style: TextStyle(
                              color: primary,
                              fontSize: tinggi / lebar * 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          width: lebar,
                          margin: EdgeInsets.only(top: marginVertical),
                          child: Text(
                            "Isi lengkap data kamu agar bisa lanjut pakai Hairdo.yu ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: tinggi / lebar * 7.5,
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: marginVertical),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: tinggi / lebar * 7.5,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Nama tidak boleh kosong';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Nama Kamu",
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: marginVertical / 2,
                                  horizontal: marginHorizontal / 2,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: greyBackground),
                            controller: _nameController,
                          ),
                        ),
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: tinggi / lebar * 7.5,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email tidak boleh kosong';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Masukkan Email",
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: marginVertical / 2,
                                  horizontal: marginHorizontal / 2,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: greyBackground),
                            controller: _emailController,
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: marginVertical),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            readOnly: true,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: tinggi / lebar * 7.5,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: marginVertical / 2,
                                  horizontal: marginHorizontal / 2,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: greyBackground),
                            controller: _numberController,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _awaitBottomSheetSex(context);
                          },
                          child: Container(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              enabled: false,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: tinggi / lebar * 7.5,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  EasyLoading.showError(
                                      "Jenis Kelamin tidak boleh kosong");
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: "Pilih Jenis Kelamin",
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: marginVertical / 2,
                                    horizontal: marginHorizontal / 2,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: greyBackground),
                              controller: _sexController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _fetchNumber() async {
    User user = FirebaseAuth.instance.currentUser!;
    setState(() {
      _numberController.text = user.phoneNumber.toString();
    });
  }

  void _awaitBottomSheetSex(BuildContext context) async {
    final result = await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      context: context,
      elevation: 1,
      builder: (context) {
        return Container(
          height: tinggi / 4,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: marginHorizontal,
              vertical: marginVertical,
            ),
            child: Column(
              children: [
                Container(
                  height: tinggi / 100,
                  width: lebar / 9,
                  decoration: BoxDecoration(
                    color: greyPill,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: lebar,
                    child: CupertinoPicker(
                      itemExtent: 40,
                      scrollController: FixedExtentScrollController(
                        initialItem: 0,
                      ),
                      onSelectedItemChanged: (value) {
                        setState(() {
                          _sexController.text = _sex[value].data.toString();
                        });
                      },
                      children: List<Widget>.generate(2, (index) {
                        return Center(child: _sex[index]);
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
