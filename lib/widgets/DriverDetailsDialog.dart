import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class DriverDetailsView extends StatefulWidget {
  String orderid;
  DriverDetailsView({this.orderid});
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
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    "Driver Details",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "gotham",
                      fontWeight: FontWeight.w600,
                      color: greytheme1200,
                    ),
                  ),
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
                      fontSize: FONTSIZE_16,
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
                              color: getColorByHex(Globle().colorscode),
                            ),
                          )),
                      Text(
                        "${Globle().loginModel.data.mobileNumber}",
                        style: TextStyle(
                            fontSize: FONTSIZE_14,
                            color: greytheme1200,
                            fontFamily: Constants.getFontType(),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  onTap: () {
                    UrlLauncher.launch(Globle().loginModel.data.mobileNumber);
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(height: 20),
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
                      fontSize: 18,
                      color: greytheme1200,
                      fontFamily: Constants.getFontType(),
                      fontWeight: FontWeight.w600),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: greytheme600)),
                    padding: EdgeInsets.fromLTRB(12, 12, 12, 16),
                    child: TextFormField(
                      // inputFormatters: [
                      //   BlacklistingTextInputFormatter(RegExp('[ ]'))
                      // ],
                      decoration: InputDecoration(
                          hintText: "Write reason",
                          hintStyle: TextStyle(
                            fontFamily: "gotham",
                            color: greytheme700,
                            fontSize: 14,
                          )),
                      maxLines: 1,
                      validator: validateText,
                      controller: _controller,
                    ),
                  ),
                ),
                RaisedButton(
                  color: (Globle().colorscode) != null
                      ? getColorByHex(Globle().colorscode)
                      : redtheme,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "Send",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "gotham",
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    // reasonBtn();
                  },
                ),
              ])),
        )
      ],
    );
  }

  String validateText(String value) {
    if (value.isEmpty) {
      return STR_FIELD_REQUIRED;
    }
    return null;
  }

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
