import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:omahdilit/bloc/activity/activity_bloc.dart';
import 'package:omahdilit/bloc/transaksi/transaksi_bloc.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/transaksi.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailPesanan extends StatefulWidget {
  bool isHistory;
  DetailPesanan({Key? key, this.isHistory = false}) : super(key: key);

  @override
  State<DetailPesanan> createState() => _DetailPesananState();
}

class _DetailPesananState extends State<DetailPesanan> {
  late final int _index;
  int _step = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransaksiBloc, TransaksiState>(
      builder: (context, state) {
        print(state);
        if (state is TransaksiLoaded) {
          print(jsonEncode(state.transaksi));
          return _buildView(context, state.transaksi);
        }
        return Container();
      },
    );
  }

  Widget _buildView(BuildContext context, Transaksi transaksi) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: greyDark,
            size: 21,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF6F6F6F)),
        title: Text(
          "Detail Pesanan Kamu",
          style: TextStyle(color: greyDark, fontSize: 18.0),
        ),
      ),
      bottomSheet: widget.isHistory ? bottomSheet(transaksi) : SizedBox(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: marginHorizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (transaksi.status == "waiting")
                Container(
                  alignment: Alignment.topCenter,
                  child: LottieBuilder.asset(
                    "assets/waiting.json",
                    width: lebar * .4,
                    height: lebar * .4,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              if (transaksi.status == "confirmed")
                Container(
                  alignment: Alignment.topCenter,
                  child: LottieBuilder.asset(
                    "assets/otw.json",
                    width: lebar * .5,
                    height: lebar * .5,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              if (transaksi.status == "finished")
                Container(
                  alignment: Alignment.topCenter,
                  child: LottieBuilder.asset(
                    "assets/finish.json",
                    width: lebar * .5,
                    height: lebar * .5,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              if (transaksi.status == "canceled")
                Container(
                  alignment: Alignment.topCenter,
                  child: LottieBuilder.asset(
                    "assets/cancel.json",
                    width: lebar * .5,
                    height: lebar * .5,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              SizedBox(
                height: marginVertical,
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  transaksi.status == "waiting"
                      ? "Tunggu Konfirmasi Mitra"
                      : transaksi.status == "confirmed"
                          ? "Mitra Masih Dijalan"
                          : transaksi.status == "finished"
                              ? "Pesanan Kamu Selesai"
                              : "Pesanan Kamu Dibatalin",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: tinggi / lebar * 9,
                  ),
                ),
              ),
              widget.isHistory == null
                  ? Container(
                      width: lebar,
                      margin: EdgeInsets.symmetric(vertical: marginVertical),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: marginHorizontal * 2,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.check_mark_circled_solid,
                                  color: blue,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: marginHorizontal / 2,
                                      vertical: marginVertical * .8,
                                    ),
                                    child: DottedLine(
                                      dashColor: transaksi.status == "waiting"
                                          ? greyMain
                                          : blue,
                                    ),
                                  ),
                                ),
                                Icon(
                                  CupertinoIcons.check_mark_circled_solid,
                                  color: transaksi.status == "waiting"
                                      ? greyMain
                                      : blue,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: marginHorizontal / 2,
                                        vertical: marginVertical * .8),
                                    child: DottedLine(
                                      dashColor: transaksi.status == "finished"
                                          ? blue
                                          : greyMain,
                                    ),
                                  ),
                                ),
                                Icon(
                                  CupertinoIcons.check_mark_circled_solid,
                                  color: transaksi.status == "finished"
                                      ? blue
                                      : greyMain,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: marginHorizontal * .6),
                                  child: Text(
                                    "Perlu\nKonfirmasi",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Dalam\nPerjalanan",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: marginHorizontal * .7),
                                  child: Text(
                                    "Pesanan\nSelesai",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  : SizedBox(
                      height: marginVertical,
                    ),
              Divider(
                color: greyDark,
                height: 2,
              ),
              SizedBox(
                height: marginVertical / 2,
              ),
              Text(
                "Alamat",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: tinggi / lebar * 8,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        transaksi.alamat!.nama.toString() + "  ",
                        style: TextStyle(
                          fontSize: tinggi / lebar * 7,
                        ),
                      ),
                      Text(
                        "(" + transaksi.alamat!.noTelp.toString() + ")",
                        style: TextStyle(
                          fontSize: tinggi / lebar * 7,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    transaksi.alamat!.alamat.toString() +
                        ", " +
                        transaksi.alamat!.kecamatan.toString() +
                        ", " +
                        transaksi.alamat!.kota.toString() +
                        ", " +
                        transaksi.alamat!.provinsi.toString(),
                    style: TextStyle(
                      fontSize: tinggi / lebar * 7,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: marginVertical / 2,
              ),
              Divider(
                color: greyDark,
                height: 2,
              ),
              SizedBox(
                height: marginVertical / 2,
              ),
              Text(
                "Mitra",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: tinggi / lebar * 8,
                ),
              ),
              SizedBox(
                height: marginVertical / 2,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: "https://omahdilit.site/images/" +
                          transaksi.mitra!.photo.toString(),
                      height: lebar * .15,
                      width: lebar * .15,
                      fit: BoxFit.cover,
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
                            transaksi.mitra!.name ?? " ",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: tinggi / lebar * 8,
                            ),
                          ),
                        ),
                        transaksi.mitra!.workshop == null
                            ? Text(
                                transaksi.mitra!.jenkel!,
                                style: TextStyle(
                                  fontSize: tinggi / lebar * 7,
                                  color: textAccent,
                                ),
                              )
                            : Text(
                                transaksi.mitra!.workshop!,
                                style: TextStyle(
                                  fontSize: tinggi / lebar * 7,
                                  color: textAccent,
                                ),
                              ),
                        transaksi.mitra!.rating == null
                            ? SizedBox()
                            : Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: lebar / 23,
                                  ),
                                  Text(
                                    transaksi.mitra!.rating!.toStringAsFixed(1),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: textAccent,
                                        fontSize: tinggi / lebar * 7),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: marginVertical,
              ),
              Divider(
                color: greyDark,
                height: 2,
              ),
              SizedBox(
                height: marginVertical / 2,
              ),
              Text(
                "Model Rambut",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: tinggi / lebar * 8,
                ),
              ),
              SizedBox(
                height: marginVertical,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: "https://omahdilit.site/images/" +
                          transaksi.model!.photo1!,
                      height: lebar * .15,
                      width: lebar * .15,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: marginHorizontal,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaksi.model!.namaModel.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: tinggi / lebar * 8,
                          ),
                        ),
                        Text(
                          transaksi.model!.jenisModel.toString(),
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
                ],
              ),
              SizedBox(
                height: marginVertical,
              ),
              Divider(
                color: greyDark,
                height: 2,
              ),
              SizedBox(
                height: marginVertical / 2,
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
                            margin: EdgeInsets.only(left: marginHorizontal / 2),
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
                        transaksi.hargacukur != null
                            ? numberFormat.format(transaksi.hargacukur)
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
                            margin: EdgeInsets.only(left: marginHorizontal / 2),
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
                        transaksi.penanganan != null
                            ? numberFormat.format(transaksi.penanganan)
                            : numberFormat.format(0),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: tinggi / lebar * 7,
                          color: textAccent,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: marginVertical / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        transaksi.totalharga != null
                            ? numberFormat.format(transaksi.totalharga)
                            : numberFormat.format(0),
                        style: TextStyle(
                            color: primary,
                            fontSize: tinggi / lebar * 9,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: marginVertical * 4.5,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container bottomSheet(Transaksi transaksi) {
    if (transaksi.status == "waiting" || transaksi.status == "confirmed") {
      return Container(
        height: tinggi * .075,
        width: lebar,
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
        child: transaksi.status == "waiting"
            ? BlocListener<TransaksiBloc, TransaksiState>(
                listener: (context, state) {
                  if (state is TransaksiLoaded) {
                    context.read<ActivityBloc>().add(GetActivity());
                  }
                },
                child: GestureDetector(
                  onTap: () {
                    context.read<TransaksiBloc>().add(CancelOrder(transaksi));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: marginHorizontal,
                      vertical: marginVertical / 1.5,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: primary, borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "Batalkan Pesanan",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  var url;
                  var number = transaksi.mitra!.number!.substring(1);
                  if (Platform.isAndroid) {
                    // add the [https]
                    url = "https://wa.me/$number"; // new line
                  } else {
                    // add the [https]
                    url =
                        "https://api.whatsapp.com/send?phone=$number"; // new line
                  }
                  print(url);
                  launchUrlString(url);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: marginHorizontal,
                    vertical: marginVertical / 1.5,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: like, borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "Hubungi Mitra",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
      );
    } else if (transaksi.status == 'finished') {
      print("tanggal => " + transaksi.endDate!);
      final birthday = DateTime.parse(transaksi.endDate!);
      final date2 = DateTime.now();
      final difference = date2.difference(birthday).inDays;
      print("difference => " + difference.toString());

      if (transaksi.review == null && difference < 3) {
        return Container(
            width: lebar,
            padding: EdgeInsets.symmetric(
              horizontal: marginHorizontal,
              vertical: marginVertical,
            ),
            color: Colors.white,
            child: Wrap(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: marginVertical / 2),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: blue, borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "Tulis Review",
                      style: textStyle.copyWith(
                        color: Colors.white,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ),
              ],
            ));
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }
}
