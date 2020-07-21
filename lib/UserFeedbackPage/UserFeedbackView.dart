import 'package:flutter/material.dart';
import 'package:foodzi/LandingPage/LandingView.dart';
import 'package:foodzi/Models/WriteRestaurantReview.dart';
import 'package:foodzi/Models/RestaurantInfoModel.dart';
import 'package:foodzi/Models/GetRestaurantReview.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoContractor.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

class UserFeedbackView extends StatefulWidget {
  DateTime dateTime;
  int restId;
  UserFeedbackView({
    this.dateTime,
    this.restId,
  });
  @override
  State createState() => new UserFeedbackViewState();
}

class UserFeedbackViewState extends State<UserFeedbackView>
    implements RestaurantInfoModelView {
  int _rating = 0;
  RestaurantInfoPresenter restaurantReviewPresenter;
  final _controller = TextEditingController();
  ProgressDialog progressDialog;

  void rate(int rating) {
    setState(() {
      if (_rating == rating) {
        _rating--;
      } else {
        _rating = rating;
      }
    });
  }

  @override
  void initState() {
    print(widget.dateTime.toString());
    restaurantReviewPresenter =
        RestaurantInfoPresenter(restaurantInfoModelView: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);

    return SafeArea(
      top: false,
      right: false,
      left: false,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Order Feedback",
            style: TextStyle(
                fontSize: FONTSIZE_20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: Constants.getFontType()),
          ),
          // backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      if (_rating != 0) {
                        if (_controller.value.text == STR_BLANK) {
                          Toast.show(STR_ADD_REVIEW, context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        } else {
                          await progressDialog.show();
                          restaurantReviewPresenter.writeRestaurantReview(
                              context,
                              widget.restId,
                              _controller.value.text,
                              _rating);
                        }
                      } else {
                        if (_controller.value.text != STR_BLANK) {
                          Toast.show(STR_ADD_RATING, context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        } else {
                          Toast.show(STR_ADD_REVIEW_RATING, context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        }
                      }
                      print(_rating);
                      print(_controller.value.text);
                    },
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: getColorByHex(Globle().colorscode),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Center(
                        child: Text(
                          "SUBMIT",
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
              )),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Image.asset("assets/FoodServeIcon/plate.png",
                    height: 150,
                    width: 150,
                    fit: BoxFit.fitWidth,
                    color: Globle().colorscode != null
                        ? getColorByHex(Globle().colorscode)
                        : orangetheme300),
                Text(
                  "You Just got served!",
                  style: TextStyle(
                    fontFamily: KEY_FONTFAMILY,
                    fontWeight: FontWeight.w700,
                    fontSize: FONTSIZE_22,
                  ),
                ),
                SizedBox(height: 5),
                widget.dateTime != null
                    ? Text(
                        "${getDateForOrderHistory(widget.dateTime.toString())}",
                        style: TextStyle(
                          fontFamily: KEY_FONTFAMILY,
                          fontWeight: FontWeight.w500,
                          fontSize: FONTSIZE_15,
                        ),
                      )
                    : Text(""),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 0.5,
                  ),
                ),
                SizedBox(height: 60),
                Text(
                  "Rate Restaurant",
                  style: TextStyle(
                    fontFamily: KEY_FONTFAMILY,
                    fontWeight: FontWeight.w400,
                    fontSize: FONTSIZE_20,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new GestureDetector(
                        child: new Icon(
                          Icons.star,
                          size: 20,
                          color: _rating >= 1 ? redtheme : greytheme1300,
                        ),
                        onTap: () => rate(1),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      new GestureDetector(
                        child: new Icon(
                          Icons.star,
                          size: 20,
                          color: _rating >= 2 ? redtheme : greytheme1300,
                        ),
                        onTap: () => rate(2),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      new GestureDetector(
                        child: new Icon(
                          Icons.star,
                          size: 20,
                          color: _rating >= 3 ? redtheme : greytheme1300,
                        ),
                        onTap: () => rate(3),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      new GestureDetector(
                        child: new Icon(
                          Icons.star,
                          size: 20,
                          color: _rating >= 4 ? redtheme : greytheme1300,
                        ),
                        onTap: () => rate(4),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      new GestureDetector(
                        child: new Icon(
                          Icons.star,
                          size: 20,
                          color: _rating >= 5 ? redtheme : greytheme1300,
                        ),
                        onTap: () => rate(5),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 37, right: 27),
                    height: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: greytheme600)),
                    padding: EdgeInsets.fromLTRB(12, 12, 12, 16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: STR_WRITE_REVIEWS,
                        hintStyle: TextStyle(
                          fontFamily: Constants.getFontType(),
                          color: greytheme700,
                          fontSize: FONTSIZE_13,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      maxLines: null,
                      controller: _controller,
                    ),
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getDateForOrderHistory(String dateString) {
    var date = DateTime.parse(dateString);
    var dateStr = DateFormat("dd MMM yyyy").format(date.toLocal());

    DateFormat format = new DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime time1 = format.parse(dateString, true);
    var time = DateFormat("hh:mm a").format(time1.toLocal());

    return "$dateStr at $time";
  }

  @override
  void getReviewFailed() {}

  @override
  void getReviewSuccess(List<RestaurantReviewList> getReviewList) {}

  @override
  void restaurantInfoFailed() {}

  @override
  void restaurantInfoSuccess(RestaurantInfoData restaurantInfoData) {}

  @override
  void writeReviewFailed() async {
    await progressDialog.hide();
  }

  @override
  void writeReviewSuccess(WriteRestaurantReviewModel writeReview) async {
    await progressDialog.hide();
    // Toast.show(
    //   STR_REVIEW_SUMBITTED,
    //   context,
    //   duration: Toast.LENGTH_SHORT,
    //   gravity: Toast.BOTTOM,
    // );
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainWidget()),
        ModalRoute.withName(STR_MAIN_WIDGET_PAGE));
  }
}
