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
  final formKey = new GlobalKey<FormState>();
  CountryModel _dropdownValue;
  String _errorText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _dropdownItems.add(CountryModel(country: 'India', countryCode: '+91'));
      _dropdownItems.add(CountryModel(country: 'USA', countryCode: '+1'));
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
      child: Column(
        children: <Widget>[
          BoxAppTextField(
            placeHolderName: KEY_FIRST_NAME,
          ),
          SizedBox(
            height: 28,
          ),
          BoxAppTextField(
            placeHolderName: KEY_LAST_NAME,
          ),
          SizedBox(
            height: 28,
          ),
          BoxAppTextField(
            placeHolderName: KEY_MOBILE_NUMBER,
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 28,
          ),
          BoxAppTextField(
            placeHolderName: KEY_STREET,
          ),
          SizedBox(
            height: 28,
          ),
          _buildCountry(),
          SizedBox(
            height: 28,
          ),
          BoxAppTextField(
            placeHolderName: KEY_STATE,
          ),
          SizedBox(
            height: 28,
          ),
          BoxAppTextField(
            placeHolderName: KEY_CITY,
          ),
          SizedBox(
            height: 28,
          ),
          BoxAppTextField(
            placeHolderName: KEY_POSTAL_CODE,
            keyboardType: TextInputType.number,
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
                  onPressed: () {},
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
}

class CountryModel {
  String country = '';
  String countryCode = '';

  CountryModel({
    this.country,
    this.countryCode,
  });
}
