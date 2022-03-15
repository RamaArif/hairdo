import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/View/Foto/detailfoto.dart';
import 'package:omahdilit/model/listmitra.dart';
import 'package:omahdilit/model/review.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../constant.dart';

class ReviewBarberman extends StatefulWidget {
  final String idmitra;
  const ReviewBarberman({Key? key, required this.idmitra}) : super(key: key);

  @override
  _ReviewBarbermanState createState() => _ReviewBarbermanState();
}

class _ReviewBarbermanState extends State<ReviewBarberman> {
  var locale = 'id';
  var _idmitra;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _idmitra = widget.idmitra;
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
          "Review Mitra",
          style: TextStyle(color: Color(0xFF6F6F6F), fontSize: 18.0),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: marginVertical / 2,
        ),
        width: lebar,
        child: FutureBuilder<ListReview>(
          future: ApiProvider().fetchReview(_idmitra),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ListReview _listReview = snapshot.data!;
              return ListView.builder(
                itemCount: _listReview.review!.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext contex, int index) {
                  ReviewModel _review = _listReview.review![index];

                  var _timeago = timeago.format(
                      DateTime.parse(_review.createdAt.toString()),
                      locale: locale);
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(
                        horizontal: marginHorizontal / 2.5,
                        vertical: marginVertical / 2.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: lebar,
                      padding: EdgeInsets.symmetric(
                          horizontal: marginHorizontal / 1.5,
                          vertical: marginVertical / 1.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://omahdilit.my.id/images/${_review.customer!.photo}",
                                  width: lebar / 7,
                                  height: lebar / 7,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: lebar / 1.45,
                                    margin: EdgeInsets.only(
                                        left: marginHorizontal / 1.5),
                                    child: Row(
                                      children: [
                                        Text(
                                          _review.customer!.name.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: tinggi / lebar * 7,
                                          ),
                                        ),
                                        Expanded(child: SizedBox()),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: lebar / 25,
                                            ),
                                            SizedBox(
                                              width: marginHorizontal / 5,
                                            ),
                                            Text(
                                              _review.rating!
                                                  .toStringAsFixed(1),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: textAccent,
                                                fontSize: tinggi / lebar * 6.5,
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
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: marginHorizontal / 3,
                              vertical: marginVertical / 1.5,
                            ),
                            child: Expanded(
                              child: Text(
                                _review.review.toString(),
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: tinggi / lebar * 7,
                                ),
                              ),
                            ),
                          ),
                          if (_review.image!.isNotEmpty)
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: marginVertical / 3,
                                horizontal: marginHorizontal,
                              ),
                              width: lebar,
                              height: lebar / 4,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _review.image!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (_) => DetailFoto(
                                            isSingle: false,
                                            imageReview: _review.image,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://omahdilit.my.id/images/" +
                                                  _review.image![index].name!,
                                          fit: BoxFit.cover,
                                          width: lebar / 4,
                                          height: lebar / 4,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Shimmer.fromColors(
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext contex, int index) {
                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.symmetric(
                            horizontal: marginHorizontal / 2.5,
                            vertical: marginVertical / 2.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: lebar,
                          height: tinggi / 15,
                          padding: EdgeInsets.symmetric(
                              horizontal: marginHorizontal,
                              vertical: marginVertical / 2),
                        ),
                      );
                    },
                  ),
                  baseColor: Colors.grey,
                  highlightColor: Colors.grey.shade300);
            }
          },
        ),
      ),
    );
  }
}
