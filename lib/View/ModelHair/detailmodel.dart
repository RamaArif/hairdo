import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omahdilit/View/KonfirmasiPesanan/konfirmasipesanan.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/modelhair.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'
];

class DetailModel extends StatefulWidget {
  const DetailModel({Key? key, required this.modelhair, this.isEdit})
      : super(key: key);

  final modelhair, isEdit;
  @override
  _DetailModelState createState() => _DetailModelState();
}

class _DetailModelState extends State<DetailModel> {
  var photo;
  var photoHair;
  late ModelHair _modelHair;
  late bool _isEdit = false;

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    _modelHair = widget.modelhair;
    if (widget.isEdit) {
      _isEdit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: tinggi / 12,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Harga Cukur",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Rp 15.0000",
                      style: TextStyle(
                          color: primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                InkWell(
                    onTap: () {
                      if (!_isEdit) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => KonfirmasiPesanan(
                              modelHair: _modelHair,
                            ),
                          ),
                        );
                      } else {
                        Navigator.pop(
                          context,
                          _modelHair,
                        );
                      }
                    },
                    child: Container(
                      height: tinggi / 18,
                      width: lebar / 2.5,
                      decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Center(
                        child: Text(
                          "Pilih Model",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ))
              ]),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: tinggi / 2.2,
              child: Stack(children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final double height = MediaQuery.of(context).size.height;
                      return CarouselSlider(
                        carouselController: _controller,
                        options: CarouselOptions(
                            height: height,
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                            autoPlay: false,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                        items: imgList
                            .map((item) => Container(
                                  child: Center(
                                      child: Image.network(
                                    item,
                                    fit: BoxFit.cover,
                                    height: height,
                                  )),
                                ))
                            .toList(),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 10.0,
                          height: 10.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.grey
                                      : Colors.white)
                                  .withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    height: tinggi / 1.89,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 20.0, left: 20.0, top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Model Rambut",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: tinggi / lebar * 9),
                              ),
                              Container(
                                width: lebar / 10,
                                height: tinggi / 19,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.favorite,
                                    color: primary,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_modelHair.namaModel.toString()),
                              Padding(
                                padding: const EdgeInsets.only(left: 50.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.thumb_up,
                                      color: like,
                                      size: lebar / 23,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: marginHorizontal / 3),
                                      child: Text(
                                        _modelHair.rating.toString() + "%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: like,
                                            fontSize: tinggi / lebar * 7),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: marginHorizontal / 3),
                                      child: Text(
                                        "dari " +
                                            _modelHair.totalreview.toString() +
                                            " review",
                                        style: TextStyle(
                                            color: textColor,
                                            fontSize: tinggi / lebar * 4.5),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: marginVertical),
                            child: Text("Deskripsi Model",
                                style: TextStyle(
                                  fontSize: tinggi / lebar * 9,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          Text(
                            _modelHair.detail.toString(),
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: tinggi / lebar * 6),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  child: Container(
                    height: tinggi / 25,
                    width: lebar / 12.5,
                    decoration: BoxDecoration(
                        color: Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.all(Radius.circular(200))),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
