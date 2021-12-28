import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:omahdilit/Api/homeapi.dart';
import 'package:omahdilit/Module/homeHair.dart';
import 'package:omahdilit/Module/homefavorite.dart';
import 'package:omahdilit/View/Search/search.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/listmitra.dart';
import 'package:omahdilit/model/spotlight.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _listSpotlight = List<Spotlight>.generate(
    5,
    (index) => Spotlight(
      id: index,
      title: "Title " + index.toString(),
      description: "ini deskripsi ke " + index.toString(),
      image: "278203919.jpeg",
      createdAt: "2021-09-04 22:29:26",
      updatedAt: "2021-09-04 22:29:26",
    ),
  );


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                width: lebar,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => Search(),
                          ),
                        );
                      },
                      child: Container(
                        width: lebar / 1.5,
                        margin: EdgeInsets.only(
                          top: marginVertical,
                          left: marginHorizontal,
                          bottom: marginVertical,
                        ),
                        child: TextField(
                          enabled: false,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: tinggi / lebar * 7,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: greyBackground,
                            prefixIcon: Icon(
                              Icons.search,
                              color: greyMain,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: marginHorizontal,
                              vertical: marginVertical,
                            ),
                            hintText: "Cari Sesuatu",
                            hintStyle: TextStyle(color: greyMain),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: marginHorizontal / 3),
                      child: Container(
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
                    Container(
                      margin: EdgeInsets.only(left: marginHorizontal) / 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: greyBackground,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          child: IconButton(
                            onPressed: () {},
                            icon: ImageIcon(
                                AssetImage(
                                  "assets/notif.png",
                                ),
                                color: greyMain),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: tinggi / 4,
                width: lebar,
                child: Swiper(
                  loop: false,
                  viewportFraction: 0.9,
                  scale: 0.95,
                  itemCount: _listSpotlight.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      "https://pantomim.devert.id/assets/img/${_listSpotlight[index].image}",
                      fit: BoxFit.fitWidth,
                    );
                  },
                  pagination: new SwiperCustomPagination(
                    builder: (BuildContext context, SwiperPluginConfig config) {
                      return new ConstrainedBox(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            new Expanded(
                              child: new Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: marginHorizontal,
                                  ),
                                  child: new DotSwiperPaginationBuilder(
                                    color: Colors.grey.shade400,
                                    activeColor: primary,
                                    size: 10.0,
                                    activeSize: 13.0,
                                  ).build(context, config),
                                ),
                              ),
                            )
                          ],
                        ),
                        constraints:
                            new BoxConstraints.expand(height: tinggi / 4),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: tinggi / 60,
              ),
              Container(
                margin: EdgeInsets.only(left: marginHorizontal),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Mitra Omah Dilit",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: tinggi / lebar * 9,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: marginHorizontal,
                  vertical: marginVertical / 10,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Pilih mitra cukur rambut favorit anda",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: tinggi / lebar * 7,
                    ),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: tinggi / 7),
                child: HomeFavorite(),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: marginHorizontal,
                    right: marginHorizontal,
                    bottom: marginVertical),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "Model Rambut",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: tinggi / lebar * 9,
                        ),
                      ),
                    ),
                    Text(
                      "Lihat Semua",
                      style: TextStyle(
                        color: primary,
                        fontSize: tinggi / lebar * 7,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: marginVertical),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: tinggi / 4),
                  child: HomeHair(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}