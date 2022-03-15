import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omahdilit/bloc/alamat/alamat_bloc.dart';
import 'package:omahdilit/bloc/bloc/activity_bloc.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/transaksi.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  ActivityBloc _activityBloc = ActivityBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activityBloc.add(GetActivity());
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
      body: BlocProvider(
        create: (context) => _activityBloc,
        child: BlocBuilder<ActivityBloc, ActivityState>(
          builder: (context, state) {
            if (state is ActivityLoaded) {
              return _buildView(state.listTransaksi);
            } else if (state is ActivityError) {}
            return _buildLoading();
          },
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Container();
  }

  Widget _buildView(ListTransaksi listTransaksi) {
    return ListView.builder(
      itemCount: listTransaksi.transaksis!.length,
      padding: EdgeInsets.symmetric(
        horizontal: marginHorizontal,
        vertical: marginVertical,
      ),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, int index) {
        Transaksi _transaksi = listTransaksi.transaksis![index];
        return Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: "https://omahdilit.my.id/images/" +
                        _transaksi.model!.photo1!,
                    width: lebar / 5,
                    height: lebar / 5,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _transaksi.model!.namaModel!,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _transaksi.mitra!.name!,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
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
        );
      },
    );
  }
}
