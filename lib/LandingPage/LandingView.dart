import 'dart:async';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/BottomTabbar/BottomTabbar.dart';
import 'package:foodzi/CartDetailsPage/CartDetailsPage.dart';
import 'package:foodzi/LandingPage/landinViewPresenter.dart';
import 'package:foodzi/Models/running_order_model.dart';
import 'package:foodzi/Notifications/NotificationView.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayDi.dart';
import 'package:foodzi/ProfilePage/ProfileScreen.dart';
import 'package:foodzi/Setting/Setting.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackView.dart';
import 'package:foodzi/StatusTrackviewTakeAway.dart/StatusTakeAwayView.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:package_info/package_info.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/Drawer/drawer.dart';
import 'package:foodzi/widgets/GeoLocationTracking.dart';
import 'package:foodzi/widgets/WebView.dart';
import 'package:geolocator/geolocator.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Landingview extends DrawerContent {
  final String title;
  final Widget body;
  Landingview({Key key, this.title, this.body});
  @override
  State<StatefulWidget> createState() {
    return _LandingStateView();
  }
}

class _LandingStateView extends State<Landingview>
    implements LandingViewProtocol {
  bool isOrderRunning = false;
  LandingViewPresenter _landingViewPresenter;
  RunningOrderModel _model;
  //final GlobalKey<_LandingStateView> _scaffoldKey =
  //GlobalKey<_LandingStateView>();
  ProgressDialog progressDialog;
  Position _position;
  StreamController<Position> _controllerPosition = new StreamController();
  Stream stream;
  StreamSubscription<double> _streamSubscription;
  bool isIgnoring = true;

  @override
  void initState() {
    stream = Globle().streamController.stream;
    _landingViewPresenter = LandingViewPresenter(this);

    callApi();
    getCurrentOrderID();
    Preference.getPrefValue<String>(STR_CURRENCY_SYMBOL).then((value) {
      if (value != null) {
        Globle().currencySymb = value;
      }
    });
    _getLocation();
    Globle().context = context;
    Globle().navigatorIndex = 1;
    onStreamListen();
    super.initState();
  }

  onStreamListen() {
    if (stream != null) {
      _streamSubscription = stream.listen((onData) {
        // pushToNotification();
        setState(() {
          Globle().notificationFLag = true;
        });
      });
    }
  }

  pushToNotification() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NotificationView()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _getLocation() async {
    GeoLocationTracking.load(context, _controllerPosition);
    _controllerPosition.stream.listen((position) async {
      print(position);
      _position = position;
      if (_position != null) {
        _landingViewPresenter.sendDeviceInfo(_position.latitude.toString(),
            _position.longitude.toString(), context);
      }
    });
  }

  callApi() async {
    // setState(() {
    //     isIgnoring = true;
    //   });
    //await progressDialog.show();
    _landingViewPresenter.getCurrentOrder(context);
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    progressDialog.style(message: STR_PLEASE_WAIT);
    return Card(
      elevation: 100.0,
      child: IgnorePointer(
        ignoring: isIgnoring,
        child: Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,
            actions: <Widget>[
              new IconButton(
                // icon: new Icon(
                //   OMIcons.notifications,
                //   color: greytheme100,
                //   size: 28,
                // ),
                icon: (Globle().notificationFLag)
                    ? Stack(
                        fit: StackFit.passthrough,
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Icon(
                            OMIcons.notifications,
                            color: greytheme100,
                            size: 30,
                          ),
                          Positioned(
                              top: -11,
                              right: -11,
                              child: Badge(
                                  badgeColor: redtheme,
                                  badgeContent: Text(STR_ONE,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white)))
                              // : Text(STR_BLANK),
                              )
                        ],
                      )
                    : Icon(
                        OMIcons.notifications,
                        color: greytheme100,
                        size: 30,
                      ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationView()));
                },
              )
            ],
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Image.asset(MENU_IAMGE_PATH),
              onPressed: widget.onMenuPressed,
            ),
          ),
          body: SingleChildScrollView(child: _getmainView()),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: (isOrderRunning)
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: (FloatingActionButton.extended(
                    onPressed: () {
                      showStatusView();
                    },
                    elevation: 20,
                    highlightElevation: 20,
                    focusElevation: 20,
                    backgroundColor: Colors.white70,
                    label: Text(STR_VIEW_YOUR_ORDER,
                        style: TextStyle(
                            fontSize: FONTSIZE_16,
                            fontFamily: KEY_FONTFAMILY,
                            fontWeight: FontWeight.w600,
                            color: greentheme100)),
                  )),
                )
              : (Container()),
          // bottomNavigationBar: (isOrderRunning)
          //     ? BottomAppBar(
          //         child: Container(
          //           color: greytheme1300,
          //           height: 40,
          //           child: _currentOrdertext(),
          //         ),
          //       )
          //     : Text(""),
        ),
      ),
    );
  }

  getCurrentOrderID() async {
    var currentOrderId =
        await Preference.getPrefValue<int>(PreferenceKeys.orderId);
    setState(() {
      if (currentOrderId != null) {
        isOrderRunning = true;
      } else {
        isOrderRunning = false;
      }
    });
  }

  getCurrentRestID() async {
    var currentRestId =
        await Preference.getPrefValue<int>(PreferenceKeys.currentRestaurantId);
    if (currentRestId != null) {
      return currentRestId;
    }
    return;
  }

  Widget _getmainView() {
    return LimitedBox(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            _buildimage(),
            SizedBox(
              height: 100,
            ),
            _buildMaintext(),
            SizedBox(
              height: 16,
            ),
            _cardoption()
          ],
        ),
      ),
    );
  }

  Widget _buildimage() {
    return Container(
        //width: MediaQuery.of(context).size.width / 1.32,
        height: MediaQuery.of(context).size.height * 0.15,
        child: Image.asset(
          FODDZI_LOGO_3X,
          fit: BoxFit.fill,
        ));
  }

  Widget _buildMaintext() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 30,
        ),
        _buidtext()
      ],
    );
  }

  Widget _buidtext() {
    return LimitedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            STR_HELLO,
            style: TextStyle(
                fontSize: FONTSIZE_16,
                fontFamily: KEY_FONTFAMILY,
                fontWeight: FontWeight.w500,
                color: greytheme100),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            Globle().loginModel.data.firstName ?? '',
            style: TextStyle(
                fontSize: FONTSIZE_32,
                fontFamily: KEY_FONTFAMILY,
                fontWeight: FontWeight.w600,
                color: greytheme500),
          ),
          SizedBox(
            height: 12,
          ),
          Text(STR_FAV_FINGERTIP,
              style: TextStyle(
                  fontSize: FONTSIZE_14,
                  fontFamily: KEY_FONTFAMILY,
                  fontWeight: FontWeight.w500,
                  color: greytheme100))
        ],
      ),
    );
  }

  Widget _cardoption() {
    return LimitedBox(
      child: Container(
        child: Column(
          children: <Widget>[
            _dineincard(),
            SizedBox(
              height: 12,
            ),
            _takeAwaycard(),
          ],
        ),
      ),
    );
  }

  Widget _dineincard() {
    return Center(
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            goToDineIn();
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.14 / 0.15,
            height: 90,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 17,
                ),
                Image.asset(DINE_IN_IMAGE_PATH),
                SizedBox(
                  width: 36,
                ),
                _buildinningtext(),
                SizedBox(
                  width: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  goToDineIn() async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BottomTabbar(
              tabValue: 0,
            )));
    if (progressDialog != null) {
      setState(() {
        isIgnoring = true;
      });
      await progressDialog.show();
      //DialogsIndicator.showLoadingDialog(context, _scaffoldKey, STR_PLEASE_WAIT);
      _landingViewPresenter.getCurrentOrder(context);
    }
  }

  Widget _buildinningtext() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Text(STR_DINEIN_TITLE,
            style: TextStyle(
                fontSize: FONTSIZE_24,
                fontFamily: KEY_FONTFAMILY,
                fontWeight: FontWeight.w600,
                color: greentheme100)),
        SizedBox(
          height: 2,
        ),
        Text(STR_SERVED_RESTAUTRANT,
            style: TextStyle(
                fontSize: FONTSIZE_16,
                fontFamily: KEY_FONTFAMILY,
                fontWeight: FontWeight.w500,
                color: greytheme100)),
      ],
    );
  }

  Widget _currentOrdertext() {
    return Stack(
      children: <Widget>[
        Center(
          child: Card(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 38.0),
                        child: Center(
                          child: Text(STR_VIEW_YOUR_ORDER,
                              style: TextStyle(
                                  fontSize: FONTSIZE_16,
                                  fontFamily: KEY_FONTFAMILY,
                                  fontWeight: FontWeight.w600,
                                  color: greentheme100)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Icon(
                        Icons.navigate_next,
                        color: greytheme600,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  showStatusView();
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _takeAwaycard() {
    return Center(
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            goToTakeAway();
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.14 / 0.15,
            height: 90,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 17,
                ),
                Image.asset(TAKE_AWAY_IMAGE_PATH),
                SizedBox(
                  width: 40,
                ),
                _buildTakeAwaytext(),
                SizedBox(
                  width: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  goToTakeAway() async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BottomTabbar(
              tabValue: 1,
            )));
    setState(() {
      isIgnoring = true;
    });
    await progressDialog.show();
    //DialogsIndicator.showLoadingDialog(context, _scaffoldKey, STR_PLEASE_WAIT);
    _landingViewPresenter.getCurrentOrder(context);
  }

  showStatusView() async {
    var currentOrderId =
        await Preference.getPrefValue<int>(PreferenceKeys.orderId);
    if (_model != null) {
      if (_model.data.dineIn != null) {
        if (_model.data.dineIn.status != STR_PAID) {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CartDetailsPage(
                    restId: _model.data.dineIn.restId,
                    orderId: Globle().orderID,
                    isFromOrder: true,
                  )));
          setState(() {
            isIgnoring = true;
          });
          await progressDialog.show();
          //DialogsIndicator.showLoadingDialog(
          //  context, _scaffoldKey, STR_PLEASE_WAIT);
          _landingViewPresenter.getCurrentOrder(context);
        }
      } else if (_model.data.takeAway != null) {
        if (_model.data.takeAway.orderType != STR_PAID) {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PaymentTipAndPayDi(
                    // orderID: widget.orderID,
                    // tableId: widget.tableId,
                    orderID: currentOrderId,
                    tableId: _model.data.takeAway.tableId,
                  )
              // StatusTakeAwayView(
              //       orderID: currentOrderId,
              //       restId: (_model.data.takeAway.status != STR_PAID)
              //           ? _model.data.takeAway.restId
              //           : _model.data.dineIn.restId,
              //       title: (_model.data.takeAway.status != STR_PAID)
              //           ? _model.data.takeAway.restaurant.restName
              //           : _model.data.dineIn.restaurant.restName,
              //       imgUrl: (_model.data.takeAway.status != STR_PAID)
              //           ? _model.data.takeAway.restaurant.coverImage
              //           : _model.data.dineIn.restaurant.coverImage,
              //     )
              ));
          setState(() {
            isIgnoring = true;
          });
          await progressDialog.show();
          //DialogsIndicator.showLoadingDialog(
          //context, _scaffoldKey, STR_PLEASE_WAIT);
          _landingViewPresenter.getCurrentOrder(context);
        }
      }
    }
  }

  Widget _buildTakeAwaytext() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Text(STR_COLLECTION,
            style: TextStyle(
                fontSize: FONTSIZE_24,
                fontFamily: KEY_FONTFAMILY,
                fontWeight: FontWeight.w600,
                color: greentheme100)),
        SizedBox(
          height: 2,
        ),
        Text(STR_ORDER_TO_COLLECT,
            style: TextStyle(
                fontSize: FONTSIZE_16,
                fontFamily: KEY_FONTFAMILY,
                fontWeight: FontWeight.w500,
                color: greytheme100)),
      ],
    );
  }

  @override
  void onFailedCurrentOrder() async {
    setState(() {
      isIgnoring = false;
    });
    if (progressDialog.isShowing()) {
      await progressDialog.hide();
    }
  }

  @override
  void onSuccessCurrentOrder(RunningOrderModel model) async {
    setState(() {
      isIgnoring = false;
    });
    if (progressDialog.isShowing()) {
      await progressDialog.hide();
    }

    //progressDialog.hide();
    // if (_scaffoldKey.currentContext != null) {
    // Navigator.of(_scaffoldKey.currentContext, rootNavigator: true)..pop();
    // }

    _model = model;
    if (model != null) {
      if (model.data.dineIn != null) {
        if (model.data.dineIn != null && model.data.dineIn.status != STR_PAID) {
          Preference.setPersistData<int>(
              model.data.dineIn.restId, PreferenceKeys.restaurantID);
          Preference.setPersistData<int>(
              model.data.dineIn.id, PreferenceKeys.orderId);
          Globle().orderID = model.data.dineIn.id;
          Preference.setPersistData<bool>(true, PreferenceKeys.isDineIn);
          Preference.setPersistData<int>(0, PreferenceKeys.dineCartItemCount);
          Globle().dinecartValue = 0;
          Preference.setPersistData<int>(0, PreferenceKeys.dineCartItemCount);
          Globle().takeAwayCartItemCount = 0;
          Preference.setPersistData<int>(0, PreferenceKeys.takeAwayCartCount);
          Preference.setPersistData<bool>(true, PreferenceKeys.isAlreadyINCart);
          Globle().isTabelAvailable = true;
          Globle().tableID = model.data.dineIn.tableId;
          Future.delayed(Duration(microseconds: 500), () {
            getCurrentOrderID();
          });
        } else {
          setDefaultData();
        }
      } else if (model.data.dineIn != null) {
        if (model.data.takeAway != null &&
            model.data.takeAway.status != STR_PAID) {
          Preference.setPersistData<int>(
              model.data.takeAway.restId, PreferenceKeys.restaurantID);
          Preference.setPersistData<int>(
              model.data.takeAway.id, PreferenceKeys.orderId);
          Preference.setPersistData<int>(0, PreferenceKeys.dineCartItemCount);
          Globle().dinecartValue = 0;
          Preference.setPersistData<int>(0, PreferenceKeys.dineCartItemCount);
          Globle().takeAwayCartItemCount = 0;
          Preference.setPersistData<int>(0, PreferenceKeys.takeAwayCartCount);
          Preference.setPersistData<bool>(null, PreferenceKeys.isDineIn);
          Globle().isTabelAvailable = false;
          Globle().tableID = 0;
          Future.delayed(Duration(microseconds: 500), () {
            getCurrentOrderID();
          });
        } else {
          setDefaultData();
        }
      } else if (model.data.cart != null) {
        Globle().isTabelAvailable = false;
        Globle().tableID = 0;
        Globle().dinecartValue += 1;
        Preference.setPersistData<int>(
            Globle().dinecartValue, PreferenceKeys.dineCartItemCount);
        Preference.setPersistData(
            model.data.cart.restId, PreferenceKeys.restaurantID);
        Preference.setPersistData(true, PreferenceKeys.isAlreadyINCart);
        Preference.setPersistData(
            model.data.cart.restName, PreferenceKeys.restaurantName);
      } else {
        setDefaultData();
      }
    }
  }

  setDefaultData() {
    Preference.setPersistData<int>(null, PreferenceKeys.orderId);
    Globle().orderID = 0;
    Preference.removeForKey(PreferenceKeys.orderId);
    Globle().dinecartValue = 0;
    Globle().takeAwayCartItemCount = 0;
    Preference.setPersistData<int>(0, PreferenceKeys.takeAwayCartCount);
    Preference.setPersistData<bool>(null, PreferenceKeys.isDineIn);
    Preference.setPersistData<int>(0, PreferenceKeys.dineCartItemCount);
    Preference.setPersistData<int>(null, PreferenceKeys.currentOrderId);
    Preference.setPersistData<bool>(null, PreferenceKeys.isAlreadyINCart);
    Preference.setPersistData<int>(null, PreferenceKeys.restaurantID);
    Globle().isTabelAvailable = false;
    Globle().tableID = 0;
    Future.delayed(Duration(microseconds: 500), () {
      getCurrentOrderID();
    });
  }

  @override
  void dispose() {
    //progressDialog.hide();
    super.dispose();
  }
}

class MainWidget extends StatefulWidget {
  MainWidget({Key key, this.title, this.appbarTitle}) : super(key: key);
  final String title;
  String appbarTitle;
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  HiddenDrawerController _drawerController;
  @override
  void initState() {
    super.initState();

    _drawerController = HiddenDrawerController(
      initialPage: Landingview(
        title: STR_MAIN,
      ),
      items: [
        DrawerItem(
            text: Text(STR_HOME,
                style: TextStyle(
                    color: (Globle().navigatorIndex == 1)
                        ? orangetheme
                        : greytheme800,
                    fontFamily: KEY_FONTFAMILY,
                    fontWeight: FontWeight.w600,
                    fontSize: FONTSIZE_15)),
            icon: Icon(Icons.home, size: 20, color: greytheme800),
            page: Landingview(
              title: STR_HOME,
            ),
            onPressed: () {
              widget.appbarTitle = STR_HOME;
              _opennewpage(STR_HOME);
            }), //HOME
        DrawerItem(
            text: Text(
              STR_ABOUT_US,
              style: TextStyle(
                  color: (Globle().navigatorIndex == 2)
                      ? orangetheme
                      : greytheme800,
                  fontFamily: KEY_FONTFAMILY,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
            icon: Icon(Icons.info, size: 20, color: greytheme800),
            page: Landingview(
              title: STR_INVITE,
            ),
            onPressed: () {
              setState(() {
                Globle().navigatorIndex = 2;
              });
              widget.appbarTitle = STR_ABOUT_US;
              _opennewpage(STR_ABOUT_US);
            }), //ABOUT US
        DrawerItem(
            text: Text(
              STR_TERMS_CONDITION,
              style: TextStyle(
                  color: (Globle().navigatorIndex == 3)
                      ? orangetheme
                      : greytheme800,
                  fontFamily: KEY_FONTFAMILY,
                  fontWeight: FontWeight.w600,
                  fontSize: FONTSIZE_15),
            ),
            icon: Icon(Icons.description, size: 20, color: greytheme800),
            page: Landingview(
              title: STR_FAVORITE_TITLE,
            ),
            onPressed: () {
              setState(() {
                Globle().navigatorIndex = 3;
              });
              widget.appbarTitle = STR_TERMS_CONDITION;
              _opennewpage(STR_TERMS_CONDITION);
            }), //TERMS & CONDITIONS
        DrawerItem(
            text: Text(
              STR_PRIVACY_POLICY,
              style: TextStyle(
                  color: (Globle().navigatorIndex == 4)
                      ? orangetheme
                      : greytheme800,
                  fontFamily: KEY_FONTFAMILY,
                  fontWeight: FontWeight.w600,
                  fontSize: FONTSIZE_15),
            ),
            icon: Icon(Icons.verified_user, size: 20, color: greytheme800),
            page: Landingview(
              title: STR_NOTIFICATION,
            ),
            onPressed: () {
              setState(() {
                Globle().navigatorIndex = 4;
              });
              widget.appbarTitle = STR_PRIVACY_POLICY;
              _opennewpage(STR_PRIVACY_POLICY);
            }), //PRIVACY POLICY
        DrawerItem(
            text: Text(STR_SETTING,
                style: TextStyle(
                    color: (Globle().navigatorIndex == 5)
                        ? orangetheme
                        : greytheme800,
                    fontFamily: KEY_FONTFAMILY,
                    fontWeight: FontWeight.w600,
                    fontSize: FONTSIZE_15)),
            icon: Icon(Icons.settings, size: 20, color: greytheme800),
            page: Landingview(
              title: STR_GALLERY,
            ),
            onPressed: () {
              setState(() {
                Globle().navigatorIndex = 5;
              });
              widget.appbarTitle = STR_SETTING;
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SettingView()));
              // _opennewpage(STR_SETTING);
            }), //SETTING
        // DrawerItem(
        //     text: Text(
        //       STR_HELP,
        //       style: TextStyle(
        //           color: (Globle().navigatorIndex == 6) ? orangetheme : greytheme800,
        //           fontFamily: KEY_FONTFAMILY,
        //           fontWeight: FontWeight.w600,
        //           fontSize: FONTSIZE_15),
        //     ),
        //     icon: Icon(
        //       Icons.help,
        //       color: greytheme800,
        //       size: 20,
        //     ),
        //     page: Landingview(
        //       title: STR_SETTING,
        //     ),
        //     onPressed: () {
        //       setState(() {
        //         Globle().navigatorIndex = 6;
        //       });
        //       widget.appbarTitle = STR_HELP;
        //       _opennewpage(STR_HELP);
        //     }), //HELP
      ],
    );
  }

  profilePic() {
    String imageUrl = STR_BLANK;
    if (Globle().loginModel.data.userDetails != null) {
      imageUrl = (Globle().loginModel.data.userDetails.profileImage != null)
          ? BaseUrl.getBaseUrlImages() +
              '${Globle().loginModel.data.userDetails.profileImage}'
          : PROFILE_IMAGE_PATH;
      return imageUrl;
    }
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: HiddenDrawer(
        controller: _drawerController,
        header: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                  },
                  child: Container(
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        placeholder: PROFILE_IMAGE_PATH,
                        image: profilePic(),
                        fit: BoxFit.cover,
                        width: 82.5,
                        height: 82.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    '${Globle().loginModel.data.firstName ?? ""} ${Globle().loginModel.data.lastName ?? ""}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: greytheme700,
                        fontSize: FONTSIZE_16,
                        fontFamily: KEY_FONTFAMILY,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }

  void _opennewpage(String title) {
    if (title.contains(STR_HOME)) {
      Navigator.pushReplacementNamed(context, STR_MAIN_WIDGET_PAGE);
    } else if (title.contains(STR_SETTING)) {
      Navigator.pushReplacementNamed(context, STR_MAIN_WIDGET_PAGE);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewPage(
                    title: widget.appbarTitle,
                    strURL: STR_GOOGLE_URL,
                  )));
    } else if (title.contains(STR_PRIVACY_POLICY)) {
      Navigator.pushReplacementNamed(context, STR_MAIN_WIDGET_PAGE);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewPage(
                    title: widget.appbarTitle,
                    strURL: STR_URL_PRIVACY_POLICY,
                  )));
    } else if (title.contains(STR_TERMS_CONDITION)) {
      Navigator.pushReplacementNamed(context, STR_MAIN_WIDGET_PAGE);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewPage(
                    title: widget.appbarTitle,
                    strURL: STR_URL_TERMS_CONDITION,
                  )));
    } else if (title.contains(STR_ABOUT_US)) {
      Navigator.pushReplacementNamed(context, STR_MAIN_WIDGET_PAGE);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewPage(
                    title: widget.appbarTitle,
                    strURL: STR_URL_ABOUT_US,
                  )));
    }
  }
}
//  (FloatingActionButton.extended(onPressed: null, label: Text(STR_VIEW_YOUR_ORDER,
//                       style: TextStyle(
//                           fontSize: FONTSIZE_16,
//                           fontFamily: KEY_FONTFAMILY,
//                           fontWeight: FontWeight.w600,
//                           color: greentheme100)),)
