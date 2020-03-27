import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/theme/colors.dart';

class SliderDialog extends StatefulWidget {
  const SliderDialog({this.onValueChange, this.initialValue});

  final String initialValue;
  final void Function(String) onValueChange;

  @override
  State createState() => new SliderDialogState();
}

class SliderDialogState extends State<SliderDialog> {
  int id = 1;
  var sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return new SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      children: <Widget>[
        Container(
          height: 190,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  STR_SELECT_RATING,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: KEY_FONTFAMILY,
                    fontSize: FONTSIZE_20,
                    fontWeight: FontWeight.w600,
                    color: greentheme100,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: Slider(
                  activeColor: greentheme100,
                  inactiveColor: greytheme100,
                  min: 0.0,
                  max: 5.0,
                  divisions: 5,
                  value: sliderValue,
                  label: '$sliderValue',
                  onChanged: (newValue) {
                    setState(() {
                      sliderValue = newValue;
                    });
                  },
                ),
              ),
              Text(
                STR_SELECTED_RATING + '$sliderValue' + STR_FIVE,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: KEY_FONTFAMILY,
                  fontSize: FONTSIZE_16,
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
                    Navigator.pop(context, sliderValue.toString());
                  },
                  child: Text(
                    STR_DONE_TITLE,
                    style: TextStyle(
                      fontFamily: KEY_FONTFAMILY,
                      fontSize: FONTSIZE_18,
                      fontWeight: FontWeight.w600,
                      color: greentheme100,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
