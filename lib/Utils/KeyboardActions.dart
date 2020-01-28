import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class FocusNodes extends FocusNode{
  static final FocusNode nodeText1 = FocusNode();
  static final FocusNode nodeText2 = FocusNode();
  static final FocusNode nodeText3 = FocusNode();
  static final FocusNode nodeText4 = FocusNode();
  static final FocusNode nodeText5 = FocusNode();
  static final FocusNode nodeText6 = FocusNode();
  //final FocusNode _nodeText7 = FocusNode();

  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  static KeyboardActionsConfig buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: nodeText1,
        ),
        KeyboardAction(
          focusNode: nodeText2,
          closeWidget: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.close),
          ),
        ),
        KeyboardAction(
          focusNode: nodeText3,
          onTapAction: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text("Custom Action"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("OK"),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  );
                });
          },
        ),
        KeyboardAction(
          focusNode: nodeText4,
          displayCloseWidget: false,
        ),
        KeyboardAction(
          focusNode: nodeText5,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("CLOSE"),
          ),
        ),
        KeyboardAction(
          focusNode: nodeText6,
          footerBuilder: (_) => PreferredSize(
              child: SizedBox(
                  height: 40,
                  child: Center(
                    child: Text('Custom Footer'),
                  )),
              preferredSize: Size.fromHeight(40)),
        ),
      ],
    );
  }
}

//   return Container(
//     padding: EdgeInsets.all(30),
//     child: KeyboardActions(
//       config: _buildConfig(context),
//           child: Column(
//         children: <Widget>[
//           BoxAppTextField(
//             placeHolderName: KEY_FIRST_NAME,
//             keyboardType: TextInputType.text,
//             focusNode: nodeText3,
//           ),
//           SizedBox(
//             height: 28,
//           ),
//           BoxAppTextField(
//             placeHolderName: KEY_LAST_NAME,
//             keyboardType: TextInputType.text,
//             focusNode: nodeText4,
//           ),
//           SizedBox(
//             height: 28,
//           ),
//           BoxAppTextField(
//             placeHolderName: KEY_MOBILE_NUMBER,
//             keyboardType: TextInputType.number,
//           ),
//           SizedBox(
//             height: 28,
//           ),
//           BoxAppTextField(
//             placeHolderName: KEY_STREET,
//           ),
//           SizedBox(
//             height: 28,
//           ),
//           BoxAppTextField(
//             placeHolderName: KEY_COUNTRY,
//           ),
//           SizedBox(
//             height: 28,
//           ),
//           BoxAppTextField(
//             placeHolderName: KEY_STATE,
//           ),
//           SizedBox(
//             height: 28,
//           ),
//           BoxAppTextField(
//             placeHolderName: KEY_CITY,
//           ),
//           SizedBox(
//             height: 28,
//           ),
//           BoxAppTextField(
//             placeHolderName: KEY_POSTAL_CODE,
//             keyboardType: TextInputType.number,
//           ),
//           SizedBox(
//             height: 44,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.39,
//                 height: 43,
//                 child: RaisedButton(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: new BorderRadius.circular(6.0),
//                   ),
//                   color: greentheme100,
//                   child: Text(
//                     KEY_UPDATE,
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'gotham',
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500),
//                   ),
//                   onPressed: () {},
//                 ),
//               ),
//               // SizedBox(width:14,),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.39,
//                 height: 43,
//                 child: RaisedButton(
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: new BorderRadius.circular(6.0),
//                       side: BorderSide(color: greytheme100)),
//                   child: Text(
//                     KEY_CANCEL_UC,
//                     style: TextStyle(
//                         color: greytheme1000,
//                         fontFamily: 'gotham',
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500),
//                   ),
//                   onPressed: () {},
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }
