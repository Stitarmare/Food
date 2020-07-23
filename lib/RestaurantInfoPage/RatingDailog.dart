import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodzi/Models/GetRestaurantReview.dart';
import 'package:foodzi/Models/RestaurantInfoModel.dart';
import 'package:foodzi/Models/WriteRestaurantReview.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:toast/toast.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoPresenter.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoContractor.dart';
import 'package:progress_dialog/progress_dialog.dart';

class MyDialogRating extends StatefulWidget {
  const MyDialogRating({this.onValueChange, this.initialValue, this.restId});

  final String initialValue;
  final void Function(String) onValueChange;
  final int restId;

  @override
  State createState() => new MyDialogRatingState();
}

class MyDialogRatingState extends State<MyDialogRating>
    with TickerProviderStateMixin
    implements RestaurantInfoModelView {
  int _rating = 0;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  RestaurantInfoPresenter restaurantReviewPresenter;
  final _controller = TextEditingController();
  ProgressDialog progressDialog;
  bool isLoader = false;

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
    restaurantReviewPresenter =
        RestaurantInfoPresenter(restaurantInfoModelView: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);

    return new SimpleDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        children: <Widget>[
          Stack(alignment: Alignment.center, children: <Widget>[
            Container(
              height: 311,
              width: 284,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      STR_WRITE_REVIEWS,
                      style: TextStyle(
                          fontSize: FONTSIZE_16,
                          color: greytheme700,
                          fontWeight: FontWeight.w600,
                          fontFamily: Constants.getFontType()),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(left: 37, right: 27),
                      height: 120,
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
                            )),
                        maxLines: 3,
                        controller: _controller,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Center(
                      child: RaisedButton(
                    color: redtheme,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () async {
                      if (_rating != 0) {
                        if (_controller.value.text == STR_BLANK) {
                          Toast.show(STR_ADD_REVIEW, context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        } else {
                          // DialogsIndicator.showLoadingDialog(
                          //     context, _keyLoader, "");
                          // await progressDialog.show();
                          setState(() {
                            isLoader = true;
                          });
                          restaurantReviewPresenter.writeRestaurantReview(
                              context,
                              widget.restId,
                              _controller.value.text,
                              _rating);
                        }
                      } else {
                        Toast.show(STR_ADD_REVIEW_RATING, context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                      }
                      print(_rating);
                      print(_controller.value.text);
                    },
                    child: Text(
                      STR_SUMBIT,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: FONTSIZE_18,
                      ),
                    ),
                  ))
                ],
              ),
            ),
            isLoader
                ? SpinKitFadingCircle(
                    color: Globle().colorscode != null
                        ? getColorByHex(Globle().colorscode)
                        : orangetheme300,
                    size: 50.0,
                    controller: AnimationController(
                        vsync: this,
                        duration: const Duration(milliseconds: 1200)),
                  )
                : Text("")
          ]),
        ]);
  }

  @override
  void getReviewFailed() {}

  @override
  void getReviewSuccess(List<RestaurantReviewList> getReviewList) {}

  @override
  void restaurantInfoFailed() {}

  @override
  void restaurantInfoSuccess(RestaurantInfoData restInfoData) {}

  @override
  void writeReviewFailed() {
    setState(() {
      isLoader = false;
    });
    Navigator.pop(context, false);
  }

  @override
  Future<void> writeReviewSuccess(
      WriteRestaurantReviewModel writeReview) async {
    // await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    setState(() {
      isLoader = false;
    });
    Toast.show(
      STR_REVIEW_SUMBITTED,
      context,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.BOTTOM,
    );
    Navigator.pop(context, true);
  }
}
