import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPageTA/AddItemPageTAView.dart';
import 'package:foodzi/MenuDropdownCategory/MenuItemDropDown.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoView.dart';
import 'package:foodzi/RestaurantPage/RestaurantContractor.dart';
import 'package:foodzi/RestaurantPage/RestaurantPresenter.dart';
import 'package:foodzi/RestaurantPageTakeAway/RestaurantTAContractor.dart';
import 'package:foodzi/RestaurantPageTakeAway/RestaurantTAPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';

//import 'package:foodzi/widgets/MenuItemDropDown.dart';
import 'package:foodzi/AddItemPage/AddItemPageView.dart';

import 'package:foodzi/theme/colors.dart';
//import 'package:foodzi/widgets/MenuItemDropDown.dart';

import 'package:foodzi/BottomTabbar/BottomTabbarRestaurant.dart';
import 'package:foodzi/widgets/imagewithloader.dart';

class RestaurantTAView extends StatefulWidget {
  String title;
  int rest_Id;
  RestaurantTAView({this.title, this.rest_Id});
  @override
  State<StatefulWidget> createState() {
    return _RestaurantTAViewState();
  }
}

class _RestaurantTAViewState extends State<RestaurantTAView>
    implements RestaurantTAModelView {
  RestaurantTAPresenter restaurantPresenter;
  List<RestaurantMenuItem> _restaurantList;
  int page = 1;
  final GlobalKey _menuKey = new GlobalKey();
  ScrollController _controller = ScrollController();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  bool _switchvalue = false;
  bool isselected = false;
  String menutype;
  @override
  void initState() {
    _detectScrollPosition();
    restaurantPresenter = RestaurantTAPresenter(this);
    restaurantPresenter.getMenuList(widget.rest_Id, context);
    // TODO: implement initState
    super.initState();
  }

  _detectScrollPosition() {
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
          print("Top");
        } else {
          restaurantPresenter.getMenuList(widget.rest_Id, context);
          print("Bottom");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: greytheme100,
            ),
            onPressed: () {
              //  Navigator.pushNamed(context, '/HotelInfoView');
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RestaurantInfoView(
                        // title: "${_restaurantList[i].restName}",
                        rest_Id: widget.rest_Id,
                      )));
            },
          )
        ],
      ),
      body: CustomScrollView(
        controller: _controller,
        slivers: <Widget>[
          _getmainviewTableno(),
          SliverToBoxAdapter(
            child: Container(
              child: SizedBox(
                height: 15,
              ),
            ),
          ),
          _getOptionsformenu(context),
          SliverToBoxAdapter(
            child: Container(
              child: SizedBox(
                height: 15,
              ),
            ),
          ),
          (_restaurantList != null)
              ? _menuItemList()
              : SliverToBoxAdapter(
                  child: Center(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                        ),
                        Text(
                          'No items found.',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'gotham',
                              fontWeight: FontWeight.w500,
                              color: greytheme700),
                        ),
                      ],
                    ),
                  ),
                )),
        ],
      ),
    );
  }

  // Widget _buildMainView() {
  //   return Container(
  //     child: Column(
  //       children: <Widget>[
  //         _getmainviewTableno(),

  //         _getOptionsformenu(),
  //         SliverToBoxAdapter(
  //                     child: Container(
  //             child: SizedBox(
  //               height: 40,
  //             ),
  //           ),
  //         ),
  //         _menuItemList()
  //       ],
  //     ),
  //   );
  // }

  Widget _getmainviewTableno() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'gotham',
                          fontWeight: FontWeight.w600,
                          color: greytheme700),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 2,
                //endIndent: 10,
                //indent: 10,
              ),
              Row(
                children: <Widget>[
                  // SizedBox(
                  //   width: 26,
                  // ),Œ
                  // Image.asset('assets/DineInImage/Group1504.png'),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Take Away',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600,
                        color: getColorByHex(Globle().colorscode)),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // Row(
              //   children: <Widget>[
              //     SizedBox(width: 20),
              //     Text(
              //       'Add Table Number',
              //       textAlign: TextAlign.start,
              //       style: TextStyle(
              //           decoration: TextDecoration.underline,
              //           decorationColor: Colors.black,
              //           fontSize: 14,
              //           fontFamily: 'gotham',
              //           fontWeight: FontWeight.w600,
              //           color: greytheme100),
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getOptionsformenu(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        child: Row(
          children: <Widget>[
            SizedBox(width: 15),
            Text(
              'veg only',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w500,
                  color: greytheme1000),
            ),
            Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                activeColor: getColorByHex(Globle().colorscode),
                onChanged: (bool value) {
                  setState(() {
                    this._switchvalue = value;
                    if (this._switchvalue) {
                      if (_restaurantList != null) {
                        DialogsIndicator.showLoadingDialog(
                            context, _keyLoader, "Loading");
                      } else {
                        Constants.showAlert(
                            "No Records", "No items found.", context);
                      }
                      menutype = 'veg';
                      restaurantPresenter.getMenuList(widget.rest_Id, context,
                          menu: menutype);
                    } else {
                      if (_restaurantList != null) {
                        DialogsIndicator.showLoadingDialog(
                            context, _keyLoader, "Loading");
                      } else {
                        Constants.showAlert(
                            "No Records", "No items found.", context);
                      }
                      menutype = null;
                      restaurantPresenter.getMenuList(widget.rest_Id, context,
                          menu: menutype);
                    }
                  });
                },
                value: this._switchvalue,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.46,
            ),
            SizedBox(
              child: OutlineButton(
                  child: Text(
                    "Menu",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w500,
                        color: (isselected)
                            ? getColorByHex(Globle().colorscode)
                            : greytheme100),
                  ),
                  borderSide: (isselected)
                      ? BorderSide(color: getColorByHex(Globle().colorscode))
                      : BorderSide(color: greytheme100),
                  //borderSide: BorderSide(color:redtheme),
                  onPressed: () async {
                    setState(() {
                      if (isselected == false) {
                        isselected = true;
                      } else {
                        isselected = false;
                      }
                    });
                    var abc = await showDialog(
                        context: context,
                        builder: (_) => MenuItem(
                              restaurantId: widget.rest_Id,
                            ),
                        barrierDismissible: true);
                    setState(() {
                      isselected = false;
                    });
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(12.0),
                  )),
              height: 22,
              width: 65,
            )
          ],
        ),
      ),
    );
  }

  Widget _menuItemList() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.7),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          // bottomLeft: Radius.circular(10.0),
                          //bottomRight: Radius.circular(10.0),
                        ),
                        // child: Align(
                        //   alignment: Alignment.bottomRight,
                        //   heightFactor: 1,
                        //   child: Image.network(
                        //       "https://static.vinepair.com/wp-content/uploads/2017/03/darts-int.jpg"),
                        // ),
                        // child: ImageWithLoader(
                        //     BaseUrl.getBaseUrlImages() +
                        //         '${_restaurantList[index].itemImage}',
                        //     fit: BoxFit.fitWidth,
                        //     width: double.infinity,
                        //     height: 100,
                        //   ),
                        child: Image.network(
                          BaseUrl.getBaseUrlImages() +
                              '${_restaurantList[index].itemImage}',
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                          height: 100,
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                "${_restaurantList[index].itemName}" ?? " ",
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'gotham',
                                    fontWeight: FontWeight.w600,
                                    color: greytheme700),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  child: AutoSizeText(
                                    "${_restaurantList[index].itemDescription}" ??
                                        " ",
                                    //maxLines: 1,
                                    style: TextStyle(
                                      color: greytheme1000,
                                      fontSize: 10,
                                      fontFamily: 'gotham',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    // minFontSize: 8,
                                    //maxFontSize: 5,
                                    // maxLines: 3,
                                  ),
                                ),
                              ),
                              // Text(
                              //   "${_restaurantList[index].itemDescription}" ??
                              //       " ",
                              //   maxLines: 2,
                              //   style: TextStyle(
                              //       fontSize: 10,
                              //       fontFamily: 'gotham',
                              //       fontWeight: FontWeight.w500,
                              //       color: greytheme1000),
                              // ),
                            ]),
                      )),
                      Container(
                        height: MediaQuery.of(context).size.width * 0.09,
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: new BoxDecoration(
                                //color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.grey,
                                    width: 0.7,
                                  ),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Center(
                                child: Text(
                                  '\$ ${_restaurantList[index].price}' ?? "",
                                  style: TextStyle(
                                      //fontFamily: FontNames.gotham,
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(64, 64, 64, 1)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  print("button is Pressed");
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AddItemPageTAView(
                                            item_id: _restaurantList[index].id,
                                            rest_id:
                                                _restaurantList[index].restId,
                                            title:
                                                '${_restaurantList[index].itemName}',
                                            description:
                                                '${_restaurantList[index].itemDescription}',
                                          )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: getColorByHex(Globle().colorscode),
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(12.0),
                                      )),
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  child: Center(
                                    child: Text(
                                      "+ ADD",
                                      style: TextStyle(
                                          //fontFamily: FontNames.gotham,
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            //   new GestureDetector(
                            //         onTap: (){
                            //             print("button is Pressed");
                            //            Navigator.of(context).push(MaterialPageRoute(
                            // builder: (context) => AddItemPageView()
                            //     )
                            //     );
                            //         },
                            //  child:
                            // Expanded(
                            //   //       child: GestureDetector(
                            //   //         onTap: (){
                            //   //             print("button is Pressed");
                            //   //            Navigator.of(context).push(MaterialPageRoute(
                            //   // builder: (context) => AddItemPageView()
                            //   //     )
                            //   //     );
                            //   //         },
                            //   child: FlatButton(
                            //     onPressed: () {
                            //       print("button is Pressed");
                            //       Navigator.of(context).push(MaterialPageRoute(
                            //           builder: (context) => AddItemPageView()));
                            //     },
                            //     child: Container(
                            //       decoration: BoxDecoration(
                            //           color: redtheme,
                            //           borderRadius: BorderRadius.only(
                            //             bottomRight: Radius.circular(12.0),
                            //           )),
                            //       width:
                            //           MediaQuery.of(context).size.width * 0.1,
                            //       child: Center(
                            //         //             child:FlatButton(
                            //         //               onPressed: (){
                            //         //                 print("button is Pressed");
                            //         //                  Navigator.of(context).push(MaterialPageRoute(
                            //         // builder: (context) => AddItemPageView()
                            //         //     )
                            //         //     );
                            //         //               },
                            //         child: Text(
                            //           "+ ADD",
                            //           style: TextStyle(
                            //               //fontFamily: FontNames.gotham,
                            //               fontSize: 14,
                            //               fontStyle: FontStyle.normal,
                            //               fontWeight: FontWeight.w600,
                            //               color: Colors.white),
                            //         ),
                            //         // )
                            //       ),
                            //     ),
                            //   ),
                            //   // ),
                            //   // ),
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }, childCount: _getint()),
    );
  }

  int _getint() {
    if (_restaurantList != null) {
      return _restaurantList.length;
    }
    return 0;
  }

  @override
  void restaurantfailed() {
    // TODO: implement restaurantfailed
  }

  @override
  void restaurantsuccess(List<RestaurantList> restlist) {
    // if (restlist.length == 0) {
    //   return;
    // }

    // setState(() {
    //   if (_restaurantList == null) {
    //     _restaurantList = restlist;
    //   } else {
    //     _restaurantList.addAll(restlist);
    //   }
    //   page++;
    // });
    // TODO: implement restaurantsuccess
  }
  @override
  void getMenuListfailed() {
    // TODO: implement getMenuListfailed
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  void getMenuListsuccess(List<RestaurantMenuItem> menulist) {
    // TODO: implement getMenuListsuccess
    if (menulist.length == 0) {
      return;
    }

    setState(() {
      if (_restaurantList == null) {
        _restaurantList = menulist;
      } else {
        _restaurantList.removeRange(0, (_restaurantList.length));
        _restaurantList.addAll(menulist);
      }
      page++;
    });
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }
}

// class Item {
//   String itemName;
//   String itemCount;
//   Item({this.itemName, this.itemCount});
// }
