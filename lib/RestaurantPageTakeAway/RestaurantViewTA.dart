import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPageTA/AddItemPageTAView.dart';
import 'package:foodzi/MenuDropdownCategory/MenuItemDropDown.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoView.dart';
import 'package:foodzi/RestaurantPageTakeAway/RestaurantTAContractor.dart';
import 'package:foodzi/RestaurantPageTakeAway/RestaurantTAPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';

class RestaurantTAView extends StatefulWidget {
  String title;
  int restId;
  String imageUrl;
  RestaurantTAView({this.title, this.restId, this.imageUrl});
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
  ScrollController _controller = ScrollController();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  bool _switchvalue = false;
  bool isselected = false;
  String menutype;
  RestaurantItemsModel _restaurantItemsModel;
  var abc;
  @override
  void initState() {
    _detectScrollPosition();
    restaurantPresenter = RestaurantTAPresenter(this);
    _restaurantItemsModel = RestaurantItemsModel();
    restaurantPresenter.getMenuList(widget.restId, context,
        categoryId: abc, menu: menutype);
    print(widget.imageUrl);
    super.initState();
  }

  _detectScrollPosition() {
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
        } else {
          restaurantPresenter.getMenuList(widget.restId, context,
              categoryId: abc, menu: menutype);
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
          Expanded(flex: 2, child: _restaurantLogo()),
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
                                STR_NO_ITEMS_FOUND,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: FONTSIZE_25,
                                    fontFamily: KEY_FONTFAMILY,
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
          fit: BoxFit.fill,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          imageUrl: BaseUrl.getBaseUrlImages() + "${widget.imageUrl}",
          errorWidget: (context, url, error) => Image.asset(
                RESTAURANT_IMAGE_PATH,
                fit: BoxFit.fill,
              )),
    );
  }

  Widget _getmainviewTableno() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: FONTSIZE_20,
                          fontFamily: KEY_FONTFAMILY,
                          fontWeight: FontWeight.w600,
                          color: greytheme700),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 2,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    STR_COLLECTION,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: FONTSIZE_20,
                        fontFamily: KEY_FONTFAMILY,
                        fontWeight: FontWeight.w600,
                        color: getColorByHex(Globle().colorscode)),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
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
              STR_VEG_ONLY,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: FONTSIZE_12,
                  fontFamily: KEY_FONTFAMILY,
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
                      _restaurantList = null;
                      DialogsIndicator.showLoadingDialog(
                          context, _keyLoader, STR_LOADING);
                      menutype = STR_VEG;
                      restaurantPresenter.getMenuList(widget.restId, context,
                          categoryId: abc, menu: menutype);
                    } else {
                      _restaurantList = null;
                      DialogsIndicator.showLoadingDialog(
                          context, _keyLoader, STR_LOADING);
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
                        fontFamily: KEY_FONTFAMILY,
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
                    abc = await showDialog(
                        context: context,
                        child: MenuItem(
                          restaurantId: widget.restId,
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
                          context, _keyLoader, STR_LOADING);
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
        childAspectRatio: 0.85,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddItemPageTAView(
                          itemId: _restaurantList[index].id,
                          restId: _restaurantList[index].restId,
                          title: '${_restaurantList[index].itemName}',
                          description:
                              '${_restaurantList[index].itemDescription}',
                          restName: widget.title,
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
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: 100,
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
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 10, top: 8),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    (_restaurantList[index].menuType == STR_VEG)
                                        ? Image.asset(
                                            IMAGE_VEG_ICON_PATH,
                                            width: 14,
                                            height: 14,
                                          )
                                        : Image.asset(
                                            IMAGE_VEG_ICON_PATH,
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
                                            STR_SPACE,
                                        maxLines: 2,
                                        minFontSize: FONTSIZE_10,
                                        maxFontSize: FONTSIZE_13,
                                        style: TextStyle(
                                            fontSize: FONTSIZE_13,
                                            fontFamily: KEY_FONTFAMILY,
                                            fontWeight: FontWeight.w600,
                                            color: greytheme700),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                AutoSizeText(
                                  "${_restaurantList[index].itemDescription}" ??
                                      STR_SPACE,
                                  maxLines: 2,
                                  minFontSize: FONTSIZE_10,
                                  maxFontSize: FONTSIZE_12,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: FONTSIZE_12,
                                      fontFamily: KEY_FONTFAMILY,
                                      fontWeight: FontWeight.w500,
                                      color: greytheme1000),
                                ),
                              ]),
                        )),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.09,
                          child: Row(
                            children: <Widget>[
                              Container(
                                decoration: new BoxDecoration(
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
                                        ? "${_restaurantItemsModel.currencyCode} " +
                                                '${_restaurantList[index].price}' ??
                                            STR_BLANK
                                        : "${_restaurantItemsModel.currencyCode} " +
                                                "${_restaurantList[index].sizePrizes[0].price}" ??
                                            STR_BLANK,
                                    style: TextStyle(
                                        fontSize: FONTSIZE_14,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(64, 64, 64, 1)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddItemPageTAView(
                                                  itemId:
                                                      _restaurantList[index].id,
                                                  restId: _restaurantList[index]
                                                      .restId,
                                                  title:
                                                      '${_restaurantList[index].itemName}',
                                                  description:
                                                      '${_restaurantList[index].itemDescription}',
                                                  imageUrl:
                                                      _restaurantList[index]
                                                          .itemImage,
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            getColorByHex(Globle().colorscode),
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(12.0),
                                        )),
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: Center(
                                      child: Text(
                                        STR_ADD,
                                        style: TextStyle(
                                            fontSize: FONTSIZE_14,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
  void restaurantfailed() {}

  @override
  void restaurantsuccess(List<RestaurantList> restlist) {}
  @override
  void getMenuListfailed() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  void getMenuListsuccess(List<RestaurantMenuItem> menulist,
      RestaurantItemsModel restaurantItemsModel1) {
    if (menulist.length == 0) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      return;
    }

    setState(() {
      if (_restaurantList == null) {
        _restaurantList = menulist;
        _restaurantItemsModel = restaurantItemsModel1;
      } else {
        _restaurantList.removeRange(0, (_restaurantList.length));
        _restaurantList.addAll(menulist);
        _restaurantItemsModel = restaurantItemsModel1;
      }
      page++;
    });
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }
}
