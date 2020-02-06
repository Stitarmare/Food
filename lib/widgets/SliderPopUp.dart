import 'package:flutter/material.dart';
import 'package:foodzi/theme/colors.dart';

class SliderDialog extends StatefulWidget {
  const SliderDialog({this.onValueChange, this.initialValue});

  final String initialValue;
  final void Function(String) onValueChange;

  @override
  State createState() => new SliderDialogState();
}

class SliderDialogState extends State<SliderDialog> {
  // String _selectedId;
// Default Radio Button Item
  // String radioItem = 'Mango';

// Group Value for Radio Button.
  int id = 1;
  var sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
    // _selectedId = widget.initialValue;
  }

  Widget build(BuildContext context) {
    return new SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      children: <Widget>[
        // AlertDialog(
        //       title:

        //       //titleTextStyle: TextStyle(),
        //       content:
        Container(
          // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          // width: MediaQuery.of(context).size.width * 0.8,
          // height: 100,
          // width: 280,
          height: 190,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Text(
                  'SELECT RATING',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'gotham',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: greentheme100,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                child: Slider(
                  activeColor: greentheme100,
                  inactiveColor: greytheme100,
                  min: 0.0,
                  max: 5.0,
                  divisions: 5,
                  value: sliderValue,
                  label: '${sliderValue}',
                  onChanged: (newValue) {
                    setState(() {
                      sliderValue = newValue;
                    });
                  },
                ),
                
              ),
               Text(
                  'SELECTED RATING: $sliderValue/5.0',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'gotham',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: greytheme700,
                  ),
                ),
              SizedBox(
                height: 12,
              ),
              Align(
                alignment: Alignment.bottomRight,
                              child: FlatButton(
                  onPressed: () {
                    // Use the second argument of Navigator.pop(...) to pass
                    // back a result to the page that opened the dialog
                    Navigator.of(context).pop(sliderValue);
                  },
                  child: Text(
                    'DONE',
                    style: TextStyle(
                      fontFamily: 'gotham',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: greentheme100,
                    ),
                  ),
                ),
              )
            ],
          ),
          //Slider(
          // activeColor:greentheme100 ,
          //   value: _slider2Val,
          //   min: 0.0,
          //   max: 100.0,
          //   divisions: 5,
          //   label: '${_slider2Val.round()}',
          //   onChanged: (double value) {
          //     setState(() => _slider2Val = value);
          //   }),
          // ),
          // actions: <Widget>[

          // ],
        )
      ],
    );
  }
}
