import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class FocusNodes extends FocusNode {
  static final FocusNode nodeText1 = FocusNode();
  static final FocusNode nodeText2 = FocusNode();
  static final FocusNode nodeText3 = FocusNode();
  static final FocusNode nodeText4 = FocusNode();
  static final FocusNode nodeText5 = FocusNode();
  static final FocusNode nodeText6 = FocusNode();

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
                    content: Text(STR_CUSTOM_ACTION),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(STR_OK),
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
            child: Text(STR_CLOSE),
          ),
        ),
        KeyboardAction(
          focusNode: nodeText6,
          footerBuilder: (_) => PreferredSize(
              child: SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(STR_CUSTOM_FOOTER),
                  )),
              preferredSize: Size.fromHeight(40)),
        ),
      ],
    );
  }
}
