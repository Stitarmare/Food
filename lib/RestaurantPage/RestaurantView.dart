import 'package:auto_size_text/auto_size_text.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPage/AddItemPageView.dart';
import 'package:foodzi/MenuDropdownCategory/MenuItemDropDown.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';
import 'package:foodzi/RestaurantPage/RestaurantContractor.dart';
import 'package:foodzi/RestaurantPage/RestaurantPresenter.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoView.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RestaurantView extends StatefulWidget {
  String title;
  int restId;
  String imageUrl;
  bool isFromOrder = false;

  int categoryid;
  RestaurantView({this.title, this.restId, this.categoryid, this.imageUrl,this.isFromOrder});
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
  ScrollController _controller = ScrollController();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  bool _switchvalue = false;
  bool isselected = false;
  ProgressDialog progressDialog;

  String menutype;
  int restaurantId;

  var tableID;
  RestaurantItemsModel restaurantItemsModel;

  var abc;
  @override
  void initState() {
    _detectScrollPosition();
    if (widget.isFromOrder == null) {
      setState(() {
        widget.isFromOrder = false;
      });
    }
    restaurantPresenter = RestaurantPresenter(this);
    restaurantItemsModel = RestaurantItemsModel();
    restaurantPresenter.getMenuList(widget.restId, context,
        categoryId: abc, menu: menutype);
    print(widget.imageUrl);
    super.initState();
  }

  _detectScrollPosition() {
    _controller.addListener(() async {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
        } else {
          await progressDialog.show();
          // DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_LOADING);
          restaurantPresenter.getMenuList(widget.restId, context,
              categoryId: abc, menu: menutype);
        }
      }
    });
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
                                  STR_NO_ITEM_FOUND,
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
                  fontFamily: KEY_FONTFAMILY,
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
                  setState(()  {
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
                        fontFamily: KEY_FONTFAMILY,
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



  Widget _restaurantLogo() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 5),
      child: isImageNotNil() == false ? Image.asset(
          RESTAURANT_IMAGE_PATH,
          fit: BoxFit.fill,
        ):  CachedNetworkImage(
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        imageUrl: BaseUrl.getBaseUrlImages() + "${restaurantItemsModel.restImage}",
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
            image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
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
        return Container(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddItemPageView(
                      
                          itemId: _restaurantList[index].id,
                          restId: _restaurantList[index].restId  ,
                          title: '${_restaurantList[index].itemName}',
                          description:
                              '${_restaurantList[index].itemDescription}',
                          restName: widget.title,
                          itemImage: '${_restaurantList[index].itemImage}',
                          isFromOrder: widget.isFromOrder,
                        )
                        )),
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
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: 100,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
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
                                          0.30,
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
                                            fontFamily: KEY_FONTFAMILY,
                                            fontWeight: FontWeight.w600,
                                            color: greytheme700),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                AutoSizeText(
                                  _restaurantList[index].itemDescription != null
                                      ? StringUtils.capitalize(
                                          "${_restaurantList[index].itemDescription}")
                                      : STR_SPACE,
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
                          height: 1,
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
                                        ? "${restaurantItemsModel.currencySymbol} " +
                                                '${_restaurantList[index].price}' ??
                                            STR_BLANK
                                        : "${restaurantItemsModel.currencySymbol} " +
                                                "${_restaurantList[index].sizePrizes[0].price}" ??
                                            STR_BLANK,
                                    style: TextStyle(
                                        fontSize: FONTSIZE_14,
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddItemPageView(
                                                  itemId:
                                                      _restaurantList[index].id,
                                                  restId: _restaurantList[index].restId ,
                                                  title:
                                                      '${_restaurantList[index].itemName}',
                                                  description:
                                                      '${_restaurantList[index].itemDescription}',
                                                  itemImage:
                                                      '${_restaurantList[index].itemImage}',
                                                      isFromOrder: widget.isFromOrder,
                                                )));
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

  callAPIOnSwitchChange(String menuType) async{
      await progressDialog.show();
                      menutype = menuType;
                      restaurantPresenter.getMenuList(widget.restId, context,
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
      if(restaurantItemsModel.restImage != null) {
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
  void notifyWaiterFailed() {
    // TODO: implement notifyWaiterFailed
  }

  @override
  void notifyWaiterSuccess() {
    // TODO: implement notifyWaiterSuccess
  }
}
