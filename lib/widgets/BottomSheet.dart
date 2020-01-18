import 'package:flutter/material.dart';
class MenuItem extends StatefulWidget {
      @override
      State<StatefulWidget> createState() => MenuItemState();
    }

    class MenuItemState extends State<MenuItem>
        with SingleTickerProviderStateMixin {
      AnimationController controller;
      Animation<double> scaleAnimation;
  //      List<Item> _menu = <Item>[
  //    Item(itemName: 'All',itemCount: '102'),
  //    Item(itemName: 'Breakfast',itemCount: '10'),
  //    Item(itemName: 'Lunch',itemCount: '23'),
  //    Item(itemName: 'Dinner',itemCount: '25'),
  //    Item(itemName: 'Deserts',itemCount: '8'),
  //    Item(itemName: 'Specials',itemCount: '3'),
  //    Item(itemName: 'Halal',itemCount: '11'),
  //    Item(itemName: 'Drinks',itemCount: '28'),
  // ];
  // // Item selectedMenu;
  // int _selectedMenu = 0;

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
      // _onSelected(index){
      //   setState(() {
      //   _selectedMenu = index;
      //   });
      // }

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
                  margin: EdgeInsets.only(bottom: 0,left: 0,right: 0,top:MediaQuery.of(context).size.height*0.6),
                    padding: EdgeInsets.all(15.0),
                    height: 320,
                    width:MediaQuery.of(context).size.width,

                    decoration: ShapeDecoration(
                        color: Color.fromRGBO(255,255,255,1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
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
                        //     child: ListView.builder(
                        //       itemCount: _menu.length,
                        //       itemBuilder: (context, index){
                        // //         return ListTile(
                        // //           title: Text(_menu[index].itemName,style: TextStyle(
                        // //             color:  _selectedMenu != null && _selectedMenu == index
                        // // ? Color.fromRGBO(237,29,37, 1)
                        // // : Color.fromRGBO(118,118,118,1),),),
                        // //           trailing: Text(_menu[index].itemCount),
                        // //           onTap: (){
                        // //             _onSelected(index);
                        // //           },
                        // //         );
                        //       },
                        //     ),
                   
                    ),
//                 child: Container(
// height: 182,
//  width: MediaQuery.of(context).size.width,
// margin: EdgeInsets.only(bottom: 0,left: 0,right: 0),
// padding: EdgeInsets.all(8.0),
// decoration: BoxDecoration(
// border: Border.all(color: Colors.black, width: 2.0),
// borderRadius: BorderRadius.circular(8.0),
// ),
// child: ListView(
// children: <Widget>[
// ListTile(title: Text('Bottom sheet')),
// TextField(
// keyboardType: TextInputType.number,
// decoration: InputDecoration(
// border: OutlineInputBorder(),
// icon: Icon(Icons.attach_money),
// labelText: 'Enter an integer',
// ),
// ),
// Container(
// alignment: Alignment.center,
// child: RaisedButton.icon(
// icon: Icon(Icons.save),
// label: Text('Save and close'),
// onPressed: () => Navigator.pop(context),
// ),
// )
// ],
// ))
              ),
            ),
          ),
        ));
      }
    }