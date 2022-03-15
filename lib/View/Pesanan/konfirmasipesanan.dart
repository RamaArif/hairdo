import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/View/Barberman/allBarberman.dart';
import 'package:omahdilit/View/FormAlamat/formAlamat.dart';
import 'package:omahdilit/View/ModelHair/allmodel.dart';
import 'package:omahdilit/View/Pesanan/detailpesanan.dart';
import 'package:omahdilit/bloc/transaksi/transaksi_bloc.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/listalamat.dart';
import 'package:omahdilit/model/transaksi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class KonfirmasiPesanan extends StatefulWidget {
  const KonfirmasiPesanan({Key? key, this.barberman, this.modelHair})
      : super(key: key);

  final modelHair, barberman;

  @override
  _KonfirmasiPesananState createState() => _KonfirmasiPesananState();
}

class _KonfirmasiPesananState extends State<KonfirmasiPesanan> {
  bool _setalamat = false, _setbarberman = false, _setmodelhair = false;
  Transaksi _transaksi = Transaksi();

  var numberFormat = new NumberFormat.currency(locale: 'id', symbol: "Rp");

  final ApiProvider _apiProvider = ApiProvider();

  Alamat _selectedAlamat = Alamat();

  int _selectedIndex = 0;
  bool _selectedItem = false;

  bool _isCompleted = false;

  late TransaksiBloc _transaksiBloc;

  bool _isCheckPrice = false;

  @override
  void initState() {
    _transaksiBloc = TransaksiBloc();

    _transaksiBloc.add(GetCustomer());
    super.initState();
    if (widget.barberman != null) {
      _setbarberman = true;
      // _barberman = widget.barberman;
      _transaksiBloc.add(MitraAddedEvent(widget.barberman));
    } else if (widget.modelHair != null) {
      _setmodelhair = true;
      _transaksiBloc.add(ModelAddedEvent(widget.modelHair));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransaksiBloc>(
      create: (context) => _transaksiBloc,
      child: BlocListener<TransaksiBloc, TransaksiState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is OnTransaction) {
            Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (_) => DetailPesanan()),
                (route) => false);
          }
        },
        child: BlocBuilder<TransaksiBloc, TransaksiState>(
          builder: (context, state) {
            if (state is CreatetransaksiLoaded) {
              _transaksi = state.transaksi;
              _isCompleted = state.isFilled;
              if (_isCheckPrice) {
                if (_transaksi.mitra != null && _transaksi.alamat != null) {
                  _checkPrice();
                }
              }
              // if (state.isComplete) {
              //
              // }
              return _buildView(context);
            } else {
              return _buildLoading(context);
            }
          },
        ),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: Container(
        height: tinggi / 12,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Harga",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      _transaksi.totalharga != null
                          ? numberFormat.format(_transaksi.totalharga)
                          : numberFormat.format(0),
                      style: TextStyle(
                          color: primary,
                          fontSize: tinggi / lebar * 9,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                InkWell(
                    onTap: () {
                      // print(jsonEncode(_transaksi));
                      if (_isCompleted) {
                        _transaksiBloc.add(CreateTransaksiEvent(_transaksi));
                      }
                    },
                    child: Container(
                      height: tinggi / 18,
                      width: lebar / 2.5,
                      decoration: BoxDecoration(
                          color: _isCompleted ? blue : Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Center(
                        child: Text(
                          "Buat Pesanan",
                          style: TextStyle(
                              fontSize: tinggi / lebar * 8,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ))
              ]),
        ),
      ),
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
          "Konfirmasi Pesanan",
          style: TextStyle(
            color: Color(0xFF6F6F6F),
            fontSize: tinggi / lebar * 8,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: marginHorizontal,
                vertical: marginVertical / 3,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Alamat",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: tinggi / lebar * 8,
                        ),
                      ),
                      Visibility(
                        visible: _setalamat,
                        child: IconButton(
                          onPressed: () {
                            _awaitChangeAlamat(context);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  _setalamat
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  _transaksi.alamat!.nama.toString() + "  ",
                                  style: TextStyle(
                                    fontSize: tinggi / lebar * 7,
                                  ),
                                ),
                                Text(
                                  "(" +
                                      _transaksi.alamat!.noTelp.toString() +
                                      ")",
                                  style: TextStyle(
                                    fontSize: tinggi / lebar * 7,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _transaksi.alamat!.alamat.toString() +
                                  ", " +
                                  _transaksi.alamat!.kecamatan.toString() +
                                  ", " +
                                  _transaksi.alamat!.kota.toString() +
                                  ", " +
                                  _transaksi.alamat!.provinsi.toString(),
                              style: TextStyle(
                                fontSize: tinggi / lebar * 7,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Column(
                            children: [
                              Text(
                                "Kamu belum atur alamat",
                                style: TextStyle(
                                  fontSize: tinggi / lebar * 7,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _awaitChangeAlamat(context);
                                },
                                child: Container(
                                  width: lebar / 2,
                                  margin: EdgeInsets.only(
                                    top: marginVertical / 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: blueshade,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: blue, width: 1),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: marginHorizontal,
                                      vertical: marginVertical / 3,
                                    ),
                                    child: Text(
                                      "Atur Alamat",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: tinggi / lebar * 7,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: marginVertical * 1.5,
                      bottom: marginVertical / 2,
                    ),
                    child: DottedLine(
                      lineThickness: 2,
                      dashGapLength: marginHorizontal / 4,
                      dashLength: marginHorizontal / 3,
                      dashColor: blue,
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Mitra",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: tinggi / lebar * 8,
                            ),
                          ),
                          Visibility(
                            visible: _setbarberman,
                            child: IconButton(
                              onPressed: () {
                                _awaitChangeBarberman(context);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      _setbarberman
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://omahdilit.my.id/images/" +
                                            _transaksi.mitra!.photo.toString(),
                                    height: tinggi / 8,
                                    width: tinggi / 8,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(left: marginHorizontal),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          bottom: marginVertical / 2,
                                        ),
                                        child: Text(
                                          _transaksi.mitra!.name.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: tinggi / lebar * 8,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        _transaksi.mitra!.workshop.toString(),
                                        style: TextStyle(
                                          fontSize: tinggi / lebar * 7,
                                          color: textAccent,
                                        ),
                                      ),
                                      _transaksi.mitra!.rating == 0
                                          ? Text("")
                                          : Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: lebar / 23,
                                                ),
                                                Text(
                                                  _transaksi.mitra!.rating!
                                                      .toStringAsFixed(1),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: textAccent,
                                                      fontSize:
                                                          tinggi / lebar * 7),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Container(
                              margin: EdgeInsets.only(top: marginVertical / 2),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "Kamu belum pilih barberman",
                                      style: TextStyle(
                                        fontSize: tinggi / lebar * 7,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _awaitChangeBarberman(context);
                                      },
                                      child: Container(
                                        width: lebar / 2,
                                        margin: EdgeInsets.only(
                                          top: marginVertical / 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: blueshade,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border:
                                              Border.all(color: blue, width: 1),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: marginHorizontal,
                                            vertical: marginVertical / 3,
                                          ),
                                          child: Text(
                                            "Pilih Barberman",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: tinggi / lebar * 7,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: marginVertical * 1.5,
                          bottom: marginVertical / 2,
                        ),
                        child: DottedLine(
                          lineThickness: 2,
                          dashGapLength: marginHorizontal / 4,
                          dashLength: marginHorizontal / 3,
                          dashColor: blue,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Model Rambut",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: tinggi / lebar * 8,
                            ),
                          ),
                          Visibility(
                            visible: _setmodelhair,
                            child: IconButton(
                              onPressed: () {
                                _awaitChangeModelHair(context);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      _setmodelhair
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://omahdilit.my.id/images/" +
                                            _transaksi.model!.photo1!,
                                    height: tinggi / 7,
                                    width: tinggi / 7,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: marginHorizontal / 2,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _transaksi.model!.namaModel
                                              .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: tinggi / lebar * 8,
                                          ),
                                        ),
                                        Text(
                                          _transaksi.model!.detail.toString(),
                                          textAlign: TextAlign.justify,
                                          overflow: TextOverflow.fade,
                                          maxLines: 5,
                                          style: TextStyle(
                                            fontSize: tinggi / lebar * 7,
                                            color: textAccent,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              margin: EdgeInsets.only(top: marginVertical / 2),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "Kamu belum pilih model rambut",
                                      style: TextStyle(
                                        fontSize: tinggi / lebar * 7,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _awaitChangeModelHair(context);
                                      },
                                      child: Container(
                                        width: lebar / 2,
                                        margin: EdgeInsets.only(
                                          top: marginVertical / 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: blueshade,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border:
                                              Border.all(color: blue, width: 1),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: marginHorizontal,
                                            vertical: marginVertical / 3,
                                          ),
                                          child: Text(
                                            "Pilih Model Rambut",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: tinggi / lebar * 7,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: marginVertical * 1.5,
                          bottom: marginVertical,
                        ),
                        child: DottedLine(
                          lineThickness: 2,
                          dashGapLength: marginHorizontal / 4,
                          dashLength: marginHorizontal / 3,
                          dashColor: blue,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rincian Harga",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: tinggi / lebar * 8),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: lebar / 50,
                                color: primary,
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(left: marginHorizontal / 2),
                                child: Text(
                                  "Biaya Cukur",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: tinggi / lebar * 7,
                                    color: textAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            _transaksi.hargacukur != null
                                ? numberFormat.format(_transaksi.hargacukur)
                                : numberFormat.format(0),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: tinggi / lebar * 7,
                              color: textAccent,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: lebar / 50,
                                color: primary,
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(left: marginHorizontal / 2),
                                child: Text(
                                  "Biaya Penanganan",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: tinggi / lebar * 7,
                                    color: textAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            _transaksi.penanganan != null
                                ? numberFormat.format(_transaksi.penanganan)
                                : numberFormat.format(0),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: tinggi / lebar * 7,
                              color: textAccent,
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: marginVertical * 5),
              child: Container(
                width: lebar,
                margin: EdgeInsets.symmetric(
                  vertical: marginVertical,
                  horizontal: marginHorizontal,
                ),
                decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: primary, width: 1),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: marginHorizontal,
                    vertical: marginVertical,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Informasi",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: tinggi / lebar * 8,
                        ),
                      ),
                      Text(
                        "Pembayaran dilakukan ditempat jika sudah selesai pelayanan",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: tinggi / lebar * 6,
                        ),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _awaitChangeModelHair(BuildContext context) async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => AllModelHair(
          isEdit: true,
        ),
      ),
    );
    if (result != null) {
      _setmodelhair = true;

      _transaksiBloc.add(ModelAddedEvent(result));
    }

    // setState(() {
    //   _setmodelhair = true;
    //   _modelHair = result;
    //   if (_setalamat && _setbarberman && _setmodelhair) {
    //     _isCompleted = true;
    //   }
    // });
  }

  void _awaitChangeBarberman(BuildContext context) async {
    await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => AllBarberman(
          isEdit: true,
        ),
      ),
    ).then(
      (value) {
        if (value != null) {
          _setbarberman = true;
          _transaksiBloc.add(MitraAddedEvent(value));
          _isCheckPrice = true;
        }
        // setState(() {
        //   _setbarberman = true;
        //   _barberman = value;
        //   _checkPrice();
        // });
      },
    );
  }

  Future<void> _awaitaddAlamat(BuildContext context) async {
    Navigator.pop(context);
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => FormAlamat(uid: _transaksi.customer!.uid.toString()),
      ),
    ).then((value) => _selectedAlamat = value);
  }

  void _awaitChangeAlamat(BuildContext context) async {
    final result = await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      context: context,
      elevation: 1,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter updateState) {
            var _currentAlamat;
            return Container(
              height: tinggi / 2.5,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: marginHorizontal,
                      right: marginHorizontal,
                      top: marginVertical,
                      bottom: marginVertical / 2,
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
                        Container(
                          margin: EdgeInsets.only(
                            top: marginVertical,
                            bottom: marginVertical / 2,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.black,
                                    size: lebar / 15,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: marginHorizontal / 2,
                                    ),
                                    child: Text(
                                      "Alamat Kamu",
                                      style: TextStyle(
                                        fontSize: tinggi / lebar * 8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  _awaitaddAlamat(context);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Tambah Alamat",
                                      style: TextStyle(
                                        fontSize: tinggi / lebar * 5,
                                        fontWeight: FontWeight.w500,
                                        color: primary,
                                      ),
                                    ),
                                    Icon(
                                      Icons.add_outlined,
                                      color: primary,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: marginVertical),
                          width: lebar,
                          child: Text(
                            "Pilih alamat kamu untuk melakukan cukur rambut ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: tinggi / lebar * 6,
                              fontWeight: FontWeight.w500,
                              color: textAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<ListAlamat>(
                      future: _apiProvider
                          .fetchAlamat(_transaksi.customer!.uid.toString()),
                      builder: (context, snapshot) {
                        // print(snapshot.toString());
                        if (snapshot.hasData) {
                          return Container(
                            child: ListView.builder(
                              itemCount: snapshot.data!.alamat!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                if (index == _selectedIndex) {
                                  _selectedItem = true;
                                  _currentAlamat =
                                      snapshot.data!.alamat![index];
                                } else {
                                  _selectedItem = false;
                                }
                                return InkWell(
                                  onTap: () {
                                    updateState(() {
                                      _selectedIndex = index;
                                    });
                                  },
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: marginHorizontal / 2),
                                    child: Container(
                                      width: lebar / 1.4,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: marginHorizontal / 2,
                                        vertical: marginVertical / 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _selectedItem
                                            ? secondary
                                            : greyMain.withOpacity(.2),
                                        border: Border.all(
                                          color: _selectedItem
                                              ? primary
                                              : greyMain,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    color: _selectedItem
                                                        ? primary
                                                        : greyMain,
                                                  ),
                                                  Text(
                                                    snapshot.data!
                                                        .alamat![index].tag
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          tinggi / lebar * 6,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: _selectedItem
                                                          ? Colors.black
                                                          : textAccent,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  snapshot.data!.alamat![index]
                                                              .utama ==
                                                          1
                                                      ? Text(
                                                          "Utama",
                                                          style: TextStyle(
                                                            fontSize: tinggi /
                                                                lebar *
                                                                5.5,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: _selectedItem
                                                                ? primary
                                                                : textAccent,
                                                          ),
                                                        )
                                                      : Container(),
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            marginHorizontal /
                                                                5,
                                                      ),
                                                      child: Icon(
                                                        Icons
                                                            .check_circle_rounded,
                                                        color: _selectedItem
                                                            ? primary
                                                            : greyMain,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            marginHorizontal /
                                                                7.5,
                                                      ),
                                                      child: Icon(
                                                        Icons.edit,
                                                        color: _selectedItem
                                                            ? primary
                                                            : greyMain,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              bottom: marginVertical,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data!.alamat![index].nama
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        tinggi / lebar * 6,
                                                    fontWeight: FontWeight.w500,
                                                    color: _selectedItem
                                                        ? Colors.black
                                                        : textAccent,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data!.alamat![index]
                                                      .alamat
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        tinggi / lebar * 6,
                                                    fontWeight: FontWeight.w400,
                                                    color: _selectedItem
                                                        ? Colors.black
                                                        : textAccent,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data!.alamat![index]
                                                          .kecamatan
                                                          .toString() +
                                                      ", " +
                                                      snapshot.data!
                                                          .alamat![index].kota
                                                          .toString() +
                                                      ", " +
                                                      snapshot
                                                          .data!
                                                          .alamat![index]
                                                          .provinsi
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        tinggi / lebar * 6,
                                                    fontWeight: FontWeight.w400,
                                                    color: _selectedItem
                                                        ? Colors.black
                                                        : textAccent,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data!.alamat![index]
                                                      .noTelp
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        tinggi / lebar * 6.5,
                                                    fontWeight: FontWeight.w400,
                                                    color: _selectedItem
                                                        ? Colors.black
                                                        : textAccent,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Shimmer.fromColors(
                            child: Container(
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: marginHorizontal / 2),
                                child: Container(
                                  width: lebar / 1.4,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: marginHorizontal / 2,
                                    vertical: marginVertical / 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _selectedItem
                                        ? secondary
                                        : greyMain.withOpacity(.2),
                                    border: Border.all(
                                      color: _selectedItem ? primary : greyMain,
                                      width: 1,
                                    ),
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
                  InkWell(
                    onTap: () {
                      Navigator.pop(context, _currentAlamat);
                    },
                    child: Container(
                      width: lebar,
                      margin: EdgeInsets.symmetric(
                        vertical: marginVertical,
                        horizontal: marginHorizontal,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: blue,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: marginVertical / 2,
                      ),
                      child: Text(
                        "Atur Alamat",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: tinggi / lebar * 7.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    ).then((value) {
      if (value != null) {
        _setalamat = true;
        _transaksiBloc.add(AlamatAddedEvent(value));
        _isCheckPrice = true;
      }
    });
  }

  Future<void> _checkPrice() async {
    _transaksiBloc.add(CountPriceEvent(_transaksi));
    _isCheckPrice = false;
  }

  Widget _buildLoading(BuildContext context) {
    return Container();
  }
}
