import 'package:flutter/material.dart';
import 'package:foodzi/DineInPage/DineInView.dart';
import 'package:foodzi/MyOrders/MyOrders.dart';
import 'package:foodzi/MyprofileBottompage/MyprofileBottompage.dart';
import 'package:foodzi/NotificationBottomPage/NotificationBottomPage.dart';
import 'package:foodzi/Notifications/NotificationView.dart';
import 'package:foodzi/ProfilePage/ProfileScreen.dart';
import 'package:foodzi/ResetPassword/ResetPassView.dart';
import 'package:foodzi/RestaurantPage/RestaurantView.dart';
import 'package:foodzi/TakeAwayPage/TakeAwayView.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class BottomTabbar extends StatefulWidget {
  int tabValue = 0;
  BottomTabbar({this.tabValue});
  @override
  State<StatefulWidget> createState() {
    return _BottomTabbarState();
  }
}

class _BottomTabbarState extends State<BottomTabbar> {
  int currentTabIndex = 0;
  List<Widget> tabsDineIn = [
    DineInView(),
    MyOrders(),
    BottomNotificationView(),
   BottomProfileScreen()
  ];
  List<Widget> tabsTakeAway = [
   TakeAwayView(),
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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: 60,
        height: 60,
        child: FittedBox(
          child: FloatingActionButton(
              backgroundColor: orangetheme,
              onPressed: () {},
              child: Image.asset('assets/ClockIcon/clock.png')),
        ),
      ),
      body: widget.tabValue == 0
          ? tabsDineIn[currentTabIndex]
          : tabsTakeAway[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          //selectedItemColor: orangetheme,
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
                  color: orangetheme,
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
                  color: orangetheme,
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
                  color: orangetheme,
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
                  color: orangetheme,
                  size: 30,
                ),
                title: Text('')),
          ]),
    );
  }
}
