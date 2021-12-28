import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/listmitra.dart';

class HomeFavorite extends StatefulWidget {
  const HomeFavorite({Key? key}) : super(key: key);

  @override
  _HomeFavoriteState createState() => _HomeFavoriteState();
}

class _HomeFavoriteState extends State<HomeFavorite> {
  var _listMitraFavorite = List<Mitra>.generate(
    10,
    (index) => Mitra(
        id: index,
        name: "Mitra" + index.toString(),
        photo: "favoriteImage.png",
        status: "online"),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _listMitraFavorite.length,
        scrollDirection: Axis.horizontal,
        itemExtent: tinggi / 13,
        padding: EdgeInsets.symmetric(
          vertical: marginVertical,
          horizontal: marginHorizontal,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: marginHorizontal / 4,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/${_listMitraFavorite[index].photo}",
                  ),
                ),
                Text(
                  "${_listMitraFavorite[index].status}",
                ),
              ],
            ),
          );
        });
  }
}
