import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPage/AddItemPageView.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/RadioDailog.dart';

class ConfirmationDineView extends StatefulWidget {
  int restID;
   ConfirmationDineView(
      {this.restID,});
  @override
  _ConfirmationDineViewState createState() => _ConfirmationDineViewState();
}

class _ConfirmationDineViewState extends State<ConfirmationDineView> {
  List<RadioButtonOrderOptions> _orderOptions = [
    RadioButtonOrderOptions(
        index: 1, title: 'Dine-in', subtitle: 'Get served in Restaurant'),
    RadioButtonOrderOptions(
        index: 2, title: "Take Away", subtitle: 'Get you food packed'),
  ];
  List<RadioButtonOptions> _radioOptions = [
    RadioButtonOptions(index: 1, title: 'ASAP'),
    RadioButtonOptions(index: 2, title: '02:30 PM'),
    RadioButtonOptions(index: 3, title: '03:00PM'),
    RadioButtonOptions(index: 4, title: '03:30 PM'),
  ];
  ScrollController _controller = ScrollController();
  int id = 1;
  int radioOrderId = 1;
  String radioItem;
  String radioOrderItem;
  String radioOrderItemsub;

  int _dropdownTableNumber;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      top: false,
      right: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[
            _getorderOptions(),
            _gettimeOptions(),
          ],
        ),
        bottomNavigationBar: Container(
          //margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          width: MediaQuery.of(context).size.width,
          height: 54,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Text(
              'CONFIRM & PLACE ORDER',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            color: getColorByHex(Globle().colorscode),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  Widget _gettimeOptions() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.only(left: 26, top: 10),
              child: Text(
                'How soon do you want it ?',
                style: TextStyle(
                    fontFamily: 'gotham', fontSize: 16, color: greytheme700),
              ),
            ),
            _getRadioOptions(),
            //_getCheckBoxOptions()
          ],
        ),
      ),
    );
  }

  Widget _getorderOptions() {
    return SliverToBoxAdapter(
      child: Container(
          margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[_getorderOption()])),
    );
  }

  _getRadioOptions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.baseline,
      children: _radioOptions
          .map((radionBtn) => Padding(
                padding: const EdgeInsets.only(top: 0),
                child: RadioListTile(
                  title: Text("${radionBtn.title}",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'gotham',
                          fontWeight: FontWeight.w500,
                          color: greytheme700)),
                  groupValue: id,
                  value: radionBtn.index,
                  dense: true,
                  activeColor: getColorByHex(Globle().colorscode),
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
  }
// Widget getTableNumber() {
//     return Container(
//       margin: EdgeInsets.only(left: 20),
//       height: 50,
//       width: MediaQuery.of(context).size.width * 0.8,
//       child: FormField(builder: (FormFieldState state) {
//         return DropdownButtonFormField(
//           //itemHeight: Constants.getScreenHeight(context) * 0.06,
//           items: _dropdownItemsTable.map((tableNumber) {
//             return new DropdownMenuItem(
//                 value: tableNumber.id,
//                 child: Row(
//                   children: <Widget>[
//                     Container(
//                         width: MediaQuery.of(context).size.width * 0.4,
//                         child: Text(
//                           "Table Number: ${tableNumber.name}",
//                           style: TextStyle(
//                               decoration: TextDecoration.underline,
//                               decorationColor:
//                                   getColorByHex(Globle().colorscode),
//                               fontSize: 14,
//                               fontFamily: 'gotham',
//                               fontWeight: FontWeight.w600,
//                               color: getColorByHex(Globle().colorscode)),
//                         )),
//                   ],
//                 ));
//           }).toList(),
//           onChanged: (newValue) {
//             // do other stuff with _category
//             setState(() {
//               _dropdownTableNumber = newValue;
//             });
//             _addItemPagepresenter.addTablenoToCart(Globle().loginModel.data.id,
//                 widget.rest_id, _dropdownTableNumber, context);
//           },

//           value: _dropdownTableNumber,
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.fromLTRB(10, 0, 5, 0),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: greentheme100, width: 2),
//             ),
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: greytheme900, width: 2)),
//             border:
//                 OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
//             filled: false,
//             hintText: 'Choose Table',
//             // prefixIcon: Icon(
//             //   Icons.location_on,
//             //   size: 20,
//             //   color: greytheme1000,
//             // ),
//             labelText: _dropdownTableNumber == null
//                 ? "Add Table Number "
//                 : "Table Number",
//             // errorText: _errorText,
//             labelStyle: TextStyle(
//                 decoration: TextDecoration.underline,
//                 decorationColor: Colors.black,
//                 fontSize: 14,
//                 fontFamily: 'gotham',
//                 fontWeight: FontWeight.w600,
//                 color: greytheme100),
//           ),
//         );
//       }),
//     );
//   }
  void getTableAlert() {
    showDialog(
      barrierDismissible: true,
      context: context,
      //child: getTableNumber(),
      builder: (context) => AlertDialog(
        title: Text(
          "Select Table",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'gotham',
              fontWeight: FontWeight.w600,
              color: greytheme700),
        ),
        actions: <Widget>[
          Divider(
            endIndent: 15,
            indent: 15,
            color: Colors.black,
          ),
          FlatButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  _getorderOption() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.baseline,
      children: _orderOptions
          .map((radionOrderBtn) => Padding(
                padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: RadioListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 16),
                      child: Text("${radionOrderBtn.title}",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'gotham',
                              fontWeight: FontWeight.w600,
                              color: getColorByHex(Globle().colorscode))),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text("${radionOrderBtn.subtitle}",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'gotham',
                              fontWeight: FontWeight.w500,
                              color: greytheme100)),
                    ),
                    groupValue: radioOrderId,
                    value: radionOrderBtn.index,
                    dense: true,
                    activeColor: getColorByHex(Globle().colorscode),
                    onChanged: (val) {
                      setState(() {
                        radioOrderItem = radionOrderBtn.title;
                        radioOrderItemsub = radionOrderBtn.subtitle;
                        radioOrderId = radionOrderBtn.index;
                        // if (radioOrderItem == 'Dine-in') {
                        //   getTableAlert();
                        // }
                      });
                    },
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class RadioButtonOptions {
  int index;
  String title;
  RadioButtonOptions({this.index, this.title});
}

class RadioButtonOrderOptions {
  int index;
  String title;
  String subtitle;
  RadioButtonOrderOptions({this.index, this.title, this.subtitle});
}
