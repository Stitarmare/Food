import 'package:flutter/material.dart';
import 'package:foodzi/Utils/ConstantImages.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/RadioDailog.dart';
import 'package:auto_size_text/auto_size_text.dart';

class OrderConfirmation2View extends StatefulWidget {
  OrderConfirmation2View({Key key}): super (key:key);
  @override
  State<StatefulWidget> createState() {
    return _OrderConfirmation2ViewState();
  }
}

class _OrderConfirmation2ViewState extends State<OrderConfirmation2View> {
   ScrollController _controller = ScrollController();
    String _selectedId;
     int count = 1;
    void _onValueChange(String value) {
    setState(() {
      _selectedId = value;
    });
  }
  Widget steppercount() {
    return Container(
      height: 24,
      width: 150,
      child: Row(children: <Widget>[
        InkWell(
          onTap: () {
            if (count > 1) {
              setState(() {
                --count;
                print(count);
              });
            }
          },
          splashColor: Colors.redAccent.shade200,
          child: Container(
            decoration: BoxDecoration(
                color: redtheme,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            alignment: Alignment.center,
              child: Icon(
                Icons.remove,
                color: Colors.white,
                size: 24,
              ),
          ),
        ),
           Padding(
            padding: const EdgeInsets.only(left: 13,right: 13),
            child: Text(count.toString(),style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'gotham',
                          fontWeight: FontWeight.w600,
                          color: greytheme700),),
          ),
        InkWell(
          onTap: () {
            if (count < 10) {
              setState(() {
                ++count;
                print(count);
              });
            }
          },
          splashColor: Colors.lightBlue,
          child: Container(
            decoration: BoxDecoration(
                color: redtheme,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            alignment: Alignment.center,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 24,
              ),
          ),
        ),
      ]),
    );
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
        body: Column(
          children: <Widget>[
               _getmainviewTableno(),
               SizedBox(height: 20,) ,
            Divider(height: 2,),
             SizedBox(height: 10,) ,
            _getAddedListItem()
          ],
        ),
        // CustomScrollView(
        //   controller: _controller,
        //   slivers: <Widget>[
        //     _getmainviewTableno(), 
        //     // Divider(height: 2,),
        //     _getAddedListItem()
        //   // _getOptions()
        //   ],
        // ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 102,
            child: Column(
              children: <Widget>[
                Align(alignment: Alignment.bottomCenter,child: FlatButton(
                  child: Text('Add More Items',style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'gotham',
                    decoration: TextDecoration.underline,
                    decorationColor: redtheme,
                    color: redtheme,
                    fontWeight: FontWeight.w600
                  ),), onPressed: () {
                    Navigator.pop(context);
                  },
                ),),
               Row(
                 mainAxisSize: MainAxisSize.max,
                 mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                    GestureDetector(
              onTap: (){
                // Navigator.pushNamed(context, '/OrderConfirmationView');
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
                width: (MediaQuery.of(context).size.width/2)-15,
                decoration: BoxDecoration(
                  color: redtheme,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
                // color: redtheme,
                child: Center(
                  // padding: EdgeInsets.only(),
                  child: Text('MAKE PAYMENT',
                  style: TextStyle(fontFamily: 'gotham',fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),),
                ),
              ),
            ),
            SizedBox(width: 15,),
                  GestureDetector(
              onTap: (){
                // Navigator.pushNamed(context, '/OrderConfirmationView');
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
                width: (MediaQuery.of(context).size.width/2)-15,
                decoration: BoxDecoration(
                  color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                        // border: Border(top: BorderSide(color: greytheme1000,width: 3),left: BorderSide(color: greytheme1000, width: 3),)
                        // border:greytheme100,
                        ),
                // color: redtheme,
                child: Center(
                    child: Text('PLACE ORDER',
                    style: TextStyle(fontFamily: 'gotham',fontWeight: FontWeight.w600,fontSize: 16,color: greytheme1000),),
                
                ),
              ),
            ),
                 ],
               )
              ],
            )
          ),
        ),
      ),
    );
  }
   Widget _getmainviewTableno() {
    return 
    // SliverToBoxAdapter(
    //   child:
      Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Row(
              //   children: <Widget>[
              //     SizedBox(
              //       width: 20,
              //     ),
                  Container(
                    // width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12,bottom: 6,left: 20),
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
                  ),
              //   ],
              // ),
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
                height: 10,
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
                height: 20,
              )
            ],
          ),
        ),
      // ),
    );
  }

   Widget _getAddedListItem(){
    return Expanded(
              child: ListView.builder(
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Image.asset('assets/VegIcon/Group1661.png',
                  height: 20,
                  width: 20,),
                ),
                SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Bacon & Cheese Burger',
                    style: TextStyle(
                      // fontFamily: 'gotham',
                      fontSize: 18,
                      color:greytheme700 
                    ),),
                    SizedBox(height: 6,),
                    SizedBox(
                            height: 30,
                            width: 180,
                            child: AutoSizeText(
                             " Lorem Epsom is simply dummy text",
                              style: TextStyle(
                                color: greytheme1000,
                                fontSize: 14,
                                // fontFamily: 'gotham',
                              ),
                              // minFontSize: 8,
                              maxFontSize: 12,
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(height: 10),
                          steppercount(),

              ],
            ),
                Expanded(
                  child: SizedBox(width: 80,),
                  flex: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20,top: 30),
                  child: Text('\$17',style: TextStyle(
                    color: greytheme700,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),),
                )
                ]
                ),
                SizedBox(
                  height: 12
                ),
                Divider(height: 2,thickness: 2,),
                 SizedBox(
                  height: 8
                ),
              ],
            ),
          );
         },
    ),
      );
  }
  //   return Scaffold(
  //     body: _getmainview(),
  //   );
  // }

//   Widget _getmainview() {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           Padding(padding: EdgeInsets.fromLTRB(15, 200, 0, 0)),
//           Center(child: Text('data')),
//           //_getmainviewTableno(),
//           SizedBox(
//             height: 20,
//           ),
//           Divider(
//             thickness: 3,
//           ),
//         ],
//       ),
//     );
//   }
// }


}