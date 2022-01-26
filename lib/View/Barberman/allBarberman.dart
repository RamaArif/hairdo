import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:omahdilit/View/Barberman/reviewBarberman.dart';
import 'package:omahdilit/View/KonfirmasiPesanan/konfirmasipesanan.dart';
import 'package:omahdilit/model/listmitra.dart';
import 'package:omahdilit/model/review.dart';
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

  var _listMitra = List<Mitra>.generate(
    10,
    (index) => Mitra(
        id: index,
        name: "Mitra " + index.toString(),
        photo: "imagemitra.png",
        workshop: "Barber",
        rating: new Random().nextDouble() * (5 - 3) + 1),
  );

  var _listReview = List<Review>.generate(
    9,
    (index) => Review(
      id: index,
      codeTransaksi: "pesanan " + index.toString(),
      review: "sangat baik ke " + index.toString(),
      rating: new Random().nextInt(5),
      createdAt: "2022-01-0" + index.toString() + "T06:39:50.000000Z",
      customer: CustomerReview(
        name: "Rama " + index.toString(),
        photo: "imgcustomer.png",
      ),
    ),
  );

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
          "Mitra Barberman",
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
          SafeArea(
            bottom: true,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: tinggi),
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  Konten(),
                  Konten(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget Konten() {
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
        return InkWell(
          onTap: () {
            _awaitBottomSheet(context, index);
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
                            _listMitra[index].photo.toString(),
                        scale: 3.5,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: marginHorizontal,
                    ),
                    child: Text(
                      "${_listMitra[index].name}",
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
                        Text(
                          _listMitra[index].workshop.toString(),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: textAccent,
                              fontSize: tinggi / lebar * 7),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: lebar / 23,
                            ),
                            Text(
                              _listMitra[index].rating!.toStringAsFixed(1),
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

  void _awaitBottomSheet(BuildContext context, int index) async {
    final result = await showModalBottomSheet(
      shape: RoundedRectangleBorder(
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
                        child: Image.network(
                          "https://omahdilit.my.id/images/" +
                              _listMitra[index].photo.toString(),
                          scale: 3.5,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${_listMitra[index].name}",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: textColor,
                                    fontSize: tinggi / lebar * 7,
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
                                      _listMitra[index]
                                          .rating!
                                          .toStringAsFixed(1),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: textAccent,
                                          fontSize: tinggi / lebar * 7),
                                    ),
                                    Text(
                                      " dari 3 review",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: textAccent,
                                          fontSize: tinggi / lebar * 5),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              _listMitra[index].workshop.toString(),
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
                        "Review Pelanggan",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: tinggi / lebar * 8,
                        ),
                      ),
                    ),
                    InkWell(
                      child: Text(
                        "Lihat Semua",
                        style: TextStyle(
                          color: blue,
                          fontSize: tinggi / lebar * 7,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => ReviewBarberman(),
                          ),
                        );
                      },
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: marginVertical,
                    ),
                    width: lebar,
                    child: ListView.builder(
                      itemCount: _listReview.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext contex, int index) {
                        Future.delayed(
                          Duration.zero,
                          () async {
                            countTimeAgo(
                              DateTime.parse(
                                _listReview[index].createdAt.toString(),
                              ),
                            );
                          },
                        );
                        return Card(
                          elevation: 2,
                          margin: EdgeInsets.symmetric(
                              horizontal: marginHorizontal / 2.5,
                              vertical: marginVertical / 2.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: lebar / 1.5,
                            padding: EdgeInsets.symmetric(
                                horizontal: marginHorizontal,
                                vertical: marginVertical / 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        "https://omahdilit.my.id/images/${_listReview[index].customer?.photo}",
                                        scale: 4.5,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: lebar / 2.7,
                                          margin: EdgeInsets.only(
                                              left: marginHorizontal / 1.5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _listReview[index]
                                                    .customer!
                                                    .name
                                                    .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: tinggi / lebar * 6,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: lebar / 25,
                                                  ),
                                                  Text(
                                                    _listReview[index]
                                                        .rating!
                                                        .toStringAsFixed(1),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: textAccent,
                                                      fontSize:
                                                          tinggi / lebar * 6,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: marginHorizontal / 1.5),
                                          child: Text(
                                            _timeago,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: textAccent,
                                              fontSize: tinggi / lebar * 6,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: marginHorizontal / 3,
                                    vertical: marginVertical / 3,
                                  ),
                                  child: Expanded(
                                    child: Text(
                                      _listReview[index].review.toString(),
                                      overflow: TextOverflow.fade,
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: tinggi / lebar * 6.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
                        Navigator.pop(context, _listMitra[index]);
                      } else {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => KonfirmasiPesanan(
                              barberman: _listMitra[index],
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
    if (_isEdit) {
      Navigator.pop(context, result);
    }
  }
}
