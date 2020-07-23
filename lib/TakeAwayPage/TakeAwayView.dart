import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodzi/BottomTabbar/TakeAwayBottombar.dart';
import 'package:foodzi/LandingPage/LandingView.dart';
import 'package:foodzi/TakeAwayPage/TakeAwayContractor.dart';
import 'package:foodzi/TakeAwayPage/TakeAwayPresenter.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/GeoLocationTracking.dart';
import 'package:foodzi/widgets/SliderPopUp.dart';
import 'package:geolocator/geolocator.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:progress_dialog/progress_dialog.dart';

class TakeAwayView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TakeAwayViewState();
  }
}

class _TakeAwayViewState extends State<TakeAwayView>
    with TickerProviderStateMixin
    implements TakeAwayRestaurantListModelView {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _controller = ScrollController();
  TakeAwayRestaurantPresenter dinerestaurantPresenter;
  List<RestaurantList> _restaurantList;
  int page = 1;

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  StreamController<Position> _controllerPosition = new StreamController();
  bool getttingLocation = false;
  bool locationNotFound = false;
  Position _position;
  String sortedBy = STR_BLANK;
  String filteredBy = STR_BLANK;
  ProgressDialog progressDialog;
  List<BottomItemButton> optionSortBy = [
    BottomItemButton(
      title: STR_DISTANCE,
      id: 1,
      isSelected: false,
    ),
    BottomItemButton(title: STR_POPULARITY, id: 2, isSelected: false),
  ];

  List<BottomItemButton> optionFilterBy = [
    BottomItemButton(title: STR_RATINGS, id: 1, isSelected: false),
    BottomItemButton(title: STR_FAVORITE, id: 2, isSelected: false),
  ];

  int delivery = 0;

  String favourite;
  String rating;
  String sortByDistance = "ASC";
  String sortByRating;
  var sliderValue;
  bool isIgnoreTouch = true;
  bool isBackActive = false;
  bool isLoader = false;

  var sliderval;
  @override
  void initState() {
    isBackActive = false;
    locator();
    _detectScrollPosition();
    dinerestaurantPresenter = TakeAwayRestaurantPresenter(this);
    if (Preference.getPrefValue<int>(PreferenceKeys.takeAwayCartCount) !=
        null) {
      Preference.getPrefValue<int>(PreferenceKeys.takeAwayCartCount)
          .then((value) {
        setState(() {
          Globle().takeAwayCartItemCount = value;
        });
      });
    }
    super.initState();
  }

  @override
  dispose() {
    _controllerPosition.close();
    super.dispose();
  }

  locator() async {
    setState(() {
      getttingLocation = false;
    });
    await GeoLocationTracking.load(context, _controllerPosition);
    _controllerPosition.stream.listen((position) async {
      print(position);
      _position = position;
      if (_position != null) {
        setState(() {
          getttingLocation = true;
          locationNotFound = false;
          isBackActive = true;
        });
        // DialogsIndicator.showLoadingDialog(
        //     context, _keyLoader, STR_PLEASE_WAIT);
        // await progressDialog.show();
        dinerestaurantPresenter.getrestaurantspage(
            _position.latitude.toString(),
            _position.longitude.toString(),
            rating,
            favourite,
            sortByDistance,
            sortByRating,
            page,
            delivery,
            context);
      } else {
        setState(() {
          locationNotFound = true;
          isIgnoreTouch = false;
          isBackActive = true;
          getttingLocation = true;
          // isBackActive = true;
        });
      }
    });
  }

  _detectScrollPosition() {
    _controller.addListener(() async {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
        } else {
          // DialogsIndicator.showLoadingDialog(
          //     context, _keyLoader, STR_PLEASE_WAIT);
          // await progressDialog.show();
          dinerestaurantPresenter.getrestaurantspage(
              _position.latitude.toString(),
              _position.longitude.toString(),
              rating,
              favourite,
              sortByDistance,
              sortByRating,
              page,
              delivery,
              context);
        }
      }
    });
  }

  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: STR_PLEASE_WAIT);
    return WillPopScope(
      onWillPop: () async => isBackActive,
      child: IgnorePointer(
        ignoring: isIgnoreTouch,
        child: Scaffold(
          key: this._scaffoldKey,
          appBar: AppBar(
              brightness: Brightness.dark,
              centerTitle: false,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text(
                STR_COLLECTION,
                style: TextStyle(
                    fontSize: FONTSIZE_18,
                    fontFamily: KEY_FONTFAMILY,
                    fontWeight: FontWeight.w500,
                    color: greytheme1200),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainWidget()),
                      ModalRoute.withName("/MainWidget"));
                },
              ),
              actions: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          FOODZI_LOGO_PATH,
                          height: 30,
                        )),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: Text(
                    //     STR_ORDER_EASY,
                    //     style: TextStyle(
                    //         fontFamily: KEY_FONTFAMILY,
                    //         fontSize: FONTSIZE_6,
                    //         color: greytheme400,
                    //         fontWeight: FontWeight.w700,
                    //         letterSpacing: 1),
                    //   ),
                    // ),
                  ],
                ),
                IconButton(
                  icon: Image.asset(LEVEL_IMAGE_PATH),
                  onPressed: () {
                    if (locationNotFound) {
                      return;
                    }
                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18.0),
                                topRight: Radius.circular(18.0))),
                        builder: (context) {
                          return StatefulBuilder(builder: (BuildContext context,
                              StateSetter setBottomState) {
                            Future<double> getRatingValue() async {
                              var val = await showDialog(
                                  context: context, child: new SliderDialog());

                              return double.parse(val.toString());
                            }

                            void setSelectedSortItem(
                                BottomItemButton bottomItem, List bottomList) {
                              // for (int i = 0; i < bottomList.length; i++) {
                              //   bottomList[i].isSelected = false;
                              // }

                              final tile = bottomList.firstWhere(
                                  (item) => item.id == bottomItem.id,
                                  orElse: null);
                              if (tile != null) {
                                setBottomState(() {
                                  tile.isSelected = !tile.isSelected;
                                  bottomItem.isSelected = tile.isSelected;
                                  if (bottomList == optionFilterBy) {
                                    filteredBy = bottomItem.title;
                                    rating = null;
                                    if (bottomItem.title == STR_RATINGS &&
                                        bottomItem.isSelected == true) {
                                      getRatingValue().then((onValue) {
                                        if (onValue >= 5.0) {
                                          rating = STR_SMALL_RATING +
                                              "${onValue.toString()}";
                                        } else {
                                          rating = STR_SMALL_RATING +
                                              "${onValue.toString()}+";
                                        }

                                        print(sliderValue.toString());
                                      });
                                    } else if (bottomItem.title ==
                                            STR_RATINGS &&
                                        bottomItem.isSelected == false) {
                                      rating = null;
                                    }
                                    if (bottomItem.title ==
                                            "Favourites Only " &&
                                        bottomItem.isSelected == true) {
                                      favourite = "favourite";
                                    } else if (bottomItem.title ==
                                            "Favourites Only " &&
                                        bottomItem.isSelected == false) {
                                      favourite = null;
                                    }
                                  } else {
                                    if (bottomItem.title == "Distance" &&
                                        bottomItem.isSelected == true) {
                                      sortByDistance = "ASC";
                                    } else if (bottomItem.title == "Distance" &&
                                        bottomItem.isSelected == false) {
                                      favourite = null;
                                    }
                                    if (bottomItem.title == "Popularity" &&
                                        bottomItem.isSelected == true) {
                                      sortByRating = "ASC";
                                    } else if (bottomItem.title ==
                                            "Popularity" &&
                                        bottomItem.isSelected == false) {
                                      sortByRating = null;
                                    }
                                  }
                                });
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
                                        ? greentheme400
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                        side: BorderSide(
                                          color: item.isSelected
                                              ? greentheme400
                                              : greytheme600,
                                        )),
                                    onPressed: () =>
                                        setSelectedSortItem(item, bottomList),
                                    child: Text(
                                      item.title,
                                      style: TextStyle(
                                          fontFamily: KEY_FONTFAMILY,
                                          color: item.isSelected
                                              ? Colors.white
                                              : greytheme1000,
                                          fontSize: FONTSIZE_14),
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
                                    bottom: MediaQuery.of(context).size.height *
                                            0.3 -
                                        38,
                                    child: FloatingActionButton(
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                          // DialogsIndicator.showLoadingDialog(
                                          //     context,
                                          //     _keyLoader,
                                          //     STR_PLEASE_WAIT);
                                          //progressDialog.hide();
                                          callOnfilter();
                                        },
                                        child: IconTheme(
                                            data: IconThemeData(
                                                color: greentheme400),
                                            child: Icon(
                                              Icons.check,
                                              size: 45,
                                              color: Colors.white,
                                            ))),
                                  ),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 28),
                                            child: Text(
                                              STR_SORT_BY,
                                              style: TextStyle(
                                                  fontSize: FONTSIZE_16,
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
                                                      _bottomSheetItem(itemSort,
                                                          optionSortBy))
                                                  .toList()),
                                        ),
                                        SizedBox(
                                          height: 10.5,
                                        ),
                                        Divider(),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.5, left: 28),
                                            child: Text(
                                              STR_FLITER_BY,
                                              style: TextStyle(
                                                  fontSize: FONTSIZE_16,
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
                                                        _bottomSheetItem(
                                                            itemFilter,
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
          body: getttingLocation == false
              ? Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          STR_CURRENT_LOCATION,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: FONTSIZE_15,
                              fontFamily: KEY_FONTFAMILY,
                              fontWeight: FontWeight.w500,
                              color: greytheme1200),
                        ),
                      ),
                      // CircularProgressIndicator()

                      SpinKitFadingCircle(
                        color: Globle().colorscode != null
                            ? getColorByHex(Globle().colorscode)
                            : orangetheme300,
                        size: 50.0,
                        controller: AnimationController(
                            vsync: this,
                            duration: const Duration(milliseconds: 1200)),
                      )
                    ],
                  ),
                )
              : locationNotFound
                  ? Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "Please enable location service and try again.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: FONTSIZE_15,
                                  fontFamily: KEY_FONTFAMILY,
                                  fontWeight: FontWeight.w500,
                                  color: greytheme1200),
                            ),
                          ),
                          FlatButton(
                              onPressed: () {
                                locator();
                              },
                              child: Text("Try again"))
                        ],
                      ),
                    )
                  : (_restaurantList != null)
                      ? (_restaurantList.length > 0)
                          ? restaurantsInfo()
                          : Container(
                              child: Center(
                                child: Text(
                                  STR_NO_RESTAURANT,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: FONTSIZE_25,
                                      fontFamily: KEY_FONTFAMILY,
                                      fontWeight: FontWeight.w500,
                                      color: greytheme700),
                                ),
                              ),
                            )
                      : Container(
                          child: Center(
                            child: Text(
                              STR_NO_RESTAURANT,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: FONTSIZE_25,
                                  fontFamily: KEY_FONTFAMILY,
                                  fontWeight: FontWeight.w500,
                                  color: greytheme700),
                            ),
                          ),
                        ),
        ),
      ),
    );
  }

  void callOnfilter() async {
    setState(() {
      page = 1;
      _restaurantList = null;
    });
    await progressDialog.show();
    dinerestaurantPresenter.getrestaurantspage(
        _position.latitude.toString(),
        _position.longitude.toString(),
        rating,
        favourite,
        sortByDistance,
        sortByRating,
        page,
        delivery,
        context);
  }

  int _getint() {
    if (_restaurantList != null) {
      return _restaurantList.length;
    }
    return 0;
  }

  Widget restaurantsInfo() {
    return Stack(children: <Widget>[
      RefreshIndicator(
        onRefresh: _refreshRstaurantList,
        child: ListView.builder(
          controller: _controller,
          itemCount: _getint(),
          itemBuilder: (_, i) {
            return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                elevation: 2,
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 14),
                child: ListTile(
                    contentPadding: EdgeInsets.all(0.0),
                    title: _getMainView(
                      _restaurantList[i].restName,
                      _restaurantList[i].distance,
                      _restaurantList[i].openingTime,
                      _restaurantList[i].closingTime,
                      _restaurantList[i].averageRating.toString(),
                      _restaurantList[i].coverImage,
                    ),
                    onTap: () {
                      Globle().takeAwayCartItemCount = 0;
                      Preference.setPersistData<int>(
                          0, PreferenceKeys.takeAwayCartCount);
                      Globle().colorscode = _restaurantList[i].colourCode;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TakeAwayBottombar(
                                title: _restaurantList[i].restName,
                                restId: _restaurantList[i].id,
                                lat: _restaurantList[i].latitude,
                                long: _restaurantList[i].longitude,
                                imageUrl: _restaurantList[i].coverImage,
                              )));
                      setState(() {});
                    }));
          },
        ),
      ),
      isLoader
          ? SpinKitFadingCircle(
              color: Globle().colorscode != null
                  ? getColorByHex(Globle().colorscode)
                  : orangetheme300,
              size: 50.0,
              controller: AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 1200)),
            )
          : Text("")
    ]);
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
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                imageUrl: BaseUrl.getBaseUrlImages() + '$imageurl',
                errorWidget: (context, url, error) => Image.asset(
                  RESTAURANT_IMAGE_PATH,
                  fit: BoxFit.fill,
                ),
              )),
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
                      fontFamily: Constants.getFontType(),
                      fontSize: FONTSIZE_16,
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
                    "${(shortdatetime == null || shortdatetime == "00:00") ? "- -" : shortdatetime} - ${(cLosingtime == null || cLosingtime == "00:00") ? "- -" : cLosingtime}",
                    style: TextStyle(
                        fontFamily: Constants.getFontType(),
                        fontSize: FONTSIZE_12,
                        fontWeight: FontWeight.w500,
                        color: greytheme100),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 13,
            ),
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
                    color: greentheme400,
                    size: 15,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '$distance ' + STR_KM,
                    style: TextStyle(
                        fontFamily: Constants.getFontType(),
                        fontSize: FONTSIZE_12,
                        fontWeight: FontWeight.w500,
                        color: greytheme100),
                  ),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                decoration: BoxDecoration(
                    color: greentheme400,
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                width: 30,
                height: 16,
                child: Center(
                  child: Text(
                    (rating == STR_NULL) ? "0.0i" : "$rating",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: Constants.getFontType(),
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
  Future<void> restaurantfailed() async {
    setState(() {
      isIgnoreTouch = false;
      isBackActive = true;
    });

    await progressDialog.hide();
  }

  @override
  Future<void> restaurantsuccess(List<RestaurantList> restlist) async {
    setState(() {
      isIgnoreTouch = false;
      isBackActive = true;
    });

    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    // if (restlist.length == 0) {
    //   setState(() {
    //     _restaurantList = null;
    //   });
    //   return;
    // }

    setState(() {
      if (_restaurantList == null) {
        _restaurantList = restlist;
      } else {
        _restaurantList.addAll(restlist);
      }
      page++;
    });
  }
}

class BottomItemButton {
  String title;
  bool isSelected;
  int id;
  BottomItemButton({this.title, this.isSelected, this.id});
}

Future<Null> _refreshRstaurantList() async {}
