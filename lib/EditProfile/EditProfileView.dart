import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzi/EditProfile/EditProfileContractor.dart';
import 'package:foodzi/EditProfile/EditProfilePresenter.dart';
import 'package:foodzi/Models/EditCityModel.dart';
import 'package:foodzi/Models/EditCountryModel.dart';
import 'package:foodzi/Models/EditStateModel.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/BoxTextField.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

class EditProfileview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditProfileState();
  }
}

class _EditProfileState extends State<EditProfileview>
    implements EditProfileModelView {
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  final FocusNode _nodeText1 = FocusNode();
  List<CountryList> _dropdownItemsCountry = [];
  List<StateList> _dropdownItemsState = [];
  List<CityList> _dropdownItemsCity = [];
  final formKey = new GlobalKey<FormState>();
  bool _validate = false;
  final GlobalKey<FormState> _editprofileFormKey = GlobalKey<FormState>();
  String _dropdownCountryValue;
  String _dropdownStateValue;
  String _dropdownCityValue;
  ProgressDialog progressDialog;
  var firstName = Globle().loginModel.data.firstName;
  var lastName = Globle().loginModel.data.lastName;
  var streetAddress = STR_BLANK;
  var countryID;
  var stateID;
  var cityID;
  var pinCode;
  EditProfilePresenter editprofilepresenter;
  @override
  void initState() {
    super.initState();
    editprofilepresenter = EditProfilePresenter(this);
    // DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
    editprofilepresenter.editCountry(context);
    editprofilepresenter.editState(context,true);
    setData();
  }

  void setData() {
    if (Globle().loginModel.data.userDetails != null) {
      streetAddress = Globle().loginModel.data.userDetails.addressLine1;

      if (Globle().loginModel.data.userDetails.country != null) {
      _dropdownCountryValue = Globle().loginModel.data.userDetails.country.name;
      countryID = Globle().loginModel.data.userDetails.country.id;
    }
    if (Globle().loginModel.data.userDetails.state != null) {
      _dropdownStateValue = Globle().loginModel.data.userDetails.state.name;
      stateID = Globle().loginModel.data.userDetails.state.id;
    }
    if (Globle().loginModel.data.userDetails.city != null) {
      _dropdownCityValue = Globle().loginModel.data.userDetails.city.name;
      cityID = Globle().loginModel.data.userDetails.city.id;
      editprofilepresenter.editCity(stateID.toString(), context,false);
    }
    pinCode = Globle().loginModel.data.userDetails.postalCode;
    }
    
  }

  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          brightness: Brightness.dark,
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Text(KEY_EDIT_PROFILE,
              style: TextStyle(
                  color: greytheme700,
                  fontSize: FONTSIZE_18,
                  fontFamily: KEY_FONTFAMILY,
                  fontWeight: FontWeight.w500)),
        ),
        body: KeyboardActions(
          config: _buildConfig(context),
          child: SingleChildScrollView(
            child: _getmainView(context),
          ),
        ));
  }

  Future<void> updateButtonClicked() async {
    if (_editprofileFormKey.currentState.validate()) {
      if (countryID == null) {
        Toast.show(
          "Please select country.",
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
        );
        return;
      }
      if (stateID == null) {
        Toast.show(
          "Please select state.",
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
        );
        return;
      }
      if (cityID == null) {
        Toast.show(
          "Please select city.",
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
        );
        return;
      }

      await progressDialog.show();
      //DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
      editprofilepresenter.performUpdate(firstName, lastName, streetAddress,
          countryID, stateID, cityID, pinCode, context);
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  Widget _getmainView(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Form(
        key: _editprofileFormKey,
        autovalidate: _validate,
        child: Column(
          children: <Widget>[
            BoxAppTextField(
              onChanged: (text) {
                firstName = text;
              },
              tfValue: Globle().loginModel.data.firstName,
              // placeHolderName:
              //     Globle().loginModel.data.firstName ?? KEY_FIRST_NAME,
              placeHolderName: KEY_FIRST_NAME,
              validator: validatename,
            ),
            SizedBox(
              height: 28,
            ),
            BoxAppTextField(
              onChanged: (text) {
                lastName = text;
              },

              tfValue: Globle().loginModel.data.lastName,
              placeHolderName: KEY_LAST_NAME,
              // placeHolderName:
              //     Globle().loginModel.data.lastName ?? KEY_LAST_NAME,
              validator: validatename,
            ),
            SizedBox(
              height: 28,
            ),
            BoxAppTextField(
              onChanged: (text) {
                streetAddress = text;
              },
              tfValue: streetAddress,
              placeHolderName: KEY_STREET,
              validator: validateStreetname,
            ),
            SizedBox(
              height: 28,
            ),
            _buildCountry(),
            SizedBox(
              height: 28,
            ),
            _buildState(),
            SizedBox(
              height: 28,
            ),
            _buildCity(),
            SizedBox(
              height: 28,
            ),
            BoxAppTextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),
                WhitelistingTextInputFormatter.digitsOnly
              ],
              onChanged: (text) {
                pinCode = text;
              },
              focusNode: _nodeText1,
              tfValue: pinCode,
              placeHolderName: KEY_POSTAL_CODE,
              keyboardType: TextInputType.number,
              validator: validatePinCode,
            ),
            SizedBox(
              height: 44,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.39,
                  height: 43,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(6.0),
                    ),
                    color: greentheme100,
                    child: Text(
                      KEY_UPDATE,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: KEY_FONTFAMILY,
                          fontSize: FONTSIZE_18,
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: () => updateButtonClicked(),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.39,
                  height: 43,
                  child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(6.0),
                        side: BorderSide(color: greytheme100)),
                    child: Text(
                      KEY_CANCEL_UC,
                      style: TextStyle(
                          color: greytheme1000,
                          fontFamily: KEY_FONTFAMILY,
                          fontSize: FONTSIZE_18,
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCountry() {
    return FormField(builder: (FormFieldState state) {
      return DropdownButtonFormField(
        items: _dropdownItemsCountry.map((CountryList country) {
          return new DropdownMenuItem(
              value: country.name,
              child: Row(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(country.name)),
                ],
              ));
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _dropdownCountryValue = newValue;
            _dropdownItemsCountry.forEach((value) {
              if (value.name.toUpperCase() ==
                  newValue.toString().toUpperCase()) {
                print(value.id);
                countryID = value.id;
              }
            });
          });
        },
        value: _dropdownCountryValue,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 5, 0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greentheme100, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greytheme900, width: 2)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
          filled: false,
          hintText: STR_CHOOSE_COUNTRY,
          prefixIcon: Icon(
            Icons.location_on,
            size: 20,
            color: greytheme1000,
          ),
          labelText: _dropdownCountryValue == null ? STR_WHERE_FROM : STR_FROM,
          labelStyle: TextStyle(
              color: greytheme1000,
              fontSize: FONTSIZE_16,
              fontFamily: KEY_FONTFAMILY,
              fontWeight: FontWeight.w500),
        ),
      );
    });
  }

  Widget _buildState() {
    return FormField(builder: (FormFieldState state) {
      return DropdownButtonFormField(
        items: _dropdownItemsState.map((StateList state) {
          return new DropdownMenuItem<String>(
              value: state.name,
              child: Row(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(state.name)),
                ],
              ));
        }).toList(),
        onChanged: (newValue) {
          setState(() async {
            _dropdownStateValue = newValue;
            _dropdownItemsState.forEach((value) {
              if (value.name.toUpperCase() ==
                  newValue.toString().toUpperCase()) {
                print(value.id);
                stateID = value.id;
              }
            });
            await progressDialog.show();
            //DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
            editprofilepresenter.editCity(stateID.toString(), context,false);
          });
        },
        value: _dropdownStateValue,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 5, 0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greentheme100, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greytheme900, width: 2)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
          filled: false,
          hintText: STR_CHOOSE_STATE,
          prefixIcon: Icon(
            Icons.pin_drop,
            size: 20,
            color: greytheme1000,
          ),
          labelText: _dropdownStateValue == null ? STR_WHERE_FROM : STR_FROM,
          labelStyle: TextStyle(
              color: greytheme1000,
              fontSize: FONTSIZE_16,
              fontFamily: KEY_FONTFAMILY,
              fontWeight: FontWeight.w500),
        ),
      );
    });
  }

  Widget _buildCity() {
    return FormField(builder: (FormFieldState state) {
      return DropdownButtonFormField(
        items: _dropdownItemsCity.map((CityList city) {
          return new DropdownMenuItem(
              value: city.name,
              child: Row(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(city.name)),
                ],
              ));
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _dropdownCityValue = newValue;
            _dropdownItemsCity.forEach((value) {
              if (value.name.toUpperCase() ==
                  newValue.toString().toUpperCase()) {
                print(value.id);
                cityID = value.id;
              }
            });
          });
        },
        value: _dropdownCityValue,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 5, 0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greentheme100, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greytheme900, width: 2)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
          filled: false,
          hintText: STR_CHOOSE_CITY,
          prefixIcon: Icon(
            Icons.location_city,
            size: 20,
            color: greytheme1000,
          ),
          labelText: _dropdownCityValue == null ? STR_WHERE_FROM : STR_FROM,
          labelStyle: TextStyle(
              color: greytheme1000,
              fontSize: FONTSIZE_16,
              fontFamily: KEY_FONTFAMILY,
              fontWeight: FontWeight.w500),
        ),
      );
    });
  }

  String validatename(String value) {
    String validCharacters = STR_VALIDATE_NAME;
    RegExp regexp = RegExp(validCharacters);
    if (value.isEmpty) {
      return KEY_THIS_SHOULD_NOT_BE_EMPTY;
    } else if (value.length > 20) {
      return KEY_THIS_SHOULD_BE_ONLY_20_CHAR_LONG;
    } else if (!regexp.hasMatch(value)) {
      return Key_SPECIAL_CHAR;
    }
    return null;
  }

  String validateStreetname(String value) {
    if (value.isEmpty) {
      return KEY_THIS_SHOULD_NOT_BE_EMPTY;
    } else if (value.length > 30) {
      return KEY_THIS_SHOULD_BE_ONLY_30_CHAR_LONG;
    }
    return null;
  }

  String validatePinCode(String value) {
    String pattern = STR_VALIDATE_PIN;
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return KEY_PINCODE_NUMBER_REQUIRED;
    }
    // else if (!regExp.hasMatch(value)) {
    //   return KEY_PIN_NUMBER_TEXT;
    // }
    else if (value.length < 4) {
      return KEY_PIN_NUMBER_LIMIT;
    }
    return null;
  }

  showDialogBox(BuildContext context) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text(
            STR_EDIT_PROFILE,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: greentheme100,
                fontWeight: FontWeight.w600,
                fontFamily: KEY_FONTFAMILY,
                fontSize: FONTSIZE_22),
          ),
          content: Text(
            STR_ACCOUNT_UPDATED,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: greytheme100,
                fontWeight: FontWeight.w500,
                fontFamily: KEY_FONTFAMILY,
                fontSize: FONTSIZE_20),
          ),
          actions: [
            FlatButton(
              child: const Text(
                STR_OK,
                style: TextStyle(
                    color: greentheme100,
                    fontWeight: FontWeight.w600,
                    fontFamily: KEY_FONTFAMILY,
                    fontSize: FONTSIZE_20),
              ),
              onPressed: () {
                // Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                //     .pop();
                Navigator.pushReplacementNamed(context, STR_MAIN_WIDGET_PAGE);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void editCityFailed() {}

  @override
  Future<void> editCitySuccess(List<CityList> cityList) async {
    if (cityList.length == 0) {
      return;
    }
    setState(() {
      _dropdownItemsCity.addAll(cityList);
    });
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void editCountryFailed() {}

  @override
  Future<void> editCountrySuccess(List<CountryList> countryList) async {
    if (countryList.length == 0) {
      return;
    }
    setState(() {
      _dropdownItemsCountry.addAll(countryList);
    });
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void editStateFailed() {}

  @override
  Future<void> editStateSuccess(List<StateList> stateList) async {
    if (stateList.length == 0) {
      return;
    }
    setState(() {
      _dropdownItemsState.addAll(stateList);
    });
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void profileUpdateFailed() {}

  @override
  Future<void> profileUpdateSuccess() async {
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    showDialogBox(context);
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: false,
      actions: [
        KeyboardAction(
          focusNode: _nodeText1,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(STR_DONE),
          ),
        ),
      ],
    );
  }
}
