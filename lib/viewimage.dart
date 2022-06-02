import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omahdilit/constant.dart';

class ViewImage extends StatefulWidget {
  final String image;
  const ViewImage({Key? key, required this.image}) : super(key: key);

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 21,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: marginVertical,
        ),
        child: CachedNetworkImage(
          imageUrl: "https://omahdilit.site/images/" + widget.image,
          width: lebar,
          height: tinggi,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
