import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:lottie/lottie.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/Module/homeHair.dart';
import 'package:omahdilit/Module/homefavorite.dart';
import 'package:omahdilit/View/Barberman/allBarberman.dart';
import 'package:omahdilit/View/Home/spotlight.dart';
import 'package:omahdilit/View/ModelHair/allmodel.dart';
import 'package:omahdilit/View/Pesanan/activity.dart';
import 'package:omahdilit/View/Search/search.dart';
import 'package:omahdilit/bloc/activity/activity_bloc.dart';
import 'package:omahdilit/bloc/modelhair/modelhair_bloc.dart';
import 'package:omahdilit/bloc/spotlight/spotlight_bloc.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/listmitra.dart';
import 'package:omahdilit/model/spotlight.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // var _listSpotlight = List<Spotlight>.generate(
  //   5,
  //   (index) => Spotlight(
  //     id: index,
  //     title: "Title " + index.toString(),
  //     description: "ini deskripsi ke " + index.toString(),
  //     image: "278203919.jpeg",
  //     createdAt: "2021-09-04 22:29:26",
  //     updatedAt: "2021-09-04 22:29:26",
  //   ),
  // );

  @override
  void initState() {
    super.initState();
    context.read<ModelhairBloc>().add(FetchHairHome());
    context.read<ActivityBloc>().add(GetActivity());
    context.read<SpotlightBloc>().add(FetchSpotlight());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: DoubleBack(
          message: "Tap lagi untuk keluar",
          child: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    width: lebar,
                    child: Row(
                      children: [
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       CupertinoPageRoute(
                        //         builder: (_) => Search(),
                        //       ),
                        //     );
                        //   },
                        //   child: Container(
                        //     width: lebar / 1.6,
                        //     margin: EdgeInsets.only(
                        //       top: marginVertical,
                        //       left: marginHorizontal,
                        //     ),
                        //     child: TextField(
                        //       enabled: false,
                        //       style: TextStyle(
                        //         color: Colors.grey.shade600,
                        //         fontSize: tinggi / lebar * 7,
                        //       ),
                        //       decoration: InputDecoration(
                        //         filled: true,
                        //         fillColor: greyBackground,
                        //         prefixIcon: Icon(
                        //           Icons.search,
                        //           color: greyMain,
                        //         ),
                        //         contentPadding: EdgeInsets.symmetric(
                        //           horizontal: marginHorizontal,
                        //           vertical: marginVertical,
                        //         ),
                        //         hintText: "Cari Sesuatu",
                        //         hintStyle: TextStyle(color: greyMain),
                        //         border: OutlineInputBorder(
                        //             borderRadius: BorderRadius.circular(50),
                        //             borderSide: BorderSide.none),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(left: marginHorizontal / 3),
                        //   child: Container(
                        //     child: Material(
                        //       color: greyBackground,
                        //       shape: CircleBorder(),
                        //       child: IconButton(
                        //           onPressed: () {},
                        //           icon: ImageIcon(
                        //             AssetImage(
                        //               "assets/heart.png",
                        //             ),
                        //           ),
                        //           color: greyMain),
                        //     ),
                        //   ),
                        // ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(
                              top: marginVertical, right: marginHorizontal),
                          child: Container(
                            decoration: BoxDecoration(
                              color: greyBackground,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              child: BlocBuilder<ActivityBloc, ActivityState>(
                                builder: (context, state) {
                                  if (state is ActivityLoaded) {
                                    if (state
                                        .listTransaksi.transaksis!.isNotEmpty) {
                                      return Badge(
                                        shape: BadgeShape.square,
                                        borderRadius: BorderRadius.circular(5),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 0),
                                        badgeContent: Text(
                                          state.listTransaksi.transaksis!.length
                                              .toString(),
                                          style: textStyle.copyWith(
                                              color: Colors.white,
                                              fontSize: tinggi / lebar * 6),
                                        ),
                                        badgeColor: primary,
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (_) => Activity(),
                                              ),
                                            );
                                          },
                                          icon: ImageIcon(
                                              AssetImage(
                                                "assets/transaction.png",
                                              ),
                                              color: greyMain),
                                        ),
                                      );
                                    } else {
                                      return emptyActivity(context);
                                    }
                                  } else {
                                    return emptyActivity(context);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<SpotlightBloc, SpotlightState>(
                    builder: (context, state) {
                      if (state is SpotlightLoaded) {
                        if (state.listSpotlight.spotlight!.isNotEmpty) {
                          List<Spotlight> _listSpotlight =
                              state.listSpotlight.spotlight!;
                          return Container(
                            height: tinggi / 4,
                            width: lebar,
                            child: Swiper(
                              loop: false,
                              viewportFraction: 0.9,
                              scale: 0.95,
                              itemCount: _listSpotlight.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (_) => DetailSpotlight(
                                                spotlight:
                                                    _listSpotlight[index])));
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: "https://omahdilit.site/images/" +
                                        _listSpotlight[index].image!,
                                    fit: BoxFit.fitWidth,
                                  ),
                                );
                              },
                              pagination: new SwiperCustomPagination(
                                builder: (BuildContext context,
                                    SwiperPluginConfig config) {
                                  return new ConstrainedBox(
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        new Expanded(
                                          child: new Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                left: marginHorizontal,
                                              ),
                                              child:
                                                  new DotSwiperPaginationBuilder(
                                                          color: Colors
                                                              .grey.shade400,
                                                          activeColor: primary,
                                                          size: 10.0,
                                                          activeSize: 10.0,
                                                          space: 2)
                                                      .build(context, config),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    constraints: new BoxConstraints.expand(
                                        height: tinggi / 4),
                                  );
                                },
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      } else {
                        return Center(
                          child: Container(
                            width: lebar / 3,
                            height: lebar / 3,
                            child: LottieBuilder.asset("assets/loading.json"),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: tinggi / 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: marginHorizontal,
                        right: marginHorizontal,
                        bottom: marginVertical / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Mitra Hairdo",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: tinggi / lebar * 9,
                            ),
                          ),
                        ),
                        InkWell(
                          child: Text(
                            "Lihat Semua",
                            style: TextStyle(
                              color: primary,
                              fontSize: tinggi / lebar * 7,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => AllBarberman(),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: marginHorizontal,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Pilih mitra cukur rambut anda",
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
                        InkWell(
                          child: Text(
                            "Lihat Semua",
                            style: TextStyle(
                              color: primary,
                              fontSize: tinggi / lebar * 7,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllModelHair()));
                          },
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
        ),
      ),
    );
  }

  IconButton emptyActivity(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => Activity(),
          ),
        );
      },
      icon: ImageIcon(
          AssetImage(
            "assets/transaction.png",
          ),
          color: greyMain),
    );
  }
}
