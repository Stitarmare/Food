import 'package:flutter/material.dart';
import 'package:foodzi/EditProfile/EditProfileContractor.dart';
import 'package:foodzi/EditProfile/EditProfilePresenter.dart';
import 'package:foodzi/Models/EditCityModel.dart';
import 'package:foodzi/Models/EditCountryModel.dart';
import 'package:foodzi/Models/EditStateModel.dart';
import 'package:foodzi/Models/loginmodel.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';

import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/BoxTextField.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';

class EditProfileview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditProfileState();
  }
}

class _EditProfileState extends State<EditProfileview>
    implements EditProfileModelView {
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  Dialogs dialogs = Dialogs();
  final FocusNode _nodeText1 = FocusNode();
  List<CountryList> _dropdownItemsCountry = [];
  List<StateList> _dropdownItemsState = [];
  List<CityList> _dropdownItemsCity = [];
  final formKey = new GlobalKey<FormState>();
  bool _validate = false;
  final GlobalKey<FormState> _editprofileFormKey = GlobalKey<FormState>();
  // CountryList _dropdownCountryValue = CountryList();
  // StateList _dropdownStateValue = StateList();
  // CityList _dropdownCityValue = CityList();
  String _dropdownCountryValue;
  String _dropdownStateValue;
  String _dropdownCityValue;
  String _errorText;
  //var stateId;
  var firstName = '';
  var lastName = '';
  var streetAddress = '';
  var countryID;
  var stateID;
  var cityID;
  var pinCode;
  EditProfilePresenter editprofilepresenter;
  @override
  void initState() {
    super.initState();
    editprofilepresenter = EditProfilePresenter(this);
    editprofilepresenter.editCountry(context);
    editprofilepresenter.editState(context);
    // setState(() {
    //   editprofilepresenter.editCountry(context);
    //   editprofilepresenter.editState(context);
    //   editprofilepresenter.editCity(stateId, context);
    //   // _dropdownItemsCountry.add(_dropdownCountryValue);
    //   // _dropdownItemsState.add(_dropdownStateValue);
    //   // _dropdownItemsCity.add(_dropdownCityValue);

    //   // _dropdownItems.add(CountryModel(country: 'India', countryCode: '+91'));
    //   // _dropdownItems.add(CountryModel(country: 'USA', countryCode: '+1'));
    //   // _dropdownItemsState.add(StateModel(state: 'MH'));
    //   // _dropdownItemsState.add(StateModel(state: 'UP'));
    //   // _dropdownItemsCity.add(CityModel(city: 'Mumbai'));
    //   // _dropdownItemsCity.add(CityModel(city: 'Navi Mumbai'));
    //   //_dropdownCountryValue = _dropdownItems[0];
    // }
    // );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Text(KEY_EDIT_PROFILE,
              style: TextStyle(
                  color: greytheme700,
                  fontSize: 18,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w500)),
        ),
        body: KeyboardActions(
          config: _buildConfig(context),
          child: SingleChildScrollView(
            child: _getmainView(context),
          ),
        ));
  }

  void updateButtonClicked() {
    if (_editprofileFormKey.currentState.validate()) {
      print("Validation Successful");
      Dialogs.showLoadingDialog(context, _keyLoader, "");
      editprofilepresenter
        ..performUpdate(firstName, lastName, streetAddress, countryID, stateID,
            cityID, pinCode, context);
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
              placeHolderName: KEY_LAST_NAME,
              validator: validatename,
            ),
            // SizedBox(
            //   height: 28,
            // ),
            // BoxAppTextField(
            //   placeHolderName: KEY_MOBILE_NUMBER,
            //   keyboardType: TextInputType.number,
            //   validator: validatemobno,
            // ),
            SizedBox(
              height: 28,
            ),
            BoxAppTextField(
              onChanged: (text) {
                streetAddress = text;
              },
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
            // BoxAppTextField(
            //   placeHolderName: KEY_STATE,
            // ),
            _buildState(),
            SizedBox(
              height: 28,
            ),
            // BoxAppTextField(
            //   placeHolderName: KEY_CITY,
            // ),
            _buildCity(),
            SizedBox(
              height: 28,
            ),
            BoxAppTextField(
              onChanged: (text) {
                pinCode = text;
              },
              focusNode: _nodeText1,
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
                          fontFamily: 'gotham',
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: () => updateButtonClicked(),
                  ),
                ),
                // SizedBox(width:14,),
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
                          fontFamily: 'gotham',
                          fontSize: 18,
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

  // Widget _buildCountry() {
  //   return FormField(
  //     builder: (FormFieldState state) {
  //       return DropdownButtonHideUnderline(
  //         child: new Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: <Widget>[
  //             new InputDecorator(
  //               decoration: InputDecoration(
  //                 contentPadding: EdgeInsets.fromLTRB(0, 0, 5, 0),
  //                 focusedBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: greentheme100, width: 2),
  //                 ),
  //                 enabledBorder: OutlineInputBorder(
  //                     borderSide: BorderSide(color: greytheme900, width: 2)),
  //                 border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(6.0)),
  //                 filled: false,
  //                 hintText: 'Choose Country',
  //                 prefixIcon: Icon(
  //                   Icons.location_on,
  //                   size: 20,
  //                   color: greytheme1000,
  //                 ),
  //                 labelText: _dropdownCountryValue.name == null
  //                     ? 'Where are you from'
  //                     : 'From',
  //                 errorText: _errorText,
  //                 labelStyle: TextStyle(
  //                     color: greytheme1000,
  //                     fontSize: 16,
  //                     fontFamily: 'gotham',
  //                     fontWeight: FontWeight.w500),
  //               ),
  //               isEmpty: _dropdownCountryValue == null,
  //               child: new DropdownButton<CountryList>(
  //                 value: _dropdownCountryValue,
  //                 isDense: true,
  //                 onChanged: (CountryList newValue) {
  //                   print('value change');
  //                   print(newValue);
  //                   setState(() {
  //                     _dropdownCountryValue = newValue;
  //                   });
  //                 },
  //                 items: _dropdownItemsCountry.map((CountryList value) {
  //                   return DropdownMenuItem<CountryList>(
  //                     value: value,
  //                     child: Text(value.name),
  //                   );
  //                 }).toList(),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  Widget _buildCountry() {
    return FormField(builder: (FormFieldState state) {
      return DropdownButtonFormField(
        //itemHeight: Constants.getScreenHeight(context) * 0.06,
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
          // do other stuff with _category
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
        // decoration: InputDecoration(
        //   border: OutlineInputBorder(
        //       borderRadius: BorderRadius.all(Radius.circular(5.0)),
        //       borderSide: BorderSide(color: Colors.blue)),
        //   enabledBorder: UnderlineInputBorder(
        //       borderSide: BorderSide(color: Colors.white)),
        //   hintText: "Select table number",
        // ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 5, 0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greentheme100, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greytheme900, width: 2)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
          filled: false,
          hintText: 'Choose Country',
          prefixIcon: Icon(
            Icons.location_on,
            size: 20,
            color: greytheme1000,
          ),
          labelText:
              _dropdownCountryValue == null ? 'Where are you from' : 'From',
          // errorText: _errorText,
          labelStyle: TextStyle(
              color: greytheme1000,
              fontSize: 16,
              fontFamily: 'gotham',
              fontWeight: FontWeight.w500),
        ),
      );
    });
  }

  // Widget _buildState() {
  //   return FormField(
  //     builder: (FormFieldState state) {
  //       return DropdownButtonHideUnderline(
  //         child: new Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: <Widget>[
  //             new InputDecorator(
  //               decoration: InputDecoration(
  //                 contentPadding: EdgeInsets.fromLTRB(0, 0, 5, 0),
  //                 focusedBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: greentheme100, width: 2),
  //                 ),
  //                 enabledBorder: OutlineInputBorder(
  //                     borderSide: BorderSide(color: greytheme900, width: 2)),
  //                 border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(6.0)),
  //                 filled: false,
  //                 hintText: 'Choose State',
  //                 prefixIcon: Icon(
  //                   Icons.pin_drop,
  //                   size: 20,
  //                   color: greytheme1000,
  //                 ),
  //                 labelText: _dropdownStateValue.name == null
  //                     ? 'Where are you from'
  //                     : 'From',
  //                // errorText: _errorText,
  //                 labelStyle: TextStyle(
  //                     color: greytheme1000,
  //                     fontSize: 16,
  //                     fontFamily: 'gotham',
  //                     fontWeight: FontWeight.w500),
  //               ),
  //               isEmpty: _dropdownStateValue == null,
  //               child: new DropdownButton<StateList>(
  //                 value: _dropdownStateValue,
  //                 isDense: true,
  //                 onChanged: (StateList newValue) {
  //                   print('value change');
  //                   print(newValue);
  //                   setState(() {
  //                     _dropdownStateValue = newValue;
  //                     stateId = newValue.id;
  //                   });
  //                 },
  //                 items: _dropdownItemsState.map((StateList value) {
  //                   return DropdownMenuItem<StateList>(
  //                     value: value,
  //                     child: Text(value.name),
  //                   );
  //                 }).toList(),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  Widget _buildState() {
    return FormField(builder: (FormFieldState state) {
      return DropdownButtonFormField(
        //itemHeight: Constants.getScreenHeight(context) * 0.06,
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
          // do other stuff with _category
          setState(() {
            _dropdownStateValue = newValue;
            _dropdownItemsState.forEach((value) {
              if (value.name.toUpperCase() ==
                  newValue.toString().toUpperCase()) {
                print(value.id);
                stateID = value.id;
              }
            });

            editprofilepresenter.editCity(stateID.toString(), context);
          });
        },
        value: _dropdownStateValue,
        // decoration: InputDecoration(
        //   border: OutlineInputBorder(
        //       borderRadius: BorderRadius.all(Radius.circular(5.0)),
        //       borderSide: BorderSide(color: Colors.blue)),
        //   enabledBorder: UnderlineInputBorder(
        //       borderSide: BorderSide(color: Colors.white)),
        //   hintText: "Select table number",
        // ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 5, 0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greentheme100, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greytheme900, width: 2)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
          filled: false,
          hintText: 'Choose State',
          prefixIcon: Icon(
            Icons.pin_drop,
            size: 20,
            color: greytheme1000,
          ),
          labelText:
              _dropdownStateValue == null ? 'Where are you from' : 'From',
          // errorText: _errorText,
          labelStyle: TextStyle(
              color: greytheme1000,
              fontSize: 16,
              fontFamily: 'gotham',
              fontWeight: FontWeight.w500),
        ),
      );
    });
  }

  // Widget _buildCity() {
  //   return FormField(
  //     builder: (FormFieldState state) {
  //       return DropdownButtonHideUnderline(
  //         child: new Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: <Widget>[
  //             new InputDecorator(
  //               decoration: InputDecoration(
  //                 contentPadding: EdgeInsets.fromLTRB(0, 0, 5, 0),
  //                 focusedBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: greentheme100, width: 2),
  //                 ),
  //                 enabledBorder: OutlineInputBorder(
  //                     borderSide: BorderSide(color: greytheme900, width: 2)),
  //                 border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(6.0)),
  //                 filled: false,
  //                 hintText: 'Choose City',
  //                 prefixIcon: Icon(
  //                   Icons.location_city,
  //                   size: 20,
  //                   color: greytheme1000,
  //                 ),
  //                 labelText: _dropdownCityValue.name == null
  //                     ? 'Where are you from'
  //                     : 'From',
  //                 //errorText: _errorText,
  //                 labelStyle: TextStyle(
  //                     color: greytheme1000,
  //                     fontSize: 16,
  //                     fontFamily: 'gotham',
  //                     fontWeight: FontWeight.w500),
  //               ),
  //               isEmpty: _dropdownCityValue == null ,
  //               child: new DropdownButton<CityList>(
  //                 value: _dropdownCityValue,
  //                 isDense: true,
  //                 onChanged: (CityList newValue) {
  //                   print('value change');
  //                   print(newValue);
  //                   setState(() {
  //                     _dropdownCityValue = newValue;
  //                   });
  //                 },
  //                 items: _dropdownItemsCity.map((CityList value) {
  //                   return DropdownMenuItem<CityList>(
  //                     value: value,
  //                     child: Text(value.name),
  //                   );
  //                 }).toList(),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  Widget _buildCity() {
    return FormField(builder: (FormFieldState state) {
      return DropdownButtonFormField(
        //itemHeight: Constants.getScreenHeight(context) * 0.06,
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

        // decoration: InputDecoration(
        //   border: OutlineInputBorder(
        //       borderRadius: BorderRadius.all(Radius.circular(5.0)),
        //       borderSide: BorderSide(color: Colors.blue)),
        //   enabledBorder: UnderlineInputBorder(
        //       borderSide: BorderSide(color: Colors.white)),
        //   hintText: "Select table number",
        // ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 5, 0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greentheme100, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greytheme900, width: 2)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
          filled: false,
          hintText: 'Choose City',
          prefixIcon: Icon(
            Icons.location_city,
            size: 20,
            color: greytheme1000,
          ),
          labelText: _dropdownCityValue == null ? 'Where are you from' : 'From',
          // errorText: _errorText,
          labelStyle: TextStyle(
              color: greytheme1000,
              fontSize: 16,
              fontFamily: 'gotham',
              fontWeight: FontWeight.w500),
        ),
      );
    });
  }

  String validatename(String value) {
    String validCharacters = r'^[a-zA-Z]';
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
    String pattern = r'(^[1-9][0-9]{5}$)';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return KEY_PINCODE_NUMBER_REQUIRED;
    } else if (!regExp.hasMatch(value)) {
      return KEY_PIN_NUMBER_TEXT;
    } else if (value.length != 6) {
      return KEY_PIN_NUMBER_LIMIT;
    }
    return null;
  }

  showDialogBox(BuildContext context) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          "Edit Profile",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: greentheme100,
              fontWeight: FontWeight.w600,
              fontFamily: 'gotham',
              fontSize: 22),
        ),
        content: Text(
          'Your account details has been successfully updated. ',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: greytheme100,
              fontWeight: FontWeight.w500,
              fontFamily: 'gotham',
              fontSize: 20),
        ),
        actions: [
          FlatButton(
            child: const Text(
              "OK",
              style: TextStyle(
                  color: greentheme100,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'gotham',
                  fontSize: 20),
            ),
            onPressed: () {
              Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                  .pop();
              Navigator.pushReplacementNamed(context, '/MainWidget');
            },
          ),
        ],
      ),
    );
  }

  @override
  void editCityFailed() {
    // TODO: implement editCityFailed
  }

  @override
  void editCitySuccess(List<CityList> cityList) {
    if (cityList.length == 0) {
      return;
    }
    setState(() {
      //  if (_dropdownItemsCity == null) {
      //   _dropdownItemsCity = cityList;
      // } else {
      //   _dropdownItemsCity.addAll(cityList);
      // }
      _dropdownItemsCity.addAll(cityList);
    });
    // TODO: implement editCitySuccess
  }

  @override
  void editCountryFailed() {
    // TODO: implement editCountryFailed
  }

  @override
  void editCountrySuccess(List<CountryList> countryList) {
    // TODO: implement editCountrySuccess
    if (countryList.length == 0) {
      return;
    }
    setState(() {
      //       if (_dropdownItemsCountry == null) {
      //   _dropdownItemsCountry = countryList;
      // } else {
      //   _dropdownItemsCountry.addAll(countryList);
      // }
      _dropdownItemsCountry.addAll(countryList);
    });
  }

  @override
  void editStateFailed() {
    // TODO: implement editStateFailed
  }

  @override
  void editStateSuccess(List<StateList> stateList) {
    if (stateList.length == 0) {
      return;
    }
    setState(() {
      //   if (_dropdownItemsState == null) {
      //   _dropdownItemsState = stateList;
      // } else {
      //   _dropdownItemsState.addAll(stateList);
      // }
      _dropdownItemsState.addAll(stateList);
    });
    // TODO: implement editStateSuccess
  }

  @override
  void profileUpdateFailed() {
    // TODO: implement profileUpdateFailed
  }

  @override
  void profileUpdateSuccess() {
    // TODO: implement profileUpdateSuccess
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
            child: Text("Done"),
          ),
        ),
      ],
    );
  }
}

// class CountryModel {
//   String country = '';
//   String countryCode = '';

//   CountryModel({
//     this.country,
//     this.countryCode,
//   });
// }

// class StateModel {
//   String state = '';
//   StateModel({
//     this.state,
//   });
// }

// class CityModel {
//   String city = '';
//   CityModel({
//     this.city,
//   });
// }
