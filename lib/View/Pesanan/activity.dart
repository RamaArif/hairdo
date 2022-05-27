import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:omahdilit/View/Pesanan/detailpesanan.dart';
import 'package:omahdilit/bloc/activity/activity_bloc.dart';
import 'package:omahdilit/bloc/transaksi/transaksi_bloc.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/transaksi.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  ActivityBloc _activityBloc = ActivityBloc();

  var numberFormat = new NumberFormat.currency(locale: 'id', symbol: "Rp");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ActivityBloc>().add(GetActivity());
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() {
    context.read<ActivityBloc>().add(RefreshActivity());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
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
          "Pesanan Kamu",
          style: TextStyle(color: Color(0xFF6F6F6F), fontSize: 18.0),
        ),
      ),
      body: BlocBuilder<ActivityBloc, ActivityState>(
        builder: (context, state) {
          if (state is ActivityLoaded) {
            if (_refreshController.isRefresh) {
              _refreshController.refreshCompleted();
            }
            return _buildView(state.listTransaksi);
          } else if (state is ActivityError) {}
          return _buildLoading();
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Container();
  }

  Widget _buildView(ListTransaksi listTransaksi) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemCount: listTransaksi.transaksis!.length,
        padding: EdgeInsets.symmetric(
          horizontal: marginHorizontal,
          vertical: marginVertical,
        ),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, int index) {
          Transaksi _transaksi = listTransaksi.transaksis![index];
          return InkWell(
            onTap: () {
              context.read<TransaksiBloc>().add(FetchOrder(_transaksi.id!));
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => DetailPesanan(),
                ),
              );
            },
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: "https://omahdilit.site/images/" +
                            _transaksi.model!.photo1!,
                        width: lebar * .2,
                        height: lebar / 5,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: marginHorizontal / 2,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: lebar * .67,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _transaksi.model!.namaModel!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: tinggi / lebar * 8,
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.yMMMd().format(
                                  DateTime.parse(_transaksi.createdAt!),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Mitra : " + _transaksi.mitra!.name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Container(
                          width: lebar * .67,
                          child: Row(
                            children: [
                              if (_transaksi.status == "waiting")
                                Expanded(
                                  child: Text(
                                    "Menunggu Konfirmasi",
                                    style: TextStyle(
                                      color: yellow,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              if (_transaksi.status == "confirmed")
                                Expanded(
                                  child: Text(
                                    "Dalam Perjalanan",
                                    style: TextStyle(
                                      color: blue,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              Text(numberFormat.format(_transaksi.totalharga)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: marginVertical * 1.5,
                  ),
                  child: DottedLine(
                    dashColor: greyMain,
                    lineThickness: 1.3,
                    dashLength: marginHorizontal / 2,
                    dashGapLength: marginHorizontal / 2.5,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
