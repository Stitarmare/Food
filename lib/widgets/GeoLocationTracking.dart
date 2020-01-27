import 'dart:async';

import 'package:geolocator/geolocator.dart';

class GeoLocationTracking {
  Future<void> _load() async {
    await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();

    StreamSubscription<Position> positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
      print(position == null
          ? 'Unknown'
          : position.latitude.toString() +
              ', ' +
              position.longitude.toString());
    });
  }

  @override
  Future<void> _loadingPositionTrack() async {
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
