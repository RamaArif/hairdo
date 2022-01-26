import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import "package:flutter/cupertino.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/View/FormAlamat/pinLocation.dart';
import 'package:omahdilit/bloc/kota/kota_bloc.dart';
import 'package:omahdilit/bloc/provinsi/provinsi_bloc.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/listalamat.dart';
import 'package:omahdilit/model/listkota.dart';
import 'package:omahdilit/model/listprovinsi.dart';

class FormAlamat extends StatefulWidget {
  const FormAlamat({Key? key}) : super(key: key);

  @override
  _FormAlamatState createState() => _FormAlamatState();
}

class _FormAlamatState extends State<FormAlamat> {
  bool isProv = false;
  Provinsi _provinsi = Provinsi();
  bool isCity = false;
  Kota _kota = Kota();
  bool isPin = false;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _numberController = new TextEditingController();
  TextEditingController _kecamatanController = new TextEditingController();
  TextEditingController _kelurahanController = new TextEditingController();
  TextEditingController _pinController = new TextEditingController();

  final ProvinsiBloc _provinsiBloc = ProvinsiBloc();
  final KotaBloc _kotaBloc = KotaBloc();

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xFF6F6F6F),
            size: 21,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF6F6F6F)),
        title: Text(
          "Alamat Kamu",
          style: TextStyle(
            color: Color(0xFF6F6F6F),
            fontSize: tinggi / lebar * 8,
          ),
        ),
      ),
      bottomSheet: Container(
        width: lebar,
        height: tinggi / 15,
        color: blue,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: marginVertical,
            ),
            color: greyBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: marginHorizontal,
                  ),
                  child: Text(
                    "Data Pemesan",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: tinggi / lebar * 7,
                    ),
                  ),
                ),
                Container(
                  width: lebar,
                  height: tinggi / 15,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: marginHorizontal / 2,
                  ),
                  margin: EdgeInsets.only(top: marginVertical / 2),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Nama Pemesan",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(
                      color: textColor,
                      fontSize: tinggi / lebar * 7,
                    ),
                    controller: _nameController,
                  ),
                ),
                Container(
                  width: lebar,
                  height: tinggi / 15,
                  padding: EdgeInsets.symmetric(
                    horizontal: marginHorizontal / 2,
                  ),
                  margin: EdgeInsets.only(top: marginVertical / 2),
                  color: Colors.white,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Nomor Telp (+62)",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(
                      color: textColor,
                      fontSize: tinggi / lebar * 7,
                    ),
                    controller: _numberController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: marginHorizontal,
                    right: marginHorizontal,
                    top: marginVertical,
                    bottom: marginVertical / 2,
                  ),
                  child: Text(
                    "Data Alamat",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: tinggi / lebar * 7,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _awaitPickProvinsi(
                      context,
                    );
                  },
                  child: Container(
                    width: lebar,
                    height: tinggi / 15,
                    padding: EdgeInsets.symmetric(
                      horizontal: marginHorizontal,
                    ),
                    margin: EdgeInsets.only(top: marginVertical / 2),
                    color: Colors.white,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _provinsi.province != null
                          ? _provinsi.province.toString()
                          : "Pilih Provinsi",
                      style: TextStyle(
                        color: textColor,
                        fontSize: tinggi / lebar * 7,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (isProv) {
                      _awaitPickKota(context, _provinsi.provinceId.toString());
                    } else {
                      EasyLoading.showError("Kamu belum pilih provinsi");
                    }
                  },
                  child: Container(
                    width: lebar,
                    height: tinggi / 15,
                    padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
                    margin: EdgeInsets.only(top: marginVertical / 2),
                    color: Colors.white,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _kota.cityName != null
                          ? _kota.cityName.toString()
                          : "Pilih Kota",
                      style: TextStyle(
                        color: textColor,
                        fontSize: tinggi / lebar * 7,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: lebar,
                  height: tinggi / 15,
                  padding: EdgeInsets.symmetric(
                    horizontal: marginHorizontal / 2,
                  ),
                  margin: EdgeInsets.only(top: marginVertical / 2),
                  color: Colors.white,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Kecamatan",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(
                      color: textColor,
                      fontSize: tinggi / lebar * 7,
                    ),
                    controller: _kecamatanController,
                  ),
                ),
                Container(
                  width: lebar,
                  height: tinggi / 15,
                  padding: EdgeInsets.symmetric(
                    horizontal: marginHorizontal / 2,
                  ),
                  margin: EdgeInsets.only(top: marginVertical / 2),
                  color: Colors.white,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: "Kelurahan",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(
                      color: textColor,
                      fontSize: tinggi / lebar * 7,
                    ),
                    controller: _kelurahanController,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _awaitSetPinLocation(
                      context,
                    );
                  },
                  child: Container(
                    width: lebar,
                    height: tinggi / 15,
                    padding: EdgeInsets.symmetric(
                      horizontal: marginHorizontal,
                    ),
                    margin: EdgeInsets.only(top: marginVertical / 2),
                    color: Colors.white,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      !isPin ? "Set Peta Lokasi" : "Sudah Set Lokasi",
                      style: TextStyle(
                        color: textColor,
                        fontSize: tinggi / lebar * 7,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _awaitPickProvinsi(BuildContext context) async {
    final result = await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      context: context,
      elevation: 1,
      builder: (context) {
        return Container(
          height: tinggi / 2,
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
                    child: FutureBuilder<ListProvinsi>(
                      future: _apiProvider.fetchProvinsi(),
                      builder: (context, snapshot) {
                        // print("Provinsi = " + snapshot.toString());
                        if (snapshot.data == null) {
                          return Container();
                        } else {
                          return CupertinoPicker(
                            backgroundColor: Colors.white,
                            useMagnifier: true,
                            magnification: 1.0,
                            itemExtent: 40,
                            scrollController: FixedExtentScrollController(
                              initialItem: 0,
                            ),
                            onSelectedItemChanged: (value) {
                              setState(() {
                                isProv = true;
                                _provinsi =
                                    snapshot.data!.rajaongkir!.results![value];
                              });
                            },
                            children: List<Widget>.generate(
                                snapshot.data!.rajaongkir!.results!.length,
                                (int index) {
                              return Center(
                                child: Text(snapshot.data!.rajaongkir!
                                        .results![index].province ??
                                    ""),
                              );
                            }),
                          );
                        }
                      },
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

  void _awaitPickKota(BuildContext context, String provinceId) async {
    final result = await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15),),
      ),
      context: context,
      elevation: 1,
      builder: (context) {
        return Container(
          height: tinggi / 2,
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
                    child: FutureBuilder<ListKota>(
                      future: _apiProvider.fetchKota(provinceId),
                      builder: (context, snapshot) {
                        // print("Provinsi = " + snapshot.toString());
                        if (snapshot.data == null) {
                          return Container();
                        } else {
                          return CupertinoPicker(
                            backgroundColor: Colors.transparent,
                            useMagnifier: true,
                            magnification: 1.0,
                            itemExtent: 40,
                            scrollController: FixedExtentScrollController(
                              initialItem: 0,
                            ),
                            onSelectedItemChanged: (value) {
                              setState(() {
                                isCity = true;
                                _kota =
                                    snapshot.data!.rajaongkir!.results![value];
                              });
                            },
                            children: List<Widget>.generate(
                              snapshot.data!.rajaongkir!.results!.length,
                              (int index) {
                                return Center(
                                  child: Text(snapshot.data!.rajaongkir!
                                          .results![index].cityName ??
                                      ""),
                                );
                              },
                            ),
                          );
                        }
                      },
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

  Future<void> _awaitSetPinLocation(BuildContext context) async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => PinLocation(),
      ),
    );
  }
}
