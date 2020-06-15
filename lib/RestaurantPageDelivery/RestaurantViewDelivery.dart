import 'package:auto_size_text/auto_size_text.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPageDelivery/AddItemPageDeliveryView.dart';
import 'package:foodzi/MenuDropdownCategory/MenuItemDropDownContractor.dart';
import 'package:foodzi/MenuDropdownCategory/MenuItemDropDownPresenter.dart';
import 'package:foodzi/Models/CategoryListModel.dart';
import 'package:foodzi/Models/CategoryListModel.dart';

import 'package:foodzi/Models/RestaurantItemsList.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoView.dart';
import 'package:foodzi/RestaurantPageDelivery/RestaurantDeliveryContractor.dart';
import 'package:foodzi/RestaurantPageDelivery/RestaurantDeliveryPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RestaurantDeliveryView extends StatefulWidget {
  String title;
  int restId;
  String imageUrl;
  bool isFromOrder = false;

  int categoryid;
  RestaurantDeliveryView(
      {this.title,
      this.restId,
      this.categoryid,
      this.imageUrl,
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
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  bool _switchvalue = false;
  bool isselected = false;
  ProgressDialog progressDialog;
  MenuDropdpwnPresenter menudropdownPresenter;
  List<CategoryItems> _categorydata;
  String menutype = " ";
  int restaurantId;
  int _selectedMenu = 0;
  int _selectedSubMenu = 0;
  var tableID;
  bool valueBool = false;
  RestaurantItemsModel restaurantItemsModel;
  List<Category> category = [];
  List<Subcategories> subcategories = [];
  List<Subcategories> subcategoriesList = [];

  var abc;
  var subCategoryIdabc;
  @override
  void initState() {
    _detectScrollPosition();
    if (widget.isFromOrder == null) {
      setState(() {
        widget.isFromOrder = false;
      });
    }
    restaurantDeliveryPresenter = RestaurantDeliveryPresenter(this);
    restaurantItemsModel = RestaurantItemsModel();
    restaurantDeliveryPresenter.getMenuList(widget.restId, context,
        categoryId: abc, menu: menutype);
    print(widget.imageUrl);
    menudropdownPresenter = MenuDropdpwnPresenter(this);
    menudropdownPresenter.getMenuLCategory(widget.restId, context);
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
              categoryId: abc, menu: menutype);
        }
      }
    });
  }

  _onSelected(index) {
    setState(() {
      _selectedMenu = index;

      if (_selectedMenu == index) {
        if (category[index].subcategories.length > 0) {
          setState(() {
            valueBool = true;
            subcategoriesList = category[index].subcategories;
            // _getSubMenucount();
          });
        } else {
          setState(() {
            valueBool = false;
            subcategoriesList = [];
          });
        }
      }

      print(_selectedMenu);
    });
    abc = category[index].id;
    if (abc != null) {
      callItemOnCategorySelect();
    } else {
      abc = null;
      callItemOnCategorySelect();
    }
  }

  _onSubMenuSelected(index) {
    setState(() {
      _selectedSubMenu = index;

      print(_selectedSubMenu);
    });
    subCategoryIdabc = category[index].subcategories[index].id;
    if (subCategoryIdabc != null) {
      callItemOnCategorySelect();
    } else {
      subCategoryIdabc = null;
      callItemOnCategorySelect();
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
              flex: 7,
              child: CustomScrollView(
                controller: _controller,
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      child: SizedBox(
                        height: 15,
                      ),
                    ),
                  ),
                  _getMenuListHorizontal(context),
                  _getSubMenuListHorizontal(context),
                  // _getOptionsformenu(context),
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
                    : orangetheme,
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
                                : orangetheme
                            : greytheme100),
                  ),
                  borderSide: (isselected)
                      ? BorderSide(
                          color: ((Globle().colorscode) != null)
                              ? getColorByHex(Globle().colorscode)
                              : orangetheme)
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
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 1.6,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _getMenucount(),
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.13 / 0.7,
                  child: Column(
                    children: <Widget>[
                      Center(
                          child: GestureDetector(
                              onTap: () async {
                                _onSelected(index);
                                // restaurantDeliveryPresenter.getMenuList(
                                //     widget.restId, context,
                                //     categoryId: abc, menu: menutype);
                              },
                              child: Text(
                                category[index].name,
                                style: TextStyle(
                                    color: _selectedMenu != null &&
                                            _selectedMenu == index
                                        ? getColorByHex(Globle().colorscode)
                                        : Color.fromRGBO(118, 118, 118, 1),
                                    fontSize: 16.0),
                              ))),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                        child: Divider(
                          thickness: 1,
                          color: _selectedMenu != null && _selectedMenu == index
                              ? getColorByHex(Globle().colorscode)
                              : Color.fromRGBO(118, 118, 118, 1),
                        ),
                      )
                    ],
                  ),
                  // ),
                );
                // return GestureDetector(
                //   onTap: () {
                //     _onSelected(index);
                //   },
                //   child: Container(
                //     height: 40,
                //     // padding: EdgeInsets.all(_categorydata[index].name.length>5? 6: 10),
                //     padding: EdgeInsets.only(
                //         left: _categorydata[index].name.length > 5 ? 6 : 16,
                //         right: _categorydata[index].name.length > 5 ? 6 : 16,
                //         top: 10,
                //         bottom: 0),
                //     margin: EdgeInsets.only(left: 6),
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         width: 1,
                //         color: _selectedMenu != null && _selectedMenu == index
                //             ? getColorByHex(Globle().colorscode)
                //             : Color.fromRGBO(118, 118, 118, 1),
                //       ),
                //       borderRadius: BorderRadius.all(Radius.circular(8)),
                //       // color: _selectedMenu != null && _selectedMenu == index
                //       //                 ? getColorByHex(Globle().colorscode)
                //       //                 : Color.fromRGBO(118, 118, 118, 1),
                //     ),
                //     child: Text(
                //       _categorydata[index].name ?? STR_BLANK,
                //       style: TextStyle(
                //         fontSize: 16,
                //         color: _selectedMenu != null && _selectedMenu == index
                //             ? getColorByHex(Globle().colorscode)
                //             : Color.fromRGBO(118, 118, 118, 1),
                //       ),
                //     ),
                //   ),
                // );
              }),
        ),
      ),
    );
  }

  _getSubMenuListHorizontal(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          height: 50,
          width: MediaQuery.of(context).size.width / 0.5,
          child: valueBool
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: subcategoriesList.length,
                  itemBuilder: (context, index) {
                    return Container(
                        width: MediaQuery.of(context).size.width * 0.13 / 0.5,
                        child: Column(
                          children: <Widget>[
                            Center(
                                child: GestureDetector(
                                    onTap: () async {
                                      _onSubMenuSelected(index);
                                    },
                                    child: Text(
                                      subcategoriesList[index].name,
                                      style: TextStyle(
                                          color: _selectedSubMenu != null &&
                                                  _selectedSubMenu == index
                                              ? getColorByHex(
                                                  Globle().colorscode)
                                              : Color.fromRGBO(
                                                  118, 118, 118, 1),
                                          fontSize: 16.0),
                                    ))),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                              child: Divider(
                                thickness: 1,
                                color: _selectedSubMenu != null &&
                                        _selectedSubMenu == index
                                    ? getColorByHex(Globle().colorscode)
                                    : Color.fromRGBO(118, 118, 118, 1),
                              ),
                            )
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
      ),
    );
  }

  int _getMenucount() {
    if (_categorydata != null) {
      for (int i = 0; i < _categorydata.length; i++) {
        setState(() {
          category = _categorydata[i].category;
        });
      }
      return category.length;
    }
    return 0;
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
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 0.8,
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
                      SizedBox(height: 5),
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
                                  minFontSize: FONTSIZE_10,
                                  maxFontSize: FONTSIZE_13,
                                  style: TextStyle(
                                      fontSize: FONTSIZE_13,
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
                                  fontSize: FONTSIZE_14,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                  // color: ((Globle().colorscode) != null)
                                  //     ? getColorByHex(Globle().colorscode)
                                  //     : orangetheme
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
                      : orangetheme),
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
                        : orangetheme),
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
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  Future<void> getMenuListsuccess(List<RestaurantMenuItem> menulist,
      RestaurantItemsModel _restaurantItemsModel1) async {
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
        _restaurantList.removeRange(0, (_restaurantList.length));
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
          subcategoriesList = categoryData[0].category[0].subcategories;
        });
      } else {
        setState(() {
          valueBool = false;
          subcategoriesList = [];
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
