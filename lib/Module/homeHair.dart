import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/View/ModelHair/detailmodel.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/listmodelrambut.dart';
import 'package:omahdilit/model/modelhair.dart';
import 'package:shimmer/shimmer.dart';

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
        namaModel: "Undercut",
        photo1: "model.png",
        photo2: "model.png",
        photo3: "model.png",
        kategori: "Laki-Laki",
        jenisModel: "Fade",
        detail:
            "Model undercut tidak ada degradasi entah itu rambut dicukur botak, 1 cm dan 2 cm yang paling penting adalah mempunyai panjang yang sama tanpa degradasi memudar."),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ModelHome>(
      future: ApiProvider().fetchModelHome(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ModelHome _list = snapshot.data!;
          return ListView.builder(
            itemCount: _listHair.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext buildContext, int index) {
              ModelHair _modelHair = _list.model![index];
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailModel(
                      modelhair: _modelHair,
                      isEdit: false,
                    ),
                  ),
                ),
                child: Container(
                  width: lebar / 2.35,
                  height: tinggi,
                  alignment: Alignment.centerLeft,
                  margin:
                      EdgeInsets.symmetric(horizontal: marginHorizontal / 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          "https://omahdilit.my.id/images/" +
                              _modelHair.photo1!),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: lebar / 11,
                        margin: EdgeInsets.only(
                            left: marginHorizontal * 6,
                            top: marginVertical / 2),
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
                      Expanded(
                        child: SizedBox(),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: marginHorizontal,
                          vertical: marginVertical / 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.3),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(12),
                          ),
                        ),
                        width: lebar,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_modelHair.namaModel}",
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: tinggi / lebar * 8),
                            ),
                            Text(
                              _modelHair.jenisModel.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                  fontSize: tinggi / lebar * 7),
                            ),
                          ],
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
            child: Container(
              width: lebar / 2.35,
              height: tinggi,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: marginHorizontal / 1.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            baseColor: Colors.grey,
            highlightColor: Colors.grey.shade300,
          );
        }
      },
    );
  }
}
