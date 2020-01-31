import 'dart:async';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationTracking {
  static Future<Stream<Position>> load(
      BuildContext context, StreamController<Position> controller) async {
    try {
      var postion = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(postion);
      controller.add(postion);
    } on Exception {
      GeolocationStatus geolocationStatus =
          await Geolocator().checkGeolocationPermissionStatus();
      print(geolocationStatus);
      switch (geolocationStatus) {
        case GeolocationStatus.denied:
          Constants.showAlert("Access Denied",
              "Please Allow The Loaction Service Enabled To Get Info", context);
          break;
        case GeolocationStatus.disabled:
          Constants.showAlert("Access Denied",
              "Please Allow The Loaction Services On", context);
          break;
        case GeolocationStatus.granted:

          //Dialogs.showLoadingDialog(context, _keyLoader, "");
          break;
        case GeolocationStatus.restricted:
          Constants.showAlert("Access Denied",
              "Please Allow The Loaction Service Enabled To Get Info", context);
          break;
        case GeolocationStatus.unknown:
        default:
          break;
      }
    }
  }

  //@override
  static Future<void> loadingPositionTrack() async {
    Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();
  }

  Future<void> _loadingPlaceMarkTrack() async {
    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(52.2165157, 6.9437819);

    double distanceInMeters = await Geolocator()
        .distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
  }
}
