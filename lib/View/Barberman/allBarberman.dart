import 'dart:math';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:omahdilit/model/listmitra.dart';

import '../../constant.dart';

class AllBarberman extends StatefulWidget {
  const AllBarberman({Key? key}) : super(key: key);

  @override
  _AllBarbermanState createState() => _AllBarbermanState();
}

class _AllBarbermanState extends State<AllBarberman>
    with TickerProviderStateMixin {
  TabController? _tabController;
  late ScrollController _scrollController;
  final List<Tab> tabs = <Tab>[
    new Tab(
      child: Container(
        height: tinggi / 6,
        width: lebar / 2.7,
        child: Align(
          alignment: Alignment.center,
          child: Text("Laki-laki"),
        ),
      ),
    ),
    new Tab(
      child: Container(
        height: tinggi / 6,
        width: lebar / 2.7,
        child: Align(
          alignment: Alignment.center,
          child: Text("Perempuan"),
        ),
      ),
    ),
  ];

  var _listMitra = List<Mitra>.generate(
    10,
    (index) => Mitra(
        id: index,
        name: "Mitra " + index.toString(),
        photo: "favoriteImage.png",
        workshop: "Barber",
        rating: new Random().nextDouble() * (5 - 3) + 1),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
    _scrollController = new ScrollController(initialScrollOffset: 5.0);
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
            height: tinggi / 10,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                    spreadRadius: 1)
              ],
            ),
            child: Container(
                margin:
                    EdgeInsets.only(left: 30, right: 30, top: 11, bottom: 11),
                height: tinggi / 12,
                decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: TabBar(
                  isScrollable: true,
                  unselectedLabelColor: primary,
                  labelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.zero,
                  indicator: new BubbleTabIndicator(
                    indicatorHeight: 35.0,
                    indicatorColor: primary,
                    tabBarIndicatorSize: TabBarIndicatorSize.label,
                    indicatorRadius: 100,
                  ),
                  tabs: tabs,
                  controller: _tabController,
                )),
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
              ))
        ],
      ),
    );
  }

  Widget Konten() {
    return GridView.builder(
      itemCount: _listMitra.length,
      controller: _scrollController,
      padding: EdgeInsets.only(bottom: marginVertical),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              context: context,
              elevation: 1,
              builder: (context) {
                return Container(
                  height: tinggi / 1.5,
                );
              },
            );
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
                      child: Image.asset(
                        "assets/${_listMitra[index].photo}",
                        scale: 2.3,
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
                          fontWeight: FontWeight.w600,
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
}
