import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class DriverDetailsView extends StatefulWidget {
  @override
  _DriverDetailsViewState createState() => _DriverDetailsViewState();
}

class _DriverDetailsViewState extends State<DriverDetailsView> {
  final _controller = TextEditingController();
  final GlobalKey<FormState> _reasonFormKey = GlobalKey<FormState>();
  bool _validate = false;
  String imageURL = STR_BLANK;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      children: <Widget>[
        Form(
          key: _reasonFormKey,
          autovalidate: _validate,
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Driver Details",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "gotham",
                              fontWeight: FontWeight.w600,
                              color: greytheme1200,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.black26,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            })),
                  ],
                ),
                SizedBox(height: 20),
                ClipOval(
                  child: CachedNetworkImage(
                    width: 70,
                    height: 70,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Container(
                        width: 70,
                        height: 70,
                        child: Center(child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) => Image.asset(
                      PROFILE_IMAGE_PATH,
                      width: 70,
                      height: 70,
                      fit: BoxFit.fill,
                    ),
                    imageUrl: profilePic(),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '${Globle().loginModel.data.firstName ?? STR_BLANK} ${Globle().loginModel.data.lastName ?? STR_BLANK}',
                  style: TextStyle(
                      fontSize: 18,
                      color: greytheme1200,
                      fontFamily: Constants.getFontType(),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          width: 32.5,
                          child: Padding(
                            padding: EdgeInsets.only(),
                            child: Icon(
                              Icons.phone,
                              size: 16,
                              color: Globle().colorscode != null
                                  ? getColorByHex(Globle().colorscode)
                                  : orangetheme,
                            ),
                          )),
                      Text(
                        "${Globle().loginModel.data.mobileNumber}",
                        style: TextStyle(
                            fontSize: 16,
                            color: greytheme1200,
                            fontFamily: Constants.getFontType(),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  onTap: () {
                    // UrlLauncher.launch(Globle().loginModel.data.mobileNumber);
                  },
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Number of Orders Delivered",
                  style: TextStyle(
                      fontSize: FONTSIZE_16,
                      color: greytheme1200,
                      fontFamily: Constants.getFontType(),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20),
                Text(
                  "124",
                  style: TextStyle(
                      fontSize: 25,
                      color: greytheme1200,
                      fontFamily: Constants.getFontType(),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                // Center(
                //   child: Container(
                //     margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                //     height: 90,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(15),
                //         border: Border.all(color: greytheme600)),
                //     padding: EdgeInsets.fromLTRB(12, 0, 12, 16),
                //     child: TextFormField(
                //       // inputFormatters: [
                //       //   BlacklistingTextInputFormatter(RegExp('[ ]'))
                //       // ],
                //       textAlign: TextAlign.start,
                //       decoration: InputDecoration(
                //           focusedBorder: InputBorder.none,
                //           enabledBorder: InputBorder.none,
                //           errorBorder: InputBorder.none,
                //           disabledBorder: InputBorder.none,
                //           hintText: "Type your message here",
                //           hintStyle: TextStyle(
                //             fontFamily: "gotham",
                //             color: greytheme700,
                //             fontSize: 16,
                //           )),
                //       maxLines: 3,
                //       validator: validateText,
                //       controller: _controller,
                //     ),
                //   ),
                // ),
                // SizedBox(height: 20),
                RaisedButton(
                  color: (Globle().colorscode) != null
                      ? getColorByHex(Globle().colorscode)
                      : orangetheme,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "CALL",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "gotham",
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    UrlLauncher.launch(
                        "tel:" + Globle().loginModel.data.mobileNumber);
                  },
                ),
              ])),
        )
      ],
    );
  }

  // String validateText(String value) {
  //   if (value.isEmpty) {
  //     return STR_FIELD_REQUIRED;
  //   }
  //   return null;
  // }

  profilePic() {
    String imageUrl = imageURL;
    // if (Globle().loginModel.data.userDetails != null) {
    //   imageUrl = (Globle().loginModel.data.userDetails.profileImage != null)
    //       ? BaseUrl.getBaseUrlImages() +
    //           '${Globle().loginModel.data.userDetails.profileImage}'
    //       : PROFILE_IMAGE_PATH;
    //   return imageUrl;
    // }
    return imageUrl;
  }
}
