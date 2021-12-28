import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omahdilit/View/ModelHair/detailmodel.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/modelhair.dart';

class HomeHair extends StatefulWidget {
  const HomeHair({Key? key}) : super(key: key);

  @override
  _HomeHairState createState() => _HomeHairState();
}

class _HomeHairState extends State<HomeHair> {
  var _listHair = List<ModelHair>.generate(
    5,
    (index) => ModelHair(
        id: index,
        namaModel: "Komahead",
        photo1: "model.png",
        photo2: "model.png",
        photo3: "model.png",
        kategori: "Laki-Laki",
        jenisModel: "Fade",
        detail:
            "model undercut tidak ada degradasi entah itu rambut dicukur botak, 1 cm dan 2 cm yang paling penting adalah mempunyai panjang yang sama tanpa degradasi memudar.",
        rating: new Random().nextDouble() * (5 - 1) + 1),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _listHair.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext buildContext, int index) {
        return InkWell(
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => DetailModel(
                modelHair: _listHair[index],
              ),
            ),
          ),
          child: Container(
            width: lebar / 2.35,
            height: tinggi,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: marginHorizontal / 1.5),
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
                  height: tinggi / 8.5,
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
                            Icons.star,
                            color: Colors.amber,
                            size: lebar / 23,
                          ),
                          Text(
                            _listHair[index].rating!.toStringAsFixed(1),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: tinggi / lebar * 7),
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
}
