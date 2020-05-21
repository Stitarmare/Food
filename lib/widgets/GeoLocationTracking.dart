import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationTracking {
  static Future<Stream<Position>> load(
      BuildContext context, StreamController<Position> controller) async {
    try {
      var value = await Geolocator().isLocationServiceEnabled();
      print(value);

      if (value) {
        var postion = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        print(postion);
        controller.add(postion);
      } else {
        controller.add(null);
      }
    } on Exception {
      GeolocationStatus geolocationStatus =
          await Geolocator().checkGeolocationPermissionStatus();
      print(geolocationStatus);
      switch (geolocationStatus) {
        case GeolocationStatus.denied:
          Constants.showAlert(STR_ACCESS_DENIED, STR_ENABLE_LOCATION, context);
          break;
        case GeolocationStatus.disabled:
          Constants.showAlert(STR_ACCESS_DENIED, STR_ALLOW_LOCATION, context);
          break;
        case GeolocationStatus.granted:
          break;
        case GeolocationStatus.restricted:
          Constants.showAlert(
              STR_ACCESS_DENIED, STR_ALLOW_LOCATION_SERVICE, context);
          break;
        case GeolocationStatus.unknown:
        default:
          break;
      }
    }
  }

  static Future<void> loadingPositionTrack() async {
    Geolocator()..forceAndroidLocationManager = true;
    await Geolocator().checkGeolocationPermissionStatus();
  }

  Future<void> _loadingPlaceMarkTrack() async {
    await Geolocator().placemarkFromCoordinates(52.2165157, 6.9437819);

    await Geolocator()
        .distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
  }
}
