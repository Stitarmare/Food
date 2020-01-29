import 'package:flutter/material.dart';
import 'package:foodzi/BottomTabbar/BottomTabbarRestaurant.dart';
import 'package:foodzi/BottomTabbar/TakeAwayBottombar.dart';
import 'package:foodzi/TakeAwayPage/TakeAwayContractor.dart';
import 'package:foodzi/TakeAwayPage/TakeAwayPresenter.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/GeoLocationTracking.dart';
import 'package:geolocator/geolocator.dart';

import 'package:outline_material_icons/outline_material_icons.dart';

class TakeAwayView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DineViewState();
  }
}

class _DineViewState extends State<TakeAwayView>
    implements TakeAwayRestaurantListModelView {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _controller = ScrollController();
  TakeAwayRestaurantPresenter dinerestaurantPresenter;
  List<RestaurantList> _restaurantList;
  int page = 1;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  Dialogs dialogs = Dialogs();

  //List<bool> _selected = List.generate(20, (i) => false);
  List<BottomItemButton> optionSortBy = [
    BottomItemButton(
      title: "Distance",
      id: 1,
      isSelected: false,
    ),
    BottomItemButton(title: "Ratings 4+", id: 2, isSelected: false),
  ];

  List<BottomItemButton> optionFilterBy = [
    BottomItemButton(title: "Cuisine", id: 1, isSelected: false),
    BottomItemButton(title: "Favourites Only ", id: 2, isSelected: false),
  ];

  @override
  void initState() {
    locator();
    _detectScrollPosition();
    GeoLocationTracking.load();
    // GeoLocationTracking.loadingPositionTrack();
    dinerestaurantPresenter = TakeAwayRestaurantPresenter(this);

    // TODO: implement initState
    super.initState();
  }

  locator() async {
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
        Dialogs.showLoadingDialog(
            context, _keyLoader, "Loading....Please Wait");

        dinerestaurantPresenter.getrestaurantspage(
            "18.579622", "73.738691", "", "", page, context);
        GeoLocationTracking.load();
        GeoLocationTracking.loadingPositionTrack();

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

  _detectScrollPosition() {
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
          print("Top");
        } else {
          dinerestaurantPresenter.getrestaurantspage(
              "18.579622", "73.738691", "", "", page, context);

          print("Bottom");
        }
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            "Take Away",
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'gotham',
                fontWeight: FontWeight.w500,
                color: greytheme1200),
          ),
          actions: <Widget>[
            IconButton(
              icon: Image.asset('assets/LevelsIcon/levels.png'),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18.0),
                            topRight: Radius.circular(18.0))),
                    builder: (context) {
                      return StatefulBuilder(builder: (BuildContext context,
                          StateSetter setBottomState /*You can rename this!*/) {
                        void setSelectedSortItem(
                            BottomItemButton bottomItem, List bottomList) {
                          for (int i = 0; i < bottomList.length; i++) {
                            bottomList[i].isSelected = false;
                          }

                          final tile = bottomList.firstWhere(
                              (item) => item.id == bottomItem.id,
                              orElse: null);
                          if (tile != null) {
                            setBottomState(() => tile.isSelected = true);
                          }
                        }

                        Widget _bottomSheetItem(
                            BottomItemButton item, List bottomList) {
                          return Container(
                            margin: EdgeInsets.only(right: 10),
                            child: SizedBox(
                              height: 29,
                              child: FlatButton(
                                color: item.isSelected
                                    ? greentheme100
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                    side: BorderSide(
                                      color: item.isSelected
                                          ? greentheme100
                                          : greytheme600,
                                    )),
                                onPressed: () =>
                                    setSelectedSortItem(item, bottomList),
                                child: Text(
                                  item.title,
                                  style: TextStyle(
                                      fontFamily: 'gotham',
                                      color: item.isSelected
                                          ? Colors.white
                                          : greytheme1000,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          );
                        }

                        return Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                right: 47,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.3 -
                                        38,
                                child: FloatingActionButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: IconTheme(
                                        data:
                                            IconThemeData(color: greentheme200),
                                        child: Icon(
                                          Icons.check,
                                          size: 45,
                                          color: Colors.white,
                                        ))),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, left: 28),
                                        child: Text(
                                          'Sorted By',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: greytheme700),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 28),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: optionSortBy
                                              .map((itemSort) =>
                                                  _bottomSheetItem(
                                                      itemSort, optionSortBy))
                                              .toList()),
                                    ),
                                    SizedBox(
                                      height: 10.5,
                                    ),
                                    Divider(),
                                    Align(
                                      // padding: EdgeInsets.only(left: 8, top: 10),
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.5, left: 28),
                                        child: Text(
                                          'Filter By',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: greytheme700),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 28),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: optionFilterBy
                                                .map((itemFilter) =>
                                                    _bottomSheetItem(itemFilter,
                                                        optionFilterBy))
                                                .toList())),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              )
                            ],
                            overflow: Overflow.visible,
                          ),
                        );
                      });
                    });
              },
            )
          ]),
      body: ListView.builder(
        controller: _controller,
        itemCount: _getint(),
        itemBuilder: (_, i) {
          return Card(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
                //side: BorderSide(color: Colors.red)
              ),
              elevation: 2,
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 14),
              // color: _selected[i]
              //     ? Colors.blue
              //     : null, // if current item is selected show blue color
              child: ListTile(
                  contentPadding: EdgeInsets.all(0.0),
                  title: _getMainView(
                    _restaurantList[i].restName,
                    _restaurantList[i].longitude,
                    _restaurantList[i].openingTime,
                    _restaurantList[i].closingTime,
                    _restaurantList[i].averageRating.toString(),
                    _restaurantList[i].coverImage,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TakeAwayBottombar(
                              title: "${_restaurantList[i].restName}",
                            )));
                    setState(() {
                      // _selected[i] = !_selected[i];
                    }
                        // reverse bool value
                        );
                  }));
        },
      ),
    );
  }

  int _getint() {
    if (_restaurantList != null) {
      return _restaurantList.length;
    }
    return 0;
  }

  Widget _getMainView(
      String merchantName,
      String distance,
      String shortdatetime,
      String cLosingtime,
      String rating,
      String imageurl) {
    return Column(
      children: <Widget>[
        Card(
          child: Container(
            height: 118,
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(BaseUrl.getBaseUrlImages() + '$imageurl'),
                  fit: BoxFit.fitWidth),
            ),
          ),
        ),
        _getdetails(merchantName, distance, shortdatetime, cLosingtime, rating)
      ],
    );
  }

  Widget _getdetails(String merchantName, String distance, String shortdatetime,
      String cLosingtime, String rating) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 11.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  merchantName,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: 'gotham',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: greytheme700),
                ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    OMIcons.accessTime,
                    color: Colors.green,
                    size: 15,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "${shortdatetime} - ${cLosingtime}",
                    style: TextStyle(
                        fontFamily: 'gotham',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: greytheme100),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 13,
            ),
            // ConstrainedBox(
            //   constraints: new BoxConstraints(
            //     minHeight: 0.0,
            //     maxHeight: 13.0,
            //   ),
            // ),
          ],
        ),
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: greentheme100,
                    size: 15,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${distance} km',
                    style: TextStyle(
                        fontFamily: 'gotham',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: greytheme100),
                  ),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                color: greentheme100,
                width: 30,
                height: 16,
                child: Center(
                  child: Text(
                    rating,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'gotham',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 13,
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  void restaurantfailed() {
    // TODO: implement restaurantfailed
  }

  @override
  void restaurantsuccess(List<RestaurantList> restlist) {
    // TODO: implement restaurantsuccess

    if (restlist.length == 0) {
      return;
    }

    setState(() {
      if (_restaurantList == null) {
        _restaurantList = restlist;
      } else {
        _restaurantList.addAll(restlist);
      }
      page++;
    });
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }
}

class BottomItemButton {
  String title;
  bool isSelected;
  int id;
  BottomItemButton({this.title, this.isSelected, this.id});
}
