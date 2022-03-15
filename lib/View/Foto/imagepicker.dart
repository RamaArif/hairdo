import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omahdilit/constant.dart';

class PickImage extends StatefulWidget {
  final double scale;
  const PickImage({Key? key, required this.scale}) : super(key: key);

  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  final cropKey = GlobalKey<CropState>();
  File? _sampleImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _awaitPickImage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(
        horizontal: marginHorizontal,
        vertical: marginVertical,
      ),
      child: _sampleImage != null
          ? Column(
              children: <Widget>[
                Expanded(
                  child: Crop.file(
                    _sampleImage!,
                    key: cropKey,
                    aspectRatio: widget.scale,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: marginVertical,
                  ),
                  alignment: AlignmentDirectional.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          'Crop Image',
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: Colors.white),
                        ),
                        onPressed: () => _cropImage(),
                      ),
                    ],
                  ),
                )
              ],
            )
          : Container(),
    );
  }

  Future<void> _awaitPickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    try {
      final _pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      setState(
        () {
          _sampleImage = File(_pickedFile!.path);
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  _cropImage() async {
    final area = cropKey.currentState!.area;

    if (area == null) {}
    final _imageFile = await ImageCrop.cropImage(
      file: _sampleImage!,
      area: area!,
      scale: widget.scale,
    );

    Navigator.pop(context, _imageFile);
  }
}
