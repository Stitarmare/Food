import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/widgets/MenuItemDropDown.dart';
class RestaurantView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RestaurantViewState();
  }
}

class _RestaurantViewState extends State<RestaurantView> {
  final GlobalKey _menuKey = new GlobalKey();
  bool _switchvalue = false;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.perm_identity),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: _buildMainView(),
      ),
    );
  }

  Widget _buildMainView() {
    return Container(
      child: Column(
        children: <Widget>[
          _getmainviewTableno(),
          SizedBox(
            height: 40,
          ),
          _getOptionsformenu()
        ],
      ),
    );
  }

  Widget _getmainviewTableno() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 40,
                ),
                Text(
                  'That’s Amore',
                  style: TextStyle(fontSize: 30),
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
                Text('Dine-in')
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
                  style: TextStyle(),
                )
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
  
 
// void _select(Item item){
//   setState(() {
    
//   });
// }

  Widget _getOptionsformenu() {
    return Row(
      children: <Widget>[
        SizedBox(width: 20),
        Text('veg only'),
        Switch(
          activeColor: Colors.red,
          onChanged: (bool value) {
            setState(() {
              this._switchvalue = value;
            });
          },
          value: this._switchvalue,
        ),
        SizedBox(
          width:180,
        ),
        SizedBox(
          child: new OutlineButton(
              child: Text("Menu"),
              onPressed: (){
                // dynamic state = _menuKey.currentState;
                // state.showButtonMenu();
                showDialog(
                  context: context,
                  builder: (_)=> MenuItem(),
                  barrierDismissible: true
                );
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(12.0))),
          height: 30,
          width: 80,
        )
      ],
    );
  }

//   Widget _dropdownMenuItem(){
//     return Container(
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
//       child: DropdownButton<Item>(
//                onChanged: (Item value) {
//                 setState(() {
//                   selectedMenu = value; 
//                 });
//               },
//               value: selectedMenu,
//               isExpanded: false,
//               items: _menu
//                   .map((Item menu){
//                     return DropdownMenuItem(
//                       child: ListTile(leading: Text(menu.itemName),trailing: Text(menu.itemCount),),
//                       value: menu,
//                     );
//                   }).toList()
//     ));

//   }
// }

}

class Item{
  String itemName;
  String itemCount;
  Item({this.itemName,this.itemCount});
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
