import 'package:auto_size_text/auto_size_text.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPageDelivery/AddItemPageDeliveryView.dart';
import 'package:foodzi/BottomTabbar/BottomTabbar.dart';
import 'package:foodzi/MenuDropdownCategory/MenuItemDropDownContractor.dart';
import 'package:foodzi/MenuDropdownCategory/MenuItemDropDownPresenter.dart';
import 'package:foodzi/Models/CategoryListModel.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoView.dart';
import 'package:foodzi/RestaurantPageDelivery/RestaurantDeliveryContractor.dart';
import 'package:foodzi/RestaurantPageDelivery/RestaurantDeliveryPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RestaurantDeliveryView extends StatefulWidget {
  String title;
  int restId;
  String imageUrl;
  bool isFromOrder = false;
  int categoryid;
  String lat;
  String long;
  RestaurantDeliveryView(
      {this.title,
      this.restId,
      this.categoryid,
      this.imageUrl,
      this.lat,
      this.long,
      this.isFromOrder});
  @override
  State<StatefulWidget> createState() {
    return _RestaurantDeliveryViewState();
  }
}

class _RestaurantDeliveryViewState extends State<RestaurantDeliveryView>
    implements RestaurantDeliveryModelView, MenuDropdownModelView {
  RestaurantDeliveryPresenter restaurantDeliveryPresenter;
  List<RestaurantMenuItem> _restaurantList;
  int page = 1;
  int restId;
  ScrollController _controller = ScrollController();
  // final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  bool _switchvalue = false;
  bool isselected = false;
  ProgressDialog progressDialog;
  MenuDropdpwnPresenter menudropdownPresenter;
  List<CategoryItems> _categorydata;
  String menutype = " ";
  int restaurantId;
  int _selectedMenu = 0;
  int previousValue;
  int _selectedSubMenu = 0;
  var tableID;
  bool valueBool = false;
  RestaurantItemsModel restaurantItemsModel;
  List<Category> category = [];
  List<Category> category2 = [];
  List<Subcategories> subcategories = [];
  List<Subcategories> subcategoriesList = [];
  List<Subcategories> subcategoriesList2 = [];
  bool isLoading = false;

  var abc;
  var subCategoryIdabc;
  @override
  void initState() {
    _detectScrollPosition();
    if (widget.isFromOrder == null) {
      setState(() {
        widget.isFromOrder = false;
        isLoading = true;
      });
    }
    restaurantDeliveryPresenter = RestaurantDeliveryPresenter(this);
    restaurantItemsModel = RestaurantItemsModel();

    // restaurantDeliveryPresenter.getMenuList(widget.restId, context,
    //     categoryId: abc, menu: menutype);
    print(widget.imageUrl);
    menudropdownPresenter = MenuDropdpwnPresenter(this);
    menudropdownPresenter.getMenuCategoryList(widget.restId, context, true);
    Preference.getPrefValue<int>("deliveryCategory").then((value) {
      if (value != null) {
        setState(() {
          _selectedMenu = value;
        });
      }
    });
    Preference.getPrefValue<int>("deliverySubCateId").then((value) {
      if (value != null) {
        setState(() {
          _selectedSubMenu = value;
        });
      }
    });
    super.initState();
  }

  _detectScrollPosition() {
    _controller.addListener(() async {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
        } else {
          await progressDialog.show();
          // DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_LOADING);
          restaurantDeliveryPresenter.getMenuList(widget.restId, context,
              categoryId: abc, menu: menutype, page: page);
        }
      }
    });
  }

  _onSelected(index) {
    setState(() {
      _selectedMenu = index;
      Preference.setPersistData<int>(_selectedMenu, "deliveryCategory");

      if (_selectedMenu == index) {
        if (category2[index].subcategories != null) {
          if (category2[index].subcategories.length > 0) {
            setState(() {
              valueBool = true;
              subcategoriesList = category2[index].subcategories;
              // subcategories = [];
              subcategoriesList2 = [];
              _selectedSubMenu = null;
              // _getSubMenucount();
            });
          } else {
            setState(() {
              valueBool = false;
              subcategoriesList = [];
            });
          }
        } else {
          setState(() {
            valueBool = false;
            subcategoriesList = [];
          });
        }
      }
      // for All as category
      // if (_selectedMenu == index) {
      //   if (category[index].subcategories != null) {
      //     if (category[index].subcategories.length > 0) {
      //       setState(() {
      //         valueBool = true;
      //         subcategoriesList = category[index].subcategories;
      //         subcategories = [];
      //         subcategoriesList2 = [];
      //         _selectedSubMenu = 0;
      //         // _getSubMenucount();
      //       });
      //     } else {
      //       setState(() {
      //         valueBool = false;
      //         subcategoriesList = [];
      //       });
      //     }
      //   } else {
      //     setState(() {
      //       valueBool = false;
      //       subcategoriesList = [];
      //     });
      //   }
      // }

      if (previousValue != null) {
        if (previousValue != _selectedMenu) {
          subCategoryIdabc = null;
          _selectedSubMenu = null;
          previousValue = _selectedMenu;
        }
      } else {
        previousValue = _selectedMenu;
      }

      print(_selectedMenu);
    });
    abc = category2[index].id;
    if (abc != null) {
      _selectedSubMenu = null;
      callItemOnCategorySelect();
    } else {
      abc = null;
      callItemOnCategorySelect();
    }
  }

  _onSubMenuSelected(index) {
    setState(() {
      _selectedSubMenu = index;
      Preference.setPersistData<int>(_selectedSubMenu, "deliverySubCateId");

      subCategoryIdabc =
          category2[_selectedMenu].subcategories[_selectedSubMenu].id;

      // if (index == 0) {
      //   _selectedSubMenu = index;
      //   subCategoryIdabc = null;
      // } else {
      //   _selectedSubMenu = index - 1;
      //   subCategoryIdabc =
      //       category2[_selectedMenu].subcategories[_selectedSubMenu].id;
      // }

      print(_selectedSubMenu);
    });

    if (subCategoryIdabc != null) {
      callItemOnCategorySelect();
      _selectedSubMenu = index;
    } else {
      subCategoryIdabc = null;
      callItemOnCategorySelect();
      _selectedSubMenu = index;
    }
    // abc = _categorydata[index].id;
    // if (abc != null) {
    //   callItemOnCategorySelect();
    // } else {
    //   abc = null;
    //   callItemOnCategorySelect();
    // }
  }

  callItemOnCategorySelect() async {
    print("CategoryId " + abc.toString());
    print("SubCategoryId " + subCategoryIdabc.toString());
    _restaurantList = null;
    await progressDialog.show();
    restaurantDeliveryPresenter.getMenuList(widget.restId, context,
        categoryId: abc, subCategoryId: subCategoryIdabc, menu: menutype);
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: STR_LOADING);
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child:
                // Align(
                //         alignment: Alignment.center,
                //         child: Image.asset(
                //           FOODZI_LOGO_PATH,
                //           height: 50,
                //         )),
                CachedNetworkImage(
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              imageUrl: BaseUrl.getBaseUrlImages() +
                  "${restaurantItemsModel.restLogo}",
              height: 50,
              // width: MediaQuery.of(context).size.width * 5,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Image.asset(
                RESTAURANT_IMAGE_PATH,
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              ),
            ),
          ),
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomTabbar(
                            tabValue: 0,
                            flag: 1,
                          )),
                  ModalRoute.withName("/BottomTabbar"));
            },
          ),
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //           Align(
                //               alignment: Alignment.centerRight,
                //               child: CachedNetworkImage(
                // placeholder: (context, url) =>
                //     Center(child: CircularProgressIndicator()),
                // imageUrl: BaseUrl.getBaseUrlImages() + "${restaurantItemsModel.restImage}",
                // errorWidget: (context, url, error) => Image.asset(
                //   RESTAURANT_IMAGE_PATH,
                //   fit: BoxFit.fill,
                // ),
                // ),
                //       )
                //  Align(
                //   alignment: Alignment.center,
                //   child: Image.asset(
                //     FOODZI_LOGO_PATH,
                //     height: 30,
                //   )),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Text(
                //     STR_ORDER_EASY,
                //     style: TextStyle(
                //         fontFamily: Constants.getFontType(),
                //         fontSize: FONTSIZE_6,
                //         color: greytheme400,
                //         fontWeight: FontWeight.w700,
                //         letterSpacing: 1),
                //   ),
                // ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.info_outline,
                color: greytheme100,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RestaurantInfoView(
                          restId: widget.restId,
                        )));
              },
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Expanded(flex: 1, child: _restaurantLogo()),
            Expanded(
                child: Column(children: <Widget>[
              _getMenuListHorizontal(context),
              _getSubMenuListHorizontal(context),
            ])),
            Expanded(
              flex: 7,
              child: CustomScrollView(
                controller: _controller,
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      child: SizedBox(
                        height: 0,
                      ),
                    ),
                  ),
                  // _getMenuListHorizontal(context),
                  // _getSubMenuListHorizontal(context),
                  // // _getOptionsformenu(context),
                  // SliverToBoxAdapter(
                  //   child: Container(
                  //     child: SizedBox(
                  //       height: 15,
                  //     ),
                  //   ),
                  // ),
                  (_restaurantList != null)
                      ? _menuItemList()
                      : isLoading
                          ? SliverToBoxAdapter(
                              child: Center(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                    ),
                                    CircularProgressIndicator(),
                                    // Text(
                                    //   STR_NO_ITEM_FOUND,
                                    //   textAlign: TextAlign.start,
                                    //   style: TextStyle(
                                    //       fontSize: FONTSIZE_25,
                                    //       fontFamily: Constants.getFontType(),
                                    //       fontWeight: FontWeight.w500,
                                    //       color: greytheme700),
                                    // ),
                                  ],
                                ),
                              ),
                            ))
                          : SliverToBoxAdapter(
                              child: Center(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                    ),
                                    Text(
                                      STR_NO_ITEM_FOUND,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: FONTSIZE_25,
                                          fontFamily: Constants.getFontType(),
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

  Widget _getOptionsformenu(BuildContext context) {
    restaurantId = widget.restId;
    return SliverToBoxAdapter(
      child: Container(
        child: Row(
          children: <Widget>[
            SizedBox(width: 15),
            Text(
              STR_VEG_ONLY,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: FONTSIZE_12,
                  fontFamily: Constants.getFontType(),
                  fontWeight: FontWeight.w500,
                  color: greytheme1000),
            ),
            Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                activeColor: ((Globle().colorscode) != null)
                    ? getColorByHex(Globle().colorscode)
                    : orangetheme300,
                onChanged: (bool value) {
                  setState(() {
                    this._switchvalue = value;
                    if (this._switchvalue) {
                      _restaurantList = null;
                      // DialogsIndicator.showLoadingDialog(
                      //     context, _keyLoader, STR_LOADING);
                      callAPIOnSwitchChange(STR_VEG);
                    } else {
                      _restaurantList = null;
                      // DialogsIndicator.showLoadingDialog(
                      //     context, _keyLoader, STR_LOADING);
                      callAPIOnSwitchChange(null);
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
                    STR_MENU,
                    style: TextStyle(
                        fontSize: FONTSIZE_12,
                        fontFamily: Constants.getFontType(),
                        fontWeight: FontWeight.w500,
                        color: (isselected)
                            ? ((Globle().colorscode) != null)
                                ? getColorByHex(Globle().colorscode)
                                : orangetheme300
                            : greytheme100),
                  ),
                  borderSide: (isselected)
                      ? BorderSide(
                          color: ((Globle().colorscode) != null)
                              ? getColorByHex(Globle().colorscode)
                              : orangetheme300)
                      : BorderSide(color: greytheme100),
                  onPressed: () async {
                    setState(() {
                      if (isselected == false) {
                        isselected = true;
                      } else {
                        isselected = false;
                      }
                    });
                    // abc = await showDialog(
                    //     context: context,
                    //     child: MenuItem(
                    //       restaurantId: widget.restId,
                    //     ),
                    //     barrierDismissible: true);
                    setState(() {
                      if (isselected == false) {
                        isselected = true;
                      } else {
                        isselected = false;
                      }
                    });
                    if (abc != null) {
                      _restaurantList = null;
                      // DialogsIndicator.showLoadingDialog(
                      //     context, _keyLoader, STR_LOADING);
                      await progressDialog.show();
                      restaurantDeliveryPresenter.getMenuList(
                          widget.restId, context,
                          categoryId: abc, menu: menutype);
                      print(abc);
                    }
                    restaurantDeliveryPresenter.getMenuList(
                        widget.restId, context,
                        categoryId: abc, menu: menutype);
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

  _getMenuListHorizontal(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 0.0),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _getMenucount(),
              itemBuilder: (context, index) {
                return Container(
                  width: _textSize(
                          category2[index].name,
                          TextStyle(
                            fontSize: 16,
                            color:
                                _selectedMenu != null && _selectedMenu == index
                                    ? (((Globle().colorscode) != null)
                                        ? getColorByHex(Globle().colorscode)
                                        : orangetheme300)
                                    : Color.fromRGBO(118, 118, 118, 1),
                          )).width +
                      20,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: GestureDetector(
                            onTap: () async {
                              _onSelected(index);
                            },
                            child: Text(
                              category2[index].name,
                              style: TextStyle(
                                fontSize: 16,
                                color: _selectedMenu != null &&
                                        _selectedMenu == index
                                    ? (((Globle().colorscode) != null)
                                        ? getColorByHex(Globle().colorscode)
                                        : orangetheme300)
                                    : Color.fromRGBO(118, 118, 118, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: _textSize(
                                category2[index].name,
                                TextStyle(
                                  fontSize: 16,
                                  color: _selectedMenu != null &&
                                          _selectedMenu == index
                                      ? (((Globle().colorscode) != null)
                                          ? getColorByHex(Globle().colorscode)
                                          : orangetheme300)
                                      : Color.fromRGBO(118, 118, 118, 1),
                                )).width +
                            20,
                        child: Divider(
                          thickness: 2,
                          color: _selectedMenu != null && _selectedMenu == index
                              ? (Globle().colorscode != null)
                                  ? getColorByHex(Globle().colorscode)
                                  : orangetheme300
                              : Color.fromRGBO(118, 118, 118, 1),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  _getSubMenuListHorizontal(BuildContext context) {
    return Expanded(
      child: Container(
        height: valueBool ? 40 : 0,
        padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 0.0),
        child: valueBool
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _getSubMenucount(),
                itemBuilder: (context, index) {
                  return Container(
                      // width: MediaQuery.of(context).size.width / 4.5,
                      width: _textSize(
                              subcategoriesList2[index].name,
                              TextStyle(
                                fontSize: 16,
                                color: _selectedSubMenu != null &&
                                        _selectedSubMenu == index
                                    ? (((Globle().colorscode) != null)
                                        ? getColorByHex(Globle().colorscode)
                                        : orangetheme300)
                                    : Color.fromRGBO(118, 118, 118, 1),
                              )).width +
                          35,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: GestureDetector(
                                onTap: () async {
                                  _onSubMenuSelected(index);
                                },
                                child: Text(
                                  subcategoriesList2[index].name,
                                  style: TextStyle(
                                      color: _selectedSubMenu != null &&
                                              _selectedSubMenu == index
                                          ? getColorByHex(Globle().colorscode)
                                          : Color.fromRGBO(118, 118, 118, 1),
                                      fontSize: 16.0),
                                )),
                          ),
                          // Divider(
                          //   thickness: 1,
                          //   color: _selectedSubMenu != null &&
                          //           _selectedSubMenu == index
                          //       ? getColorByHex(Globle().colorscode)
                          //       : Color.fromRGBO(118, 118, 118, 1),
                          // )
                        ],
                      ));
                  // return GestureDetector(
                  //   onTap: () {
                  //     _onSubMenuSelected(index);
                  //   },
                  //   child: Container(
                  //     // height: 40,
                  //     // padding: EdgeInsets.all(_categorydata[index].name.length>5? 6: 10),
                  //     padding: EdgeInsets.only(
                  //         left: _subcategorydata[index].title.length > 5 ? 6 : 10,
                  //         right: _subcategorydata[index].title.length > 5 ? 6 : 10,
                  //         top: 10,
                  //         bottom: 0),
                  //     margin: EdgeInsets.only(left: 6),
                  //     // decoration: BoxDecoration(
                  //     //   border: Border.all(
                  //     //     width: 1,
                  //     //     color: _selectedMenu != null && _selectedMenu == index
                  //     //                   ? getColorByHex(Globle().colorscode)
                  //     //                   : Color.fromRGBO(118, 118, 118, 1),
                  //     //   ),
                  //     //   borderRadius: BorderRadius.all(Radius.circular(8)),
                  //     //   // color: _selectedMenu != null && _selectedMenu == index
                  //     //   //                 ? getColorByHex(Globle().colorscode)
                  //     //   //                 : Color.fromRGBO(118, 118, 118, 1),
                  //     // ),
                  //     child: Text(
                  //       _subcategorydata[index].title,
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         color:
                  //             _selectedSubMenu != null && _selectedSubMenu == index
                  //                 ? getColorByHex(Globle().colorscode)
                  //                 : Color.fromRGBO(118, 118, 118, 1),
                  //         decoration: TextDecoration.underline,
                  //       ),
                  //     ),
                  //   ),
                  // );
                })
            : Container(),
      ),
    );
  }

  int _getMenucount() {
    // if (category.length == 0) {
    //   category.insert(0, category1[0]);
    // }
    if (_categorydata != null) {
      for (int i = 0; i < _categorydata.length; i++) {
        setState(() {
          category2 = _categorydata[i].category;
        });
      }

      // if (category.length == 1) {
      //   category.addAll(category2);
      // }
      return category2.length;
    }
    return 0;
  }

  int _getSubMenucount() {
    if (subcategoriesList != null) {
      subcategoriesList2 = subcategoriesList;
      return subcategoriesList2.length;
    } else {
      return 0;
    }

    //for All as subcategory
    // if (subcategories.length == 0) {
    //   // subcategories.insert(0, subcategoriesList1[0]);
    //   subcategoriesList2 = subcategories;
    //   if (subcategoriesList != null) {
    //     subcategoriesList2.addAll(subcategoriesList);
    //     return subcategoriesList2.length;
    //   }
    // } else {
    //   return subcategoriesList2.length;
    // }
  }

  // int _getSubMenucount() {
  //   if (subcategoriesList.length != 0) {
  //     return subcategoriesList.length;
  //   }
  //   return 0;
  //   // if (_subcategorydata != null) {
  //   //   return _subcategorydata.length;
  //   // }
  //   // return 0;
  // }
  Widget _restaurantLogo() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 5),
      child: isImageNotNil() == false
          ? Image.asset(
              RESTAURANT_IMAGE_PATH,
              fit: BoxFit.fill,
            )
          : CachedNetworkImage(
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              imageUrl: BaseUrl.getBaseUrlImages() +
                  "${restaurantItemsModel.restImage}",
              errorWidget: (context, url, error) => Image.asset(
                RESTAURANT_IMAGE_PATH,
                fit: BoxFit.fill,
              ),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0),
                    bottomLeft: const Radius.circular(10.0),
                    bottomRight: const Radius.circular(10.0),
                  ),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.fill),
                ),
              ),
            ),
    );
  }

  Widget _menuItemList() {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        // childAspectRatio: 0.7,
        childAspectRatio: queryData.devicePixelRatio * 0.3,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return
            //  Container(
            //   child:
            LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddItemDeliveryPageView(
                        itemId: _restaurantList[index].id,
                        restId: _restaurantList[index].restId,
                        title: '${_restaurantList[index].itemName}',
                        description:
                            '${_restaurantList[index].itemDescription}',
                        restName: widget.title,
                        itemImage: '${_restaurantList[index].itemImage}',
                        isFromOrder: widget.isFromOrder,
                        lat: widget.lat,
                        long: widget.long,
                      ))),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(color: Colors.grey, width: 0.7),
                    // borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Column(
                    children: <Widget>[
                      LimitedBox(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          // child: Align(
                          //   alignment: Alignment.bottomRight,
                          //   heightFactor: 1,
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: 150,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              FOOD_IMAGE_PATH,
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: 100,
                            ),
                            imageUrl: BaseUrl.getBaseUrlImages() +
                                '${_restaurantList[index].itemImage}',
                          ),
                          // ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Expanded(
                      //     child: Padding(
                      //   padding: EdgeInsets.only(left: 10, top: 8),
                      //   child:
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: Center(
                                child: AutoSizeText(
                                  _restaurantList[index].itemName != null
                                      ? StringUtils.capitalize(
                                          "${_restaurantList[index].itemName}")
                                      : STR_SPACE,
                                  maxLines: 2,
                                  // minFontSize: FONTSIZE_10,
                                  // maxFontSize: FONTSIZE_13,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: FONTSIZE_15,
                                      fontFamily: Constants.getFontType(),
                                      fontWeight: FontWeight.w600,
                                      color: greytheme700),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            // priceWithGramWidget(_restaurantList, index),
                            SizedBox(width: 5),
                            Text(
                              (_restaurantList[index].sizePrizes.isEmpty)
                                  ? "${restaurantItemsModel.currencySymbol} " +
                                          '${_restaurantList[index].price}' ??
                                      STR_BLANK
                                  : "${restaurantItemsModel.currencySymbol} " +
                                          "${_restaurantList[index].sizePrizes[0].price} " ??
                                      STR_BLANK,
                              style: TextStyle(
                                  fontSize: FONTSIZE_15,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                  // color: ((Globle().colorscode) != null)
                                  //     ? getColorByHex(Globle().colorscode)
                                  //     : orangetheme300
                                  color: greytheme700),
                            ),
                          ]),
                      // )),
                      SizedBox(
                        height: 1,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          // ),
        );
      }, childCount: _getint()),
    );
  }

  Widget priceWithGramWidget(List<RestaurantMenuItem> _listItem, index) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              // getitemname(_restaurantList),
              getitemname(itemSizeinGramList),
              style: TextStyle(
                  fontSize: FONTSIZE_14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: ((Globle().colorscode) != null)
                      ? getColorByHex(Globle().colorscode)
                      : orangetheme300),
            ),
            SizedBox(width: 5),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                (_restaurantList[index].sizePrizes.isEmpty)
                    ? "${restaurantItemsModel.currencySymbol}" +
                            '${_restaurantList[index].price}' ??
                        STR_BLANK
                    : "${restaurantItemsModel.currencySymbol}" +
                            "${_restaurantList[index].sizePrizes[0].price}" ??
                        STR_BLANK,
                // getitemname(itemSizeinGramList),
                style: TextStyle(
                    fontSize: FONTSIZE_14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    color: ((Globle().colorscode) != null)
                        ? getColorByHex(Globle().colorscode)
                        : orangetheme300),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String getitemname(List<ItemGram> _listitem) {
    var itemname = '';
    int i;
    for (i = 0; i < _listitem.length; i++) {
      itemname += "${_listitem[i].title} \n";
    }
    if (itemname.isNotEmpty) {
      itemname = removeLastChar(itemname);
      itemname = removeLastChar(itemname);
    }
    return itemname;
  }

  static String removeLastChar(String str) {
    return str.substring(0, str.length - 1);
  }

  callAPIOnSwitchChange(String menuType) async {
    await progressDialog.show();
    menutype = menuType;
    restaurantDeliveryPresenter.getMenuList(widget.restId, context,
        categoryId: abc, menu: menutype);
  }

  int _getint() {
    if (_restaurantList != null) {
      return _restaurantList.length;
    }
    return 0;
  }

  bool isImageNotNil() {
    if (restaurantItemsModel != null) {
      if (restaurantItemsModel.restImage != null) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<void> getMenuListfailed() async {
    await progressDialog.hide();
    setState(() {
      isLoading = false;
    });
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  Future<void> getMenuListsuccess(List<RestaurantMenuItem> menulist,
      RestaurantItemsModel _restaurantItemsModel1) async {
    setState(() {
      isLoading = false;
    });
    if (menulist.length == 0) {
      await progressDialog.hide();
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      return;
    }
    setState(() {
      if (_restaurantList == null) {
        _restaurantList = menulist;
        restaurantItemsModel = _restaurantItemsModel1;
      } else {
        // _restaurantList.removeRange(0, (_restaurantList.length));
        _restaurantList.addAll(menulist);
        restaurantItemsModel = _restaurantItemsModel1;
      }
      page++;
    });
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  void notifyWaiterFailed() {}
  @override
  void notifyWaiterSuccess() {}
  @override
  void getMenuLCategoryfailed() {}
  @override
  void getMenuLCategorysuccess([List<CategoryItems> categoryData]) {
    if (categoryData.length == 0) {
      return;
    }
    setState(() {
      if (_categorydata == null) {
        _categorydata = categoryData;
      } else {
        _categorydata.addAll(categoryData);
      }
      if (categoryData[0].category[0].subcategories.length > 0) {
        setState(() {
          valueBool = true;
          subcategoriesList =
              categoryData[0].category[_selectedMenu].subcategories;
          abc = categoryData[0].category[_selectedMenu].id;
          subCategoryIdabc = categoryData[0]
              .category[_selectedMenu]
              .subcategories[_selectedSubMenu]
              .id;
          callItemOnCategorySelect();
        });
      } else {
        setState(() {
          valueBool = false;
          subcategoriesList = [];
          abc = categoryData[0].category[_selectedMenu].id;
          callItemOnCategorySelect();
        });
      }
    });
  }
}

List<MenuTitles> _subcategorydata = [
  MenuTitles(title: 'Water'),
  MenuTitles(title: 'Wine'),
  MenuTitles(title: 'Beer'),
  MenuTitles(title: 'Soda'),
  MenuTitles(title: 'Hot Drinks'),
];

class MenuTitles {
  String title;
  bool isSelected;
  int id;
  MenuTitles({this.title, this.id, this.isSelected});
}

class ItemGram {
  String title;
  int id;
  ItemGram({this.title, this.id});
}

List<ItemGram> itemSizeinGramList = [
  ItemGram(title: '250g'),
  ItemGram(title: '300g'),
];
// List<Category> category1 = [Category(id: 0, name: "All")];
// List<Subcategories> subcategoriesList1 = [Subcategories(id: 0, name: "All")];
