import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';
import 'package:foodzi/PaymentTipAndPayDelivery/PaymentDeliveryView.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/map_view/change_address_view.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/AppTextfield.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  String restName;
  int flag;
  int price;
  int restId;
  int userId;
  String orderType;
  int tableId;
  String tablename;
  List<int> items;
  double totalAmount;
  String latitude;
  String longitude;
  List<MenuCartList> itemdata;
  String currencySymbol;
  MapView(
      {this.userId,
      this.price,
      this.items,
      this.restId,
      this.latitude,
      this.tablename,
      this.longitude,
      this.orderType,
      this.tableId,
      this.totalAmount,
      this.currencySymbol,
      this.itemdata,
      this.restName,
      this.flag});
  @override
  State<StatefulWidget> createState() {
    return MapViewState();
  }
}

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION_ADDRESS = LatLng(19.018078, 72.830329);
const LatLng DEST_LOCATION_ADDRESS = LatLng(19.018952, 72.843176);

class MapViewState extends State<MapView> {
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
  Address addressMap;
  String strLocality = "";
  String strAdminArea = "";
  String strSubLOcality = "";
  String strSubAdminArea = "";
  String strAddressLine = "";
  String strFeatureName = "";
  String strThoroughfare = "";
  String strSubThoroughfare = "";
  String strAddress = "";
  String addres = "";
  bool isFormEnabled = true;
  bool enabletv = false;
  String strData = "";
  String landMark = "";
  String homeAddress = "";
  String strLat = "";
  String strLong = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController _bottomSheetController;
  TextEditingController houseTxtEditContrl = TextEditingController();
  TextEditingController landmarkTxtEditContrl = TextEditingController();
  final GlobalKey<FormState> houseLandmarkFormKey = GlobalKey<FormState>();
  bool _validate = false;
//api key
  String googleAPIKey = "AIzaSyDme9kw3nMJil33E11ZdJHkJ-uML1HgDKk";
  @override
  void initState() {
    // create an instance of Location
    location = new Location();
    polylinePoints = PolylinePoints();
    initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION_ADDRESS);
    setLocationChange();
    // set the initial location
    setInitialLocation();
    // set custom marker pins
    // setSourceAndDestinationIcons();
    // _modalBottomSheetMenu();
    // _showBottomSheetCallback();
    super.initState();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icons8-car-48.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icons8-map-pin-16.png');
  }

  setLocationChange() {
// subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location.onLocationChanged.listen((cLoc) async {
      var latLong = LatLng(cLoc.latitude, cLoc.longitude);
      final GoogleMapController controller = await _controller.future;
      if (mounted) {
        setState(() {
          currentLocation = cLoc;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  zoom: CAMERA_ZOOM,
                  tilt: CAMERA_TILT,
                  bearing: CAMERA_BEARING,
                  target: latLong)));
          initialCameraPosition = CameraPosition(
              zoom: CAMERA_ZOOM,
              tilt: CAMERA_TILT,
              bearing: CAMERA_BEARING,
              target: latLong);
          //  updatePinOnMap();
        });
      }
    });
  }

  void setInitialLocation() async {
    // set the initial location by pulling the user's
    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION_ADDRESS.latitude,
      "longitude": DEST_LOCATION_ADDRESS.longitude
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
    strLat = (cameraPosition.target.latitude).toString();
    strLong = (cameraPosition.target.longitude).toString();
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
        addressMap = first;
        // strLocality = first.locality != null ? first.locality : "";
        // strAdminArea = first.adminArea != null ? first.adminArea : "";
        // strSubLOcality = first.subLocality != null ? first.subLocality : "";
        // strSubAdminArea = first.subAdminArea != null ? first.subAdminArea : "";
        // strAddressLine = first.addressLine != null ? first.addressLine : "";
        // strFeatureName = first.featureName != null ? first.featureName : "";
        // strThoroughfare = first.thoroughfare != null ? first.thoroughfare : "";
        // strSubThoroughfare =
        //     first.subThoroughfare != null ? first.subThoroughfare : "";
        // strAddress = strLocality +
        //     "," +
        //     strAdminArea +
        //     "," +
        //     strSubLOcality +
        //     "," +
        //     strSubAdminArea +
        //     "," +
        //     strAddressLine +
        //     "," +
        //     strFeatureName +
        //     "," +
        //     strThoroughfare +
        //     "," +
        //     strSubThoroughfare;
        strAddress = first.addressLine;
        strAddress = removeLastChar(strAddress);
      });
      // if (_bottomSheetController != null) {
      //   _bottomSheetController.setState(() {
      //     addres = strAddress;
      //   });
      // } else {
      //   setState(() {
      //     addres = strAddress;
      //   });
      // }
      // print(
      //     ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
      print(strAddress);
    }
    print("cameraIdeal");
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(STR_ADDRESS_SELECTION),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottom),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: isFormEnabled ? 6 : 8,
                  child: Stack(
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
                            if (destinationLocation != null) {
                              // showPinsOnMap();
                            }
                          },
                          gestureRecognizers: Set()
                            ..add(Factory<PanGestureRecognizer>(
                                () => PanGestureRecognizer()))),
                      Image.asset("assets/MappinImage/mappin.png"),
                      // Align(
                      //     alignment: Alignment.topCenter,
                      //     child: addressMap != null
                      //         ? Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Card(
                      //                 shape: RoundedRectangleBorder(
                      //                     borderRadius: BorderRadius.circular(12.0)),
                      //                 clipBehavior: Clip.antiAliasWithSaveLayer,
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(15.0),
                      //                   child: Text(strAddress),
                      //                 )),
                      //           )
                      //         : Container()),
                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: Container(
                      //     width: 200,
                      //     height: 50,
                      //     child: RaisedButton(
                      //       color: greentheme100,
                      //       child: Text(
                      //         STR_CONFIRM_ADDRESS,
                      //         style: TextStyle(
                      //             fontSize: FONTSIZE_18,
                      //             fontWeight: FontWeight.w700,
                      //             fontFamily: KEY_FONTFAMILY),
                      //       ),
                      //       textColor: Colors.white,
                      //       textTheme: ButtonTextTheme.normal,
                      //       splashColor: Color.fromRGBO(72, 189, 111, 0.80),
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: new BorderRadius.circular(32.0),
                      //           side:
                      //               BorderSide(color: Color.fromRGBO(72, 189, 111, 0.80))),
                      //       onPressed: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => PaymentDeliveryView(
                      //                       flag: 1,
                      //                       restName: widget.restName,
                      //                       restId: widget.restId,
                      //                       userId: widget.userId,
                      //                       items: widget.items,
                      //                       totalAmount: widget.totalAmount,
                      //                       orderType: widget.orderType,
                      //                       latitude: widget.latitude,
                      //                       longitude: widget.longitude,
                      //                       itemdata: widget.itemdata,
                      //                       currencySymbol: widget.currencySymbol,
                      //                       tableId: widget.tableId,
                      //                       addressData: strAddress,
                      //                     )));
                      //       },
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Expanded(
                    flex: isFormEnabled ? 4 : 3,
                    child: Form(
                      key: houseLandmarkFormKey,
                      autovalidate: _validate,
                      child: Container(
                        // height: 360.0,
                        color: Color(0xFF737373),
                        child: new Container(
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(10.0),
                                    topRight: const Radius.circular(10.0))),
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 5, 0),
                                    child: Container(
                                      height: 25,
                                      child: RaisedButton(
                                        color: Colors.grey,
                                        child: Text(
                                          "CHANGE",
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: KEY_FONTFAMILY),
                                        ),
                                        textColor: Colors.white,
                                        textTheme: ButtonTextTheme.normal,
                                        splashColor:
                                            Color.fromRGBO(72, 189, 111, 0.80),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(8.0),
                                        ),
                                        onPressed: () {
                                          // enableField();
                                          Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChangeAddressView()))
                                              .then((value) {
                                            if (value != null) {
                                              setState(() {
                                                strAddress = value["text"];
                                              });
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(strAddress),
                                  ),
                                ),
                                Expanded(child: _addressField()),
                                Expanded(child: _landmarkField()),
                                Expanded(child: _saveandproceedBtn()),
                              ],
                            )),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String removeLastChar(String str) {
    String strData;
    if (str.endsWith(",")) {
      strData = str.substring(0, str.length - 1);
    } else {
      strData = str;
    }
    return strData;
  }

  showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    if (currentLocation != null) {
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);
      // get a LatLng out of the LocationData object
      var destPosition =
          LatLng(destinationLocation.latitude, destinationLocation.longitude);
      // add the initial source location pin
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: pinPosition,
          icon: sourceIcon));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: destPosition,
          icon: destinationIcon));
      setPolylines();
    }
  }

  void setPolylines() async {
    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        currentLocation.latitude,
        currentLocation.longitude,
        destinationLocation.latitude,
        destinationLocation.longitude);
    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {
        _polylines.add(Polyline(
            width: 5, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates));
      });
    }
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);
      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: pinPosition, // updated position
          icon: sourceIcon));
    });
  }

  // enableField() {
  //   // _bottomSheetController.setState(() {
  //   //   isFormEnabled = true;
  //   // });
  //   setState(() {
  //     isFormEnabled = true;
  //   });
  // }
  _showBottomSheetCallback() {
    Future.delayed(Duration(seconds: 0), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _bottomSheetController = _scaffoldKey.currentState
            .showBottomSheet<void>((BuildContext context) {
          return Container(
            height: 360.0,
            color: Color(0xFF737373),
            child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                        child: Container(
                          height: 25,
                          child: RaisedButton(
                            color: Colors.grey,
                            child: Text(
                              "CHANGE",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: KEY_FONTFAMILY),
                            ),
                            textColor: Colors.white,
                            textTheme: ButtonTextTheme.normal,
                            splashColor: Color.fromRGBO(72, 189, 111, 0.80),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                            onPressed: () {
                              // enableField();
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(addres),
                      ),
                    ),
                    _addressField(),
                    _landmarkField(),
                    _saveandproceedBtn(),
                  ],
                )),
          );
        });
      });
    });
  }

  void _closeModalBottomSheet() {
    if (_bottomSheetController != null) {
      _bottomSheetController.close();
      _bottomSheetController = null;
    }
  }

  Widget _addressField() {
    return isFormEnabled
        ? Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: AppTextField(
              // enable: isFormEnabled,
              // inputFormatters: [
              //   LengthLimitingTextInputFormatter(20),
              //   BlacklistingTextInputFormatter(RegExp(STR_INPUTFORMAT))
              // ],
              controller: houseTxtEditContrl,
              onChanged: (text) {
                homeAddress = text;
              },
              keyboardType: TextInputType.text,
              placeHolderName: "House/Flat/Block No",
              validator: validateHouseNo,
              onSaved: (String value) {},
            ),
          )
        : Container();
  }

  Widget _landmarkField() {
    return isFormEnabled
        ? Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: AppTextField(
              // enable: isFormEnabled,
              // inputFormatters: [
              //   LengthLimitingTextInputFormatter(20),
              //   BlacklistingTextInputFormatter(RegExp(STR_INPUTFORMAT))
              // ],
              controller: landmarkTxtEditContrl,
              onChanged: (text) {
                landMark = text;
              },
              keyboardType: TextInputType.text,
              placeHolderName: "Landmark",
              validator: validateLandmark,
              onSaved: (String value) {},
            ),
          )
        : Container();
  }

  Widget _saveandproceedBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Container(
        //   padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        //   height: 50,
        //   width: 120,
        //   child: RaisedButton(
        //     color: greentheme100,
        //     child: Text(
        //       "Save",
        //       style: TextStyle(
        //           fontSize: 16,
        //           color: Colors.white,
        //           fontWeight: FontWeight.w700,
        //           fontFamily: KEY_FONTFAMILY),
        //     ),
        //     textColor: Colors.white,
        //     textTheme: ButtonTextTheme.normal,
        //     splashColor: Color.fromRGBO(72, 189, 111, 0.80),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: new BorderRadius.circular(8.0),
        //     ),
        //     onPressed: () {
        //       saveAddress();
        //       // setState(() {
        //       //   isFormEnabled = false;
        //       // });
        //     },
        //   ),
        // ),
        // SizedBox(width: 20),
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          height: 50,
          width: MediaQuery.of(context).size.width * 0.5,
          child: RaisedButton(
            color: greentheme100,
            child: Text(
              "Proceed",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: KEY_FONTFAMILY),
            ),
            textColor: Colors.white,
            textTheme: ButtonTextTheme.normal,
            splashColor: Color.fromRGBO(72, 189, 111, 0.80),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8.0),
            ),
            onPressed: () {
              proceedBtn();
            },
          ),
        ),
      ],
    );
  }

  saveAddress() {
    if (houseTxtEditContrl.text != "" && landmarkTxtEditContrl.text != "") {
      if (homeAddress != null && landMark != null) {
        // setState(() {
        //   strAddress = homeAddress + ", " + landMark;
        //   print(strAddress);
        // });
      }
    }
  }

  proceedBtn() {
    if (houseLandmarkFormKey.currentState.validate()) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentDeliveryView(
                    flag: 1,
                    restName: widget.restName,
                    restId: widget.restId,
                    userId: widget.userId,
                    // price: int.parse(
                    //     _cartItemList[indx].price),
                    items: widget.items,
                    totalAmount: widget.totalAmount,
                    orderType: widget.orderType,
                    latitude: strLat,
                    longitude: strLong,
                    itemdata: widget.itemdata,
                    currencySymbol: widget.currencySymbol,
                    tableId: widget.tableId,
                    address: strAddress,
                    houseNo: houseTxtEditContrl.text,
                    landmark: landmarkTxtEditContrl.text,
                  )));
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  String validateHouseNo(String value) {
    // String validCharacters = STR_VALIDATE_NAME_TITLE;
    // RegExp regexp = RegExp(validCharacters);
    if (value.isEmpty) {
      return HOUSE_SHOULD_NOT_BE_EMPTY;
    }
    return null;
  }

  String validateLandmark(String value) {
    // String validCharacters = STR_VALIDATE_NAME_TITLE;
    // RegExp regexp = RegExp(validCharacters);
    if (value.isEmpty) {
      return LANDMARK_SHOULD_NOT_BE_EMPTY;
    }
    return null;
  }
}
