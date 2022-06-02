import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/spotlight.dart';
import 'package:intl/date_symbol_data_local.dart';

class DetailSpotlight extends StatefulWidget {
  final Spotlight spotlight;
  const DetailSpotlight({Key? key, required this.spotlight}) : super(key: key);

  @override
  State<DetailSpotlight> createState() => _DetailSpotlightState();
}

class _DetailSpotlightState extends State<DetailSpotlight> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xffFF4C30),
            size: 21,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: marginHorizontal,
            vertical: marginVertical,
          ),
          child: Column(
            children: [
              Text(
                widget.spotlight.title!,
                style: textStyle.copyWith(
                  fontWeight: bold,
                  fontSize: tinggi / lebar * 10,
                ),
              ),
              SizedBox(
                height: marginVertical,
              ),
              Row(
                children: [
                  Spacer(),
                  Text(DateFormat("EEEE, d MMMM yyyy", 'id').format(
                    DateTime.parse(widget.spotlight.createdAt!),
                  ))
                ],
              ),
              SizedBox(
                height: marginVertical / 2,
              ),
              CachedNetworkImage(
                imageUrl:
                    "https://omahdilit.site/images/" + widget.spotlight.image!,
                width: lebar,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(
                height: marginVertical,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.spotlight.description!,
                  textAlign: TextAlign.justify,
                  style: textStyle.copyWith(
                    fontWeight: medium,
                    fontSize: tinggi / lebar * 7,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
