import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';

import '../../constant.dart';

class PinLocation extends StatefulWidget {
  final LatLng? latLng;
  const PinLocation({
    Key? key,
    this.latLng,
  }) : super(key: key);

  @override
  _PinLocationState createState() => _PinLocationState();
}

class _PinLocationState extends State<PinLocation> {
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();
  TextEditingController _textController = TextEditingController();

  LatLng currentLatLng = LatLng(-7.2648849, 112.7458897);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.latLng != null) {
      currentLatLng = widget.latLng!;
    }
    _awaitGetCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
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
          "Atur Pin Lokasi",
          style: TextStyle(
            color: Color(0xFF6F6F6F),
            fontSize: tinggi / lebar * 8,
          ),
        ),
      ),
      bottomSheet: Container(
        width: lebar,
        height: tinggi / 15,
        color: blue,
        child: InkWell(
          onTap: () {
            print(currentLatLng.toString());
            Navigator.pop(context, currentLatLng);
          },
          child: Center(
              child: Text(
            "Simpan",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: tinggi / lebar * 7.5),
          )),
        ),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            MapPicker(
              iconWidget: Icon(
                Icons.location_pin,
                color: primary,
                size: tinggi / 20,
              ),
              child: GoogleMap(
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition:
                    CameraPosition(target: currentLatLng, zoom: 15),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onCameraMoveStarted: () {
                  // notify map is moving
                  mapPickerController.mapMoving!();
                  _textController.text = "checking ...";
                },
                onCameraMove: (cameraPosition) {
                  setState(() {
                    currentLatLng = new LatLng(cameraPosition.target.latitude,
                        cameraPosition.target.longitude);
                  });
                },
                onCameraIdle: () async {
                  // notify map stopped moving
                  mapPickerController.mapFinishedMoving!();
                  //get address name from camera position
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                    currentLatLng.latitude,
                    currentLatLng.longitude,
                  );
                  // update the ui with the address
                  _textController.text = placemarks.first.street.toString();
                },
              ),
              mapPickerController: mapPickerController,
            ),
            Positioned(
              bottom: tinggi / 2,
              width: lebar - marginHorizontal * 2,
              height: tinggi / 15,
              child: TextFormField(
                textAlign: TextAlign.center,
                readOnly: true,
                controller: _textController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: marginVertical / 2,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: blue,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: textColor,
                  fontSize: tinggi / lebar * 7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _awaitGetCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Geolocator.getCurrentPosition().then((value) {
      setState(() {
        currentLatLng = new LatLng(value.latitude, value.longitude);
      });
    });
  }
}
