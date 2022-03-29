import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:omahdilit/bloc/history/history_bloc.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/transaksi.dart';
import 'package:shimmer/shimmer.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  HistoryBloc _historyBloc = HistoryBloc();
  @override
  void initState() {
    // TODO: implement initState
    _historyBloc.add(GetHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF6F6F6F)),
        title: Text(
          "Riwayat Pesanan",
          style: TextStyle(color: textAccent, fontSize: 18.0),
        ),
      ),
      body: BlocProvider(
        create: (context) => _historyBloc,
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoading) {
              return _buildLoading();
            } else if (state is HistoryLoaded) {
              return _buildView(state.listTransaksi);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildView(ListTransaksi listTransaksi) {
    return Container(
      child: ListView.builder(
        itemCount: listTransaksi.transaksis!.length,
        itemBuilder: (BuildContext context, int index) {
          Transaksi _transaksi = listTransaksi.transaksis![index];
          return InkWell(
            onTap: () {},
            child: Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(
                horizontal: marginHorizontal,
                vertical: marginVertical / 2,
              ),
              child: Container(
                width: lebar,
                margin: EdgeInsets.symmetric(
                  vertical: marginVertical / 2,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: marginHorizontal / 2,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: "https://omahdilit.my.id/images/" +
                                  _transaksi.model!.photo1!,
                              fit: BoxFit.cover,
                              width: lebar / 7.5,
                              height: lebar / 7.5,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: lebar / 1.5,
                                margin: EdgeInsets.only(
                                  left: marginHorizontal / 2,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _transaksi.model!.namaModel!,
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: tinggi / lebar * 8,
                                      ),
                                    ),
                                    Text(
                                      DateFormat(
                                              "dd MMM yyyy",
                                              Localizations.localeOf(context)
                                                  .toLanguageTag())
                                          .format(
                                        DateTime.parse(_transaksi.createdAt!),
                                      ),
                                      style: TextStyle(
                                        color: textAccent,
                                        fontWeight: FontWeight.w500,
                                        fontSize: tinggi / lebar * 6.5,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: marginHorizontal / 2),
                                child: Text(
                                  "Jl. sana sini",
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: tinggi / lebar * 7,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: marginVertical / 2),
                      child: Divider(
                        color: textAccent,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: marginHorizontal,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Mitra : " + _transaksi.mitra!.name!,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: tinggi / lebar * 7.5,
                            ),
                          ),
                          Text(
                            numberFormat.format(_transaksi.totalharga),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primary,
                              fontSize: tinggi / lebar * 9,
                            ),
                          )
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
  }

  Widget _buildLoading() {
    return Shimmer.fromColors(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(
                horizontal: marginHorizontal,
                vertical: marginVertical / 2,
              ),
              child: Container(
                width: lebar,
                height: tinggi * .15,
                margin: EdgeInsets.symmetric(
                  vertical: marginVertical / 2,
                ),
              ),
            );
          },
        ),
        baseColor: Colors.grey,
        highlightColor: Colors.grey.shade300);
  }
}
