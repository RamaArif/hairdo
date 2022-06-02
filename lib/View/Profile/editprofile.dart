import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omahdilit/View/Login/verification.dart';
import 'package:omahdilit/bloc/profile/profile_bloc.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/loading.dart';
import 'package:omahdilit/model/customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoading) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return LoadingBuilder();
        } else if (state is ProfileSuccess) {
          _numberController.text = state.customer.number!;
          _nameController.text = state.customer.name!;
          _emailController.text = state.customer.email!;
          _sexController.text = state.customer.jenkel!;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Color(0xffFF4C30),
                  size: 21,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.white,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              title: Text(
                "Edit Profil",
                style: textStyle.copyWith(
                  color: primary,
                  fontWeight: bold,
                  fontSize: tinggi / lebar * 9,
                ),
              ),
            ),
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
                    if (state.customer.number == _numberController.text) {
                      context.read<ProfileBloc>().add(UpdateProfile(_customer));
                    } else {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => Verification(
                                    code: _customer.number!.substring(0, 3),
                                    phone: _customer.number!
                                        .substring(3, _customer.number!.length),
                                    isEdit: true,
                                    customer: _customer,
                                  )));
                    }
                  }
                },
                child: Container(
                  width: lebar,
                  decoration: BoxDecoration(
                      color: primary, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    "Simpan",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: tinggi / lebar * 7.5),
                  )),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: marginHorizontal,
                  vertical: marginVertical,
                ),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            "Ubah data kamu dengan benar biar kamu bisa pakai Hairdo.yu lebih nyaman",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: tinggi / lebar * 7.5,
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
                  ],
                ),
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
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
