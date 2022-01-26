import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:omahdilit/model/review.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../constant.dart';

class ReviewBarberman extends StatefulWidget {
  const ReviewBarberman({Key? key}) : super(key: key);

  @override
  _ReviewBarbermanState createState() => _ReviewBarbermanState();
}

class _ReviewBarbermanState extends State<ReviewBarberman> {
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
          "Review Barberman",
          style: TextStyle(color: Color(0xFF6F6F6F), fontSize: 18.0),
        ),
      ),
      
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: marginVertical,
        ),
        width: lebar,
        child: ListView.builder(
          itemCount: _listReview.length,
          scrollDirection: Axis.vertical,
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
                width: lebar,
                padding: EdgeInsets.symmetric(
                    horizontal: marginHorizontal, vertical: marginVertical / 2),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: lebar / 2.7,
                              margin:
                                  EdgeInsets.only(left: marginHorizontal / 1.5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _listReview[index].customer!.name.toString(),
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
                                          fontWeight: FontWeight.w500,
                                          color: textAccent,
                                          fontSize: tinggi / lebar * 6,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: marginHorizontal / 1.5),
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
    );
  }
  void countTimeAgo(DateTime time) {
    final now = new DateTime.now();
    final difference = now.difference(time);
    _timeago = timeago.format(now.subtract(difference), locale: locale);
  }
}
