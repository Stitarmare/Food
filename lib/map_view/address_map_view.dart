import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AddressMapView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddressMapViewState();
  }
}

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(19.018078, 72.830329);
const LatLng DEST_LOCATION = LatLng(19.018952, 72.843176);

class AddressMapViewState extends State<AddressMapView> {
  Completer<GoogleMapController> _controller = Completer();

  // for my drawn routes on the map
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  Set<Marker> _markers = Set<Marker>();
  LatLng moveLagLong;

// for my custom marker pins
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
// the user's initial location and current location
// as it moves
  LocationData currentLocation;
// a reference to the destination location
  LocationData destinationLocation;
  CameraPosition initialCameraPosition;
// wrapper around the location API
  Location location;

  Address add;

//api key
  String googleAPIKey = "AIzaSyDme9kw3nMJil33E11ZdJHkJ-uML1HgDKk";

  @override
  void initState() {
    // TODO: implement initState

    // create an instance of Location
    location = new Location();
    polylinePoints = PolylinePoints();

    initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);
    setLocationChange();
    // set the initial location
    setInitialLocation();
    super.initState();
  }

  setLocationChange() {
// subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location.onLocationChanged.listen((cLoc) async {
      var latLong = LatLng(cLoc.latitude, cLoc.longitude);
      final GoogleMapController controller = await _controller.future;

      setState(() {
        currentLocation = cLoc;

        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            zoom: CAMERA_ZOOM,
            tilt: CAMERA_TILT,
            bearing: CAMERA_BEARING,
            target: latLong)));

        initialCameraPosition = CameraPosition(
            zoom: CAMERA_ZOOM,
            tilt: CAMERA_TILT,
            bearing: CAMERA_BEARING,
            target: latLong);
      });
    });
  }

  void setInitialLocation() async {
    // set the initial location by pulling the user's
    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
    });
    // current location from the location's getLocation()

    currentLocation = await location.getLocation();
  }

  void onCameraMove(CameraPosition cameraPosition) async {
    print("camera move");
    print(
        "${cameraPosition.target.latitude},${cameraPosition.target.longitude}");
    moveLagLong =
        LatLng(cameraPosition.target.latitude, cameraPosition.target.longitude);
    // setState(() {
    //   _markers.removeWhere((m) => m.markerId.value == 'myMarkerAdd');

    //   _markers.add(Marker(
    //       markerId: MarkerId('myMarkerAdd'),
    //       position: LatLng(cameraPosition.target.latitude,
    //           cameraPosition.target.longitude)));
    // });
  }

  void onCameraIdle() async {
    if (moveLagLong != null) {
      final coordinates =
          new Coordinates(moveLagLong.latitude, moveLagLong.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      setState(() {
        add = first;
      });
      print(first.runtimeType);
      print(
          ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
    }
    print("cameraIdeal");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            compassEnabled: true,
            onCameraIdle: onCameraIdle,
            onCameraMove: onCameraMove,
            tiltGesturesEnabled: false,
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              if (destinationLocation != null) {}
            },
          ),
          Image.asset("assets/mappin.png"),
          Align(
              alignment: Alignment.topCenter,
              child: add != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                                ' ${add.locality}, ${add.adminArea},${add.subLocality}, ${add.subAdminArea},${add.addressLine}, ${add.featureName},${add.thoroughfare}, ${add.subThoroughfare}'),
                          )),
                    )
                  : Container())
        ],
      ),
    );
  }
}
