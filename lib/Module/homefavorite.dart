import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:omahdilit/View/Barberman/reviewBarberman.dart';
import 'package:omahdilit/View/KonfirmasiPesanan/konfirmasipesanan.dart';
import 'package:omahdilit/bloc/mitra/mitrafavorite_bloc.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/listmitra.dart';
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

  Widget _buildView(BuildContext context, ListMitra listMitra) {
    // _listMitraFavorite = listMitra.mitra!;
    return ListView.builder(
      itemCount: listMitra.mitra!.length,
      scrollDirection: Axis.horizontal,
      itemExtent: tinggi / 13,
      padding: EdgeInsets.symmetric(
        vertical: marginVertical,
        horizontal: marginHorizontal,
      ),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          // onTap: () {
          //   showModalBottomSheet(
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(15),
          //           topRight: Radius.circular(15)),
          //     ),
          //     context: context,
          //     elevation: 1,
          //     builder: (context) {
          //       return Container(
          //         height: tinggi / 2,
          //         child: Padding(
          //           padding: EdgeInsets.symmetric(
          //             horizontal: marginHorizontal,
          //             vertical: marginVertical,
          //           ),
          //           child: Column(
          //             children: [
          //               Container(
          //                 height: tinggi / 100,
          //                 width: lebar / 9,
          //                 decoration: BoxDecoration(
          //                   color: greyPill,
          //                   borderRadius: BorderRadius.circular(5),
          //                 ),
          //               ),
          //               Container(
          //                 margin: EdgeInsets.symmetric(
          //                   vertical: marginVertical,
          //                 ),
          //                 child: Row(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     ClipRRect(
          //                       borderRadius: BorderRadius.circular(100),
          //                       child: Image.network(
          //                         "https://omahdilit.my.id/images/" +
          //                             listMitra.mitra![index].photo.toString(),
          //                         scale: 3.5,
          //                       ),
          //                     ),
          //                     Container(
          //                       width: lebar / 1.6,
          //                       margin: EdgeInsets.only(
          //                         left: marginHorizontal,
          //                         top: marginVertical / 2,
          //                       ),
          //                       child: Column(
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                           Row(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.spaceBetween,
          //                             children: [
          //                               Text(
          //                                 listMitra.mitra![index].name
          //                                     .toString(),
          //                                 textAlign: TextAlign.left,
          //                                 overflow: TextOverflow.fade,
          //                                 maxLines: 1,
          //                                 style: TextStyle(
          //                                   fontWeight: FontWeight.w500,
          //                                   color: textColor,
          //                                   fontSize: tinggi / lebar * 7,
          //                                 ),
          //                               ),
          //                               Row(
          //                                 children: [
          //                                   Icon(
          //                                     Icons.star,
          //                                     color: Colors.amber,
          //                                     size: lebar / 23,
          //                                   ),
          //                                   Text(
          //                                     listMitra.mitra![index].rating!
          //                                         .toStringAsFixed(1),
          //                                     style: TextStyle(
          //                                         fontWeight: FontWeight.w600,
          //                                         color: textAccent,
          //                                         fontSize: tinggi / lebar * 7),
          //                                   ),
          //                                   Text(
          //                                     " dari 3 review",
          //                                     style: TextStyle(
          //                                         fontWeight: FontWeight.w400,
          //                                         color: textAccent,
          //                                         fontSize: tinggi / lebar * 5),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ],
          //                           ),
          //                           Text(
          //                             listMitra.mitra![index].workshop
          //                                 .toString(),
          //                             textAlign: TextAlign.left,
          //                             overflow: TextOverflow.fade,
          //                             maxLines: 1,
          //                             style: TextStyle(
          //                                 fontWeight: FontWeight.w300,
          //                                 color: textAccent,
          //                                 fontSize: tinggi / lebar * 7),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Container(
          //                     child: Text(
          //                       "Review Pelanggan",
          //                       style: TextStyle(
          //                         fontWeight: FontWeight.w500,
          //                         fontSize: tinggi / lebar * 8,
          //                       ),
          //                     ),
          //                   ),
          //                   InkWell(
          //                     child: Text(
          //                       "Lihat Semua",
          //                       style: TextStyle(
          //                         color: blue,
          //                         fontSize: tinggi / lebar * 7,
          //                         fontWeight: FontWeight.w300,
          //                       ),
          //                     ),
          //                     onTap: () {
          //                       Navigator.push(
          //                         context,
          //                         CupertinoPageRoute(
          //                           builder: (_) => ReviewBarberman(),
          //                         ),
          //                       );
          //                     },
          //                   )
          //                 ],
          //               ),
          //               Expanded(
          //                 child: Container(
          //                   margin: EdgeInsets.symmetric(
          //                     vertical: marginVertical,
          //                   ),
          //                   width: lebar,
          //                   child: ListView.builder(
          //                     itemCount: _listReview.length,
          //                     scrollDirection: Axis.horizontal,
          //                     itemBuilder: (BuildContext contex, int index) {
          //                       Future.delayed(
          //                         Duration.zero,
          //                         () async {
          //                           countTimeAgo(
          //                             DateTime.parse(
          //                               _listReview[index].createdAt.toString(),
          //                             ),
          //                           );
          //                         },
          //                       );
          //                       return Card(
          //                         elevation: 2,
          //                         margin: EdgeInsets.symmetric(
          //                             horizontal: marginHorizontal / 2.5,
          //                             vertical: marginVertical / 2.5),
          //                         shape: RoundedRectangleBorder(
          //                           borderRadius: BorderRadius.circular(10),
          //                         ),
          //                         child: Container(
          //                           width: lebar / 1.5,
          //                           padding: EdgeInsets.symmetric(
          //                               horizontal: marginHorizontal,
          //                               vertical: marginVertical / 2),
          //                           child: Column(
          //                             crossAxisAlignment:
          //                                 CrossAxisAlignment.start,
          //                             children: [
          //                               Row(
          //                                 children: [
          //                                   ClipRRect(
          //                                     borderRadius:
          //                                         BorderRadius.circular(100),
          //                                     child: Image.network(
          //                                       "https://omahdilit.my.id/images/${_listReview[index].customer?.photo}",
          //                                       scale: 4.5,
          //                                       fit: BoxFit.cover,
          //                                     ),
          //                                   ),
          //                                   Column(
          //                                     crossAxisAlignment:
          //                                         CrossAxisAlignment.start,
          //                                     children: [
          //                                       Container(
          //                                         width: lebar / 2.7,
          //                                         margin: EdgeInsets.only(
          //                                             left: marginHorizontal /
          //                                                 1.5),
          //                                         child: Row(
          //                                           mainAxisAlignment:
          //                                               MainAxisAlignment
          //                                                   .spaceBetween,
          //                                           children: [
          //                                             Text(
          //                                               _listReview[index]
          //                                                   .customer!
          //                                                   .name
          //                                                   .toString(),
          //                                               style: TextStyle(
          //                                                 fontWeight:
          //                                                     FontWeight.w500,
          //                                                 fontSize: tinggi /
          //                                                     lebar *
          //                                                     6,
          //                                               ),
          //                                             ),
          //                                             Row(
          //                                               children: [
          //                                                 Icon(
          //                                                   Icons.star,
          //                                                   color: Colors.amber,
          //                                                   size: lebar / 25,
          //                                                 ),
          //                                                 Text(
          //                                                   _listReview[index]
          //                                                       .rating!
          //                                                       .toStringAsFixed(
          //                                                           1),
          //                                                   style: TextStyle(
          //                                                     fontWeight:
          //                                                         FontWeight
          //                                                             .w500,
          //                                                     color: textAccent,
          //                                                     fontSize: tinggi /
          //                                                         lebar *
          //                                                         6,
          //                                                   ),
          //                                                 ),
          //                                               ],
          //                                             ),
          //                                           ],
          //                                         ),
          //                                       ),
          //                                       Padding(
          //                                         padding: EdgeInsets.only(
          //                                             left: marginHorizontal /
          //                                                 1.5),
          //                                         child: Text(
          //                                           _timeago,
          //                                           style: TextStyle(
          //                                             fontWeight:
          //                                                 FontWeight.w500,
          //                                             color: textAccent,
          //                                             fontSize:
          //                                                 tinggi / lebar * 6,
          //                                           ),
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   )
          //                                 ],
          //                               ),
          //                               Padding(
          //                                 padding: EdgeInsets.symmetric(
          //                                   horizontal: marginHorizontal / 3,
          //                                   vertical: marginVertical / 3,
          //                                 ),
          //                                 child: Expanded(
          //                                   child: Text(
          //                                     _listReview[index]
          //                                         .review
          //                                         .toString(),
          //                                     overflow: TextOverflow.fade,
          //                                     maxLines: 3,
          //                                     style: TextStyle(
          //                                       fontWeight: FontWeight.w400,
          //                                       fontSize: tinggi / lebar * 6.5,
          //                                     ),
          //                                   ),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                       );
          //                     },
          //                   ),
          //                 ),
          //               ),
          //               Container(
          //                 width: lebar,
          //                 padding: EdgeInsets.symmetric(
          //                   vertical: marginVertical / 2,
          //                 ),
          //                 decoration: BoxDecoration(
          //                   color: blue,
          //                   borderRadius: BorderRadius.circular(5),
          //                 ),
          //                 child: InkWell(
          //                   onTap: () {
          //                     Navigator.push(
          //                       context,
          //                       CupertinoPageRoute(
          //                         builder: (_) => KonfirmasiPesanan(
          //                           barberman: listMitra.mitra![index],
          //                         ),
          //                       ),
          //                     );
          //                   },
          //                   child: Text(
          //                     "Pilih Barberman",
          //                     textAlign: TextAlign.center,
          //                     style: TextStyle(
          //                       color: Colors.white,
          //                       fontWeight: FontWeight.w600,
          //                       fontSize: tinggi / lebar * 8,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   );
          // },
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: marginHorizontal / 4,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    "https://omahdilit.my.id/images/" +
                        listMitra.mitra![index].photo.toString(),
                    fit: BoxFit.cover,
                    width: lebar / 7.5,
                    height: lebar / 7.5,
                  ),
                ),
                Text(
                  listMitra.mitra![index].status ==  "1"? "Online" : listMitra.mitra![index].status ==  "0" ? "Offline" : listMitra.mitra![index].status ==  "2" ? "Sibuk" : "-",
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
            return InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: marginHorizontal / 4,
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        "",
                      ),
                    ),
                    Text(
                      "",
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
