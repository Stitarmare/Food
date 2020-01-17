import 'package:flutter/material.dart';
//import 'package:foodzi/DineInPage/DineInView.dart';
import 'package:foodzi/RestaurantPage/RestaurantView.dart';
import 'package:foodzi/Notifications/NotificationView.dart';
import 'package:foodzi/ProfilePage/ProfileScreen.dart';
import 'package:foodzi/ResetPassword/ResetPassView.dart';
import 'package:foodzi/theme/colors.dart';

class BottomTabbarHome extends StatefulWidget {
  BottomTabbarHome();
  @override
  State<StatefulWidget> createState() {
    return _BottomTabbarHomeState();
  }
}

class _BottomTabbarHomeState extends State<BottomTabbarHome> {
  int currentTabIndex = 0;
  List<Widget> tabsHome = [
    RestaurantView(),
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
              backgroundColor: redtheme,
              onPressed: () {},
              child: Image.asset('assets/ClockIcon/clock.png')),
        ),
      ),
      body: 
           tabsHome[currentTabIndex],
          
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
