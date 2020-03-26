import 'package:flutter/material.dart';
import 'package:foodzi/BottomTabbar/BottomTabbar.dart';
import 'package:foodzi/LandingPage/landinViewPresenter.dart';
import 'package:foodzi/Models/running_order_model.dart';
import 'package:foodzi/Notifications/NotificationView.dart';
import 'package:foodzi/ProfilePage/ProfileScreen.dart';
import 'package:foodzi/ProfilePage/ProfileScreen.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackView.dart';
import 'package:foodzi/StatusTrackviewTakeAway.dart/StatusTakeAwayView.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/main.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/Drawer/drawer.dart';
import 'package:foodzi/widgets/WebView.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Landingview extends DrawerContent {
  Landingview({Key key, this.title, this.body});
  String title;
  final Widget body;
  @override
  State<StatefulWidget> createState() {
    return _LandingStateView();
  }
}

class _LandingStateView extends State<Landingview>
    implements LandingViewProtocol {
  //String titleAppBar = "Testing";
  bool isOrderRunning = false;
  LandingViewPresenter _landingViewPresenter;
  RunningOrderModel _model;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  @override
  void initState() {
    _landingViewPresenter = LandingViewPresenter(this);
    // setState(() {
    //DialogsIndicator.showLoadingDialog(context, _keyLoader, "");
    _landingViewPresenter.getCurrentOrder(context);
    // });
    getCurrentOrderID();
    super.initState();
  }

  // @override
  // void didUpdateWidget(Landingview oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.body != oldWidget.body) {
  //     _landingViewPresenter.getCurrentOrder(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 100.0,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          //  title: Text(titleAppBar),
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
            icon: Image.asset('assets/MenuIcon/menu.png'),
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
        await Preference.getPrefValue<int>(PreferenceKeys.ORDER_ID);
    if (currentOrderId != null) {
      setState(() {
        isOrderRunning = true;
      });
      //currentOrderId;
    }
    return;
  }

  getCurrentRestID() async {
    var currentRestId = await Preference.getPrefValue<int>(
        PreferenceKeys.CURRENT_RESTAURANT_ID); //ORDER_ID
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
          "assets/Logo/foodzi_logo@3x.jpg",
        ));
  }

  Widget _orderEasy() {
    return Padding(
      padding: const EdgeInsets.only(right: 40.0, top: 5),
      child: Container(
        alignment: Alignment.topRight,
        child: Text(
          'ORDER EASY',
          style: TextStyle(
              // fontFamily: 'HelveticaNeue',
              fontFamily: "gotham",
              fontSize: 12,
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
            'Hello',
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'gotham',
                fontWeight: FontWeight.w500,
                color: greytheme100),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            Globle().loginModel.data.firstName ?? '',
            style: TextStyle(
                fontSize: 32,
                fontFamily: 'gotham',
                fontWeight: FontWeight.w600,
                color: greytheme500),
          ),
          SizedBox(
            height: 12,
          ),
          Text('All your favourites at your fingertip !!',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'gotham',
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
            // SizedBox(
            //   height: 12,
            // ),
            // isOrderRunning ?
            // _currentOrderCard()
            // : Container()
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
            //TODO: add await here
            // _goToNextPageDineIn(context);
            goToDineIn();
            print('Card tapped.');
          },
          child: Container(
            width: 345,
            height: 90,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 17,
                ),
                Image.asset('assets/DineInImage/Group1504.png'),
                SizedBox(
                  width: 36,
                ),
                _buildinningtext(),
                SizedBox(
                  width: 40,
                ),
                // Icon(
                //   Icons.navigate_next,
                //   color: greytheme600,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  goToDineIn() async{
    var val = await  Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BottomTabbar(
                      tabValue: 0,
                      //tableName: _model.data.dineIn.table.tableName,
                    )));

getCurrentOrderID();
    print("fa gsas gsaggsafh");
    
    
  }

  Widget _buildinningtext() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Text('Dine-in',
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'gotham',
                fontWeight: FontWeight.w600,
                color: greentheme100)),
        SizedBox(
          height: 2,
        ),
        Text('Get served in Restaurant',
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'gotham',
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
                  child: Text('View Your Order',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'gotham',
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

            // Text('Track your current order',
            //     style: TextStyle(
            //         fontSize: 14,
            //         fontFamily: 'gotham',
            //         fontWeight: FontWeight.w500,
            //         color: greytheme100)),
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
            //TODO: add wait here 
            
            goToTakeAway();
            print('Card tapped.');
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
                Image.asset('assets/TakeAwayImage/Group1505.png'),
                SizedBox(
                  width: 40,
                ),
                _buildTakeAwaytext(),
                SizedBox(
                  width: 40,
                ),
                // Icon(
                //   Icons.navigate_next,
                //   color: greytheme600,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  goToTakeAway() async {
   var val = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BottomTabbar(
                      tabValue: 1,
                    )));

    print("take away back");
  }

  showStatusView() async {
    var currentOrderId =
        await Preference.getPrefValue<int>(PreferenceKeys.ORDER_ID);
    // _goToNextPageDineIn(context);
    if (_model != null) {
      if (_model.data.dineIn != null) {
        if (_model.data.dineIn.status != "paid") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StatusTrackView(
                    orderID: currentOrderId,
                    rest_id: (_model.data.dineIn.status != "paid")
                        ? _model.data.dineIn.restId
                        : _model.data.takeAway.restId,
                    //restname: _model.data.dineIn.restaurant.restName,
                    title: (_model.data.dineIn.status != "paid")
                        ? _model.data.dineIn.restaurant.restName
                        : _model.data.takeAway.restaurant.restName,
                    flag: 3,
                    tableId: (_model.data.dineIn.status != "paid")
                        ? _model.data.dineIn.tableId
                        : 0,
                    tableName: _model.data.dineIn.table.tableName,
                  )));
        }
      }
      if (_model.data.takeAway != null) {
        if (_model.data.takeAway.orderType != "paid") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StatusTakeAwayView(
                    orderID: currentOrderId,
                    rest_id: (_model.data.takeAway.status != "paid")
                        ? _model.data.takeAway.restId
                        : _model.data.dineIn.restId,
                    //restname: _model.data.dineIn.restaurant.restName,
                    title: (_model.data.takeAway.status != "paid")
                        ? _model.data.takeAway.restaurant.restName
                        : _model.data.dineIn.restaurant.restName,
                  )));
        }
      }
    }

    print('Card tapped.');
  }

  Widget _currentOrderCard() {
    return Center(
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            showStatusView();
          },
          child: Container(
            width: 345,
            height: 90,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 17,
                ),
                ClipOval(
                  child: Container(
                    width: 46.8,
                    height: 46.8,
                    child: Image.asset(
                      'assets/OrderIcon/order.png',
                      color: Colors.white,
                    ),
                    color: orangetheme,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                // _currentOrdertext(),
                SizedBox(
                  width: 40,
                ),
                Icon(
                  Icons.navigate_next,
                  color: greytheme600,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTakeAwaytext() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Text('Collection',
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'gotham',
                fontWeight: FontWeight.w600,
                color: greentheme100)),
        SizedBox(
          height: 2,
        ),
        // 'Get you food packed'
        Text('Order to Collect',
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'gotham',
                fontWeight: FontWeight.w500,
                color: greytheme100)),
      ],
    );
  }

  @override
  void onFailedCurrentOrder() {
    print("object");
    
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();

    // TODO: implement onFailedCurrentOrder
  }

  @override
  void onSuccessCurrentOrder(RunningOrderModel model) async{
    // TODO: implement onSuccessCurrentOrder
    _model = model;
    if (model != null) {
      if (model.data.dineIn != null) {
        if (model.data.dineIn != null && model.data.dineIn.status != "paid") {
          Preference.setPersistData<int>(
              model.data.dineIn.restId, PreferenceKeys.restaurantID);
          Preference.setPersistData<int>(
              model.data.dineIn.id, PreferenceKeys.ORDER_ID);
          Preference.setPersistData<bool>(true, PreferenceKeys.ISDINEIN);
          Globle().dinecartValue = 0;
          Preference.setPersistData<int>(0, PreferenceKeys.dineCartItemCount);
          Preference.setPersistData<bool>(true, PreferenceKeys.isAlreadyINCart);
          Future.delayed(Duration(microseconds: 500), () {
            getCurrentOrderID();
          });
        } else {
          setDefaultData();
          //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
        }
      } else if (model.data.dineIn != null) {
        if (model.data.takeAway != null &&
            model.data.takeAway.status != "paid") {
          Preference.setPersistData<int>(
              model.data.takeAway.restId, PreferenceKeys.restaurantID);
          Preference.setPersistData<int>(
              model.data.takeAway.id, PreferenceKeys.ORDER_ID);
          Preference.setPersistData<int>(0, PreferenceKeys.dineCartItemCount);
          Globle().dinecartValue = 0;
          Preference.setPersistData<bool>(null, PreferenceKeys.ISDINEIN);
          //Preference.setPersistData<bool>(true, PreferenceKeys.isAlreadyINCart);
          Future.delayed(Duration(microseconds: 500), () {
            getCurrentOrderID();
          });
        } else {
          setDefaultData();
          //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
        }
      }  else {
          setDefaultData();
          //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
        }

      //For Dine current order

      //For Take away current order

    }
  }
  setDefaultData() {
    Preference.setPersistData<int>(null, PreferenceKeys.ORDER_ID);
          Preference.removeForKey(PreferenceKeys.ORDER_ID);
          Globle().dinecartValue = 0;
          Preference.setPersistData<bool>(null, PreferenceKeys.ISDINEIN);
          Preference.setPersistData<int>(null, PreferenceKeys.CURRENT_ORDER_ID);
          Preference.setPersistData<bool>(null, PreferenceKeys.isAlreadyINCart);
          Preference.setPersistData<int>(null, PreferenceKeys.restaurantID);
          Future.delayed(Duration(microseconds: 500), () {
            getCurrentOrderID();
          });
  }
  // _goToNextPageTakeAway(BuildContext context) {
  //   return Navigator.of(context).push(MaterialPageRoute(builder: (context) {
  //     return DineInView(
  //       title: 'Take Away',
  //     );
  //   }));
  // }
  // _goToNextPageDineIn(BuildContext context) {
  //   return Navigator.of(context).push(MaterialPageRoute(builder: (context) {
  //     return DineInView(
  //       title: 'Dine-in',
  //     );
  //   }));
  // }
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
        title: 'main',
      ),
      items: [
        DrawerItem(
            text: Text('Home',
                style: TextStyle(
                    color: greytheme800,
                    fontFamily: 'gotham',
                    fontWeight: FontWeight.w600,
                    fontSize: 15)),
            icon: Icon(Icons.home, size: 20, color: greytheme800),
            page: Landingview(
              title: 'Home',
            ),
            onPressed: () {
              widget.appbarTitle = 'Home';
              _opennewpage();
            }),
        DrawerItem(
            text: Text('Settings',
                style: TextStyle(
                    color: greytheme800,
                    fontFamily: 'gotham',
                    fontWeight: FontWeight.w600,
                    fontSize: 15)),
            icon: Icon(Icons.settings, size: 20, color: greytheme800),
            page: Landingview(
              title: 'Gallery',
            ),
            onPressed: () {
              widget.appbarTitle = 'Settings';
              _opennewpage();
            }),
        DrawerItem(
            text: Text(
              'Terms & Conditions',
              style: TextStyle(
                  color: greytheme800,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
            icon: Icon(Icons.description, size: 20, color: greytheme800),
            page: Landingview(
              title: 'Favorites',
            ),
            onPressed: () {
              widget.appbarTitle = 'Favorites';
              _opennewpage();
            }),
        DrawerItem(
            text: Text(
              'Privacy Policy',
              style: TextStyle(
                  color: greytheme800,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
            icon: Icon(Icons.verified_user, size: 20, color: greytheme800),
            page: Landingview(
              title: 'Notification',
            ),
            onPressed: () {
              widget.appbarTitle = 'Privacy Policy';
              _opennewpage();
            }),
        DrawerItem(
            text: Text(
              'About Us',
              style: TextStyle(
                  color: greytheme800,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
            icon: Icon(Icons.info, size: 20, color: greytheme800),
            page: Landingview(
              title: 'invite',
            ),
            onPressed: () {
              widget.appbarTitle = 'About Us';
              _opennewpage();
            }),
        DrawerItem(
            text: Text(
              'Help',
              style: TextStyle(
                  color: greytheme800,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
            icon: Icon(
              Icons.help,
              color: greytheme800,
              size: 20,
            ),
            page: Landingview(
              title: 'SETTINGS',
            ),
            onPressed: () {
              widget.appbarTitle = "Help";
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
          : 'assets/PlaceholderImage/placeholder.png';
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
                        placeholder: 'assets/PlaceholderImage/placeholder.png',
                        image: profilePic(),
                        fit: BoxFit.cover,
                        width: 82.5,
                        height: 82.5,
                      ),
                      //     child: Image.asset(
                      //   'assets/ProfileImage/MaskGroup15@3x.png',
                      //   width: 70,
                      //   height: 70,
                      // )
                      // child: CachedNetworkImage(
                      //   imageUrl: BaseUrl.getBaseUrlImages() + '${Globle().loginModel.data.userDetails.profileImage}',
                      //   placeholder: (context, url)=> CircularProgressIndicator(),
                      //   errorWidget: (context, url, error) => Icon(Icons.error),
                      // ),
                      //child: Image.network(BaseUrl.getBaseUrlImages() + '${Globle().loginModel.data.userDetails.profileImage}',width: 70,height: 70,),
                    ),
                  ),
                ),
                // ),
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
                        fontSize: 16,
                        fontFamily: 'gotham',
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
    //Navigator.of(context).pushNamed('/webview');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebViewPage(
                  title: widget.appbarTitle,
                )));
  }
}
