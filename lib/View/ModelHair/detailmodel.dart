import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/modelhair.dart';
import 'package:omahdilit/model/photohair.dart';

class DetailModel extends StatefulWidget {
  const DetailModel({Key? key, required this.modelHair}) : super(key: key);
  final ModelHair modelHair;
  @override
  _DetailModelState createState() => _DetailModelState();
}

class _DetailModelState extends State<DetailModel> {
  var photo;
  var photoHair;
  @override
  void initState() {
    super.initState();
    photo = [
      widget.modelHair.photo1.toString(),
      widget.modelHair.photo2.toString(),
      widget.modelHair.photo3.toString()
    ];
    photoHair = List<PhotoHair>.generate(
      3,
      (index) => PhotoHair(photo: photo[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            itemBuilder: (context, int index) {
              return InkWell(
                child: Container(),
              );
            },
          )
        ],
      ),
    );
  }
}
