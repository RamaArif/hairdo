import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omahdilit/constant.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:omahdilit/model/modelhair.dart';

import 'detailmodel.dart';

class AllModelHair extends StatefulWidget {
  const AllModelHair({Key? key, this.isEdit}) : super(key: key);

  final isEdit;

  @override
  _AllModelHairState createState() => _AllModelHairState();
}

class _AllModelHairState extends State<AllModelHair>
    with TickerProviderStateMixin {
  TabController? _tabController;
  late ScrollController _scrollController;
  late bool _isEdit = false;
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

  var _listHair = List<ModelHair>.generate(
    10,
    (index) => ModelHair(
      id: index,
      namaModel: "Undercut " + index.toString(),
      photo1: "model.png",
      photo2: "model.png",
      photo3: "model.png",
      kategori: "Laki-Laki",
      jenisModel: "Fade",
      detail:
          "Model undercut tidak ada degradasi entah itu rambut dicukur botak, 1 cm dan 2 cm yang paling penting adalah mempunyai panjang yang sama tanpa degradasi memudar.",
      rating: new Random().nextInt(100),
      totalreview: new Random().nextInt(100),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
    _scrollController = new ScrollController(initialScrollOffset: 5.0);
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
          "Model Rambut",
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
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  spreadRadius: 1)
            ]),
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
                    children: <Widget>[konten(), konten()]),
              ))
        ],
      ),
    );
  }

  Widget konten() {
    return GridView.builder(
      itemCount: 10,
      controller: _scrollController,
      padding: EdgeInsets.only(bottom: 180),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.9, crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            if (!_isEdit) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailModel(
                    modelhair: _listHair[index],
                    isEdit: _isEdit,
                  ),
                ),
              );
            } else {
              _awaitChangeModelHair(
                context,
                _listHair[index],
              );
            }
          },
          child: Container(
            width: lebar / 2.35,
            height: tinggi,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
                horizontal: marginHorizontal / 1.5,
                vertical: marginVertical / 1.7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  "assets/${_listHair[index].photo1}",
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: marginHorizontal * 6, top: marginVertical / 2),
                  child: Container(
                    width: lebar / 11,
                    child: Material(
                      color: greyBackground,
                      shape: CircleBorder(),
                      child: IconButton(
                          onPressed: () {},
                          icon: ImageIcon(
                            AssetImage(
                              "assets/heart.png",
                            ),
                          ),
                          color: greyMain),
                    ),
                  ),
                ),
                SizedBox(
                  height: tinggi / 9,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: marginHorizontal,
                  ),
                  child: Text(
                    "${_listHair[index].namaModel}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: tinggi / lebar * 8),
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
                        _listHair[index].jenisModel.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: tinggi / lebar * 7),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            color: Colors.white,
                            size: lebar / 23,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: marginHorizontal / 2),
                            child: Text(
                              _listHair[index].rating!.toString() + "%",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: tinggi / lebar * 7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _awaitChangeModelHair(BuildContext context, ModelHair modelHair) async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => DetailModel(
          isEdit: true,
          modelhair: modelHair,
        ),
      ),
    );
    Navigator.pop(context, result);
  }
}
