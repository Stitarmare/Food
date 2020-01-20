import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/BoxTextField.dart';


class EditProfileview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditProfileState();
  }
}

class _EditProfileState extends State<EditProfileview> {
  static List<CountryModel> _dropdownItems = new List();
  static List<StateModel> _dropdownItemsState = new List();
  static List<CityModel> _dropdownItemsCity = new List();
  final formKey = new GlobalKey<FormState>();
  bool _validate = false;
  final GlobalKey<FormState> _editprofileFormKey = GlobalKey<FormState>();
  CountryModel _dropdownValue;
  StateModel _dropdownStateValue;
  CityModel _dropdownCityValue;
  String _errorText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _dropdownItems.add(CountryModel(country: 'India', countryCode: '+91'));
      _dropdownItems.add(CountryModel(country: 'USA', countryCode: '+1'));
      _dropdownItemsState.add(StateModel(state: 'MH'));
      _dropdownItemsState.add(StateModel(state: 'UP'));
      _dropdownItemsCity.add(CityModel(city: 'Mumbai'));
      _dropdownItemsCity.add(CityModel(city: 'Navi Mumbai'));
      //_dropdownValue = _dropdownItems[0];
    });
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
        body: SingleChildScrollView(
          child: _getmainView(context),
        ));
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
             
              placeHolderName: KEY_FIRST_NAME,
              validator: validatename,
            ),
            SizedBox(
              height: 28,
            ),
            BoxAppTextField(
              
              placeHolderName: KEY_LAST_NAME,
              validator: validatename,
            ),
            SizedBox(
              height: 28,
            ),
            BoxAppTextField(
             
              placeHolderName: KEY_MOBILE_NUMBER,
              keyboardType: TextInputType.number,
              validator: validatemobno,
            ),
            SizedBox(
              height: 28,
            ),
            BoxAppTextField(
              
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
                    onPressed: () {
                      if (_editprofileFormKey.currentState.validate()) {
                        print("Validation Successful");
                      } else {
                        setState(() {
                          _validate = true;
                        });
                      }
                    },
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
                    onPressed: () {},
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
    return FormField(
      builder: (FormFieldState state) {
        return DropdownButtonHideUnderline(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new InputDecorator(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: greentheme100, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: greytheme900, width: 2)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  filled: false,
                  hintText: 'Choose Country',
                  prefixIcon: Icon(
                    Icons.location_on,
                    size: 20,
                    color: greytheme1000,
                  ),
                  labelText:
                      _dropdownValue == null ? 'Where are you from' : 'From',
                  errorText: _errorText,
                  labelStyle: TextStyle(
                      color: greytheme1000,
                      fontSize: 16,
                      fontFamily: 'gotham',
                      fontWeight: FontWeight.w500),
                ),
                isEmpty: _dropdownValue == null,
                child: new DropdownButton<CountryModel>(
                  value: _dropdownValue,
                  isDense: true,
                  onChanged: (CountryModel newValue) {
                    print('value change');
                    print(newValue);
                    setState(() {
                      _dropdownValue = newValue;
                    });
                  },
                  items: _dropdownItems.map((CountryModel value) {
                    return DropdownMenuItem<CountryModel>(
                      value: value,
                      child: Text(value.country),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildState() {
    return FormField(
      builder: (FormFieldState state) {
        return DropdownButtonHideUnderline(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new InputDecorator(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: greentheme100, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: greytheme900, width: 2)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  filled: false,
                  hintText: 'Choose State',
                  prefixIcon: Icon(
                    Icons.pin_drop,
                    size: 20,
                    color: greytheme1000,
                  ),
                  labelText: _dropdownStateValue == null
                      ? 'Where are you from'
                      : 'From',
                  errorText: _errorText,
                  labelStyle: TextStyle(
                      color: greytheme1000,
                      fontSize: 16,
                      fontFamily: 'gotham',
                      fontWeight: FontWeight.w500),
                ),
                isEmpty: _dropdownStateValue == null,
                child: new DropdownButton<StateModel>(
                  value: _dropdownStateValue,
                  isDense: true,
                  onChanged: (StateModel newValue) {
                    print('value change');
                    print(newValue);
                    setState(() {
                      _dropdownStateValue = newValue;
                    });
                  },
                  items: _dropdownItemsState.map((StateModel value) {
                    return DropdownMenuItem<StateModel>(
                      value: value,
                      child: Text(value.state),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCity() {
    return FormField(
      builder: (FormFieldState state) {
        return DropdownButtonHideUnderline(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new InputDecorator(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: greentheme100, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: greytheme900, width: 2)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  filled: false,
                  hintText: 'Choose Country',
                  prefixIcon: Icon(
                    Icons.location_city,
                    size: 20,
                    color: greytheme1000,
                  ),
                  labelText: _dropdownCityValue == null
                      ? 'Where are you from'
                      : 'From',
                  errorText: _errorText,
                  labelStyle: TextStyle(
                      color: greytheme1000,
                      fontSize: 16,
                      fontFamily: 'gotham',
                      fontWeight: FontWeight.w500),
                ),
                isEmpty: _dropdownCityValue == null,
                child: new DropdownButton<CityModel>(
                  value: _dropdownCityValue,
                  isDense: true,
                  onChanged: (CityModel newValue) {
                    print('value change');
                    print(newValue);
                    setState(() {
                      _dropdownCityValue = newValue;
                    });
                  },
                  items: _dropdownItemsCity.map((CityModel value) {
                    return DropdownMenuItem<CityModel>(
                      value: value,
                      child: Text(value.city),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
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

  String validatemobno(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return KEY_MOBILE_NUMBER_REQUIRED;
    } else if (!regExp.hasMatch(value)) {
      return KEY_MOBILE_NUMBER_TEXT;
    } else if (value.length != 10) {
      return KEY_MOBILE_NUMBER_LIMIT;
    }
    // if(value.trim().length <= 0){
    if (value.isEmpty) {
      return KEY_THIS_SHOULD_NOT_BE_EMPTY;
    }
    return null;
  }

  String validateStreetname(String value) {
    if (value.isEmpty) {
      return KEY_THIS_SHOULD_NOT_BE_EMPTY;
    } else if (value.length > 20) {
      return KEY_THIS_SHOULD_BE_ONLY_20_CHAR_LONG;
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
}

class CountryModel {
  String country = '';
  String countryCode = '';

  CountryModel({
    this.country,
    this.countryCode,
  });
}

class StateModel {
  String state = '';
  StateModel({
    this.state,
  });
}

class CityModel {
  String city = '';
  CityModel({
    this.city,
  });
}
