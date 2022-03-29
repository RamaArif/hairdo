import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:im_stepper/stepper.dart';
import 'package:lottie/lottie.dart';
import 'package:omahdilit/bloc/activity/activity_bloc.dart';
import 'package:omahdilit/bloc/alamat/alamat_bloc.dart';
import 'package:omahdilit/bloc/transaksi/transaksi_bloc.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/transaksi.dart';

class DetailPesanan extends StatefulWidget {
  final int index;
  const DetailPesanan({Key? key, required this.index}) : super(key: key);

  @override
  State<DetailPesanan> createState() => _DetailPesananState();
}

class _DetailPesananState extends State<DetailPesanan> {
  // ActivityBloc _activityBloc = ActivityBloc();
  late final int _index;
  int _step = 1;

  @override
  void initState() {
    _index = widget.index;
    // _activityBloc.add(DetailActivity(_index),);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityBloc, ActivityState>(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: marginHorizontal,
            vertical: marginVertical,
          ),
          child: Column(
            children: [
              SizedBox(
                height: marginVertical,
              ),
              if (transaksi.status == "waiting")
                Container(
                  alignment: Alignment.topCenter,
                  child: LottieBuilder.asset(
                    "assets/waiting.json",
                    width: lebar * .5,
                    height: lebar * .5,
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
              SizedBox(
                height: marginVertical * 2,
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
              Container(
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
                              child: DottedLine(),
                            ),
                          ),
                          Icon(
                            CupertinoIcons.check_mark_circled_solid,
                            color:
                                transaksi.status == "waiting" ? greyMain : blue,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: marginHorizontal / 2,
                                  vertical: marginVertical * .8),
                              child: DottedLine(),
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
                            padding:
                                EdgeInsets.only(right: marginHorizontal * .6),
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
                            padding:
                                EdgeInsets.only(left: marginHorizontal * .7),
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
              ),
              Divider(
                color: greyDark,
                height: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
