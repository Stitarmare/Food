import 'package:flutter/material.dart';
import 'package:foodzi/Models/GetRestaurantReview.dart';
import 'package:foodzi/Models/RestaurantInfoModel.dart';
import 'package:foodzi/Models/WriteRestaurantReview.dart';
import 'package:foodzi/theme/colors.dart';
//import 'package:rating_bar/rating_bar.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoPresenter.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoContractor.dart';

class MyDialogRating extends StatefulWidget {
  const MyDialogRating({this.onValueChange, this.initialValue,this.rest_id});

  final String initialValue;
  final void Function(String) onValueChange;
  final int rest_id;

  @override
  State createState() => new MyDialogRatingState();
}
class MyDialogRatingState extends State<MyDialogRating> 
implements RestaurantInfoModelView{
 int _rating = 0;
  // TextEditingController _controller;
   RestaurantInfoPresenter restaurantReviewPresenter;
  final _controller = TextEditingController();

  void rate(int rating) {
    //Other actions based on rating such as api calls.
    setState(() {
      if (_rating == rating){
        _rating--;
      }else{
        _rating = rating;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
     restaurantReviewPresenter = RestaurantInfoPresenter(restaurantInfoModelView: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),

      children: <Widget>[
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
                        'Write Review',
                        style: TextStyle(
                            fontSize: 16, color: greytheme700,fontWeight: FontWeight.w600,fontFamily: 'gotham'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Rating for Reviews
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new GestureDetector(
                            child: new Icon(
                              Icons.star,
                              size: 20,
                              color: _rating >= 1
                                  ? redtheme
                                  : greytheme1300,
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
                              color: _rating >= 2
                                  ? redtheme
                                  : greytheme1300,
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
                              color: _rating >= 3
                                  ? redtheme
                                  : greytheme1300,
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
                              color: _rating >= 4
                                  ? redtheme
                                  :greytheme1300,
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
                              color: _rating >= 5
                                  ? redtheme
                                  : greytheme1300,
                            ),
                            onTap: () => rate(5),
                          )
                        ],
                      ),
                    ),
  //                     RatingBar(
  //   onRatingChanged: (rating) => setState(() => _rating = rating),
  //   filledIcon: Icons.star,
  //   emptyIcon: Icons.star_border,
  //   halfFilledIcon: Icons.star_half,
  //   isHalfAllowed: false,
  //   filledColor: Colors.green,
  //   emptyColor: Colors.redAccent,
  //   halfFilledColor: Colors.amberAccent, 
  //   size: 20,
  // ),
                    SizedBox(
                      height: 20
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 37, right: 27),
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: greytheme600)),
                        // color: Color.fromRGBO(213, 213, 213, 1)),
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 16),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Write Review.",
                            hintStyle: TextStyle(
                                fontFamily: 'gotham',
                                color: greytheme700,
                                fontSize: 13,
                                //fontWeight: FontWeight.w600),
                            )
                          ),
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
                      onPressed: () {
                        // restaurantIdInfoPresenter.writeRestaurantReview(
                        //     context, widget.rest_Id, _controller.text, 3);
                        restaurantReviewPresenter.writeRestaurantReview(context, widget.rest_id, _controller.value.text, _rating);
                        print(_rating);
                        print(_controller.value.text);
                        //Write Review API Call
                      },
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                          color:Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ))
                  ],
                ),
              ),
      ]
    );
  }

  @override
  void getReviewFailed() {
    // TODO: implement getReviewFailed
  }

  @override
  void getReviewSuccess(RestaurantReviewData getReviewList) {
    // TODO: implement getReviewSuccess
  }

  @override
  void restaurantInfoFailed() {
    // TODO: implement restaurantInfoFailed
  }

  @override
  void restaurantInfoSuccess(RestaurantInfoData restInfoData) {
    // TODO: implement restaurantInfoSuccess
  }

  @override
  void writeReviewFailed() {
    // TODO: implement writeReviewFailed
  }

  @override
  void writeReviewSuccess(WriteRestaurantReviewModel writeReview) {
    // TODO: implement writeReviewSuccess
  }
}