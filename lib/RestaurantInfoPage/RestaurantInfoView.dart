import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Models/RestaurantInfoModel.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoPresenter.dart';
import 'package:foodzi/Models/GetRestaurantReview.dart';
import 'package:foodzi/Models/WriteRestaurantReview.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/widgets/ExpandedTextWidgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoContractor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:foodzi/RestaurantInfoPage/RatingDailog.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CallService {
  void call(String number) => launch("tel:$number");
}

GetIt locator = GetIt();

void set() {
  locator.registerSingleton(CallService());
}

class RestaurantInfoView extends StatefulWidget {
  int restId;
  RestaurantInfoView({this.restId});

  RestaurantInfoViewState createState() => RestaurantInfoViewState();
}

class RestaurantInfoViewState extends State<RestaurantInfoView>
    implements RestaurantInfoModelView {
  DialogsIndicator dialogs = DialogsIndicator();
  RestaurantInfoPresenter restaurantIdInfoPresenter;
  RestaurantInfoData _restaurantInfoData;
  List<RestaurantReviewList> _getReviewData;
  bool isExpanded = false;
  ProgressDialog progressDialog;
  ScrollController _scrollcontroller;
  List<MenuCategoryButton> menuOptionItem = [
    MenuCategoryButton(title: "Sea Food", id: 1, isSelected: false),
    MenuCategoryButton(title: "Arabic", id: 2, isSelected: false),
    MenuCategoryButton(title: "Indian", id: 3, isSelected: false),
    MenuCategoryButton(title: "Chinese", id: 4, isSelected: false),
  ];

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  bool isRestaurantViewed = true;
  bool isReview = false;
  var _current;
  var isInfoLoaded = false;
  List<Gallary> gallaryImages = [
    Gallary(
        id: 0,
        imagePath: HOTEL_IMAGE_PATH,
        createdAt: "",
        restId: 0,
        updatedAt: ""),
    Gallary(
        id: 0,
        imagePath: RESTAURANT_IMAGE_PATH,
        createdAt: "",
        restId: 0,
        updatedAt: ""),
    Gallary(
        id: 0,
        imagePath: HOTEL_IMAGE_PATH_1,
        createdAt: "",
        restId: 0,
        updatedAt: "")
  ];
  final CallService _service = locator<CallService>();

  @override
  void initState() {
    _scrollcontroller = ScrollController();
    restaurantIdInfoPresenter =
        RestaurantInfoPresenter(restaurantInfoModelView: this);
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    _getRestaurantInfo();

    super.initState();
  }

  _getRestaurantInfo() async {
    //DialogsIndicator.showLoadingDialog(context, _keyLoader, "");
   await  progressDialog.show();
    restaurantIdInfoPresenter.getRestaurantInfoPage(context, widget.restId);
  }

  _getRestaurantReview() async {
    await progressDialog.show();
    //DialogsIndicator.showLoadingDialog(context, _keyLoader, "");
    restaurantIdInfoPresenter.getRestaurantReview(context, widget.restId);
  }

  @override
  Widget build(BuildContext context) {
    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }
      return result;
    }

    Widget imageCarousel = new Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.red),
          height: Constants.getSafeAreaHeight(context) * 0.35,
          width: Constants.getScreenWidth(context),
          child: CarouselSlider(
            autoPlay: true,
            autoPlayAnimationDuration: Duration(microseconds: 10),
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
            viewportFraction: 1.0,
            aspectRatio: 16 / 9,
            height: Constants.getSafeAreaHeight(context) * 0.35,
            items: gallaryImages.map((src) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      height: Constants.getSafeAreaHeight(context) * 0.35,
                      width: Constants.getScreenWidth(context),
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      child: isInfoLoaded
                          ? CachedNetworkImage(
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                  width: 45,
                                  height: 45,
                                  child: Center(
                                      child: CircularProgressIndicator())),
                              imageUrl:
                                  BaseUrl.getBaseUrlImages() + src.imagePath,
                              errorWidget: (context, url, error) => Image.asset(
                                RESTAURANT_IMAGE_PATH,
                                fit: BoxFit.fill,
                              ),
                            )
                          : Image.asset(
                              src.imagePath,
                              fit: BoxFit.cover,
                            ));
                },
              );
            }).toList(),
          ),
        ),
        Positioned(
          top: (Constants.getSafeAreaHeight(context) * 0.25),
          right: Constants.getScreenWidth(context) / 2.3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(
              gallaryImages,
              (index, url) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Colors.white
                          : Color.fromRGBO(255, 255, 255, 0.2)),
                );
              },
            ),
          ),
        )
      ],
    );

    Widget hotelInfo = new Container(
        height: MediaQuery.of(context).size.height * 0.68 + 23,
        child: SingleChildScrollView(
          controller: _scrollcontroller,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: AutoSizeText(
                    getRestName(),
                    maxLines: 2,
                    maxFontSize: FONTSIZE_16,
                    style: TextStyle(
                        color: greytheme700,
                        fontFamily: KEY_FONTFAMILY,
                        fontWeight: FontWeight.w500,
                        fontSize: FONTSIZE_16),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: SizedBox(
                          height: 30,
                          width: 260,
                          child: AutoSizeText(
                            getAddressText(),
                            style: TextStyle(
                              color: greytheme100,
                              fontFamily: KEY_FONTFAMILY,
                            ),
                            maxFontSize: FONTSIZE_14,
                            maxLines: 2,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 10,
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: FlatButton(
                            child: ClipOval(
                              child: Image.asset(
                                NAVIGATE_IMAGE_PATH,
                                color: ((Globle().colorscode) != null)
                                    ? getColorByHex(Globle().colorscode)
                                    : orangetheme,
                                width: 14,
                              ),
                            ),
                            onPressed: () {
                              mapview();
                            },
                          ),
                        ),
                      ),
                    ]),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 49,
                      height: 18,
                      decoration: BoxDecoration(
                          color: greytheme700,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Icon(
                              Icons.star,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4, top: 2, bottom: 2),
                            child: Text(
                              getAverageRating(),
                              style: TextStyle(
                                  fontFamily: KEY_FONTFAMILY,
                                  fontSize: FONTSIZE_10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      '(${getReviewsCount()}+' + STR_REVIEWS + ')',
                      style: TextStyle(
                          fontSize: FONTSIZE_13,
                          fontFamily: KEY_FONTFAMILY,
                          color: greytheme100),
                    )
                  ],
                ),
                SizedBox(
                  height: 17,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _service.call(getContactNumber());
                      },
                      child: Container(
                        height: 33,
                        width: 157,
                        decoration: BoxDecoration(
                            color: ((Globle().colorscode) != null)
                                ? getColorByHex(Globle().colorscode)
                                : orangetheme,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                                width: 32.5,
                                child: Padding(
                                  padding: EdgeInsets.only(),
                                  child: Icon(
                                    Icons.phone,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                )),
                            VerticalDivider(
                              thickness: 2,
                              width: 1,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 7, top: 6, bottom: 5, left: 7),
                              child: Text(
                                getContactNumber(),
                                style: TextStyle(
                                    fontFamily: KEY_FONTFAMILY,
                                    fontSize: FONTSIZE_14,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 22,
                ),
                customTabbar()
              ]),
        ));
    return Scaffold(
      body: _restaurantInfoData == null
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      STR_FETCHING_INFO,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: FONTSIZE_12,
                          fontFamily: KEY_FONTFAMILY,
                          fontWeight: FontWeight.w500,
                          color: greytheme1200),
                    ),
                  ),
                  CircularProgressIndicator()
                ],
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                fit: StackFit.passthrough,
                alignment: AlignmentDirectional.topStart,
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(left: 0, right: 0, top: 0, child: imageCarousel),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FlatButton(
                              child: Image.asset(
                                BACK_BTN_ICON_PATH,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 520,
                              ),
                              flex: 2,
                            ),
                          ],
                        )),
                  ),
                  Positioned(
                    top: Constants.getSafeAreaHeight(context) * 0.3,
                    left: 0,
                    child: Container(
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(40.0),
                              topRight: const Radius.circular(40.0))),
                      height: Constants.getSafeAreaHeight(context) * 0.7,
                      width: Constants.getScreenWidth(context),
                      child: hotelInfo,
                    ),
                  )
                ],
              ),
            ),
    );
  }

  mapview() async {
    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps);

    await availableMaps.first.showMarker(
        coords: Coords(double.parse(_restaurantInfoData.latitude),
            double.parse(_restaurantInfoData.longitude)),
        title: _restaurantInfoData.restName,
        description: _restaurantInfoData.addressLine1);
  }

  Widget menuButton(Categories item) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: RaisedButton(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            item.name,
            style: TextStyle(
              fontFamily: KEY_FONTFAMILY,
              fontSize: FONTSIZE_10,
              color: greytheme1000,
            ),
          ),
        ),
        color: greytheme1100,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              3.0,
            ),
            side: BorderSide(
              color: greytheme1100,
            )),
        onPressed: () {},
      ),
    );
  }

  Widget restaurantInfoList(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, top: 12),
            child: Text(
              STR_OPENING_HOURS,
              style: TextStyle(
                  fontFamily: KEY_FONTFAMILY,
                  fontWeight: FontWeight.w700,
                  fontSize: FONTSIZE_14,
                  color: greytheme700),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          getScheduleLength() == 0
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 60, 8, 8),
                    child: Text(STR_NO_SCHDUL_AVL),
                  ),
                )
              : Container(
                  child: ListView.builder(
                  controller: _scrollcontroller,
                  itemCount: getScheduleLength(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 30.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: Text(
                                    _restaurantInfoData
                                        .schedule[index].dayOfWeek,
                                    style: TextStyle(
                                        fontSize: FONTSIZE_12,
                                        color: greytheme1000),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: 120,
                                  ),
                                  flex: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 24),
                                  child: Text(
                                      '${_restaurantInfoData.schedule[index].fromTime}' +
                                          STR_DASH_SIGN +
                                          '${_restaurantInfoData.schedule[index].toTime}',
                                      style: TextStyle(
                                          fontSize: FONTSIZE_12,
                                          color: greytheme1000)),
                                ),
                              ],
                            ),
                            Divider(
                              height: 2,
                              color: Colors.grey,
                              indent: 20.0,
                              endIndent: 20.0,
                            )
                          ],
                        ));
                  },
                ))
        ],
      ),
    );
  }

  Widget reviewList(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, top: 12),
                child: Text(
                  STR_REVIEWS,
                  style: TextStyle(
                      fontFamily: KEY_FONTFAMILY,
                      fontWeight: FontWeight.w700,
                      fontSize: FONTSIZE_14,
                      color: greytheme700),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 120,
                ),
                flex: 2,
              ),
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(top: 12, right: 20),
                  child: Text(STR_WRITE_REVIEWS,
                      style: TextStyle(
                          fontFamily: KEY_FONTFAMILY,
                          fontWeight: FontWeight.w700,
                          fontSize: FONTSIZE_14,
                          color: ((Globle().colorscode) != null)
                              ? getColorByHex(Globle().colorscode)
                              : orangetheme,
                          decoration: TextDecoration.underline,
                          decorationThickness: 5.0)),
                ),
                onTap: () async {
                  var dailogValue = await showDialog(
                      context: context,
                      barrierDismissible: true,
                      child: MyDialogRating(
                        restId: widget.restId,
                      ));
                  setState(() {
                    if (dailogValue != null) {
                      if (dailogValue == true) {
                        _getRestaurantReview();
                      }
                    }
                  });
                },
              ),
            ],
          ),
          getRestaurantReviewLength() == 0
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(STR_NO_REVIEWS),
                  ),
                )
              : Container(
                  child: ListView.builder(
                  controller: _scrollcontroller,
                  itemCount: getRestaurantReviewLength(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18, top: 10),
                                              child: ClipOval(
                                                child: CachedNetworkImage(
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                    PROFILE_IMAGE_PATH,
                                                    width: 45,
                                                    height: 45,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                    PROFILE_IMAGE_PATH,
                                                    width: 45,
                                                    height: 45,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  imageUrl: BaseUrl
                                                          .getBaseUrlImages() +
                                                      getProfileImage(index),
                                                  height: 45,
                                                  width: 45,
                                                  fit: BoxFit.fill,
                                                ),
                                                //     child: Image.network(
                                                //   BaseUrl.getBaseUrlImages() +
                                                //       getProfileImage(index),
                                                //   height: 45,
                                                //   width: 45,
                                                // )
                                              )),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18, top: 16.5),
                                              child: Text(
                                                  _getReviewData[index]
                                                          .user
                                                          .firstName +
                                                      STR_SPACE +
                                                      _getReviewData[index]
                                                          .user
                                                          .lastName,
                                                  style: TextStyle(
                                                      fontSize: FONTSIZE_13,
                                                      color: greytheme1000,
                                                      fontFamily:
                                                          KEY_FONTFAMILY,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18, top: 8),
                                              child: Container(
                                                width: 39,
                                                height: 18,
                                                decoration: BoxDecoration(
                                                    color: greytheme700,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4))),
                                                child: Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4),
                                                      child: Icon(
                                                        Icons.star,
                                                        size: 10,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4,
                                                              top: 2,
                                                              bottom: 2),
                                                      child: Text(
                                                        _getReviewData[index]
                                                            .rating
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                KEY_FONTFAMILY,
                                                            fontSize:
                                                                FONTSIZE_12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 18, top: 10),
                                                  child: ExpandableText(
                                                      _getReviewData[index]
                                                          .description),
                                                )),
                                            SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        ),
                                      ])),
                              Divider(
                                height: 2,
                                color: Colors.grey,
                                indent: 20.0,
                                endIndent: 20.0,
                              )
                            ]));
                  },
                ))
        ],
      ),
    );
  }

  Widget customTabbar() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          Card(
            borderOnForeground: true,
            elevation: 5.0,
            child: Container(
              constraints: BoxConstraints.expand(height: 40),
              child: TabBar(
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        STR_RESTAURANT_INFO,
                        style:
                            TextStyle(fontFamily: KEY_FONTFAMILY, fontSize: 15),
                      ),
                    ),
                    Tab(
                      child: Text(
                        STR_REVIEWS,
                        style: TextStyle(
                            fontFamily: KEY_FONTFAMILY, fontSize: FONTSIZE_15),
                      ),
                    )
                  ],
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                          color: ((Globle().colorscode) != null)
                              ? getColorByHex(Globle().colorscode)
                              : orangetheme,
                          width: 2),
                      insets: EdgeInsets.symmetric(horizontal: 30)),
                  labelColor: ((Globle().colorscode) != null)
                      ? getColorByHex(Globle().colorscode)
                      : orangetheme,
                  unselectedLabelColor: greytheme1000,
                  onTap: (index) {
                    switch (index) {
                      case 0:
                        setState(() {
                          isRestaurantViewed = true;
                          isReview = false;
                        });

                        break;
                      case 1:
                        setState(() {
                          isRestaurantViewed = false;
                          isReview = true;
                        });
                        break;
                    }
                  }),
            ),
          ),
          isRestaurantViewed
              ? Center(child: Container(child: restaurantInfoList(context)))
              : Center(child: Container(child: reviewList(context))),
        ],
      ),
    );
  }

  @override
  Future<void> restaurantInfoFailed() async {
    //await progressDialog.hide();
  }

  @override
  Future<void> restaurantInfoSuccess(RestaurantInfoData restInfoData) async {
    setState(() {
      if (restInfoData == null) {}
      _restaurantInfoData = restInfoData;
      if (_restaurantInfoData.gallary != null &&
          _restaurantInfoData.gallary.length > 0) {
        gallaryImages = _restaurantInfoData.gallary;
        isInfoLoaded = true;
      }
    });
    _getRestaurantReview();
    //await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  Future<void> getReviewFailed() async {
    await progressDialog.hide();
  }

  @override
  Future<void> getReviewSuccess(
      List<RestaurantReviewList> getReviewList) async {
    setState(() {
      _getReviewData = getReviewList;
      print(_getReviewData);
    });
    await progressDialog.hide();
    // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  void writeReviewFailed() {}

  @override
  void writeReviewSuccess(WriteRestaurantReviewModel writeReview) {}

  String getRestName() {
    if (_restaurantInfoData != null) {
      if (_restaurantInfoData.restName != null) {
        return _restaurantInfoData.restName;
      }
      return STR_BLANK;
    }

    return STR_BLANK;
  }

  String getAddressText() {
    if (_restaurantInfoData != null) {
      return _restaurantInfoData.addressLine1 ??
          STR_BLANK + STR_SPACE + _restaurantInfoData.addressLine2 ??
          STR_BLANK + STR_SPACE + _restaurantInfoData.addressLine3 ??
          STR_BLANK;
    }
    return "";
  }

  int getCategoryLength() {
    if (_restaurantInfoData != null) {
      return _restaurantInfoData.category.length;
    }
    return 0;
  }

  String getAverageRating() {
    if (_restaurantInfoData != null) {
      if (_restaurantInfoData.averageRating != null) {
        return _restaurantInfoData.averageRating.toString();
      }
      return STR_ZERO;
    }
    return STR_ZERO;
  }

  String getReviewsCount() {
    if (_restaurantInfoData != null) {
      if (_restaurantInfoData.reviewsCount != null) {
        return _restaurantInfoData.reviewsCount.toString();
      }
      return STR_ZERO;
    }
    return STR_ZERO;
  }

  String getProfileImage(int index) {
    if (_getReviewData != null) {
      if (_getReviewData[index].user != null) {
        if (_getReviewData[index].user.userDetails != null) {
          if (_getReviewData[index].user.userDetails.profileImage != null) {
            return _getReviewData[index].user.userDetails.profileImage;
          }
          return STR_SPACE;
        }
        return STR_SPACE;
      }
      return STR_SPACE;
    }
    return STR_SPACE;
  }

  String getContactNumber() {
    if (_restaurantInfoData != null) {
      if (_restaurantInfoData.contactNumber != null) {
        return _restaurantInfoData.contactNumber.toString();
      }
      return STR_ZERO;
    }
    return STR_ZERO;
  }

  int getScheduleLength() {
    if (_restaurantInfoData != null) {
      return _restaurantInfoData.schedule.length;
    }
    return 0;
  }

  int getRestaurantReviewLength() {
    if (_getReviewData != null) {
      return _getReviewData.length;
    }
    return 0;
  }
}

class MenuCategoryButton {
  String title;
  bool isSelected;
  int id;
  MenuCategoryButton({this.title, this.isSelected, this.id});
}