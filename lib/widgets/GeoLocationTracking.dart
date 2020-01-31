import 'dart:async';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationTracking {
  static Future<Position> load(BuildContext context) async {
    try {
      await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
      print(position == null
          ? 'Unknown'
          : position.latitude.toString() +
              ', ' +
              position.longitude.toString());
      //if(Po)
      return position;
    });
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
        Constants.showAlert(
            "Access Denied", "Please Allow The Loaction Services On", context);
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
