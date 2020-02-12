import 'package:flutter/material.dart';
import 'package:foodzi/MyOrders/MyOrders.dart';
import 'package:foodzi/MyprofileBottompage/MyprofileBottompage.dart';
import 'package:foodzi/NotificationBottomPage/NotificationBottomPage.dart';
//import 'package:foodzi/DineInPage/DineInView.dart';
import 'package:foodzi/Notifications/NotificationView.dart';
import 'package:foodzi/ProfilePage/ProfileScreen.dart';
import 'package:foodzi/ResetPassword/ResetPassView.dart';
import 'package:foodzi/MyOrders/MyOrders.dart';
import 'package:foodzi/RestaurantPageTakeAway/RestaurantViewTA.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class TakeAwayBottombar extends StatefulWidget {
  String title;
  int rest_Id;
  TakeAwayBottombar({this.title,this.rest_Id});
  @override
  State<StatefulWidget> createState() {
    return _TakeAwayBottombarState();
  }
}

class _TakeAwayBottombarState extends State<TakeAwayBottombar> {
  var title;
  int currentTabIndex = 0;
  List<Widget> tabsHome = [
    RestaurantTAView(),
    MyOrders(),
    BottomNotificationView(),
    BottomProfileScreen()
  ];
  onTapIndex(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.title != null) {
      setState(() {
        tabsHome.setAll(0, [
          RestaurantTAView(
            title: widget.title,
            rest_Id:widget.rest_Id,
          )
        ]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Container(
      //   width: 60,
      //   height: 60,
      //   child: FittedBox(
      //     child: FloatingActionButton(
      //         backgroundColor: redtheme,
      //         onPressed: () {},
      //         child: Image.asset('assets/ClockIcon/clock.png')),
      //   ),
      // ),
      floatingActionButton: Container(
        width: 60,
        height: 120,
        child: Column(
          children: <Widget>[
             FittedBox(
            child: FloatingActionButton(
                backgroundColor: orangetheme,
                onPressed: () {
                  print("1");
                },
                heroTag: "btnBuzzer",
                child: Image.asset('assets/ClockIcon/clock.png')),
          ),
          SizedBox(height: 5,),
          FittedBox(
            child: FloatingActionButton(
                backgroundColor: orangetheme,
                onPressed: () {
                  print("2");
                                Navigator.pushNamed(context, '/OrderConfirmationView');

                },
                heroTag: "btnAddCart",
                child: Icon(Icons.add_shopping_cart,color: Colors.white,)),
          ),
          ],
                  
        ),
      ),
      body: tabsHome[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          //selectedItemColor: redtheme,
          onTap: onTapIndex,
          currentIndex: currentTabIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                //icon: Image.asset('assets/HomeIcon/home(2).png'),
                icon: Icon(
                  OMIcons.home,
                  color: greytheme100,
                  size: 30,
                ),
                activeIcon: Icon(
                  OMIcons.home,
                  color: redtheme,
                  size: 30,
                ),
                title: Text('')),
            BottomNavigationBarItem(
                //icon: Image.asset('assets/OrderIcon/order.png'),
                icon: Icon(
                  OMIcons.assignment,
                  color: greytheme100,
                  size: 30,
                ),
                activeIcon: Icon(
                  OMIcons.assignment,
                  color: redtheme,
                  size: 30,
                ),
                title: Text('')),
            BottomNavigationBarItem(
                //icon: Image.asset('assets/NotificationIcon/Path1159.png'),
                icon: Icon(
                  OMIcons.notifications,
                  color: greytheme100,
                  size: 30,
                ),
                activeIcon: Icon(
                  OMIcons.notifications,
                  color: redtheme,
                  size: 30,
                ),
                title: Text('')),
            BottomNavigationBarItem(
                //icon: Image.asset('assets/UserIcon/Group3.png'),
                icon: Icon(
                  OMIcons.personOutline,
                  color: greytheme100,
                  size: 30,
                ),
                activeIcon: Icon(
                  OMIcons.person,
                  color: redtheme,
                  size: 30,
                ),
                title: Text('')),
          ]),
    );
  }
}
