import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

class Gmapview extends StatelessWidget {
  double latitude;
  double longtitude;
  String title;
  String description;
  Gmapview({this.latitude, this.longtitude, this.title, this.description});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: mapview(),
      ),
    );
  }

  mapview() async {
    final availableMaps = await MapLauncher.installedMaps;
    print(
        availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    await availableMaps.first.showMarker(
        coords: Coords(latitude, longtitude),
        title: title,
        description: description);
  }
}
