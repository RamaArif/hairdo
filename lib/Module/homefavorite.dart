import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/View/Barberman/reviewBarberman.dart';
import 'package:omahdilit/View/Pesanan/konfirmasipesanan.dart';
import 'package:omahdilit/bloc/mitra/mitrafavorite_bloc.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/detailmitra.dart';
import 'package:omahdilit/model/listmitra.dart';
import 'package:omahdilit/model/modelhair.dart';
import 'package:omahdilit/model/review.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeFavorite extends StatefulWidget {
  const HomeFavorite({Key? key}) : super(key: key);

  @override
  _HomeFavoriteState createState() => _HomeFavoriteState();
}

class _HomeFavoriteState extends State<HomeFavorite> {
  final MitrafavoriteBloc _mitraFavoriteBloc = MitrafavoriteBloc();

  var locale = 'id';
  var loadedTime, _timeago;

  @override
  void initState() {
    super.initState();
    setState(() {
      _mitraFavoriteBloc.add(GetMitraFavoriteEvent());
    });

    timeago.setLocaleMessages('id', timeago.IdMessages());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _mitraFavoriteBloc,
      child: BlocListener<MitrafavoriteBloc, MitrafavoriteState>(
        listener: (context, state) {
          if (state is MitrafavoriteError) {
            EasyLoading.showError(state.message.toString());
          }
        },
        child: BlocBuilder<MitrafavoriteBloc, MitrafavoriteState>(
          builder: (context, state) {
            if (state is MitrafavoriteInitial) {
              return _buildLoading(context);
            } else if (state is MitrafavoriteLoading) {
              return _buildLoading(context);
            } else if (state is MitrafavoriteLoaded) {
              return _buildView(context, state.listMitra);
            } else if (state is MitrafavoriteError) {
              EasyLoading.showError(state.message.toString());
            }
            return _buildLoading(context);
          },
        ),
      ),
    );
  }

  void countTimeAgo(DateTime parse) {
    final now = new DateTime.now();
    final difference = now.difference(parse);
    setState(() {
      _timeago = timeago.format(now.subtract(difference), locale: locale);
    });
  }

  Widget _buildView(BuildContext context, ListMitraFavorite listMitra) {
    // _listMitraFavorite = listMitra.mitra!;
    return ListView.builder(
      itemCount: listMitra.mitra!.length,
      scrollDirection: Axis.horizontal,
      itemExtent: tinggi / 12,
      padding: EdgeInsets.symmetric(
        vertical: marginVertical,
        horizontal: marginHorizontal,
      ),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            _awaitBottomSheet(context, listMitra.mitra![index]);
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: marginHorizontal / 4,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: "https://omahdilit.site/images/" +
                        listMitra.mitra![index].photo.toString(),
                    fit: BoxFit.cover,
                    width: lebar / 7.5,
                    height: lebar / 7.5,
                  ),
                ),
                Text(
                  listMitra.mitra![index].name!.split(" ").elementAt(0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemExtent: tinggi / 13,
          padding: EdgeInsets.symmetric(
            vertical: marginVertical,
            horizontal: marginHorizontal,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: marginHorizontal / 4,
              ),
            );
          }),
    );
  }

  void _awaitBottomSheet(BuildContext context, Mitra _mitra) async {
    Mitra mitra = Mitra();
    var _rating, _totalReview;
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      context: context,
      elevation: 1,
      builder: (context) {
        return FutureBuilder<DetailMitra>(
          future: ApiProvider().fetchDetailMitra(_mitra.id.toString()),
          builder: (context, snapshot) {
            // print(snapshot.data!.transaksis![0].toString());
            if (snapshot.hasData) {
              mitra = snapshot.data!.detail!;
              _rating = snapshot.data!.rating;
              _totalReview = snapshot.data!.total;
              mitra.rating = double.parse(_rating);
            }
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
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: marginVertical,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: "https://omahdilit.site/images/" +
                                  _mitra.photo.toString(),
                              width: lebar / 4.7,
                              height: lebar / 4.7,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: lebar / 1.6,
                            margin: EdgeInsets.only(
                              left: marginHorizontal,
                              top: marginVertical / 2,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${_mitra.name}",
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: textColor,
                                        fontSize: tinggi / lebar * 7,
                                      ),
                                    ),
                                    snapshot.hasData
                                        ? mitra.transaksis!.isNotEmpty
                                            ? Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: lebar / 23,
                                                  ),
                                                  Text(
                                                    _rating,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: textAccent,
                                                        fontSize:
                                                            tinggi / lebar * 7),
                                                  ),
                                                  Text(
                                                    " dari $_totalReview review",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: textAccent,
                                                        fontSize:
                                                            tinggi / lebar * 5),
                                                  ),
                                                ],
                                              )
                                            : Container()
                                        : Shimmer.fromColors(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: lebar / 23,
                                                ),
                                                Text(
                                                  "   ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: textAccent,
                                                      fontSize:
                                                          tinggi / lebar * 7),
                                                ),
                                                Text(
                                                  "      ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: textAccent,
                                                      fontSize:
                                                          tinggi / lebar * 5),
                                                ),
                                              ],
                                            ),
                                            baseColor: Colors.grey,
                                            highlightColor:
                                                Colors.grey.shade300,
                                          ),
                                  ],
                                ),
                                Text(
                                  _mitra.workshop.toString(),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: textAccent,
                                      fontSize: tinggi / lebar * 7),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Review",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: tinggi / lebar * 8,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (snapshot.hasData)
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: marginVertical / 3,
                            ),
                            alignment: Alignment.center,
                            width: lebar,
                            child: mitra.transaksis!.length != 0
                                ? ListView.builder(
                                    itemCount: mitra.transaksis!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext contex, int index) {
                                      ModelHair _modelHair =
                                          mitra.transaksis![index].model!;
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (_) => ReviewBarberman(
                                                idmitra: _mitra.id!.toString(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: lebar / 2.35,
                                          height: tinggi,
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.symmetric(
                                              horizontal:
                                                  marginHorizontal / 1.5,
                                              vertical: marginVertical / 1.7),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                "https://omahdilit.site/images/" +
                                                    _modelHair.photo1!,
                                              ),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: SizedBox(),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: marginHorizontal,
                                                  vertical: marginVertical / 3,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(.3),
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    bottom: Radius.circular(12),
                                                  ),
                                                ),
                                                width: lebar,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${_modelHair.namaModel}",
                                                      textAlign: TextAlign.left,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white,
                                                          fontSize: tinggi /
                                                              lebar *
                                                              8),
                                                    ),
                                                    Text(
                                                      _modelHair.reviews!.length
                                                              .toString() +
                                                          " review",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.white,
                                                          fontSize: tinggi /
                                                              lebar *
                                                              7),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Text("Tidak ada data")),
                      ),
                    if (!snapshot.hasData)
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: marginVertical,
                          ),
                          width: lebar,
                          child: Shimmer.fromColors(
                            child: ListView.builder(
                              itemCount: 10,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext contex, int index) {
                                return Container(
                                  width: lebar / 2.35,
                                  height: tinggi,
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: marginHorizontal / 1.5,
                                      vertical: marginVertical / 1.7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                );
                              },
                            ),
                            baseColor: Colors.grey,
                            highlightColor: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    Container(
                      width: lebar,
                      padding: EdgeInsets.symmetric(
                        vertical: marginVertical / 2,
                      ),
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => KonfirmasiPesanan(
                                barberman: mitra,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Pilih Barberman",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: tinggi / lebar * 8,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
