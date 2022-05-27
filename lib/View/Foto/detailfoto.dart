import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:omahdilit/constant.dart';
import 'package:omahdilit/model/review.dart';

class DetailFoto extends StatefulWidget {
  final List<ImageReview>? imageReview;
  final String? image;
  final bool isSingle;
  const DetailFoto(
      {Key? key, this.imageReview, this.image, required this.isSingle})
      : super(key: key);

  @override
  State<DetailFoto> createState() => _DetailFotoState();
}

class _DetailFotoState extends State<DetailFoto> {
  String? _imageUrl;
  List<ImageReview>? _imageReview;
  bool _isSingle = false;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.isSingle) {
      _imageUrl = widget.image;
    } else {
      _imageReview = widget.imageReview;
    }
    _isSingle = widget.isSingle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: lebar,
      height: tinggi,
      color: Colors.black,
      alignment: Alignment.center,
      child: !_isSingle
          ? Swiper(
              loop: false,
              itemBuilder: (BuildContext context, int index) {
                print(_imageReview![index].name!);
                return ExtendedImage.network(
                  "https://omahdilit.site/images/" + _imageReview![index].name!,
                  fit: BoxFit.fitWidth,
                  cache: true,
                  mode: ExtendedImageMode.gesture,
                  initGestureConfigHandler: (state) {
                    return GestureConfig(
                      minScale: 0.7,
                      animationMinScale: 0.7,
                      maxScale: 3.0,
                      animationMaxScale: 3.5,
                      speed: 1.0,
                      inertialSpeed: 100.0,
                      initialScale: 1,
                      inPageView: true,
                      initialAlignment: InitialAlignment.center,
                    );
                  },
                );
              },
              itemCount: _imageReview!.length,
              pagination: new SwiperPagination(
                margin: new EdgeInsets.symmetric(
                  horizontal: marginHorizontal,
                  vertical: marginVertical,
                ),
                builder: new SwiperCustomPagination(
                  builder: (BuildContext context, SwiperPluginConfig config) {
                    return new ConstrainedBox(
                      child: new Container(
                          child: new Text(
                        "${config.activeIndex + 1} / ${config.itemCount}",
                        style: new TextStyle(
                          fontSize: tinggi / lebar * 8,
                          color: Colors.white,
                        ),
                      )),
                      constraints:
                          new BoxConstraints.expand(height: marginVertical),
                    );
                  },
                ),
              ),
            )
          : CachedNetworkImage(imageUrl: _imageUrl!),
    );
  }
}
