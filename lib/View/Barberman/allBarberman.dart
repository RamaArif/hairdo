import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/View/Barberman/reviewBarberman.dart';
import 'package:omahdilit/View/Pesanan/konfirmasipesanan.dart';
import 'package:omahdilit/model/detailmitra.dart';
import 'package:omahdilit/model/listmitra.dart';
import 'package:omahdilit/model/modelhair.dart';
import 'package:omahdilit/model/review.dart';
import 'package:omahdilit/model/transaksi.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../constant.dart';

class AllBarberman extends StatefulWidget {
  const AllBarberman({Key? key, this.isEdit}) : super(key: key);
  final isEdit;
  @override
  _AllBarbermanState createState() => _AllBarbermanState();
}

class _AllBarbermanState extends State<AllBarberman>
    with TickerProviderStateMixin {
  TabController? _tabController;
  late ScrollController _scrollController;
  late bool _isEdit = false;
  final List<Tab> tabs = <Tab>[
    new Tab(child: Text("Laki-laki")),
    new Tab(
      child: Text("Perempuan"),
    ),
  ];

  var locale = 'id';
  var loadedTime, _timeago;

  // var _listReview = List<Review>.generate(
  //   9,
  //   (index) => Review(
  //     id: index,
  //     codeTransaksi: "pesanan " + index.toString(),
  //     review: "sangat baik ke " + index.toString(),
  //     rating: new Random().nextInt(5),
  //     createdAt: "2022-01-0" + index.toString() + "T06:39:50.000000Z",
  //     customer: CustomerReview(
  //       name: "Rama " + index.toString(),
  //       photo: "imgcustomer.png",
  //     ),
  //   ),
  // );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
    _scrollController = new ScrollController(initialScrollOffset: 5.0);

    timeago.setLocaleMessages('id', timeago.IdMessages());
    if (widget.isEdit != null) {
      _isEdit = true;
    }
  }

  @override
  void dispose() {
    _tabController!.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Mitra Hairdo",
          style: TextStyle(color: Color(0xFF6F6F6F), fontSize: 18.0),
        ),
        actions: [
          InkWell(
            child: Container(
              margin: EdgeInsets.only(
                  left: marginHorizontal / 20, top: 10, bottom: 10),
              child: Material(
                color: Color(0xFFEEEEEE),
                shape: CircleBorder(),
                child: IconButton(
                    onPressed: () {},
                    icon: ImageIcon(
                      AssetImage(
                        "assets/heart.png",
                      ),
                      size: 18,
                    ),
                    color: greyMain),
              ),
            ),
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(
                  left: marginHorizontal / 20, top: 10, bottom: 10, right: 15),
              child: Material(
                color: Color(0xFFEEEEEE),
                shape: CircleBorder(),
                child: IconButton(
                    onPressed: () {},
                    icon: ImageIcon(
                      AssetImage(
                        "assets/search.png",
                      ),
                      size: 18,
                    ),
                    color: greyMain),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            width: lebar,
            height: tinggi / 15,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                    spreadRadius: 1)
              ],
            ),
            child: TabBar(
              isScrollable: false,
              unselectedLabelColor: textAccent,
              labelColor: primary,
              indicatorPadding: EdgeInsets.zero,
              indicatorColor: primary,
              tabs: tabs,
              controller: _tabController,
            ),
          ),
          FutureBuilder<ListMitra>(
            future: ApiProvider().fetchMitra(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ListMitra _listMitra = snapshot.data!;
                // print("cewek " + _listMitra.mitracewek.toString());
                // print("Cowok " + _listMitra.mitracowok.toString());
                return SafeArea(
                  bottom: true,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: tinggi),
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        konten(_listMitra.mitracowok!),
                        konten(_listMitra.mitracewek!),
                      ],
                    ),
                  ),
                );
              } else {
                return SafeArea(
                  bottom: true,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: tinggi),
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        kontenLoading(),
                        kontenLoading(),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget konten(List<Mitra> _listMitra) {
    return GridView.builder(
      itemCount: _listMitra.length,
      controller: _scrollController,
      padding: EdgeInsets.only(
        top: marginVertical / 1.5,
        bottom: marginVertical * 9,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        Mitra _mitra = _listMitra[index];
        var sum = 0, total;
        double rating;
        total = _mitra.reviews!.length;
        for (final reviews in _mitra.reviews!.toList()) {
          sum += reviews.rating!;
        }

        rating = sum / total;
        return InkWell(
          onTap: () {
            _awaitBottomSheet(context, _mitra);
          },
          child: Card(
            elevation: 1.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.symmetric(
                horizontal: marginHorizontal / 2,
                vertical: marginVertical / 1.7),
            child: Container(
              width: lebar / 2.35,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(
                vertical: marginVertical,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                      vertical: marginVertical / 2,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        "https://omahdilit.my.id/images/" +
                            _mitra.photo.toString(),
                        width: lebar / 4.7,
                        height: lebar / 4.7,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: marginHorizontal,
                    ),
                    child: Text(
                      _mitra.name!,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: textColor,
                          fontSize: tinggi / lebar * 7),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: marginHorizontal,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            _mitra.workshop ?? "Workshop",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: textAccent,
                                fontSize: tinggi / lebar * 7),
                          ),
                        ),
                        sum != 0
                            ? Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: lebar / 23,
                                    ),
                                    Text(
                                      rating.toStringAsFixed(1),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: textAccent,
                                          fontSize: tinggi / lebar * 7),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void countTimeAgo(DateTime time) {
    final now = new DateTime.now();
    final difference = now.difference(time);
    setState(() {
      _timeago = timeago.format(now.subtract(difference), locale: locale);
    });
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
                              imageUrl: "https://omahdilit.my.id/images/" +
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
                                        ? _totalReview != 0
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
                                                  "  ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: textAccent,
                                                      fontSize:
                                                          tinggi / lebar * 7),
                                                ),
                                                Text(
                                                  "       ",
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
                                )
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
                                                "https://omahdilit.my.id/images/" +
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
                          if (_isEdit) {
                            Navigator.pop(context, mitra);
                          } else {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => KonfirmasiPesanan(
                                  barberman: mitra,
                                ),
                              ),
                            );
                          }
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
    ).then((value) {
      if (_isEdit) {
        if (value != null) {
          Navigator.pop(context, value);
        }
      }
    });
  }

  Widget kontenLoading() {
    return Shimmer.fromColors(
      child: GridView.builder(
        itemCount: 10,
        controller: _scrollController,
        padding: EdgeInsets.only(
          top: marginVertical / 1.5,
          bottom: marginVertical * 9,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 1.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.symmetric(
                horizontal: marginHorizontal / 2,
                vertical: marginVertical / 1.7),
            child: Container(
              width: lebar / 2.35,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(
                vertical: marginVertical,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
      ),
      baseColor: Colors.grey,
      highlightColor: Colors.grey.shade300,
    );
  }
}
