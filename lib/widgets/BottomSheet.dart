import 'package:flutter/material.dart';

class BottomSheetItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomSheetItemState();
}

class BottomSheetItemState extends State<BottomSheetItem>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Container(
                // margin: EdgeInsets.only(left: 158,right: 13,top: 80),
                margin: EdgeInsets.only(
                    // bottom: 0,
                    // left: 0,
                    // right: 0,
                    top: MediaQuery.of(context).size.height * 0.6),
                padding: EdgeInsets.all(15.0),
                height: 320,
                width: MediaQuery.of(context).size.width,

                decoration: ShapeDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0))
                        )
                        ),
                child: ListView(
                  children: <Widget>[
                    ListTile(title: Text('Bottom sheet')),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.attach_money),
                        labelText: 'Enter an integer',
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: RaisedButton.icon(
                        icon: Icon(Icons.save),
                        label: Text('Save and close'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    )
                  ],
             
                ),


              ),
            ),
          ),
        )
        );
  }
}
