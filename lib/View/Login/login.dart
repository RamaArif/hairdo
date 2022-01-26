import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:omahdilit/View/Login/verification.dart';
import 'package:omahdilit/constant.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _phoneController = new TextEditingController();
  String countryCode = "+62";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomSheet: Container(
          color: Colors.white,
          height: tinggi / 10,
          padding: EdgeInsets.symmetric(vertical: marginVertical),
          margin: EdgeInsets.only(bottom: marginVertical),
          child: MaterialButton(
            onPressed: () {
              if (_phoneController.text.length > 10) {
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => verification(
                        code: countryCode,
                        phone: _phoneController.text,
                      ),
                    ),
                    (route) => false);
              } else {
                EasyLoading.showError("Masukkan nomor yang valid!");
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
          child: SafeArea(
            child: Container(
              height: tinggi / 1.12,
              width: lebar,
              padding: EdgeInsets.symmetric(
                horizontal: marginHorizontal,
                vertical: marginVertical * 2,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: lebar,
                    child: Text(
                      "Selamat Datang",
                      style: TextStyle(
                        color: primary,
                        fontSize: tinggi / lebar * 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: tinggi / 90,
                  ),
                  Container(
                    width: lebar,
                    child: Text(
                      "Masuk untuk mulai cukur rambut",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: tinggi / lebar * 9,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: tinggi / 30,
                  ),
                  Container(
                    width: lebar,
                    child: Text(
                      "Nomor Telepon",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: tinggi / lebar * 7,
                      ),
                    ),
                  ),
                  Container(
                    height: tinggi / 10,
                    width: lebar,
                    child: Row(
                      children: [
                        Container(
                          height: tinggi / 12,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: greyBackground),
                          child: CountryCodePicker(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: tinggi / lebar * 8,
                            ),
                            onChanged: (val) {
                              setState(() {
                                countryCode = val.code!;
                              });
                            },
                            initialSelection: 'ID',
                            favorite: ['+62', 'ID'],
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                          ),
                        ),
                        SizedBox(
                          width: lebar / 30,
                        ),
                        Expanded(
                          child: Container(
                            height: tinggi / 12,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(12)
                              ],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: tinggi / lebar * 8,
                              ),
                              decoration: InputDecoration(
                                  hintText: "Nomor Telepon",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: greyBackground),
                              controller: _phoneController,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                                text: "Dengan mendaftar, saya akan menerima "),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Syarat dan Ketentuan Pengguna",
                                  style: TextStyle(color: primary),
                                ),
                              ),
                            ),
                            TextSpan(text: " yang berlaku di Hairdo"),
                          ]),
                    ),
                  ),
                  SizedBox(height: tinggi / 15),
                ],
              ),
            ),
          ),
        ));
  }
}
