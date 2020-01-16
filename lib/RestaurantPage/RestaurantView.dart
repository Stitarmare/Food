import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/theme/colors.dart';

class RestaurantView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RestaurantViewState();
  }
}

class _RestaurantViewState extends State<RestaurantView> {
  bool _switchvalue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: greytheme100,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          _getmainviewTableno(),
          SliverToBoxAdapter(
            child: Container(
              child: SizedBox(
                height: 15,
              ),
            ),
          ),
          _getOptionsformenu(context),
          SliverToBoxAdapter(
            child: Container(
              child: SizedBox(
                height: 15,
              ),
            ),
          ),
          _menuItemList()
        ],
      ),
    );
  }

  // Widget _buildMainView() {
  //   return Container(
  //     child: Column(
  //       children: <Widget>[
  //         _getmainviewTableno(),

  //         _getOptionsformenu(),
  //         SliverToBoxAdapter(
  //                     child: Container(
  //             child: SizedBox(
  //               height: 40,
  //             ),
  //           ),
  //         ),
  //         _menuItemList()
  //       ],
  //     ),
  //   );
  // }

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
                  Text(
                    'That’s Amore',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600,
                        color: greytheme700),
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

  Widget _getOptionsformenu(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        child: Row(
          children: <Widget>[
            SizedBox(width: 15),
            Text(
              'veg only',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w500,
                  color: greytheme1000),
            ),
            Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                activeColor: redtheme,
                onChanged: (bool value) {
                  setState(() {
                    this._switchvalue = value;
                  });
                },
                value: this._switchvalue,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.46,
            ),
            SizedBox(
              child: OutlineButton(
                  child: Text(
                    "Menu",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w500,
                        color: greytheme100),
                  ),
                  onPressed: null,
                  borderSide: BorderSide(color: greentheme100),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(12.0),
                  )),
              height: 22,
              width: 65,
            )
          ],
        ),
      ),
    );
  }

  Widget _menuItemList() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.7),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          heightFactor: 1,
                          child: Image.network(
                              "https://static.vinepair.com/wp-content/uploads/2017/03/darts-int.jpg"),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                "data",
                                maxLines: 1,
                                style: TextStyle(
                                    //fontFamily: FontNames.gotham,
                                    fontSize: 13,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(64, 64, 64, 1)),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "data",
                                maxLines: 2,
                                style: TextStyle(
                                    //fontFamily: FontNames.gotham,
                                    fontSize: 10,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromRGBO(64, 64, 64, 1)),
                              )
                            ]),
                      )),
                      Container(
                        height: MediaQuery.of(context).size.width * 0.09,
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: new BoxDecoration(
                                //color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.grey,
                                    width: 0.7,
                                  ),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Center(
                                child: Text(
                                  "\$ 12",
                                  style: TextStyle(
                                      //fontFamily: FontNames.gotham,
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(64, 64, 64, 1)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: redtheme,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(12.0),
                                    )),
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: Center(
                                  child: Text(
                                    "+ ADD",
                                    style: TextStyle(
                                        //fontFamily: FontNames.gotham,
                                        fontSize: 14,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }, childCount: 7),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:foodzi/Utils/String.dart';

// class RestaurantView extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _RestaurantViewState();
//   }
// }

// class _RestaurantViewState extends State<RestaurantView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.perm_identity),
//             onPressed: () {},
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: _buildMainView(),
//       ),
//     );
//   }

//   Widget _buildMainView() {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           _getmainviewTableno(),
//           SizedBox(
//             height: 40,
//           ),
//           _getOptionscollections()
//         ],
//       ),
//     );
//   }

//   Widget _getmainviewTableno() {
//     return Container(
//       margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
//       child: Card(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 SizedBox(
//                   width: 40,
//                 ),
//                 Text(
//                   'That’s Amore',
//                   style: TextStyle(fontSize: 30),
//                 ),
//               ],
//             ),
//             Divider(
//               thickness: 2,
//               //endIndent: 10,
//               //indent: 10,
//             ),
//             Row(
//               children: <Widget>[
//                 SizedBox(
//                   width: 26,
//                 ),
//                 Image.asset('assets/DineInImage/Group1504.png'),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Text('Dine-in')
//               ],
//             ),
//             Row(
//               children: <Widget>[SizedBox(width: 76), Text('Add Table Number')],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _getOptionscollections() {
//     return Container(
//       margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
//       child: Column(
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               SizedBox(
//                 height: 22,
//                 // width: 100,
//                 child: new OutlineButton(
//                     child: new Text("Breakfast"),
//                     onPressed: null,
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(2.0))),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               SizedBox(
//                 height: 22,
//                 //   width: 80,
//                 child: new OutlineButton(
//                     child: new Text("Lunch"),
//                     onPressed: null,
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(2.0))),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               SizedBox(
//                 height: 22,
//                 //  width: 70,
//                 child: new OutlineButton(
//                     child: new Text("Dinner"),
//                     onPressed: null,
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(2.0))),
//               ),
//             ],
//           ),
//           Column(
//             children: <Widget>[
//               SizedBox(height: 10),
//               SizedBox(
//                 height: 22,
//                 child: new OutlineButton(
//                     child: new Text("Deserts"),
//                     onPressed: null,
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(2.0))),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
