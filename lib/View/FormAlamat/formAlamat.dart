import 'dart:convert';

import 'package:flutter/material.dart';
import "package:flutter/cupertino.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/View/FormAlamat/pinLocation.dart';
import 'package:omahdilit/bloc/provcity/city_bloc.dart';
import 'package:omahdilit/bloc/provcity/province_bloc.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/listalamat.dart';
import 'package:omahdilit/model/listkota.dart';
import 'package:omahdilit/model/listprovinsi.dart';
import 'package:shimmer/shimmer.dart';

class FormAlamat extends StatefulWidget {
  final String uid;

  const FormAlamat({Key? key, required this.uid}) : super(key: key);

  @override
  _FormAlamatState createState() => _FormAlamatState();
}

class _FormAlamatState extends State<FormAlamat> {
  bool isProv = false;
  Provinsi? _provinsi;

  int indexProvince = 0, indexCity = 0;
  bool isCity = false;
  Kota? _kota;
  bool isPin = false;
  bool utama = true;
  LatLng? latLng;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _numberController = new TextEditingController();
  TextEditingController _kecamatanController = new TextEditingController();
  TextEditingController _tagController = new TextEditingController();
  TextEditingController _alamatController = new TextEditingController();

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
            onTap: () async {
              if (isCity &&
                  isProv &&
                  isPin &&
                  _nameController.text.isNotEmpty &&
                  _numberController.text.isNotEmpty &&
                  _kecamatanController.text.isNotEmpty &&
                  _tagController.text.isNotEmpty &&
                  _alamatController.text.isNotEmpty) {
                Alamat alamat = Alamat(
                    uidCustomer: widget.uid,
                    tag: _tagController.text,
                    nama: _nameController.text,
                    noTelp: _numberController.text,
                    alamat: _alamatController.text,
                    provinsi: _provinsi!.province,
                    kota: _kota!.cityName,
                    kecamatan: _kecamatanController.text,
                    lat: latLng!.latitude,
                    lng: latLng!.longitude,
                    utama: utama ? 1 : 0);
                print(alamat.tag.toString());
                print(alamat.nama.toString());
                print(alamat.noTelp.toString());
                print(alamat.alamat.toString());
                print(alamat.provinsi.toString());
                print(alamat.kota.toString());
                print(alamat.kecamatan.toString());
                print(alamat.lat.toString());
                print(alamat.lng.toString());
                print(alamat.utama.toString());
                final result = await ApiProvider().createAlamat(alamat);
                if (result.alamat!.isNotEmpty) {
                  Navigator.pop(context, alamat);
                }
              } else {
                EasyLoading.showError("Pastikan semua form terisi");
              }
            },
            child: Center(
              child: Text(
                "Simpan",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: tinggi / lebar * 7.5),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: marginVertical,
              ),
              padding: EdgeInsets.only(
                bottom: marginVertical * 3,
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
                        hintText:
                            "Simpan alamat sebagai, contoh : Rumah, Kantor...",
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
                      controller: _tagController,
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
                        hintText: "Alamat lengkap",
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
                      controller: _alamatController,
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
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: marginVertical / 2),
                      color: Colors.white,
                      child: Text(
                        isProv ? _provinsi!.province! : "Pilih provinsi",
                        style: TextStyle(
                          color: isProv ? textColor : textAccent,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (isProv) {
                        _awaitPickKota(
                            context, _provinsi!.provinceId.toString());
                      } else {
                        EasyLoading.showError("Kamu belum pilih provinsi");
                      }
                    },
                    child: Container(
                      width: lebar,
                      height: tinggi / 15,
                      padding: EdgeInsets.symmetric(
                        horizontal: marginHorizontal,
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: marginVertical / 2),
                      color: Colors.white,
                      child: Text(
                        isCity ? _kota!.cityName! : "Pilih kota",
                        style: TextStyle(
                          color: isCity ? textColor : textAccent,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            !isPin ? "Set Peta Lokasi" : "Sudah Set Lokasi",
                            style: TextStyle(
                              color: !isPin ? textAccent : textColor,
                              fontSize: tinggi / lebar * 7,
                            ),
                          ),
                          isPin
                              ? Icon(
                                  Icons.check_sharp,
                                  color: blue,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: lebar,
                    height: tinggi / 15,
                    padding: EdgeInsets.symmetric(
                      horizontal: marginHorizontal,
                    ),
                    margin: EdgeInsets.only(top: marginVertical / 2),
                    color: Colors.white,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Jadikan alamat utama ",
                          style: TextStyle(
                            color: textColor,
                            fontSize: tinggi / lebar * 7,
                          ),
                        ),
                        Switch.adaptive(
                          value: utama,
                          onChanged: (bool value) {
                            setState(
                              () {
                                utama = value;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _awaitPickProvinsi(BuildContext context) async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
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
                    color: greyLight,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: lebar,
                    child: BlocBuilder<ProvinceBloc, ProvinceState>(
                      builder: (context, state) {
                        if (state is ProvLoaded) {
                          return CupertinoPicker(
                            useMagnifier: true,
                            magnification: 1.0,
                            itemExtent: 50,
                            scrollController: FixedExtentScrollController(
                                initialItem: indexProvince),
                            onSelectedItemChanged: (value) {
                              setState(() {
                                isProv = true;
                                _kota = null;
                                indexCity = 0;
                                indexProvince = value;
                                _provinsi = state
                                    .listProvinsi.rajaongkir!.results![value];
                              });
                            },
                            children: List<Widget>.generate(
                                state.listProvinsi.rajaongkir!.results!.length,
                                (int index) {
                              return Center(
                                child: Text(state.listProvinsi.rajaongkir!
                                        .results![index].province ??
                                    ""),
                              );
                            }),
                          );
                        } else {
                          return Shimmer.fromColors(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: marginVertical,
                                horizontal: marginHorizontal,
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: marginHorizontal / 2),
                                child: Container(
                                  width: lebar,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: marginHorizontal / 2,
                                    vertical: marginVertical / 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade400,
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
    ).whenComplete(() {
      if (_provinsi != null) {
        context.read<CityBloc>().add(GetCity(_provinsi!.provinceId!));
      }
    });
  }

  void _awaitPickKota(BuildContext context, String provinceId) async {
    final result = await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
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
                    color: greyLight,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: lebar,
                    child: BlocBuilder<CityBloc, CityState>(
                      builder: (context, state) {
                        if (state is CityLoaded) {
                          print(jsonEncode(state.listKota));
                          return CupertinoPicker(
                            useMagnifier: true,
                            magnification: 1.0,
                            itemExtent: 50,
                            scrollController: FixedExtentScrollController(
                              initialItem: indexCity,
                            ),
                            onSelectedItemChanged: (value) {
                              setState(() {
                                isCity = true;
                                indexCity = value;

                                _kota =
                                    state.listKota.rajaongkir!.results![value];
                              });
                            },
                            children: List<Widget>.generate(
                                state.listKota.rajaongkir!.results!.length,
                                (int index) {
                              return Center(
                                child: Text(state.listKota.rajaongkir!
                                        .results![index].cityName ??
                                    ""),
                              );
                            }),
                          );
                        } else {
                          return Shimmer.fromColors(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: marginVertical,
                                horizontal: marginHorizontal,
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: marginHorizontal / 2),
                                child: Container(
                                  width: lebar,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: marginHorizontal / 2,
                                    vertical: marginVertical / 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade400,
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

  // void _awaitPickProvinsi(BuildContext context) async {
  //   final result = await showModalBottomSheet(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(15), topRight: Radius.circular(15)),
  //     ),
  //     context: context,
  //     elevation: 1,
  //     builder: (context) {
  //       return Container(
  //         height: tinggi / 2,
  //         child: Padding(
  //           padding: EdgeInsets.symmetric(
  //             horizontal: marginHorizontal,
  //             vertical: marginVertical,
  //           ),
  //           child: Column(
  //             children: [
  //               Container(
  //                 height: tinggi / 100,
  //                 width: lebar / 9,
  //                 decoration: BoxDecoration(
  //                   color: greyPill,
  //                   borderRadius: BorderRadius.circular(5),
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Container(
  //                   width: lebar,
  //                   child: FutureBuilder<ListProvinsi>(
  //                     future: _apiProvider.fetchProvinsi(),
  //                     builder: (context, snapshot) {
  //                       // print("Provinsi = " + snapshot.toString());
  //                       if (snapshot.data == null) {
  //                         return Shimmer.fromColors(
  //                           child: Container(
  //                             margin: EdgeInsets.symmetric(
  //                               vertical: marginVertical,
  //                               horizontal: marginHorizontal,
  //                             ),
  //                             child: Card(
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(12),
  //                               ),
  //                               margin: EdgeInsets.symmetric(
  //                                   horizontal: marginHorizontal / 2),
  //                               child: Container(
  //                                 width: lebar,
  //                                 padding: EdgeInsets.symmetric(
  //                                   horizontal: marginHorizontal / 2,
  //                                   vertical: marginVertical / 2,
  //                                 ),
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(12),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           baseColor: Colors.grey.shade300,
  //                           highlightColor: Colors.grey.shade400,
  //                         );
  //                       } else {
  //                         return CupertinoPicker(
  //                           useMagnifier: true,
  //                           magnification: 1.0,
  //                           itemExtent: 40,
  //                           scrollController: FixedExtentScrollController(
  //                             initialItem: 0,
  //                           ),
  //                           onSelectedItemChanged: (value) {
  //                             setState(() {
  //                               isProv = true;

  //                               _provinsi =
  //                                   snapshot.data!.rajaongkir!.results![value];
  //                             });
  //                           },
  //                           children: List<Widget>.generate(
  //                               snapshot.data!.rajaongkir!.results!.length,
  //                               (int index) {
  //                             return Center(
  //                               child: Text(snapshot.data!.rajaongkir!
  //                                       .results![index].province ??
  //                                   ""),
  //                             );
  //                           }),
  //                         );
  //                       }
  //                     },
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _awaitPickKota(BuildContext context, String provinceId) async {
  //   final result = await showModalBottomSheet(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(15),
  //         topRight: Radius.circular(15),
  //       ),
  //     ),
  //     context: context,
  //     elevation: 1,
  //     builder: (context) {
  //       return Container(
  //         height: tinggi / 2,
  //         child: Padding(
  //           padding: EdgeInsets.symmetric(
  //             horizontal: marginHorizontal,
  //             vertical: marginVertical,
  //           ),
  //           child: Column(
  //             children: [
  //               Container(
  //                 height: tinggi / 100,
  //                 width: lebar / 9,
  //                 decoration: BoxDecoration(
  //                   color: greyPill,
  //                   borderRadius: BorderRadius.circular(5),
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Container(
  //                   width: lebar,
  //                   child: FutureBuilder<ListKota>(
  //                     future: _apiProvider.fetchKota(provinceId),
  //                     builder: (context, snapshot) {
  //                       // print("Provinsi = " + snapshot.toString());
  //                       if (!snapshot.hasData) {
  //                         return Shimmer.fromColors(
  //                           child: Container(
  //                             margin: EdgeInsets.symmetric(
  //                               vertical: marginVertical,
  //                               horizontal: marginHorizontal,
  //                             ),
  //                             child: Card(
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(12),
  //                               ),
  //                               margin: EdgeInsets.symmetric(
  //                                   horizontal: marginHorizontal / 2),
  //                               child: Container(
  //                                 width: lebar,
  //                                 padding: EdgeInsets.symmetric(
  //                                   horizontal: marginHorizontal / 2,
  //                                   vertical: marginVertical / 2,
  //                                 ),
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(12),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           baseColor: Colors.grey.shade300,
  //                           highlightColor: Colors.grey.shade400,
  //                         );
  //                       } else {
  //                         return CupertinoPicker(
  //                           useMagnifier: true,
  //                           magnification: 1.0,
  //                           itemExtent: 40,
  //                           scrollController: FixedExtentScrollController(
  //                             initialItem: 0,
  //                           ),
  //                           onSelectedItemChanged: (value) {
  //                             setState(() {
  //                               isCity = true;
  //                               _kota =
  //                                   snapshot.data!.rajaongkir!.results![value];
  //                             });
  //                           },
  //                           children: List<Widget>.generate(
  //                             snapshot.data!.rajaongkir!.results!.length,
  //                             (int index) {
  //                               return Center(
  //                                 child: Text(snapshot.data!.rajaongkir!
  //                                         .results![index].cityName ??
  //                                     ""),
  //                               );
  //                             },
  //                           ),
  //                         );
  //                       }
  //                     },
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void _awaitSetPinLocation(BuildContext context) async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => latLng == null
            ? PinLocation()
            : PinLocation(
                latLng: latLng,
              ),
      ),
    );
    print(result.toString());
    setState(() {
      isPin = true;
      latLng = result;
    });
  }
}
