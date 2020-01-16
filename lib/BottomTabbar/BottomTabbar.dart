import 'package:flutter/material.dart';
import 'package:foodzi/DineInPage/DineInView.dart';
import 'package:foodzi/Notifications/NotificationView.dart';
import 'package:foodzi/ProfilePage/ProfileScreen.dart';
import 'package:foodzi/ResetPassword/ResetPassView.dart';
import 'package:foodzi/RestaurantPage/RestaurantView.dart';
import 'package:foodzi/theme/colors.dart';

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
    DineInView(
      title: 'Dine In',
    ),
    RestaurantView(),
    NotificationView(),
    ProfileScreen()
  ];
  List<Widget> tabsTakeAway = [
    DineInView(title: 'Take Away'),
    ResetPasswordview(),
    NotificationView(),
    ProfileScreen()
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
          onTap: onTapIndex,
          currentIndex: currentTabIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset('assets/HomeIcon/home(2).png'),
                title: Text('')),
            BottomNavigationBarItem(
                icon: Image.asset('assets/OrderIcon/order.png'),
                title: Text('')),
            BottomNavigationBarItem(
                icon: Image.asset('assets/NotificationIcon/Path1159.png'),
                title: Text('')),
            BottomNavigationBarItem(
                icon: Image.asset('assets/UserIcon/Group3.png'),
                title: Text('')),
          ]),
    );
  }
}
