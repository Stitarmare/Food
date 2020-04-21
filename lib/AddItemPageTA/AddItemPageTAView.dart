import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPageTA/AddItemPageTAContractor.dart';
import 'package:foodzi/AddItemPageTA/AddItemPageTAPresenter.dart';
import 'package:foodzi/Models/AddItemPageModel.dart';
import 'package:foodzi/Models/AddMenuToCartModel.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/AppTextfield.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AddItemPageTAView extends StatefulWidget {
  String title;
  String description;
  int itemId;
  int restId;
  String imageUrl;
  String restName;
  AddItemPageTAView(
      {this.title,
      this.description,
      this.itemId,
      this.restId,
      this.imageUrl,
      String restName});
  _AddItemPageTAViewState createState() => _AddItemPageTAViewState();
}

class _AddItemPageTAViewState extends State<AddItemPageTAView>
    implements
        AddItemPageTAModelView,
        AddmenuToCartModelviews,
        ClearCartTAModelView {
  List<bool> isSelected;

  AddItemsToCartModel addMenuToCartModel;

  Item items;

  List<Extras> extra;

  Spreads spread;
  Sizes size;
  List<Sizes> sizes;
  List<Switches> switches;
  bool isLoding = false;
  AddItemPageModelList _addItemPageModelList;
  AddItemModelList _addItemModelList;
  int itemId;
  int restId;
  ScrollController _controller = ScrollController();
  AddItemPageTApresenter _addItemPagepresenter;
  bool alreadyAddedTA = false;
  int restaurantTA;
  int sizesid = 1;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  ProgressDialog progressDialog;

  String specialReq;
  Spreads defaultSpread;

  List<Extras> defaultExtra;

  Sizes defaultSize;
  List<Switches> defaultSwitch;
  @override
  void initState() {
    _addItemPagepresenter = AddItemPageTApresenter(this, this, this);
    isSelected = [true, false];
    setState(() {
      isLoding = true;
    });
    _addItemPagepresenter.performAddItem(widget.itemId, widget.restId, context);
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
        spreadDefault:
            _addItemModelList.spreads[i - 1].spreadDefault ?? STR_BLANK,
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

  int checkboxbtn(int length) {
    List<CheckBoxOptions> _checkboxlist = [];
    for (int i = 1; i <= length; i++) {
      _checkboxlist.add(CheckBoxOptions(
        price: _addItemModelList.extras[i - 1].price ?? STR_BLANK,
        isChecked: (_addItemModelList.extras[i - 1].extraDefault == "yes")
            ? true
            : false,
        index: _addItemModelList.extras[i - 1].id ?? 0,
        title: _addItemModelList.extras[i - 1].name ?? STR_BLANK,
        defaultAddition: _addItemModelList.extras[i - 1].extraDefault,
      ));
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
          index: _addItemModelList.switches[i - 1].id,
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
          splashColor: getColorByHex(Globle().colorscode),
          child: Container(
            decoration: BoxDecoration(
                color: getColorByHex(Globle().colorscode),
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
                color: getColorByHex(Globle().colorscode),
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
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);

    return SafeArea(
      left: false,
      top: false,
      right: false,
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
          child: Container(
            height: 160,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: totalamounttext(),
                ),
                GestureDetector(
                  onTap: () async {
                    if (addMenuToCartModel == null) {
                      addMenuToCartModel = AddItemsToCartModel();
                    }
                    addMenuToCartModel.userId = Globle().loginModel.data.id;
                    addMenuToCartModel.restId = widget.restId;
                    addMenuToCartModel.tableId = null;
                    if (items == null) {
                      items = Item();
                    }

                    addMenuToCartModel.items = [items];
                    addMenuToCartModel.items[0].itemId = widget.itemId;
                    addMenuToCartModel.items[0].preparationNote = specialReq;
                    addMenuToCartModel.items[0].extra = extra ?? defaultExtra;
                    addMenuToCartModel.items[0].spreads = spread == null
                        ? (defaultSpread != null) ? [defaultSpread] : []
                        : [spread];
                    addMenuToCartModel.items[0].switches =
                        (switches != []) ? switches : (defaultSwitch);
                    addMenuToCartModel.items[0].quantity = count;
                    addMenuToCartModel.items[0].sizes =
                        size == null ? [defaultSize] : [size];

                    print(addMenuToCartModel.toJson());

                    var alreadyAddedTA = await Preference.getPrefValue<bool>(
                        PreferenceKeys.isAlreadyINCart);
                    var restaurantTA = await Preference.getPrefValue<int>(
                        PreferenceKeys.restaurantID);
                    var restaurantName = await (Preference.getPrefValue<String>(
                        PreferenceKeys.restaurantName));
                    if (alreadyAddedTA != null && restaurantTA != null) {
                      if ((widget.restId != restaurantTA) && (alreadyAddedTA)) {
                        cartAlert(
                            STR_STARTNEWORDER,
                            (restaurantName != null)
                                ? STR_YOUR_UNFINIHED_ORDER +
                                    "$restaurantName" +
                                    STR_WILLDELETE
                                : STR_UNFINISHEDORDER,
                            context);
                      } else {
                        // DialogsIndicator.showLoadingDialog(
                        //     context, _keyLoader, STR_BLANK);
                        await progressDialog.show();
                        _addItemPagepresenter.performaddMenuToCart(
                            addMenuToCartModel, context);
                      }
                    } else {
                      // DialogsIndicator.showLoadingDialog(
                      //     context, _keyLoader, STR_BLANK);
                      await progressDialog.show();
                      _addItemPagepresenter.performaddMenuToCart(
                          addMenuToCartModel, context);
                    }
                  },
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                        color: getColorByHex(Globle().colorscode),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Center(
                      child: Text(
                        STR_ADDTOCART,
                        style: TextStyle(
                            fontFamily: KEY_FONTFAMILY,
                            fontWeight: FontWeight.w600,
                            fontSize: FONTSIZE_16,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget totalamounttext() {
    return Column(
      children: <Widget>[
        Container(
          // color: Colors.grey,

          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  '${"Total "}' +
                      '${getCurrencySymbol()}' +
                      '${getTotalText()}',
                  style: TextStyle(
                      fontSize: 20,
                      color: redtheme,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: AppTextField(
            onChanged: (text) {
              specialReq = text;
            },
            placeHolderName: STR_SPLREQ,
            validator: validatepassword,
            onSaved: (String value) {
              print(value);
              specialReq = value;
            },
          ),
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }

  String validatepassword(String value) {
    if (value.length == 0) {
      return KEY_PASSWORD_REQUIRED;
    } else if (value.length < 1000) {
      return KEY_THIS_SHOULD_BE_MIN_8_CHAR_LONG;
    }
    return null;
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
                            color: getColorByHex(Globle().colorscode),
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
                            onPressed: () async {
                              // DialogsIndicator.showLoadingDialog(
                              //     context, _keyLoader, STR_BLANK);
                              await progressDialog.show();
                              _addItemPagepresenter.clearCart(context);
                              Preference.setPersistData<int>(
                                  widget.restId, PreferenceKeys.restaurantID);
                              Preference.setPersistData<bool>(
                                  true, PreferenceKeys.isAlreadyINCart);
                              Preference.setPersistData<String>(widget.restName,
                                  PreferenceKeys.restaurantName);
                              Globle().dinecartValue = 0;
                              Preference.setPersistData<int>(
                                  0, PreferenceKeys.dineCartItemCount);
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

  Widget _getmainviewTableno() {
    return SliverToBoxAdapter(child: _foodItemLogo());
  }

  Widget _foodItemLogo() {
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
        imageBuilder: (context, imageProvider) => Container(
          height: 175,
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
    );
  }

  Widget _getOptions() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 25, left: 26),
                child: Text(
                  StringUtils.capitalize(widget.title),
                  style: TextStyle(
                      fontFamily: KEY_FONTFAMILY,
                      fontSize: FONTSIZE_16,
                      fontWeight: FontWeight.w600,
                      color: greytheme700),
                ),
              ),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 35,
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            //margin: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.4),
                                Container(
                                  child: Text(
                                    _addItemModelList.spreadsLabel ??
                                        STR_SPREADS,
                                    style: TextStyle(
                                        fontFamily: KEY_FONTFAMILY,
                                        fontSize: FONTSIZE_16,
                                        color: redtheme),
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.13),
                                (_addItemModelList.spreadsrequired == "yes")
                                    ? Center(
                                        child: Container(
                                          decoration:
                                              BoxDecoration(color: redtheme),
                                          width: 65,
                                          height: 20,
                                          child: Center(
                                            child: Text(
                                              STR_REQUIRED,
                                              style: TextStyle(
                                                  fontFamily: KEY_FONTFAMILY,
                                                  fontSize: FONTSIZE_10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 35,
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.4),
                                Container(
                                  child: Text(
                                    _addItemModelList.extrasLabel ??
                                        STR_ADDITIONS,
                                    style: TextStyle(
                                        fontFamily: KEY_FONTFAMILY,
                                        fontSize: FONTSIZE_16,
                                        color: redtheme),
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.1),
                                (_addItemModelList.extrasrequired == "yes")
                                    ? Center(
                                        child: Container(
                                          decoration:
                                              BoxDecoration(color: redtheme),
                                          width: 65,
                                          height: 20,
                                          child: Center(
                                            child: Text(
                                              STR_REQUIRED,
                                              style: TextStyle(
                                                  fontFamily: KEY_FONTFAMILY,
                                                  fontSize: FONTSIZE_10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 35,
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.4),
                                Container(
                                  child: Text(
                                    _addItemModelList.switchesLabel ??
                                        STR_SWITCHES,
                                    style: TextStyle(
                                        fontFamily: KEY_FONTFAMILY,
                                        fontSize: FONTSIZE_16,
                                        color: redtheme),
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.11),
                                (_addItemModelList.switchesrequired == "yes")
                                    ? Center(
                                        child: Container(
                                          decoration:
                                              BoxDecoration(color: redtheme),
                                          width: 65,
                                          height: 20,
                                          child: Center(
                                            child: Text(
                                              STR_REQUIRED,
                                              style: TextStyle(
                                                  fontFamily: KEY_FONTFAMILY,
                                                  fontSize: FONTSIZE_10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                        togglebutton(),
                        SizedBox(
                          height: 10,
                        ),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 35,
                              decoration:
                                  BoxDecoration(color: Colors.grey[200]),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4),
                                  Container(
                                    child: Text(
                                      STR_SIZE,
                                      style: TextStyle(
                                          fontFamily: KEY_FONTFAMILY,
                                          fontSize: FONTSIZE_16,
                                          color: redtheme),
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.21),
                                  Center(
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: redtheme),
                                      width: 65,
                                      height: 20,
                                      child: Center(
                                        child: Text(
                                          STR_REQUIRED,
                                          style: TextStyle(
                                              fontFamily: KEY_FONTFAMILY,
                                              fontSize: FONTSIZE_10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
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
                        _getRadioOptionsSizes(),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
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
                        secondary: Text(Globle().currencySymb != null
                                ? "${Globle().currencySymb} " +
                                    "${radionBtnsize.secondary}"
                                : STR_R_CURRENCY_SYMBOL +
                                    "${radionBtnsize.secondary}") ??
                            Text(STR_DATA),
                        groupValue: defaultSize.sizeid,
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
                        groupValue: (radionBtn.spreadDefault == "yes")
                            ? radionBtn.index
                            : id,
                        value: radionBtn.index,
                        dense: true,
                        activeColor: getColorByHex(Globle().colorscode),
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

  String getCurrencySymbol() {
    if (_addItemPageModelList != null) {
      if (_addItemPageModelList.currencySymbol != null) {
        return _addItemPageModelList.currencySymbol;
      }
    }

    return "";
  }

  String getTotalText() {
    if (_addItemModelList != null) {
      if (_addItemModelList.price != "") {
        return _addItemModelList.price;
      } else if (_addItemModelList.sizePrizes.length > 0) {
        return _addItemModelList.sizePrizes[0].price;
      }
    }
    return "";
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
                              fillColor: getColorByHex(Globle().colorscode),
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
                    activeColor: getColorByHex(Globle().colorscode),
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
                              Globle().currencySymb != null
                                  ? Globle().currencySymb +
                                      STR_SPACE +
                                      checkBtn.price.toString()
                                  : STR_BLANK,
                              style: TextStyle(
                                  fontSize: FONTSIZE_13, color: greytheme700),
                            ),
                          ),
                        ),
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
                        fontSize: 15,
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
  Future<void> addItemfailed() async {
    setState(() {
      isLoding = false;
    });
    await progressDialog.hide();
  }

  @override
  Future<void> addItemsuccess(List<AddItemModelList> _additemlist) async {
    setState(() {
      isLoding = false;
    });
    _addItemModelList = _additemlist[0];

    getradiobtn(_addItemModelList.spreads.length);
    getRequiredSpread(_addItemModelList.spreads.length);

    checkboxbtn(_addItemModelList.extras.length);
    getRequiredExtra(_addItemModelList.extras.length);

    switchbtn(_addItemModelList.switches.length);
    getRequiredSwitch(_addItemModelList.switches.length);

    getradiobtnsize(_addItemModelList.sizePrizes.length);
    getRequiredSize(_addItemModelList.sizePrizes.length);

    await progressDialog.hide();
    // Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  Future<void> addMenuToCartfailed() async {
    await progressDialog.hide();
  }

  @override
  Future<void> addMenuToCartsuccess() async {
    specialReq = "";
    Globle().takeAwayCartItemCount += 1;
    Preference.setPersistData<int>(
        Globle().takeAwayCartItemCount, PreferenceKeys.takeAwayCartCount);
    Preference.setPersistData(widget.restId, PreferenceKeys.restaurantID);
    Preference.setPersistData(true, PreferenceKeys.isAlreadyINCart);
    Preference.setPersistData(widget.restName, PreferenceKeys.restaurantName);
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    await progressDialog.hide();
    showAlertSuccess(
        "${widget.title}", "${widget.title} " + STR_CARTADDED, context);
  }

  @override
  Future<void> clearCartFailed() async {
    await progressDialog.hide();
  }

  @override
  Future<void> clearCartSuccess() async {
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    Preference.setPersistData(null, PreferenceKeys.restaurantID);
    Preference.setPersistData(null, PreferenceKeys.isAlreadyINCart);
    Preference.setPersistData(null, PreferenceKeys.restaurantName);
    await progressDialog.hide();
  }

  void getRequiredSpread(int length) {
    for (int i = 1; i <= length; i++) {
      defaultSpread = Spreads();
      if (_addItemModelList.spreads[i - 1].spreadDefault == "yes") {
        // defaultSpread = _addItemModelList.spreads[i - 1] as Spreads;
        defaultSpread.spreadId = _addItemModelList.spreads[i - 1].id;
      } else {
        defaultSpread = null;
      }
    }
  }

  void getRequiredExtra(int length) {
    for (int i = 1; i <= length; i++) {
      Extras extradefault = Extras();
      defaultExtra = List<Extras>();
      if (_addItemModelList.extras[i - 1].extraDefault == "yes") {
        extradefault.extraId = (_addItemModelList.extras[i - 1].id);
        defaultExtra.add(extradefault);
      }
    }
  }

  void getRequiredSize(int length) {
    defaultSize = Sizes();
    if (_addItemModelList.sizePrizes.length > 0) {
      setState(() {
        //defaultSize = _addItemModelList.sizePrizes[0] as Sizes;
        defaultSize.sizeid = _addItemModelList.sizePrizes[0].id;
      });
      print(defaultSize);
    }
  }

  void getRequiredSwitch(int length) {
    for (int i = 1; i <= length; i++) {
      Switches requiredSwitch = Switches();
      defaultSwitch = List<Switches>();
      if (_addItemModelList.switches[i - 1].switchDefault == "yes") {
        requiredSwitch.switchId = (_addItemModelList.switches[i - 1].id);
        requiredSwitch.switchOption = _addItemModelList.switches[i - 1].option1;
        defaultSwitch.add(requiredSwitch);
      } else {
        defaultSwitch = [];
      }
    }
  }
}

// OrderConfirmationView
class CheckBoxOptions {
  int index;
  String title;
  String price;
  bool isChecked;
  String defaultAddition;
  CheckBoxOptions(
      {this.index,
      this.title,
      this.price,
      this.isChecked,
      this.defaultAddition});
}

class RadioButtonOptions {
  int index;
  String title;
  String price;
  String spreadDefault;
  RadioButtonOptions({this.index, this.title, this.price, this.spreadDefault});
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
