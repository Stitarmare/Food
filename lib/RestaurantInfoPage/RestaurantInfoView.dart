import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:foodzi/widgets/imagewithloader.dart';
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

//enum DailogAction { yes, abort }
class CallService{
  void call(String number)=>launch("tel:$number");
}
GetIt locator = GetIt();

void set(){
  locator.registerSingleton(CallService());
}

class RestaurantInfoView extends StatefulWidget {
  int rest_Id;
  RestaurantInfoView({this.rest_Id});

  RestaurantInfoViewState createState() => RestaurantInfoViewState();
}

class RestaurantInfoViewState extends State<RestaurantInfoView>
    implements RestaurantInfoModelView {
  DialogsIndicator dialogs = DialogsIndicator();
  RestaurantInfoPresenter restaurantIdInfoPresenter;
  RestaurantInfoData _restaurantInfoData;
  List<RestaurantReviewList> _getReviewData;
  bool isExpanded = false;
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
        imagePath: "assets/HotelImages/Image31.png",
        createdAt: "",
        restId: 0,
        updatedAt: ""),
        Gallary(
        id: 0,
        imagePath: "assets/HotelImages/Image12.png",
        createdAt: "",
        restId: 0,
        updatedAt: ""),
        Gallary(
        id: 0,
        imagePath: "assets/HotelImages/MaskGroup20.png",
        createdAt: "",
        restId: 0,
        updatedAt: "")
  ];
  final CallService _service = locator<CallService>();

  @override
  void initState() {
    restaurantIdInfoPresenter =
        RestaurantInfoPresenter(restaurantInfoModelView: this);
    _getRestaurantInfo();
    // DialogsIndicator.showLoadingDialog(context, _keyLoader, "");
    
    super.initState();
  }

  _getRestaurantInfo() {
    DialogsIndicator.showLoadingDialog(context, _keyLoader, "");

    restaurantIdInfoPresenter.getRestaurantInfoPage(context, widget.rest_Id);
  }

  _getRestaurantReview() {
    restaurantIdInfoPresenter.getRestaurantReview(context, widget.rest_Id);
  }

// _writeRestaurantReview(){
//   restaurantIdInfoPresenter.writeRestaurantReview(context, widget.rest_Id, _controller.toString(), 3);
// }

  int _rating = 0;
  // TextEditingController _controller;
  final _controller = TextEditingController();

  void rate(int rating) {
    //Other actions based on rating such as api calls.
    setState(() {
      _rating = rating;
    });
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

    Widget image_carousel = new Stack(
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
                      // child: isInfoLoaded ? 
                      // Image.network(BaseUrl.getBaseUrlImages() + src.imagePath,fit: BoxFit.cover,)
                      // // CachedNetworkImage(
                      // //   imageUrl: BaseUrl.getBaseUrlImages() + src.imagePath,
                      // //   fit: BoxFit.cover,
                      // //   //  placeholder: (context, url) => CircularProgressIndicator(),
                      // // ) 
                      // : Image.asset(src.imagePath)
                      // // Image.network(
                      // //   src,
                      // //   fit: BoxFit.cover,
                      // //   )
                      child: isInfoLoaded
                          ? ImageWithLoader(
                              BaseUrl.getBaseUrlImages() + src.imagePath,
                              fit:  BoxFit.cover,
                            )
                          //  Image.network(
                          //     BaseUrl.getBaseUrlImages() + src.imagePath,
                          //     fit: BoxFit.cover,
                          //   )
                            
                          // CachedNetworkImage(
                          //   imageUrl: BaseUrl.getBaseUrlImages() + src.imagePath,
                          //   fit: BoxFit.cover,
                          //   //  placeholder: (context, url) => CircularProgressIndicator(),
                          // )
                          : Image.asset(src.imagePath,fit: BoxFit.cover,)
                      );
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
          child:
           Column(
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
                  // child: Text(
                  //   _restaurantInfoData.restName,
                  //   style: TextStyle(
                  //       color: greytheme700,
                  //       // color: Colors.red,
                  //       fontFamily: 'gotham',
                  //       fontWeight: FontWeight.w500,
                  //       fontSize: 16),
                  // ),
                  child: AutoSizeText(
                    getRestName(),
                    maxLines: 2,
                    maxFontSize: 16,
                    style: TextStyle(
                        color: greytheme700,
                        // color: Colors.red,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
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
                            // 'Via in Arcione 115, 00187 Rome Italy',
                            getAddressText(),
                            style: TextStyle(
                              color: greytheme100,
                              // fontSize: 14,
                              fontFamily: 'gotham',
                            ),
                            // minFontSize: 8,
                            maxFontSize: 14,
                            maxLines: 2,

                            // overflow: Overflow.visible,
                            // overflow: Overflow.visible,
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
                                'assets/NavigateButton/next(2).png',
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
                // SizedBox(
                //   height: 5,
                // ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   margin: EdgeInsets.only(left: 20),
                //   height: 20,
                //   child: new ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     shrinkWrap: true,
                //     physics: const ClampingScrollPhysics(),
                //     itemCount: getCategoryLength(),
                //     itemBuilder: (BuildContext context, int index) {
                //       return menuButton(_restaurantInfoData.category[index]);
                //     },
                //   ),
                // ),
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
                      // color: Colors.black,
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
                              // '_restaurantInfoData.averageRating.toString()',
                              getAverageRating(),
                              style: TextStyle(
                                  fontFamily: 'gotham',
                                  fontSize: 10,
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
                      '(${getReviewsCount()}+ Reviews)',
                      // _restaurantInfoData.reviewsCount.toString(),
                      // "($_restaurantInfoData.reviewsCount.toString())",
                      // _restaurantInfoData.reviewsCount.toString(),
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'gotham',
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
                       onTap: (){
                          _service.call(getContactNumber());
                        },
                           child: Container(
                        height: 33,
                        width: 157,
                        decoration: BoxDecoration(
                            color: redtheme,
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
                            // Divider(thickness: 5,color: Colors.white,),
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
                                // _restaurantInfoData.contactNumber,
                                style: TextStyle(
                                    fontFamily: 'gotham',
                                    fontSize: 14,
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
      body: _restaurantInfoData == null? Container(
        child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text("Please wait while getting Restaurant Info!",textAlign: TextAlign.center,style: TextStyle(
                fontSize: 12,
                fontFamily: 'gotham',
                fontWeight: FontWeight.w500,
                color: greytheme1200),),
                  ),
                  CircularProgressIndicator()
                ],
              ),
      ): Container(
        // height: Constants.getSafeAreaHeight(context) * 0.35,
        //             width: Constants.getScreenWidth(context),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.passthrough,
          alignment: AlignmentDirectional.topStart,
          // fit: StackFit.expand,
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(left: 0, right: 0, top: 0, child: image_carousel),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Container(
                   margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                    child: Image.asset('assets/BackButtonIcon/Path1621.png',color: Colors.black,),
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
              )

                  // )
                  ),
            ),
            // Positioned(
            //   left: 3.0,
            //   top: 21.0,
            //   child: FlatButton(
            //     child:
            //         Image.asset('assets/BackButtonIcon/Path1621.png'),
            //     onPressed: () {
            //       Navigator.pop(context);
            //     },
            //   ),
            // ),
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
    print(
        availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

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
            // item.title,
            style: TextStyle(
              fontFamily: 'gotham',
              fontSize: 10,
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

      // ),
    );
  }

  Widget RestaurantInfoList(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, top: 12),
            child: Text(
              'Opening Hours',
              style: TextStyle(
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: greytheme700),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          getScheduleLength() ==0? Center(
            child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 60, 8, 8),
            child: Text('No Schedule Available'),
          ),
          ):Container(
              // height: 150,
              child: ListView.builder(
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
                              _restaurantInfoData.schedule[index].dayOfWeek,
                              style:
                                  TextStyle(fontSize: 12, color: greytheme1000),
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
                                '${_restaurantInfoData.schedule[index].fromTime} - ${_restaurantInfoData.schedule[index].toTime}',
                                style: TextStyle(
                                    fontSize: 12, color: greytheme1000)),
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

  Widget ReviewList(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // widget(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, top: 12),
                child: Text(
                  'Reviews',
                  style: TextStyle(
                      fontFamily: 'gotham',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
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
                  child: Text('Write Review',
                      style: TextStyle(
                          fontFamily: 'gotham',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: redtheme,
                          decoration: TextDecoration.underline,
                          decorationThickness: 5.0
                          // decorationStyle: TextDecorationStyle.solid,
                          )),
                ),
                onTap: () async {
                  var dailogValue = await showDialog(
                      context: context,
                      barrierDismissible: true,
                      child: MyDialogRating(
                        rest_id: widget.rest_Id,
                      ));
                  setState(() {
                    print("success");
                    if (dailogValue != null) {
                      if (dailogValue == true) {
                        _getRestaurantReview();
                      }
                    }
                  });

                  // await reviewPopup(context);
                },
              ),
            ],
          ),
          // ),
          //
          getRestaurantReviewLength()
           ==0 ? Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('No Reviews'),
          ),):
          Container(
              // height: MediaQuery.of(context).size.height * 0.35,
              child: ListView.builder(
                // itemCount: _restaurantInfoData.reviews.length,
                itemCount: getRestaurantReviewLength(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      // height: 105,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18, top: 10),
                                      child: ClipOval(
                                        child:
                                            //                    CachedNetworkImage(
                                            //   imageUrl: BaseUrl.getBaseUrlImages() + _getReviewData.reviews[index].user.userDetails,
                                            //   fit: BoxFit.cover,
                                            //   //  placeholder: (context, url) => CircularProgressIndicator(),
                                            // )
                                        //     Image.asset(
                                        //   'assets/ProfileImage/MaskGroup15.png',
                                        //   height: 45,
                                        //   width: 45,
                                        // ),
                                        Image.network(BaseUrl.getBaseUrlImages() + getProfileImage(index),height: 45,width: 45,)
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
                                              _getReviewData[index].user
                                                      .firstName +
                                                  " " +
                                                  _getReviewData[index]
                                                      .user.lastName,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: greytheme1000,
                                                  fontFamily: 'gotham',
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18, top: 8),
                                          child: Container(
                                            width: 39,
                                            height: 18,
                                            // color: Colors.black,
                                            decoration: BoxDecoration(
                                                color: greytheme700,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4))),

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
                                              padding: const EdgeInsets.only(
                                                  left: 4, top: 2, bottom: 2),
                                              child: Text(
                                                _getReviewData[index].rating
                                                // _getReviewData
                                                //     .reviews[index].rating
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'gotham',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
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
                                          padding: const EdgeInsets.only(
                                              left: 18, top: 10),
                                          child: ExpandableText(_getReviewData[index].description
                                              // 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Lorem Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem.',
                                              // maxLines: 5,)
                                              ),
                                        )),
                                    SizedBox(

                                      height: 10,
                                    )
                                  ],
                                ),
                             // ),
                             
                          //   ],
                          // )
                              ]
                              )
                              ),

 Divider(
                                height: 2,
                                color: Colors.grey,
                                indent: 20.0,
                                endIndent: 20.0,
                              )



                              ]
                              ));
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
                        'Restaurants Info',
                        style: TextStyle(fontFamily: 'gotham', fontSize: 15),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Review',
                        style: TextStyle(
                          fontFamily: 'gotham',
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: redtheme, width: 2),
                      insets: EdgeInsets.symmetric(horizontal: 30)),
                  labelColor: redtheme,
                  unselectedLabelColor: greytheme1000,
                  onTap: (index) {
                    switch (index) {
                      case 0:
                        print('Restaurants Info');
                        setState(() {
                          isRestaurantViewed = true;
                          isReview = false;
                        });

                        break;
                      case 1:
                        print('Review');
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
              ? Center(child: Container(child: RestaurantInfoList(context)))
              : Center(child: Container(child: ReviewList(context))),
        ],
      ),
    );
  }
  @override
  void restaurantInfoFailed() {
    // TODO: implement restaurantInfoFailed
  }

  @override
  void restaurantInfoSuccess(RestaurantInfoData restInfoData) {
    setState(() {
      if (restInfoData == null) {
        // Dialogs.showLoadingDialog(context, _keyLoader, "");
        //CircularProgressIndicator();
      }
      _restaurantInfoData = restInfoData;
      if (_restaurantInfoData.gallary != null &&
          _restaurantInfoData.gallary.length > 0) {
        gallaryImages = _restaurantInfoData.gallary;
        isInfoLoaded = true;
      }
      //print(_restaurantInfoData.restName);
      // print(_restaurantInfoData.schedule);
      // _restaurantInfoData = restInfoData;
      // _restInfoData = restInfoData;
    });
    _getRestaurantReview();
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    // TODO: implement restaurantInfoSuccess
  }

  @override
  void getReviewFailed() {
    // TODO: implement getReviewFailed
  }

  @override
  void getReviewSuccess( List<RestaurantReviewList> getReviewList) {
    // TODO: implement getReviewSuccess
    setState(() {
      _getReviewData = getReviewList;
      print(_getReviewData);
    });
  }

  @override
  void writeReviewFailed() {
    // TODO: implement writeReviewFailed
  }

  @override
  void writeReviewSuccess(WriteRestaurantReviewModel writeReview) {
    // TODO: implement writeReviewSuccess
    print('Review Success');
  }

  String getRestName() {
    if (_restaurantInfoData != null) {
      if (_restaurantInfoData.restName != null) {
        return _restaurantInfoData.restName;
      }
      return "";
    }

    return "";
  }

  String getAddressText() {
    if (_restaurantInfoData != null) {
      return _restaurantInfoData.addressLine1 ??
          "" + " " + _restaurantInfoData.addressLine2 ??
          "" + " " + _restaurantInfoData.addressLine3 ??
          "";
    }
    return "";
    // 'Via in Arcione 115, 00187 Rome Italy',
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
      return "0";
    }
    return "0";
  }

  String getReviewsCount() {
    if (_restaurantInfoData != null) {
      if (_restaurantInfoData.reviewsCount != null) {
        return _restaurantInfoData.reviewsCount.toString();
      }
      return "0";
    }
    return "0";
  }
// _getReviewData[index].user.userDetails.profileImage
  String getProfileImage(int index){
    if(_getReviewData !=null){
      if(_getReviewData[index].user!=null){
        if(_getReviewData[index].user.userDetails!=null){
          if(_getReviewData[index].user.userDetails.profileImage!=null){
            return _getReviewData[index].user.userDetails.profileImage;
          }
          return " ";
        }
        return " ";
      }
      return " ";
    }
    return " ";
  }

  String getContactNumber() {
    if (_restaurantInfoData != null) {
      if (_restaurantInfoData.contactNumber != null) {
        return _restaurantInfoData.contactNumber.toString();
      }
      return "0";
    }
    return "0";
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