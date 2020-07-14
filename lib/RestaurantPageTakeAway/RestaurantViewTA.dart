import 'package:auto_size_text/auto_size_text.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPageTA/AddItemPageTAView.dart';
import 'package:foodzi/BottomTabbar/BottomTabbar.dart';
import 'package:foodzi/MenuDropdownCategory/MenuItemDropDown.dart';
import 'package:foodzi/MenuDropdownCategory/MenuItemDropDownContractor.dart';
import 'package:foodzi/MenuDropdownCategory/MenuItemDropDownPresenter.dart';
import 'package:foodzi/Models/CategoryListModel.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoView.dart';
import 'package:foodzi/RestaurantPageTakeAway/RestaurantTAContractor.dart';
import 'package:foodzi/RestaurantPageTakeAway/RestaurantTAPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RestaurantTAView extends StatefulWidget {
  String title;
  int restId;
  String imageUrl;
  String lat;
  String long;
  RestaurantTAView(
      {this.title, this.restId, this.imageUrl, this.lat, this.long});
  @override
  State<StatefulWidget> createState() {
    return _RestaurantTAViewState();
  }
}

class _RestaurantTAViewState extends State<RestaurantTAView>
    implements RestaurantTAModelView, MenuDropdownModelView {
  RestaurantTAPresenter restaurantPresenter;
  List<RestaurantMenuItem> _restaurantList;
  int page = 1;
  ScrollController _controller = ScrollController();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  bool _switchvalue = false;
  bool isselected = false;
  String menutype = " ";
  RestaurantItemsModel _restaurantItemsModel;
  ProgressDialog progressDialog;
  MenuDropdpwnPresenter menudropdownPresenter;
  List<CategoryItems> _categorydata;
  int _selectedMenu = 0;
  int _selectedSubMenu = 0;
  bool valueBool = false;
  int previousValue;
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
    restaurantPresenter = RestaurantTAPresenter(this);
    _restaurantItemsModel = RestaurantItemsModel();
    setState(() {
      isLoading = true;
    });
    restaurantPresenter.getMenuList(widget.restId, context,
        categoryId: abc, menu: menutype);
    print(widget.imageUrl);
    menudropdownPresenter = MenuDropdpwnPresenter(this);
    menudropdownPresenter.getMenuCategoryList(widget.restId, context, true);
    super.initState();
  }

  _detectScrollPosition() {
    _controller.addListener(() async {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
        } else {
          await progressDialog.show();
          restaurantPresenter.getMenuList(widget.restId, context,
              categoryId: abc, menu: menutype, page: page);
        }
      }
    });
  }

  _onSelected(index) {
    setState(() {
      _selectedMenu = index;

      if (_selectedMenu == index) {
        if (category[index].subcategories != null) {
          if (category[index].subcategories.length > 0) {
            setState(() {
              valueBool = true;
              subcategoriesList = category[index].subcategories;
              subcategories = [];
              subcategoriesList2 = [];
              _selectedSubMenu = 0;
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

      if (previousValue != null) {
        if (previousValue != _selectedMenu) {
          subCategoryIdabc = null;
          _selectedSubMenu = 0;
          previousValue = _selectedMenu;
        }
      } else {
        previousValue = _selectedMenu;
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
      if (index == 0) {
        _selectedSubMenu = index;
        subCategoryIdabc = null;
      } else {
        _selectedSubMenu = index - 1;
        subCategoryIdabc =
            category[_selectedMenu].subcategories[_selectedSubMenu].id;
      }

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
    restaurantPresenter.getMenuList(widget.restId, context,
        categoryId: abc, subCategoryId: subCategoryIdabc, menu: menutype);
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: STR_LOADING);
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: CachedNetworkImage(
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            imageUrl: BaseUrl.getBaseUrlImages() +
                "${_restaurantItemsModel.restLogo}",
            height: 50,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Image.asset(
              RESTAURANT_IMAGE_PATH,
              fit: BoxFit.scaleDown,
              height: 30,
              width: 40,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomTabbar(
                          tabValue: 1,
                        )),
                ModalRoute.withName("/BottomTabbar"));
          },
        ),
        actions: <Widget>[
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
          // Expanded(flex: 2, child: _restaurantLogo()),
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
                // _getOptionsformenu(context),
                _getMenuListHorizontal(context),
                _getSubMenuListHorizontal(context),
                SliverToBoxAdapter(
                  child: Container(
                    child: SizedBox(
                      height: 15,
                    ),
                  ),
                ),
                (_restaurantList != null)
                    ? _menuItemList()
                    : isLoading
                        ? SliverToBoxAdapter(
                            child: Center(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
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
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                  ),
                                  // CircularProgressIndicator(),
                                  Text(
                                    STR_NO_ITEMS_FOUND,
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
      ),
    );
  }

  Widget _restaurantLogo() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 5),
      child: CachedNetworkImage(
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        imageUrl: BaseUrl.getBaseUrlImages() + "${widget.imageUrl}",
        errorWidget: (context, url, error) => Image.asset(
          RESTAURANT_IMAGE_PATH,
          fit: BoxFit.fill,
        ),
        //fit: BoxFit.fill,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
              bottomLeft: const Radius.circular(10.0),
              bottomRight: const Radius.circular(10.0),
            ),
            image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
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
                activeColor: getColorByHex(Globle().colorscode),
                onChanged: (bool value) {
                  setState(() async {
                    this._switchvalue = value;
                    if (this._switchvalue) {
                      _restaurantList = null;
                      // DialogsIndicator.showLoadingDialog(
                      //     context, _keyLoader, STR_LOADING);
                      await progressDialog.show();
                      menutype = STR_VEG;
                      restaurantPresenter.getMenuList(widget.restId, context,
                          categoryId: abc, menu: menutype);
                    } else {
                      _restaurantList = null;
                      // DialogsIndicator.showLoadingDialog(
                      //     context, _keyLoader, STR_LOADING);
                      await progressDialog.show();
                      menutype = null;
                      restaurantPresenter.getMenuList(widget.restId, context,
                          categoryId: abc, menu: menutype);
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
                            ? getColorByHex(Globle().colorscode)
                            : greytheme100),
                  ),
                  borderSide: (isselected)
                      ? BorderSide(color: getColorByHex(Globle().colorscode))
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
                      restaurantPresenter.getMenuList(widget.restId, context,
                          categoryId: abc, menu: menutype);
                      print(abc);
                    }
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
        childAspectRatio: 0.8,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return
            // Container(
            //   child:
            LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddItemPageTAView(
                        itemId: _restaurantList[index].id,
                        restId: _restaurantList[index].restId,
                        title: '${_restaurantList[index].itemName}',
                        description:
                            '${_restaurantList[index].itemDescription}',
                        imageUrl: '${_restaurantList[index].itemImage}',
                        lat: widget.lat,
                        long: widget.long,
                        restName: widget.title,
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
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                        ),
                      ),
                      SizedBox(height: 10),
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
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: FONTSIZE_15,
                                    fontFamily: KEY_FONTFAMILY,
                                    fontWeight: FontWeight.w600,
                                    color: greytheme700),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          // priceWithGramWidget(_restaurantList, index),

                          Text(
                            (_restaurantList[index].sizePrizes.isEmpty)
                                ? "${_restaurantItemsModel.currencySymbol} " +
                                        '${_restaurantList[index].price}' ??
                                    STR_BLANK
                                : "${_restaurantItemsModel.currencySymbol} " +
                                        "${_restaurantList[index].sizePrizes[0].price}" ??
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
                        ],
                      ),
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
                    ? "${_restaurantItemsModel.currencySymbol}" +
                            '${_restaurantList[index].price}' ??
                        STR_BLANK
                    : "${_restaurantItemsModel.currencySymbol}" +
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

  _getMenuListHorizontal(BuildContext context) {
    return SliverToBoxAdapter(
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
                          category[index].name,
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
                              category[index].name,
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
                                category[index].name,
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
    return SliverToBoxAdapter(
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
                          32,
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

  // int _getMenucount() {
  //   if (_categorydata != null) {
  //     for (int i = 0; i < _categorydata.length; i++) {
  //       setState(() {
  //         category = _categorydata[i].category;
  //       });
  //     }
  //     return category.length;
  //   }
  //   return 0;
  // }

  int _getMenucount() {
    if (category.length == 0) {
      category.insert(0, category1[0]);
    }
    if (_categorydata != null) {
      for (int i = 0; i < _categorydata.length; i++) {
        setState(() {
          category2 = _categorydata[i].category;
        });
      }

      if (category.length == 1) {
        category.addAll(category2);
      }
      return category.length;
    }
    return 0;
  }

  int _getSubMenucount() {
    if (subcategories.length == 0) {
      subcategories.insert(0, subcategoriesList1[0]);
      subcategoriesList2 = subcategories;
      if (subcategoriesList != null) {
        subcategoriesList2.addAll(subcategoriesList);
        return subcategoriesList2.length;
      }
    } else {
      return subcategoriesList2.length;
    }

    return 0;
  }

  int _getint() {
    if (_restaurantList != null) {
      return _restaurantList.length;
    }
    return 0;
  }

  @override
  void restaurantfailed() {}

  @override
  void restaurantsuccess(List<RestaurantList> restlist) {}
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
      RestaurantItemsModel restaurantItemsModel1) async {
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
        _restaurantItemsModel = restaurantItemsModel1;
      } else {
        // _restaurantList.removeRange(0, (_restaurantList.length));
        _restaurantList.addAll(menulist);
        _restaurantItemsModel = restaurantItemsModel1;
      }
      page++;
    });
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

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
    });

    // if (categoryData[0].category[0].subcategories.length > 0) {
    //   setState(() {
    //     valueBool = true;
    //     subcategoriesList = categoryData[0].category[0].subcategories;
    //   });
    // } else {
    //   setState(() {
    //     valueBool = false;
    //     subcategoriesList = [];
    //   });
    // }
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

List<Category> category1 = [Category(id: 0, name: "All")];
List<Subcategories> subcategoriesList1 = [Subcategories(id: 0, name: "All")];
