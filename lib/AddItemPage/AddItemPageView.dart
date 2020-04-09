import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPage/ADdItemPagePresenter.dart';
import 'package:foodzi/AddItemPage/AddItemPageContractor.dart';
import 'package:foodzi/Models/AddItemPageModel.dart';
import 'package:foodzi/Models/AddMenuToCartModel.dart';
import 'package:foodzi/Models/GetTableListModel.dart';
import 'package:foodzi/Models/UpdateOrderModel.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddItemPageView extends StatefulWidget {
  String title;
  String description;
  int itemId;
  int restId;
  String restName;
  String itemImage;

  AddItemPageView(
      {this.title,
      this.description,
      this.itemId,
      this.restId,
      this.restName,
      this.itemImage});
  _AddItemPageViewState createState() => _AddItemPageViewState();
}

class _AddItemPageViewState extends State<AddItemPageView>
    implements
        AddItemPageModelView,
        AddmenuToCartModelview,
        AddTablenoModelView,
        GetTableListModelView,
        ClearCartModelView,
        UpdateCartModelView {
  List<bool> isSelected;
  int tableId;
  AddItemsToCartModel addMenuToCartModel;
  GetTableList getTableListModel;
  AddItemPageModelList _addItemPageModelList;
  Item items;
  List<Extras> extra;
  UpdateOrderModel _updateOrderModel;
  Spreads spread;
  Sizes size;
  List<Sizes> sizes;
  bool isAddBtnClicked = false;
  SharedPreferences prefs;
  List<int> listItemIdList = [];
  List<Switches> switches;
  bool isTableList = false;
  List<String> listStrItemId = [];
  List<int> listIntItemId = [];
  int itemIdValue;
  bool getttingLocation = false;
  AddItemModelList _addItemModelList;
  int itemId;
  int restId;
  ScrollController _controller = ScrollController();
  AddItemPagepresenter _addItemPagepresenter;
  List<TableList> _dropdownItemsTable = [];
  int _dropdownTableNumber;
  int tableID;
  bool alreadyAdded = false;
  int restaurant;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  int sizesid;
  bool isLoding = false;

  @override
  void initState() {
    _addItemPagepresenter =
        AddItemPagepresenter(this, this, this, this, this, this);
    isSelected = [true, false];
    setState(() {
      isLoding = true;
    });

    _addItemPageModelList = AddItemPageModelList();
    _addItemPagepresenter.performAddItem(widget.itemId, widget.restId, context);
    _addItemPagepresenter.getTableListno(widget.restId, context);
    itemIdValue = widget.itemId;
    print("${widget.itemImage}");
    super.initState();
  }

  int id = 1;
  int count = 1;
  String radioItem;
  String radioItemsize;

  List<RadioButtonOptions> _radioOptions = [];
  List<RadioButtonOptionsSizes> _radioOptionsSizes = [];
  List<CheckBoxOptions> _checkBoxOptions = [];
  List<SwitchesItems> _switchOptions = [];

  int getradiobtn(int length) {
    List<RadioButtonOptions> radiolist = [];
    for (int i = 1; i <= length; i++) {
      radiolist.add(RadioButtonOptions(
        index: _addItemModelList.spreads[i - 1].id,
        title: _addItemModelList.spreads[i - 1].name ?? STR_BLANK,
      ));
    }

    setState(() {
      _radioOptions = radiolist;
    });

    return radiolist.length;
  }

  int getradiobtnsize(int length) {
    List<RadioButtonOptionsSizes> radiolistsize = [];
    for (int i = 1; i <= length; i++) {
      radiolistsize.add(RadioButtonOptionsSizes(
        index: _addItemModelList.sizePrizes[i - 1].id ?? 0,
        title: _addItemModelList.sizePrizes[i - 1].size ?? STR_BLANK,
        secondary: _addItemModelList.sizePrizes[i - 1].price ?? STR_BLANK,
      ));
    }

    setState(() {
      _radioOptionsSizes = radiolistsize;
    });
    return radiolistsize.length;
  }

  int gettablelist(List<GetTableList> getlist) {
    List<TableList> _tablelist = [];
    for (int i = 0; i < getlist.length; i++) {
      _tablelist.add(TableList(
        id: getlist[i].id,
        restid: widget.restId,
        name: getlist[i].tableName,
      ));
    }
    setState(() {
      _dropdownItemsTable = _tablelist;
    });
    getlistoftable();
    return _tablelist.length;
  }

  int checkboxbtn(int length) {
    List<CheckBoxOptions> _checkboxlist = [];
    for (int i = 1; i <= length; i++) {
      _checkboxlist.add(CheckBoxOptions(
          price: _addItemModelList.extras[i - 1].price ?? STR_BLANK,
          isChecked: false,
          index: _addItemModelList.extras[i - 1].id ?? 0,
          title: _addItemModelList.extras[i - 1].name ?? STR_BLANK));
    }
    setState(() {
      _checkBoxOptions = _checkboxlist;
    });

    return _checkboxlist.length;
  }

  int switchbtn(int length) {
    List<SwitchesItems> _switchlist = [];
    for (int i = 1; i <= length; i++) {
      _switchlist.add(SwitchesItems(
          option1: _addItemModelList.switches[i - 1].option1 ?? STR_BLANK,
          option2: _addItemModelList.switches[i - 1].option2 ?? STR_BLANK,
          index: _addItemModelList.switches[i - 1].id ?? 0,
          title: _addItemModelList.switches[i - 1].name ?? STR_BLANK,
          isSelected: [true, false]));
    }

    setState(() {
      _switchOptions = _switchlist;
    });

    return _switchlist.length;
  }

  Widget steppercount() {
    return Container(
      height: 24,
      width: 150,
      child: Row(children: <Widget>[
        InkWell(
          onTap: () {
            if (count > 1) {
              setState(() {
                --count;
                print(count);
              });
              items.quantity = count;
            }
          },
          splashColor: ((Globle().colorscode) != null)
              ? getColorByHex(Globle().colorscode)
              : orangetheme,
          child: Container(
            decoration: BoxDecoration(
                color: ((Globle().colorscode) != null)
                    ? getColorByHex(Globle().colorscode)
                    : orangetheme,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            alignment: Alignment.center,
            child: Icon(
              Icons.remove,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13, right: 13),
          child: Text(
            count.toString(),
            style: TextStyle(
                fontSize: FONTSIZE_16,
                fontFamily: KEY_FONTFAMILY,
                fontWeight: FontWeight.w600,
                color: greytheme700),
          ),
        ),
        InkWell(
          onTap: () {
            if (count < 10) {
              setState(() {
                ++count;
                print(count);
              });
              items.quantity = count;
            }
          },
          splashColor: Colors.lightBlue,
          child: Container(
            decoration: BoxDecoration(
                color: ((Globle().colorscode) != null)
                    ? getColorByHex(Globle().colorscode)
                    : orangetheme,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            alignment: Alignment.center,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      top: false,
      right: false,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: isLoding
            ? Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Loading",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: FONTSIZE_15,
                            fontFamily: KEY_FONTFAMILY,
                            fontWeight: FontWeight.w500,
                            color: greytheme1200),
                      ),
                    ),
                    CircularProgressIndicator()
                  ],
                ),
              )
            : CustomScrollView(
                controller: _controller,
                slivers: <Widget>[_getmainviewTableno(), _getOptions()],
              ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
            onTap: () async {
              var alreadyAdde = await Preference.getPrefValue<bool>(
                  PreferenceKeys.isAlreadyINCart);
              var restauran = await (Preference.getPrefValue<int>(
                  PreferenceKeys.restaurantID));
              var restaurantName = await (Preference.getPrefValue<String>(
                  PreferenceKeys.restaurantName));
              var orderId =
                  await Preference.getPrefValue<int>(PreferenceKeys.orderId);
              if (orderId != null) {
                if (restauran == widget.restId) {
                  if (_updateOrderModel == null) {
                    _updateOrderModel = UpdateOrderModel();
                  }
                  _updateOrderModel.orderId = orderId;
                  _updateOrderModel.userId = Globle().loginModel.data.id;
                  if (items == null) {
                    items = Item();
                  }

                  _updateOrderModel.items = items;
                  _updateOrderModel.items.quantity = count;
                  _updateOrderModel.items.itemId = widget.itemId;
                  _updateOrderModel.items.extra = extra ?? null;
                  _updateOrderModel.items.spreads =
                      spread == null ? [] : [spread];
                  _updateOrderModel.items.switches = switches ?? [];
                  _updateOrderModel.items.sizes = size == null ? [] : [size];
                  print(_updateOrderModel.toJson());
                  DialogsIndicator.showLoadingDialog(
                      context, _keyLoader, STR_BLANK);
                  _addItemPagepresenter.updateOrder(_updateOrderModel, context);
                } else {
                  Constants.showAlert(
                      KEY_INVALIDORDER, KEY_ORDERFROMREST, context);
                }
              } else {
                checkForItemIsAlreadyInCart(
                    alreadyAdde, restauran, restaurantName);
              }
            },
            child: Container(
                height: 54,
                decoration: BoxDecoration(
                    color: ((Globle().colorscode) != null)
                        ? getColorByHex(Globle().colorscode)
                        : orangetheme,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Center(
                  child: Text(
                    KEY_ADDTOCART,
                    style: TextStyle(
                        fontFamily: KEY_FONTFAMILY,
                        fontWeight: FontWeight.w600,
                        fontSize: FONTSIZE_16,
                        color: Colors.white),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  void checkForItemIsAlreadyInCart(
      bool alreadyAdde, int restauran, String restaurantName) {
    if (addMenuToCartModel == null) {
      addMenuToCartModel = AddItemsToCartModel();
    }
    addMenuToCartModel.userId = Globle().loginModel.data.id;
    addMenuToCartModel.restId = widget.restId;
    addMenuToCartModel.tableId = _dropdownTableNumber;
    if (items == null) {
      items = Item();
    }

    addMenuToCartModel.items = [items];
    addMenuToCartModel.items[0].itemId = widget.itemId;
    addMenuToCartModel.items[0].extra = extra ?? [];
    addMenuToCartModel.items[0].spreads = spread == null ? [] : [spread];
    addMenuToCartModel.items[0].switches = switches ?? [];
    addMenuToCartModel.items[0].quantity = count;
    addMenuToCartModel.items[0].sizes = size == null ? [] : [size];
    print(addMenuToCartModel.toJson());
    if (alreadyAdde != null && restauran != null) {
      if ((widget.restId != restauran) && (alreadyAdde)) {
        cartAlert(
            STR_STARTNEWORDER,
            (restaurantName != null)
                ? STR_YOUR_UNFINIHED_ORDER + "$restaurantName" + STR_WILLDELETE
                : STR_UNFINISHEDORDER,
            context);
      } else {
        DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
        _addItemPagepresenter.performaddMenuToCart(addMenuToCartModel, context);
      }
    } else {
      DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
      _addItemPagepresenter.performaddMenuToCart(addMenuToCartModel, context);
    }
  }

  void cartAlert(String title, String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
                content: Text(
                  message,
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, right: 5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: RaisedButton(
                            color: ((Globle().colorscode) != null)
                                ? getColorByHex(Globle().colorscode)
                                : orangetheme,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              STR_NEWORDER,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: FONTSIZE_15,
                                  fontFamily: KEY_FONTFAMILY,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              DialogsIndicator.showLoadingDialog(
                                  context, _keyLoader, "");
                              _addItemPagepresenter.clearCart(context);
                              Preference.setPersistData<int>(
                                  widget.restId, PreferenceKeys.restaurantID);
                              Preference.setPersistData<bool>(
                                  true, PreferenceKeys.isAlreadyINCart);
                              Preference.setPersistData<String>(widget.restName,
                                  PreferenceKeys.restaurantName);
                              Globle().dinecartValue = 0;
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.32,
                          height: 40,
                          child: RaisedButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: greytheme100),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              STR_CANCEL,
                              style: TextStyle(
                                  fontSize: FONTSIZE_17,
                                  fontFamily: KEY_FONTFAMILY,
                                  fontWeight: FontWeight.w400,
                                  color: greytheme100),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget _foodItemLogo() {
    return Container(
      child: new Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: CachedNetworkImage(
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            imageUrl: BaseUrl.getBaseUrlImages() + "${widget.itemImage}",
            errorWidget: (context, url, error) => Image.asset(
              RESTAURANT_IMAGE_PATH,
              fit: BoxFit.fill,
            ),
            imageBuilder: (context, imageProvider) => Container(
              height: 195,
              width: double.infinity,
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
        ),
      ),
    );
  }

  Widget _getmainviewTableno() {
    return SliverToBoxAdapter(
      child: _foodItemLogo(),
    );
  }

  getlistoftable() {
    if (_dropdownItemsTable != null) {
      if (_dropdownItemsTable.length >= 0) {
        setState(() {
          isTableList = true;
        });
        return;
      }
      setState(() {
        isTableList = false;
      });
    }
    setState(() {
      isTableList = false;
    });
  }

  Widget _getOptions() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10, left: 26),
                child: Text(
                  StringUtils.capitalize(widget.title),
                  style: TextStyle(
                      fontFamily: KEY_FONTFAMILY,
                      fontSize: FONTSIZE_16,
                      fontWeight: FontWeight.w600,
                      color: greytheme700),
                ),
              ),
              // ),
              Padding(
                padding: EdgeInsets.only(left: 26, top: 12),
                child: Text(
                  StringUtils.capitalize(widget.description),
                  style: TextStyle(
                      fontFamily: KEY_FONTFAMILY,
                      fontSize: FONTSIZE_16,
                      color: greytheme1000),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 26),
                    child: Text(
                      STR_QUANTITY,
                      style: TextStyle(
                          fontFamily: KEY_FONTFAMILY,
                          fontSize: FONTSIZE_16,
                          color: greytheme700),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  steppercount()
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 2,
              ),
              _radioOptions.length == 0
                  ? Container()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 26, top: 15),
                          child: Text(
                            STR_SPREADS,
                            style: TextStyle(
                                fontFamily: KEY_FONTFAMILY,
                                fontSize: FONTSIZE_16,
                                color: greytheme700),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 26, top: 8),
                          child: Text(
                            STR_SELECT_OPTION,
                            style: TextStyle(
                                fontFamily: KEY_FONTFAMILY,
                                fontSize: FONTSIZE_12,
                                color: greytheme1000),
                          ),
                        ),
                        _getRadioOptions(),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          thickness: 2,
                        ),
                      ],
                    ),

              _checkBoxOptions.length == 0
                  ? Container()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 26, top: 15),
                          child: Text(
                            STR_ADDITIONS,
                            style: TextStyle(
                                fontFamily: KEY_FONTFAMILY,
                                fontSize: FONTSIZE_16,
                                color: greytheme700),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 26, top: 8),
                          child: Text(
                            STR_MULIPLE_OPTIONS,
                            style: TextStyle(
                                fontFamily: KEY_FONTFAMILY,
                                fontSize: FONTSIZE_12,
                                color: greytheme1000),
                          ),
                        ),
                        _getCheckBoxOptions(),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 2,
                        ),
                      ],
                    ),

              _switchOptions.length == 0
                  ? Container()
                  : Column(
                      children: <Widget>[
                        togglebutton(),
                        Divider(
                          thickness: 2,
                        ),
                      ],
                    ),

              SizedBox(
                height: 10,
              ),
              _radioOptionsSizes.length == 0
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 26, top: 15),
                          child: Text(
                            STR_SIZE,
                            style: TextStyle(
                                fontFamily: KEY_FONTFAMILY,
                                fontSize: FONTSIZE_16,
                                color: greytheme700),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 26, top: 8),
                          child: Text(
                            STR_SELECT_OPTION,
                            style: TextStyle(
                                fontFamily: KEY_FONTFAMILY,
                                fontSize: FONTSIZE_12,
                                color: greytheme1000),
                          ),
                        ),
                      ],
                    ),

              _getRadioOptionsSizes(),
              SizedBox(
                height: 10,
              )
            ]),
      ),
    );
  }

  _getRadioOptionsSizes() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _radioOptionsSizes.length > 0
            ? _radioOptionsSizes
                .map((radionBtnsize) => Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: RadioListTile(
                        title: radionBtnsize.title != null
                            ? Text(StringUtils.capitalize(
                                "${radionBtnsize.title}"))
                            : Text(STR_DATA),
                        secondary: Text(
                                '${_addItemPageModelList.currencySymbol} ' +
                                    "${radionBtnsize.secondary}") ??
                            Text(STR_DATA),
                        groupValue: sizesid,
                        value: radionBtnsize.index,
                        dense: true,
                        activeColor: ((Globle().colorscode) != null)
                            ? getColorByHex(Globle().colorscode)
                            : orangetheme,
                        onChanged: (val) {
                          setState(() {
                            if (size == null) {
                              size = Sizes();
                            }
                            radioItemsize = radionBtnsize.title;
                            print(radionBtnsize.title);
                            sizesid = radionBtnsize.index;
                            size.sizeid = sizesid;
                          });
                        },
                      ),
                    ))
                .toList()
            : [Container()]);
  }

  _getRadioOptions() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _radioOptions.length > 0
            ? _radioOptions
                .map((radionBtn) => Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: RadioListTile(
                        title: radionBtn.title != null
                            ? Text(StringUtils.capitalize("${radionBtn.title}"))
                            : Text(STR_DATA),
                        groupValue: id,
                        value: radionBtn.index,
                        dense: true,
                        activeColor: ((Globle().colorscode) != null)
                            ? getColorByHex(Globle().colorscode)
                            : orangetheme,
                        onChanged: (val) {
                          setState(() {
                            if (spread == null) {
                              spread = Spreads();
                            }
                            radioItem = radionBtn.title;
                            print(radionBtn.title);
                            id = radionBtn.index;
                            spread.spreadId = id;
                          });
                        },
                      ),
                    ))
                .toList()
            : [Container()]);
  }

  Widget togglebutton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _switchOptions.length > 0
          ? _switchOptions
              .map((switchs) => Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 28),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                switchs.title ?? STR_BLANK,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: FONTSIZE_16,
                                    fontFamily: KEY_FONTFAMILY,
                                    fontWeight: FontWeight.w500,
                                    color: greytheme700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 40,
                          child: ToggleButtons(
                              borderColor: greytheme1300,
                              fillColor: ((Globle().colorscode) != null)
                                  ? getColorByHex(Globle().colorscode)
                                  : orangetheme,
                              borderWidth: 2,
                              selectedBorderColor: Colors.transparent,
                              selectedColor: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              children: <Widget>[
                                Container(
                                  width: 85,
                                  child: Text(
                                    "${switchs.option1}" ?? STR_BLANK,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: FONTSIZE_14,
                                        fontFamily: KEY_FONTFAMILY,
                                        fontWeight: FontWeight.w500,
                                        color: (switchs.isSelected[0] == true)
                                            ? Colors.white
                                            : greytheme700),
                                  ),
                                ),
                                Container(
                                  width: 85,
                                  child: Text(
                                    '${switchs.option2}' ?? STR_BLANK,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: FONTSIZE_14,
                                        fontFamily: KEY_FONTFAMILY,
                                        fontWeight: FontWeight.w500,
                                        color: (switchs.isSelected[1] == false)
                                            ? greytheme700
                                            : Colors.white),
                                  ),
                                ),
                              ],
                              onPressed: (int index) {
                                setState(() {
                                  switchs.isSelected[0] =
                                      !switchs.isSelected[0];
                                  switchs.isSelected[1] =
                                      !switchs.isSelected[1];
                                });
                                if (switches == null) {
                                  switches = [];
                                }
                                if (switches.length > 0) {
                                  for (int i = 0; i < switches.length; i++) {
                                    if (switches[i].switchId == switchs.index) {
                                      if (index == 0) {
                                        switches[i].switchOption =
                                            switchs.option1;
                                      }
                                      if (index == 1) {
                                        switches[i].switchOption =
                                            switchs.option2;
                                      }
                                    } else {
                                      var switchItem = Switches();
                                      switchItem.switchId = switchs.index;
                                      if (index == 0) {
                                        switchItem.switchOption =
                                            switchs.option1;
                                      }
                                      if (index == 1) {
                                        switchItem.switchOption =
                                            switchs.option2;
                                      }
                                      switches.add(switchItem);
                                    }
                                  }
                                } else {
                                  var switchItem = Switches();
                                  switchItem.switchId = switchs.index;
                                  if (index == 0) {
                                    switchItem.switchOption = switchs.option1;
                                  }
                                  if (index == 1) {
                                    switchItem.switchOption = switchs.option2;
                                  }
                                  switches.add(switchItem);
                                }
                              },
                              isSelected: switchs.isSelected),
                        )
                      ],
                    ),
                  ))
              .toList()
          : [Container()],
    );
  }

  _getCheckBoxOptions() {
    return Column(
        children: _checkBoxOptions.length > 0
            ? _checkBoxOptions
                .map((checkBtn) => CheckboxListTile(
                    activeColor: ((Globle().colorscode) != null)
                        ? getColorByHex(Globle().colorscode)
                        : orangetheme,
                    value: checkBtn.isChecked,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (val) {
                      setState(() {
                        if (extra == null) {
                          extra = [];
                        }
                        if (extra.length > 0) {
                          if (val) {
                            var ext = Extras();
                            ext.extraId = checkBtn.index;
                            extra.add(ext);
                          } else {
                            for (int i = 0; i < extra.length; i++) {
                              if (checkBtn.index == extra[i].extraId) {
                                extra.removeAt(i);
                              }
                            }
                          }
                        } else {
                          var ext = Extras();
                          ext.extraId = checkBtn.index;
                          extra.add(ext);
                        }
                        checkBtn.isChecked = val;
                      });
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          checkBtn.title != null
                              ? StringUtils.capitalize(checkBtn.title)
                              : STR_BLANK,
                          style: TextStyle(fontSize: 13, color: greytheme700),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 100,
                          ),
                          flex: 2,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(
                              "${_addItemPageModelList.currencySymbol} " +
                                      checkBtn.price.toString() ??
                                  STR_BLANK,
                              style: TextStyle(
                                  fontSize: FONTSIZE_13, color: greytheme700),
                            ),
                          ),
                        ),
                        // ),
                      ],
                    )))
                .toList()
            : [Container()]);
  }

  void showAlertSuccess(String title, String message, BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Text(
                  StringUtils.capitalize(title),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: FONTSIZE_18,
                      fontFamily: KEY_FONTFAMILY,
                      fontWeight: FontWeight.w600,
                      color: greytheme700),
                ),
                content:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Image.asset(
                    SUCCESS_IMAGE_PATH,
                    width: 75,
                    height: 75,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    StringUtils.capitalize(message),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: FONTSIZE_15,
                        fontFamily: KEY_FONTFAMILY,
                        fontWeight: FontWeight.w500,
                        color: greytheme700),
                  )
                ]),
                actions: <Widget>[
                  Divider(
                    endIndent: 15,
                    indent: 15,
                    color: Colors.black,
                  ),
                  FlatButton(
                    child: Text(STR_OK,
                        style: TextStyle(
                            fontSize: FONTSIZE_16,
                            fontFamily: KEY_FONTFAMILY,
                            fontWeight: FontWeight.w600,
                            color: greytheme700)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ));
  }

  @override
  void addItemfailed() {
    setState(() {
      isLoding = false;
    });
  }

  @override
  void addItemsuccess(List<AddItemModelList> _additemlist,
      AddItemPageModelList addItemPageModelList1) {
    setState(() {
      isLoding = false;
    });
    _addItemModelList = _additemlist[0];

    getradiobtn(_addItemModelList.spreads.length);

    getradiobtnsize(_addItemModelList.sizePrizes.length);

    checkboxbtn(_addItemModelList.extras.length);

    switchbtn(_addItemModelList.switches.length);
    setState(() {
      _addItemPageModelList = addItemPageModelList1;
    });
    // Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void addMenuToCartfailed() {}

  @override
  void addMenuToCartsuccess() {
    Globle().dinecartValue += 1;
    Preference.setPersistData<int>(
        Globle().dinecartValue, PreferenceKeys.dineCartItemCount);
    Preference.setPersistData<int>(widget.restId, PreferenceKeys.restaurantID);
    Preference.setPersistData<bool>(true, PreferenceKeys.isAlreadyINCart);
    Preference.setPersistData<String>(widget.restName, PreferenceKeys.restaurantName);
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();

    showAlertSuccess(
        "${widget.title}", "${widget.title} " + STR_CARTADDED, context);
  }

  @override
  void addTablebnoSuccces() {}

  @override
  void addTablenofailed() {}

  @override
  void getTableListFailed() {}

  @override
  void getTableListSuccess(List<GetTableList> _getlist) {
    getTableListModel = _getlist[0];
    if (_getlist.length > 0) {
      gettablelist(_getlist);
    }
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void clearCartFailed() {}

  @override
  void clearCartSuccess() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    Preference.setPersistData(null, PreferenceKeys.restaurantID);
    Preference.setPersistData(null, PreferenceKeys.isAlreadyINCart);
    Preference.setPersistData(null, PreferenceKeys.restaurantName);
  }

  @override
  void updateOrderFailed() {}

  @override
  void updateOrderSuccess() {
    Globle().dinecartValue += 1;
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    showAlertSuccess(
        "${widget.title}", "${widget.title} " + STR_CARTADDED, context);
  }
}

class CheckBoxOptions {
  int index;
  String title;
  String price;
  bool isChecked;

  CheckBoxOptions({
    this.index,
    this.title,
    this.price,
    this.isChecked,
  });
}

class RadioButtonOptions {
  int index;
  String title;

  RadioButtonOptions({this.index, this.title});
}

class RadioButtonOptionsSizes {
  int index;
  String title;
  String secondary;

  RadioButtonOptionsSizes({this.index, this.title, this.secondary});
}

class SwitchesItems {
  int index;
  String title;
  String option1;
  List<bool> isSelected;
  String option2;
  SwitchesItems(
      {this.index, this.title, this.option1, this.option2, this.isSelected});
}

class TableList {
  String name;
  int restid;
  int id;
  TableList({this.restid, this.id, this.name});
}

class AddTableno {
  int userId;
  int tableId;
  int restId;

  AddTableno({this.restId, this.tableId, this.userId});
}
