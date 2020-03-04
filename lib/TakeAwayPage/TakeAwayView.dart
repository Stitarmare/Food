import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/BottomTabbar/BottomTabbarRestaurant.dart';
import 'package:foodzi/BottomTabbar/TakeAwayBottombar.dart';
import 'package:foodzi/TakeAwayPage/TakeAwayContractor.dart';
import 'package:foodzi/TakeAwayPage/TakeAwayPresenter.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/GeoLocationTracking.dart';
import 'package:foodzi/widgets/SliderPopUp.dart';
import 'package:foodzi/widgets/imagewithloader.dart';
import 'package:geolocator/geolocator.dart';

import 'package:outline_material_icons/outline_material_icons.dart';

class TakeAwayView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TakeAwayViewState();
  }
}

class _TakeAwayViewState extends State<TakeAwayView>
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
  Position _position;
  String sortedBy = '';
  String filteredBy = '';
  //List<bool> _selected = List.generate(20, (i) => false);
  List<BottomItemButton> optionSortBy = [
    BottomItemButton(
      title: "Distance",
      id: 1,
      isSelected: false,
    ),
    BottomItemButton(title: "Popularity", id: 2, isSelected: false),
  ];

  List<BottomItemButton> optionFilterBy = [
    BottomItemButton(title: "Ratings", id: 1, isSelected: false),
    BottomItemButton(title: "Favourites Only ", id: 2, isSelected: false),
  ];
  var sliderValue;
  bool isIgnoreTouch = true;
  var sliderval;
  @override
  void initState() {
    locator();
    _detectScrollPosition();
    //GeoLocationTracking.load();
    // GeoLocationTracking.loadingPositionTrack();
    dinerestaurantPresenter = TakeAwayRestaurantPresenter(this);
    if(Preference.getPrefValue<int>(PreferenceKeys.takeAwayCartCount ) != null){
     Preference.getPrefValue<int>(PreferenceKeys.takeAwayCartCount).then((value){
       Globle().takeAwayCartItemCount = value;
    });
    }
    // TODO: implement initState
    super.initState();
  }

  locator() async {
    setState(() {
      getttingLocation = false;
    });
    var strim = await GeoLocationTracking.load(context, _controllerPosition);
    _controllerPosition.stream.listen((position) {
      print(position);
      _position = position;
      if (_position != null) {
        setState(() {
          getttingLocation = true;
        });
        DialogsIndicator.showLoadingDialog(context, _keyLoader, "Please Wait");

        dinerestaurantPresenter.getrestaurantspage(
            _position.latitude.toString(),
            _position.longitude.toString(),
            //"18.579622",
            //"73.738691",
            sortedBy,
            filteredBy,
            page,
            context);
      } else {
        setState(() {
          getttingLocation = false;
        });
      }
    });
  }

  _detectScrollPosition() {
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
          print("Top");
        } else {
          dinerestaurantPresenter.getrestaurantspage(
              _position.latitude.toString(),
              _position.longitude.toString(),
              "",
              "",
              page,
              context);

          print("Bottom");
        }
      }
    });
  }

  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isIgnoreTouch,
      child: Scaffold(
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
                            StateSetter
                                setBottomState /*You can rename this!*/) {
                          Future<double> getRatingValue() async {
                            var val = await showDialog(
                                context: context, child: new SliderDialog());

                            return double.parse(val.toString());
                          }

                          void setSelectedSortItem(
                              BottomItemButton bottomItem, List bottomList) {
                            for (int i = 0; i < bottomList.length; i++) {
                              bottomList[i].isSelected = false;
                            }

                            final tile = bottomList.firstWhere(
                                (item) => item.id == bottomItem.id,
                                orElse: null);
                            if (tile != null) {
                              setBottomState(() {
                                tile.isSelected = true;
                                if (bottomList == optionSortBy) {
                                  sortedBy = bottomItem.title;
                                  if (bottomItem.title == "Distance") {
                                    print('Distance selected');
                                    sortedBy = "distance";
                                  } else {
                                    print('popularity');
                                    sortedBy = "rating";
                                  }
                                }
                                if (bottomList == optionFilterBy) {
                                  filteredBy = bottomItem.title;
                                  if (bottomItem.title == "Ratings") {
                                    getRatingValue().then((onValue) {
                                      filteredBy =
                                          "rating${onValue.toString()}+";
                                      print(sliderValue.toString());
                                    });

                                    //ShowDialogBox
                                    // showDialogBox(context);

                                  }
                                } else {
                                  print('Favourites only');
                                  filteredBy = "favourite";
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
                                        // dinerestaurantPresenter
                                        //     .getrestaurantspage(
                                        //         _position.latitude.toString(),
                                        //         _position.longitude.toString(),
                                        //         sortedBy,
                                        //         filteredBy,
                                        //         page,
                                        //         context);
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                        DialogsIndicator.showLoadingDialog(
                                            context, _keyLoader, "Please Wait");

                                        dinerestaurantPresenter
                                            .getrestaurantspage(
                                                _position.latitude.toString(),
                                                _position.longitude.toString(),
                                                sortedBy,
                                                filteredBy,
                                                page,
                                                context);
                                        // if (_restaurantList.length != null) {
                                        //
                                        // } else {
                                        //   Navigator.of(_keyLoader.currentContext,
                                        //       rootNavigator: true);
                                        // }

                                        //     .pop();
                                      },
                                      child: IconTheme(
                                          data: IconThemeData(
                                              color: greentheme200),
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
                        "Please wait, while Fetching your current location!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'gotham',
                            fontWeight: FontWeight.w500,
                            color: greytheme1200),
                      ),
                    ),
                    CircularProgressIndicator()
                  ],
                ),
              )
            : (_restaurantList != null)
                ? restaurantsInfo()
                : Container(
                    child: Center(
                      child: Text(
                        'No restaurants found.',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'gotham',
                            fontWeight: FontWeight.w500,
                            color: greytheme700),
                      ),
                    ),
                  ),
      ),
    );
  }

  int _getint() {
    if (_restaurantList != null) {
      return _restaurantList.length;
    }
    return 0;
  }

  Widget restaurantsInfo() {
    return RefreshIndicator(
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
                    Globle().colorscode = _restaurantList[i].colourCode;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TakeAwayBottombar(
                              title: _restaurantList[i].restName,
                              rest_Id: _restaurantList[i].id,
                              lat: _restaurantList[i].latitude,
                              long: _restaurantList[i].longitude,
                            )));
                    setState(() {
// selected[i] = !selected[i];
                    }
// reverse bool value
                        );
                  }));
        },
      ),
    );
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
              // decoration: new BoxDecoration(
              //   image: DecorationImage(
              //       image: NetworkImage(BaseUrl.getBaseUrlImages() + '$imageurl'),
              //       fit: BoxFit.fitWidth),
              // ),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                imageUrl: BaseUrl.getBaseUrlImages() + '$imageurl',
                errorWidget: (context, url, error) => Image.asset(
                  "assets/HotelImages/Image12.png",
                  fit: BoxFit.fill,
                ),
              )
              // child: ImageWithLoader(BaseUrl.getBaseUrlImages() + '$imageurl',
              //     fit: BoxFit.fitWidth),
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
                decoration: BoxDecoration(
                    color: greentheme100,
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                width: 30,
                height: 16,
                child: Center(
                  child: Text(
                    (rating != null) ? '4.5' : rating,
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
    isIgnoreTouch = false;
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    if (restlist.length == 0) {
      setState(() {
        _restaurantList = null;
      });
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
  }
}

class BottomItemButton {
  String title;
  bool isSelected;
  int id;
  BottomItemButton({this.title, this.isSelected, this.id});
}
Future<Null> _refreshRstaurantList() async{
    print('refreshing List...');

  }