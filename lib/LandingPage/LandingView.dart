import 'package:flutter/material.dart';
import 'package:foodzi/BottomTabbar/BottomTabbar.dart';
import 'package:foodzi/LandingPage/landinViewPresenter.dart';
import 'package:foodzi/Models/running_order_model.dart';
import 'package:foodzi/Notifications/NotificationView.dart';
import 'package:foodzi/ProfilePage/ProfileScreen.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackView.dart';
import 'package:foodzi/StatusTrackviewTakeAway.dart/StatusTakeAwayView.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/Drawer/drawer.dart';
import 'package:foodzi/widgets/WebView.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

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

  @override
  void initState() {
    _landingViewPresenter = LandingViewPresenter(this);
    _landingViewPresenter.getCurrentOrder(context);
    getCurrentOrderID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 100.0,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(
                OMIcons.notifications,
                color: greytheme100,
                size: 28,
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
        bottomNavigationBar: (isOrderRunning)
            ? BottomAppBar(
                child: Container(
                  color: greytheme1300,
                  height: 40,
                  child: _currentOrdertext(),
                ),
              )
            : Text(""),
      ),
    );
  }

  getCurrentOrderID() async {
    var currentOrderId =
        await Preference.getPrefValue<int>(PreferenceKeys.orderId);
    if (currentOrderId != null) {
      setState(() {
        isOrderRunning = true;
      });
    } else {
      setState(() {
        isOrderRunning = false;
      });
    }
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
            _orderEasy(),
            SizedBox(
              height: 125,
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
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Image.asset(
          FODDZI_LOGO_3X,
        ));
  }

  Widget _orderEasy() {
    return Padding(
      padding: const EdgeInsets.only(right: 40.0, top: 5),
      child: Container(
        alignment: Alignment.topRight,
        child: Text(
          STR_ORDER_EASY,
          style: TextStyle(
              fontFamily: KEY_FONTFAMILY,
              fontSize: FONTSIZE_12,
              color: greytheme400,
              fontWeight: FontWeight.w700,
              letterSpacing: 1),
        ),
      ),
    );
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
            width: 345,
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

    getCurrentOrderID();
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
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
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
            getCurrentOrderID();
          },
          child: Container(
            width: 345,
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
  }

  showStatusView() async {
    var currentOrderId =
        await Preference.getPrefValue<int>(PreferenceKeys.orderId);
    if (_model != null) {
      if (_model.data.dineIn != null) {
        if (_model.data.dineIn.status != STR_PAID) {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StatusTrackView(
                    orderID: currentOrderId,
                    restId: (_model.data.dineIn.status != STR_PAID)
                        ? _model.data.dineIn.restId
                        : _model.data.takeAway.restId,
                    title: (_model.data.dineIn.status != STR_PAID)
                        ? _model.data.dineIn.restaurant.restName
                        : _model.data.takeAway.restaurant.restName,
                    flag: 3,
                    tableId: (_model.data.dineIn.status != STR_PAID)
                        ? _model.data.dineIn.tableId
                        : 0,
                    tableName: _model.data.dineIn.table.tableName,
                  )));
          getCurrentOrderID();
        }
      }
      if (_model.data.takeAway != null) {
        if (_model.data.takeAway.orderType != STR_PAID) {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StatusTakeAwayView(
                    orderID: currentOrderId,
                    restId: (_model.data.takeAway.status != STR_PAID)
                        ? _model.data.takeAway.restId
                        : _model.data.dineIn.restId,
                    title: (_model.data.takeAway.status != STR_PAID)
                        ? _model.data.takeAway.restaurant.restName
                        : _model.data.dineIn.restaurant.restName,
                  )));
          getCurrentOrderID();
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
  void onFailedCurrentOrder() {}

  @override
  void onSuccessCurrentOrder(RunningOrderModel model) async {
    _model = model;
    if (model != null) {
      if (model.data.dineIn != null) {
        if (model.data.dineIn != null && model.data.dineIn.status != STR_PAID) {
          Preference.setPersistData<int>(
              model.data.dineIn.restId, PreferenceKeys.restaurantID);
          Preference.setPersistData<int>(
              model.data.dineIn.id, PreferenceKeys.orderId);
          Preference.setPersistData<bool>(true, PreferenceKeys.isDineIn);
          Globle().dinecartValue = 0;
          Preference.setPersistData<int>(0, PreferenceKeys.dineCartItemCount);
          Preference.setPersistData<bool>(true, PreferenceKeys.isAlreadyINCart);
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
          Preference.setPersistData<bool>(null, PreferenceKeys.isDineIn);
          Future.delayed(Duration(microseconds: 500), () {
            getCurrentOrderID();
          });
        } else {
          setDefaultData();
        }
      } else {
        setDefaultData();
      }
    }
  }

  setDefaultData() {
    Preference.setPersistData<int>(null, PreferenceKeys.orderId);
    Preference.removeForKey(PreferenceKeys.orderId);
    Globle().dinecartValue = 0;
    Preference.setPersistData<bool>(null, PreferenceKeys.isDineIn);
    Preference.setPersistData<int>(null, PreferenceKeys.currentOrderId);
    Preference.setPersistData<bool>(null, PreferenceKeys.isAlreadyINCart);
    Preference.setPersistData<int>(null, PreferenceKeys.restaurantID);
    Future.delayed(Duration(microseconds: 500), () {
      getCurrentOrderID();
    });
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
                    color: greytheme800,
                    fontFamily: KEY_FONTFAMILY,
                    fontWeight: FontWeight.w600,
                    fontSize: FONTSIZE_15)),
            icon: Icon(Icons.home, size: 20, color: greytheme800),
            page: Landingview(
              title: STR_HOME,
            ),
            onPressed: () {
              widget.appbarTitle = STR_HOME;
              _opennewpage();
            }),
        DrawerItem(
            text: Text(STR_SETTING,
                style: TextStyle(
                    color: greytheme800,
                    fontFamily: KEY_FONTFAMILY,
                    fontWeight: FontWeight.w600,
                    fontSize: FONTSIZE_15)),
            icon: Icon(Icons.settings, size: 20, color: greytheme800),
            page: Landingview(
              title: STR_GALLERY,
            ),
            onPressed: () {
              widget.appbarTitle = STR_SETTING;
              _opennewpage();
            }),
        DrawerItem(
            text: Text(
              STR_TERMS_CONDITION,
              style: TextStyle(
                  color: greytheme800,
                  fontFamily: KEY_FONTFAMILY,
                  fontWeight: FontWeight.w600,
                  fontSize: FONTSIZE_15),
            ),
            icon: Icon(Icons.description, size: 20, color: greytheme800),
            page: Landingview(
              title: STR_FAVORITE_TITLE,
            ),
            onPressed: () {
              widget.appbarTitle = STR_FAVORITE_TITLE;
              _opennewpage();
            }),
        DrawerItem(
            text: Text(
              STR_PRIVACY_POLICY,
              style: TextStyle(
                  color: greytheme800,
                  fontFamily: KEY_FONTFAMILY,
                  fontWeight: FontWeight.w600,
                  fontSize: FONTSIZE_15),
            ),
            icon: Icon(Icons.verified_user, size: 20, color: greytheme800),
            page: Landingview(
              title: STR_NOTIFICATION,
            ),
            onPressed: () {
              widget.appbarTitle = STR_PRIVACY_POLICY;
              _opennewpage();
            }),
        DrawerItem(
            text: Text(
              STR_ABOUT_US,
              style: TextStyle(
                  color: greytheme800,
                  fontFamily: KEY_FONTFAMILY,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
            icon: Icon(Icons.info, size: 20, color: greytheme800),
            page: Landingview(
              title: STR_INVITE,
            ),
            onPressed: () {
              widget.appbarTitle = STR_ABOUT_US;
              _opennewpage();
            }),
        DrawerItem(
            text: Text(
              STR_HELP,
              style: TextStyle(
                  color: greytheme800,
                  fontFamily: KEY_FONTFAMILY,
                  fontWeight: FontWeight.w600,
                  fontSize: FONTSIZE_15),
            ),
            icon: Icon(
              Icons.help,
              color: greytheme800,
              size: 20,
            ),
            page: Landingview(
              title: STR_SETTING,
            ),
            onPressed: () {
              widget.appbarTitle = STR_HELP;
              _opennewpage();
            }),
      ],
    );
  }

  profilePic() {
    String imageUrl = '';
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

  void _opennewpage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebViewPage(
                  title: widget.appbarTitle,
                )));
  }
}
