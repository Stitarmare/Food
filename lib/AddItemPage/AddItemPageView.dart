import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/RadioDailog.dart';
// import 'package:flutter_counter/flutter_counter.dart';

// import 'package:flui/flui.dart';

class AddItemPageView extends StatefulWidget {
  AddItemPageView({Key key}) : super(key: key);

  _AddItemPageViewState createState() => _AddItemPageViewState();
}

class _AddItemPageViewState extends State<AddItemPageView> {
  ScrollController _controller = ScrollController();
 
  // double _defaultValue = 1;
  int id = 1;
  String radioItem;
  String _selectedId;

  // FLCountStepperController _stepperController =
  //     FLCountStepperController(defaultValue: 1, min: 1, max: 10, step: 1);

  List<RadioButtonOptions> _radioOptions = [
    RadioButtonOptions(index: 1, title: 'Item 1'),
    RadioButtonOptions(index: 2, title: 'Item 2'),
    RadioButtonOptions(index: 3, title: 'Item 3'),
    RadioButtonOptions(index: 4, title: 'Item 4'),
  ];
  List<CheckBoxOptions> _checkBoxOptions = [
    CheckBoxOptions(id: 1, title: 'Item 1', price: 12.0,isChecked: false),
    CheckBoxOptions(id: 2, title: 'Item 2', price: 12.0,isChecked: false),
    CheckBoxOptions(id: 3, title: 'Item 3', price: 12.0,isChecked: false),
    CheckBoxOptions(id: 4, title: 'Item 4', price: 12.0,isChecked: false),
  ];

   void _onValueChange(String value) {
    setState(() {
      _selectedId = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      top: true,
      right: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[_getmainviewTableno(), _getOptions()],
        ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
            onTap: (){
              // print("button is pressed");
              showDialog(
                context: context,
                child: new RadioDialog(
                  onValueChange: _onValueChange,
                  initialValue: _selectedId,
                ));
            },
            child: Container(
              height: 54,
              decoration: BoxDecoration(
                color: redtheme,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
              // color: redtheme,
              child: Center(
                child: Text('ADD \$24',
                style: TextStyle(fontFamily: 'gotham',fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getmainviewTableno() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      'Wimpy',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'gotham',
                          fontWeight: FontWeight.w600,
                          color: greytheme700),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 2,
                //endIndent: 10,
                //indent: 10,
              ),
              Row(
                children: <Widget>[
                  // SizedBox(
                  //   width: 26,
                  // ),
                  // Image.asset('assets/DineInImage/Group1504.png'),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Dine-in',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600,
                        color: redtheme),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text(
                    'Add Table Number',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                        fontSize: 14,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600,
                        color: greytheme100),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getOptions() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 25, left: 26),
              child: Text(
                'Chicken Cordon',
                style: TextStyle(
                    fontFamily: 'gotham',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: greytheme700),
              ),
            ),
            // ),
            Padding(
              padding: EdgeInsets.only(left: 26, top: 12),
              child: Text(
                'Lorem Epsom is simply dummy text',
                style: TextStyle(
                    fontFamily: 'gotham',
                    fontSize: 16,
                    // fontWeight: FontWeight.w500,
                    color: greytheme1000),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 26),
                  child: Text(
                    'Quantity:',
                    style: TextStyle(
                        fontFamily: 'gotham',
                        fontSize: 16,
                        color: greytheme700),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                // Container(

                // )
                // Counter(
                //   initialValue: _defaultValue,
                //   minValue: 0,
                //   maxValue: 10,
                //   step: 0.5,
                //   decimalPlaces: 1,
                //   buttonSize: 15,
                //   color: redtheme,
                //   onChanged: (value) {
                //     // get the latest value from here
                //     setState(() {
                //       _defaultValue = value;
                //     });
                //   },
                // ),
                // FLCountStepper(
                //     controller: _stepperController,
                //     disabled: true, // default is false
                //     disableInput: true,
                //     actionColor: redtheme, // default is true
                //     onChanged: (value) {})
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 2,
            ),
            Padding(
              padding: EdgeInsets.only(left: 26, top: 15),
              child: Text(
                'Spreads',
                style: TextStyle(
                    fontFamily: 'gotham', fontSize: 16, color: greytheme700),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 26, top: 8),
              child: Text(
                'Please select any one option',
                style: TextStyle(
                    fontFamily: 'gotham', fontSize: 12, color: greytheme1000),
              ),
            ),
            _getRadioOptions(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 26, top: 15),
              child: Text(
                'Additions',
                style: TextStyle(
                    fontFamily: 'gotham', fontSize: 16, color: greytheme700),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 26, top: 8),
              child: Text(
                'You can select multiple options',
                style: TextStyle(
                    fontFamily: 'gotham', fontSize: 12, color: greytheme1000),
              ),
            ),
            _getCheckBoxOptions()
          ],
        ),
      ),
    );
  }

  _getRadioOptions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.baseline,
      children: _radioOptions
          .map((radionBtn) => Padding(
                padding: const EdgeInsets.only(top: 5),
                child: RadioListTile(
                  title: Text("${radionBtn.title}"),
                  groupValue: id,
                  value: radionBtn.index,
                  dense: true,
                  activeColor: redtheme,
                  onChanged: (val) {
                    setState(() {
                      radioItem = radionBtn.title;
                      id = radionBtn.index;
                    });
                  },
                ),
              ))
          .toList(),
    );
    // return SingleChildScrollView(
    //   controller: controller,
    //   child: Column(

    //   ),
    // ),

    // return Container(
    //   height: 150,
    //   width: MediaQuery.of(context).size.width,
    //   child: Wrap(
    //     //direction: Axis.vertical,
    //     runSpacing: 5,
    //     //spacing: 10,
    //     children:_radioOptions.map((radionBtn) =>RadioListTile(
    //                 title: Text("${radionBtn.title}"),
    //                 groupValue: id,
    //                 value: radionBtn.index,
    //                 dense: true,
    //                 activeColor: Color.fromRGBO(239, 29, 37, 1),
    //                 onChanged: (val) {
    //                   setState(() {
    //                     radioItem = radionBtn.title ;
    //                     id = radionBtn.index;
    //                   });
    //                 },
    //               )).toList(),
    //   ),
    // );
  }

  _getCheckBoxOptions() {
     return Column(
            children:  
                        _checkBoxOptions.map((checkBtn) => CheckboxListTile(
                          activeColor: redtheme,
                          value: checkBtn.isChecked,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (val){
                            setState(() {
                             checkBtn.isChecked = val;
                            });
                          },
                          title: Text(checkBtn.title,style: TextStyle(fontSize: 13,color: Color.fromRGBO(64, 64, 64, 1)),),
                        )
                        ).toList(),
            // children: <Widget>[
            //   new CheckboxListTile(
            //     title: Text(_checkBoxOptions[index].title),
            //     activeColor: redtheme,
            //     controlAffinity: ListTileControlAffinity.leading, value: null, onChanged: (bool value) {},
            //     // value: _checkBoxOptions[index] ,

            //   )
            // ],
          );
    // return new ListView.builder(
    //   itemCount: _checkBoxOptions.length,
    //   itemExtent: 20,
    //   itemBuilder: (BuildContext context, int index) {
    //     return Container(
    //       padding: new EdgeInsets.all(10.0),
    //       child: new Column(
    //         children:  
    //                     _checkBoxOptions.map((text) => CheckboxListTile(
    //                       activeColor: Color.fromRGBO(237, 29, 37, 1),
    //                       value: _isChecked,
    //                       onChanged: (val){
    //                         setState(() {
    //                           _isChecked = val;
    //                         });
    //                       },
    //                       title: Text(text.title,style: TextStyle(fontSize: 13,color: Color.fromRGBO(64, 64, 64, 1)),),
    //                     )
    //                     ).toList(),
    //         // children: <Widget>[
    //         //   new CheckboxListTile(
    //         //     title: Text(_checkBoxOptions[index].title),
    //         //     activeColor: redtheme,
    //         //     controlAffinity: ListTileControlAffinity.leading, value: null, onChanged: (bool value) {},
    //         //     // value: _checkBoxOptions[index] ,

    //         //   )
    //         // ],
    //       ),
    //       // child: new Column(
    //       //     children: _checkBoxOptions
    //       //         .map((checkBtn) => CheckboxListTile(
    //       //               title: Text("${checkBtn.title}"),
    //       //               // groupValue: id,
    //       //               // value: checkBtn.index,
    //       //               activeColor: Color.fromRGBO(239, 29, 37, 1),
    //       //               onChanged: (bool value) {}, value: null,
    //       //             ))
    //       //         .toList()
    //       // )
    //       //     // <Widget>[
    //           // new CheckboxListTile(
    //           //     // value: index,
    //           //     title: new Text(_checkBoxOptions[index].title,),
    //           //     controlAffinity: ListTileControlAffinity.leading, onChanged: (bool value) {}, value: null,

    //           //     // controlAffinity: ListTileControlAffinity.leading,
    //           //     // onChanged:(){}
    //           // )
    //           // ],
    //           // ),
    //     );
      // },
    // )
  }
}

class CheckBoxOptions {
  int id;
  String title;
  double price;
  bool isChecked;
  CheckBoxOptions({this.id, this.title, this.price,this.isChecked});
}

class RadioButtonOptions {
  int index;
  String title;
  RadioButtonOptions({this.index, this.title});
}