import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/theme/colors.dart';

class UserGuideView extends StatefulWidget {
  @override
  _UserGuideViewState createState() => _UserGuideViewState();
}

class _UserGuideViewState extends State<UserGuideView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("UserGuide")),
      body: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("${index + 1}",
                        style: TextStyle(
                            fontSize: FONTSIZE_16,
                            fontFamily: KEY_FONTFAMILY,
                            fontWeight: FontWeight.w600,
                            color: greytheme700)),
                    SizedBox(width: 10),
                    Text(data[index].title,
                        style: TextStyle(
                            fontSize: FONTSIZE_16,
                            fontFamily: KEY_FONTFAMILY,
                            fontWeight: FontWeight.w600,
                            color: greytheme700)),
                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: Image.asset(
                  data[index].imagePath,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(child: Container())
            ],
          );
        },

        // indicatorLayout: PageIndicatorLayout.COLOR,
        autoplay: false,
        itemCount: data.length,
        // pagination: SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }
}

List<SwiperData> data = [
  SwiperData(
    title: "Register in a few steps",
    imagePath: "assets/UserGuide/Registerpage.png",
  ),
  SwiperData(
    title: "Please enter your mobile number to get OTP",
    imagePath: "assets/UserGuide/otpscreen.png",
  ),
  SwiperData(
    title: "Login",
    imagePath: "assets/UserGuide/loginpage.png",
  ),
  SwiperData(
    title: "Locate desired Restaurant",
    imagePath: "assets/UserGuide/Registerpage.png",
  ),
  SwiperData(
    title: "Choose items from menu ",
    imagePath: "assets/UserGuide/menulist.png",
  ),
  SwiperData(
    title: "Choose order & add to cart",
    imagePath: "assets/UserGuide/additemtocart.png",
  ),
  SwiperData(
    title: "When done eating - request digital bill",
    imagePath: "assets/UserGuide/currentorders.png",
  ),
  SwiperData(
    title: "Options to split bill",
    imagePath: "assets/UserGuide/splitbill.png",
  ),
  SwiperData(
      title: "Safe Easy Payment using Phone",
      imagePath: "assets/UserGuide/paymentpage.png"),
];

class SwiperData {
  String title;
  String imagePath;
  SwiperData({this.title, this.imagePath});
}
