import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:money2/money2.dart';
import 'package:omahdilit/View/Barberman/allBarberman.dart';
import 'package:omahdilit/View/FormAlamat/formAlamat.dart';
import 'package:omahdilit/View/ModelHair/allmodel.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/listalamat.dart';
import 'package:omahdilit/model/listmitra.dart';
import 'package:omahdilit/model/modelhair.dart';

class KonfirmasiPesanan extends StatefulWidget {
  const KonfirmasiPesanan({Key? key, this.barberman, this.modelHair})
      : super(key: key);

  final modelHair, barberman;

  @override
  _KonfirmasiPesananState createState() => _KonfirmasiPesananState();
}

class _KonfirmasiPesananState extends State<KonfirmasiPesanan> {
  bool _setalamat = false, _setbarberman = false, _setmodelhair = false;
  ModelHair _modelHair = ModelHair();
  Mitra _barberman = Mitra();

  bool utama = true;

  var _listAlamat = List<Alamat>.generate(
    10,
    (index) => Alamat(
        id: index,
        tag: "Rumah",
        alamat: "Jl. Sana sini no. " + index.toString(),
        provinsi: "Jawa Timur",
        kota: "Surabaya",
        kecamatan: "sembarang",
        noTelp: "+6285155439113",
        lat: -7.8684532,
        lng: 112.5289937,
        utama: index < 0 ? true : false),
  );

  @override
  void initState() {
    super.initState();
    if (widget.barberman != null) {
      _setbarberman = true;
      _barberman = widget.barberman;
    } else if (widget.modelHair != null) {
      _setmodelhair = true;
      _modelHair = widget.modelHair;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      "Rp 15.0000",
                      style: TextStyle(
                          color: primary,
                          fontSize: tinggi / lebar * 9,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => KonfirmasiPesanan(),
                        ),
                      );
                    },
                    child: Container(
                      height: tinggi / 18,
                      width: lebar / 2.5,
                      decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
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
                  Visibility(
                    visible: _setalamat,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Hernawan Septiansyah  ",
                              style: TextStyle(
                                fontSize: tinggi / lebar * 7,
                              ),
                            ),
                            Text(
                              "(+6285155439113)",
                              style: TextStyle(
                                fontSize: tinggi / lebar * 7,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Jl. Jojoran 3C no.29, Kel. Mojo, Kec. Gubeng, Kota Surabaya",
                          style: TextStyle(
                            fontSize: tinggi / lebar * 7,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                    replacement: Center(
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
                            "Mitra Barberman",
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
                      Visibility(
                        visible: _setbarberman,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                "https://omahdilit.my.id/images/" +
                                    _barberman.photo.toString(),
                                height: tinggi / 8,
                                width: tinggi / 8,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: marginHorizontal),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      bottom: marginVertical / 2,
                                    ),
                                    child: Text(
                                      _barberman.name.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: tinggi / lebar * 8,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Jarak : 5 km",
                                    style: TextStyle(
                                      fontSize: tinggi / lebar * 7,
                                      color: textAccent,
                                    ),
                                  ),
                                  Text(
                                    _barberman.workshop.toString(),
                                    style: TextStyle(
                                      fontSize: tinggi / lebar * 7,
                                      color: textAccent,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: lebar / 23,
                                      ),
                                      Text(
                                        !_setbarberman
                                            ? ""
                                            : _barberman.rating!
                                                .toStringAsFixed(1),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: textAccent,
                                            fontSize: tinggi / lebar * 7),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        replacement: Container(
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
                                    setState(() {
                                      _setbarberman = true;
                                    });
                                  },
                                  child: InkWell(
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
                                        borderRadius: BorderRadius.circular(12),
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
                                ),
                              ],
                            ),
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
                      Visibility(
                        visible: _setmodelhair,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                "https://omahdilit.my.id/images/imagemodel.png",
                                height: tinggi / 7,
                                width: tinggi / 7,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: marginHorizontal / 2,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _modelHair.namaModel.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: tinggi / lebar * 8,
                                      ),
                                    ),
                                    Text(
                                      _modelHair.detail.toString(),
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
                        ),
                        replacement: Container(
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
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: blue, width: 1),
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
                                  "Model Rambut",
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
                            "Rp15.000",
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
                            "Rp15.000",
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

    setState(() {
      _setmodelhair = true;
      _modelHair = result;
    });
  }

  void _awaitChangeBarberman(BuildContext context) async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => AllBarberman(
          isEdit: true,
        ),
      ),
    );

    setState(() {
      _setbarberman = true;
      _barberman = result;
    });
  }

  Future<void> _awaitaddAlamat(BuildContext context) async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => FormAlamat(),
      ),
    );
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
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    if (index > 0) {
                      utama = false;
                    } else {
                      utama = true;
                    }
                    return Card(
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
                          color: utama ? secondary : greyMain.withOpacity(.2),
                          border: Border.all(
                            color: utama ? primary : greyMain,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: utama ? primary : greyMain,
                                    ),
                                    Text(
                                      _listAlamat[index].tag.toString(),
                                      style: TextStyle(
                                        fontSize: tinggi / lebar * 6,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            utama ? Colors.black : textAccent,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Visibility(
                                      visible: utama,
                                      child: Text(
                                        "Utama",
                                        style: TextStyle(
                                          fontSize: tinggi / lebar * 5.5,
                                          fontWeight: FontWeight.w500,
                                          color: utama ? primary : textAccent,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: marginHorizontal / 5,
                                        ),
                                        child: Icon(
                                          Icons.check_circle_rounded,
                                          color: utama ? primary : greyMain,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: marginHorizontal / 7.5,
                                        ),
                                        child: Icon(
                                          Icons.edit,
                                          color: utama ? primary : greyMain,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _listAlamat[index].alamat.toString(),
                                    style: TextStyle(
                                      fontSize: tinggi / lebar * 6,
                                      fontWeight: FontWeight.w400,
                                      color: utama ? Colors.black : textAccent,
                                    ),
                                  ),
                                  Text(
                                    _listAlamat[index].kecamatan.toString() +
                                        ", " +
                                        _listAlamat[index].kota.toString() +
                                        ", " +
                                        _listAlamat[index].provinsi.toString(),
                                    style: TextStyle(
                                      fontSize: tinggi / lebar * 6,
                                      fontWeight: FontWeight.w400,
                                      color: utama ? Colors.black : textAccent,
                                    ),
                                  ),
                                  Text(
                                    _listAlamat[index].noTelp.toString(),
                                    style: TextStyle(
                                      fontSize: tinggi / lebar * 6.5,
                                      fontWeight: FontWeight.w400,
                                      color: utama ? Colors.black : textAccent,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
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
              )
            ],
          ),
        );
      },
    );
  }
}
