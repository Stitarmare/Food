import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPage/AddItemPageView.dart';
import 'package:foodzi/MenuDropdownCategory/MenuItemDropDown.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';
import 'package:foodzi/RestaurantPage/RestaurantContractor.dart';
import 'package:foodzi/RestaurantPage/RestaurantPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoView.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
//import 'package:foodzi/RestaurantInfoPage/RestaurantInfoView.dart';

//import 'package:foodzi/widgets/MenuItemDropDown.dart';

import 'package:foodzi/theme/colors.dart';
//import 'package:foodzi/widgets/MenuItemDropDown.dart';

import 'package:foodzi/BottomTabbar/BottomTabbarRestaurant.dart';
import 'package:foodzi/widgets/imagewithloader.dart';

class RestaurantView extends StatefulWidget {
  String title;
  int rest_Id;
  String imageUrl;

  int categoryid;
  RestaurantView({this.title, this.rest_Id, this.categoryid, this.imageUrl});
  @override
  State<StatefulWidget> createState() {
    return _RestaurantViewState();
  }
}

class _RestaurantViewState extends State<RestaurantView>
    implements RestaurantModelView {
  RestaurantPresenter restaurantPresenter;

  List<RestaurantMenuItem> _restaurantList;
  int page = 1;
  int restId;
  final GlobalKey<State> _menuKey = new GlobalKey();
  ScrollController _controller = ScrollController();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  bool _switchvalue = false;
  bool isselected = false;
  List<int> _dropdownItemsTable = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  String menutype;
  int _dropdownTableNumber;
  int restaurantId;

  var tableID;
  RestaurantItemsModel restaurantItemsModel;

  var abc;
  @override
  void initState() {
    _detectScrollPosition();
    restaurantPresenter = RestaurantPresenter(this);
    restaurantItemsModel = RestaurantItemsModel();
    //DialogsIndicator.showLoadingDialog(context, _keyLoader, "Loading");
    restaurantPresenter.getMenuList(widget.rest_Id, context,
        category_id: abc, menu: menutype);
    print("image Url-->");
    print(widget.imageUrl);
    super.initState();
  }

  _detectScrollPosition() {
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
          print("Top");
        } else {
          DialogsIndicator.showLoadingDialog(context, _keyLoader, "Loading");
          restaurantPresenter.getMenuList(widget.rest_Id, context,
              category_id: abc, menu: menutype);
          print("Bottom");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.info_outline,
                color: greytheme100,
              ),
              onPressed: () {
                // Navigator.pushNamed(context, '/RestaurantInfoView');
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: context)=>RestaurantInfoView(rest_Id: widget.rest_Id,));

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RestaurantInfoView(
                          rest_Id: widget.rest_Id,
                        )));
              },
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(flex: 2, child: _restaurantLogo()),
            Expanded(
              flex: 7,
              child: CustomScrollView(
                controller: _controller,
                slivers: <Widget>[
                  // _getmainviewTableno(),
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
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
            ),
          ],
        ));
  }

  // Widget getTableNumber() {
  //   return Container(
  //     height: 50,
  //     width: MediaQuery.of(context).size.width * 0.8,
  //     child: FormField(builder: (FormFieldState state) {
  //       return DropdownButtonFormField(
  //         //itemHeight: Constants.getScreenHeight(context) * 0.06,
  //         items: _dropdownItemsTable.map((int tableNumber) {
  //           return new DropdownMenuItem(
  //               value: tableNumber,
  //               child: Row(
  //                 children: <Widget>[
  //                   Container(
  //                       width: MediaQuery.of(context).size.width * 0.4,
  //                       child: Text(
  //                         "Table Number: $tableNumber",
  //                         style: TextStyle(
  //                             decoration: TextDecoration.underline,
  //                             decorationColor:
  //                                 getColorByHex(Globle().colorscode),
  //                             fontSize: 14,
  //                             fontFamily: 'gotham',
  //                             fontWeight: FontWeight.w600,
  //                             color: getColorByHex(Globle().colorscode)),
  //                       )),
  //                 ],
  //               ));
  //         }).toList(),
  //         onChanged: (newValue) {
  //           // do other stuff with _category
  //           setState(() {
  //             _dropdownTableNumber = newValue;
  //             _dropdownItemsTable.forEach((value) {
  //               if (value == newValue) {
  //                 print(value);
  //                 tableID = value;
  //               }
  //             });
  //           });
  //         },

  //         value: _dropdownTableNumber,
  //         decoration: InputDecoration(
  //           contentPadding: EdgeInsets.fromLTRB(10, 0, 5, 0),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(color: greentheme100, width: 2),
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //               borderSide: BorderSide(color: greytheme900, width: 2)),
  //           border:
  //               OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
  //           filled: false,
  //           hintText: 'Choose Table',
  //           // prefixIcon: Icon(
  //           //   Icons.location_on,
  //           //   size: 20,
  //           //   color: greytheme1000,
  //           // ),
  //           labelText: _dropdownTableNumber == null
  //               ? "Add Table Number "
  //               : "Table Number",
  //           // errorText: _errorText,
  //           labelStyle: TextStyle(
  //               decoration: TextDecoration.underline,
  //               decorationColor: Colors.black,
  //               fontSize: 14,
  //               fontFamily: 'gotham',
  //               fontWeight: FontWeight.w600,
  //               color: greytheme100),
  //         ),
  //       );
  //     }),
  //   );
  // }
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
        margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
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
                  // ),
                  // Image.asset('assets/DineInImage/Group1504.png'),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Dine-in',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600,
                        color: ((Globle().colorscode) != null)
                            ? getColorByHex(Globle().colorscode)
                            : orangetheme),
                  )
                ],
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   children: <Widget>[
              //     SizedBox(width: 20),
              //     // Text(
              //     //   'Add Table Number',
              //     //   textAlign: TextAlign.start,
              //     //   style: TextStyle(
              //     //       decoration: TextDecoration.underline,
              //     //       decorationColor: Colors.black,
              //     //       fontSize: 14,
              //     //       fontFamily: 'gotham',
              //     //       fontWeight: FontWeight.w600,
              //     //       color: greytheme100),
              //     // ),
              //     //
              //     getTableNumber(),
              //     //SizedBox(width: 10,),
              //   ],
              // ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getOptionsformenu(BuildContext context) {
    restaurantId = widget.rest_Id;
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
                activeColor: ((Globle().colorscode) != null)
                    ? getColorByHex(Globle().colorscode)
                    : orangetheme,
                onChanged: (bool value) {
                  //  DialogsIndicator.showLoadingDialog(
                  //      context, _keyLoader, "Loading");
                  setState(() {
                    this._switchvalue = value;
                    // menutype = (this._switchvalue == true) ? 'veg':
                    // null;
                    // print(menutype);
                    // restaurantPresenter.getMenuList(
                    //     widget.rest_Id, context,menu:menutype);
                    if (this._switchvalue) {
                      _restaurantList = null;
                      DialogsIndicator.showLoadingDialog(
                          context, _keyLoader, "Loading");
                      menutype = 'veg';
                      restaurantPresenter.getMenuList(widget.rest_Id, context,
                          category_id: abc, menu: menutype);
                    } else {
                      _restaurantList = null;
                      DialogsIndicator.showLoadingDialog(
                          context, _keyLoader, "Loading");
                      menutype = null;
                      restaurantPresenter.getMenuList(widget.rest_Id, context,
                          category_id: abc, menu: menutype);
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
                            ? ((Globle().colorscode) != null)
                                ? getColorByHex(Globle().colorscode)
                                : orangetheme
                            : greytheme100),
                  ),
                  borderSide: (isselected)
                      ? BorderSide(
                          color: ((Globle().colorscode) != null)
                              ? getColorByHex(Globle().colorscode)
                              : orangetheme)
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
                    abc = await showDialog(
                        context: context,
                        child: MenuItem(
                          restaurantId: widget.rest_Id,
                        ),
                        barrierDismissible: true);
                    setState(() {
                      if (isselected == false) {
                        isselected = true;
                      } else {
                        isselected = false;
                      }
                    });
                    if (abc != null) {
                      _restaurantList = null;
                      DialogsIndicator.showLoadingDialog(
                          context, _keyLoader, "Loading");
                      restaurantPresenter.getMenuList(widget.rest_Id, context,
                          category_id: abc, menu: menutype);
                      print(abc);

                      print("abc");
                    }
                    // else {
                    //   Constants.showAlert(
                    //       "No Records", "No items found.", context);
                    // }
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

  Widget _restaurantLogo() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 5),
      child: CachedNetworkImage(
          fit: BoxFit.fill,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          imageUrl: BaseUrl.getBaseUrlImages() + "${widget.imageUrl}",
          errorWidget: (context, url, error) => Image.asset(
                "assets/HotelImages/Image12.png",
                fit: BoxFit.fill,
              )),
    );
  }

  Widget _menuItemList() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 0.85,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddItemPageView(
                          item_id: _restaurantList[index].id,
                          rest_id: _restaurantList[index].restId,
                          title: '${_restaurantList[index].itemName}',
                          description:
                              '${_restaurantList[index].itemDescription}',
                          restName: widget.title,
                          itemImage: '${_restaurantList[index].itemImage}',
                        ))),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.7),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Column(
                      children: <Widget>[
                        LimitedBox(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              heightFactor: 1,
                              // child: Container(
                              //   //height: 150,
                              //   //width: MediaQuery.of(context).size.width,
                              //   decoration: new BoxDecoration(
                              //     image: DecorationImage(
                              //         image: NetworkImage(
                              //           BaseUrl.getBaseUrlImages() +
                              //               '${_restaurantList[index].itemImage}',
                              //         ),
                              //         fit: BoxFit.fitHeight),
                              //   ),
                              // ),
                              // child: ImageWithLoader(
                              //   BaseUrl.getBaseUrlImages() +
                              //       '${_restaurantList[index].itemImage}',
                              //   fit: BoxFit.fitWidth,
                              //   width: double.infinity,
                              //   height: 100,
                              // ),

                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: 100,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/PlaceholderFoodImage/MaskGroup55.png",
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                  height: 100,
                                ),
                                imageUrl: BaseUrl.getBaseUrlImages() +
                                    '${_restaurantList[index].itemImage}',
                              ),
                              // Image.network(
                              //   BaseUrl.getBaseUrlImages() +
                              //       '${_restaurantList[index].itemImage}',
                              //   fit: BoxFit.fitWidth,
                              //   width: double.infinity,
                              //   height: 100,
                              // ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 10, top: 2),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    (_restaurantList[index].menuType == "veg")
                                        ? Image.asset(
                                            'assets/VegIcon/Group1661.png',
                                            //color: greentheme,
                                            width: 14,
                                            height: 14,
                                          )
                                        : Image.asset(
                                            'assets/VegIcon/Group1661.png',
                                            color: redtheme,
                                            width: 14,
                                            height: 14,
                                          ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.36,
                                      child: AutoSizeText(
                                        "${_restaurantList[index].itemName}" ??
                                            " ",
                                        maxLines: 2,
                                        minFontSize: 10,
                                        maxFontSize: 13,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'gotham',
                                            fontWeight: FontWeight.w600,
                                            color: greytheme700),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 5,
                                ),
                                // Expanded(
                                //   flex: 1,
                                //   child: SingleChildScrollView(
                                //     child: AutoSizeText(
                                //       "${_restaurantList[index].itemDescription}" ??
                                //           " ",
                                //       //maxLines: 1,
                                //       style: TextStyle(
                                //         color: greytheme1000,
                                //         fontSize: 10,
                                //         fontFamily: 'gotham',
                                //         fontWeight: FontWeight.w500,
                                //       ),
                                //       // minFontSize: 8,
                                //       //maxFontSize: 5,
                                //       // maxLines: 3,
                                //     ),
                                //   ),
                                // ),
                                AutoSizeText(
                                  "${_restaurantList[index].itemDescription}" ??
                                      " ",
                                  maxLines: 2,
                                  minFontSize: 10,
                                  maxFontSize: 12,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'gotham',
                                      fontWeight: FontWeight.w500,
                                      color: greytheme1000),
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
                                    (_restaurantList[index].sizePrizes.isEmpty)
                                        ? "${restaurantItemsModel.currencyCode} " +
                                                '${_restaurantList[index].price}' ??
                                            ''
                                        : "${restaurantItemsModel.currencyCode} " +
                                                "${_restaurantList[index].sizePrizes[0].price}" ??
                                            "",
                                    style: TextStyle(
                                        //fontFamily: FontNames.gotham,
                                        fontSize: 14,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                        color: ((Globle().colorscode) != null)
                                            ? getColorByHex(Globle().colorscode)
                                            : orangetheme),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: new GestureDetector(
                                  onTap: () {
                                    // if (_dropdownTableNumber == null) {
                                    //   Constants.showAlert(
                                    //       widget.title,
                                    //       "Please select table number first.",
                                    //       context);
                                    // } else {
                                    print("button is Pressed");
                                    print(_restaurantList[index].itemImage);

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddItemPageView(
                                                  item_id:
                                                      _restaurantList[index].id,
                                                  rest_id:
                                                      _restaurantList[index]
                                                          .restId,
                                                  title:
                                                      '${_restaurantList[index].itemName}',
                                                  description:
                                                      '${_restaurantList[index].itemDescription}',
                                                  itemImage:
                                                      '${_restaurantList[index].itemImage}',
                                                )));
                                    //}
                                    //   Globle().colorscode = _restaurantList[index]
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ((Globle().colorscode) != null)
                                            ? getColorByHex(Globle().colorscode)
                                            : orangetheme,
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
                            ],
                          ),
                        ),
                      ],
                    ),
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
  void getMenuListfailed() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  void getMenuListsuccess(List<RestaurantMenuItem> menulist,
      RestaurantItemsModel _restaurantItemsModel1) {
    if (menulist.length == 0) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      return;
    }
    setState(() {
      if (_restaurantList == null) {
        _restaurantList = menulist;
        restaurantItemsModel = _restaurantItemsModel1;
      } else {
        _restaurantList.removeRange(0, (_restaurantList.length));
        _restaurantList.addAll(menulist);
        restaurantItemsModel = _restaurantItemsModel1;
      }

      page++;
    });
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }
//   void _onLoading() {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return Dialog(
//         child: new Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             new CircularProgressIndicator(),
//             new Text("Loading"),
//           ],
//         ),
//       );
//     },
//   );
//   new Future.delayed(new Duration(seconds: 2), () {
//     Navigator.pop(context); //pop dialog
//     print('Loading');
//    // _login();
//   });
// }
}

// class Item {
//   String itemName;
//   String itemCount;
//   Item({this.itemName, this.itemCount});
// }
