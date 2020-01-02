import 'package:flutter/material.dart';

class DineInView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DineViewState();
  }
}

class _DineViewState extends State<DineInView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _getMainView(),
      ),
    );
  }
}

Widget _getMainView() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/HotelImages/Image12.png',
                width: 400,
                fit: BoxFit.cover,
              ),
            )
          ],
        )
      ],
    ),
  );
}

// import 'package:flutter/material.dart';

// final List rooms = [
//   {"image": "assets/HotelImages/Image12.png", "title": "That’s Amore"},
//   {"image": "assets/HotelImages/Image12.png", "title": "Peaceful Room"},
//   {"image": "assets/HotelImages/Image12.png", "title": "Beautiful Room"},
//   {
//     "image": "assets/HotelImages/Image12.png",
//     "title": "Vintage room near Pashupatinath"
//   },
// ];

// class HotelHomePage extends StatelessWidget {
//   static final String path = "lib/src/pages/hotel/hhome.dart";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             title: Text('data'),
//             //expandedHeight: 180.0,
//             backgroundColor: Colors.cyan,
//             leading: IconButton(
//               icon: Icon(
//                 Icons.menu,
//                 color: Colors.white,
//               ),
//               onPressed: () {},
//             ),
//             actions: <Widget>[
//               IconButton(
//                 icon: Icon(
//                   Icons.favorite_border,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {},
//               ),
//             ],
//             floating: false,
//             flexibleSpace: ListView(
//               children: <Widget>[],
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: SizedBox(
//               height: 10.0,
//             ),
//           ),
//           // SliverToBoxAdapter(
//           //     // child: _buildCategories(),
//           //     ),
//           SliverList(
//             delegate:
//                 SliverChildBuilderDelegate((BuildContext context, int index) {
//               return _buildRooms(context, index);
//             }, childCount: 10),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildRooms(BuildContext context, int index) {
//     var room = rooms[index % rooms.length];
//     return Container(
//       margin: EdgeInsets.all(20.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(5.0),
//         child: Container(
//           child: Material(
//             elevation: 5.0,
//             borderRadius: BorderRadius.circular(5.0),
//             color: Colors.white,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Stack(
//                   children: <Widget>[
//                     Image.asset(room['image']),
//                     Positioned(
//                       right: 10,
//                       top: 10,
//                       child: Icon(
//                         Icons.star,
//                         color: Colors.grey.shade800,
//                         size: 20.0,
//                       ),
//                     ),
//                     Positioned(
//                       right: 8,
//                       top: 8,
//                       child: Icon(
//                         Icons.star_border,
//                         color: Colors.white,
//                         size: 24.0,
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 20.0,
//                       right: 10.0,
//                       child: Container(
//                         padding: EdgeInsets.all(10.0),
//                         color: Colors.white,
//                         child: Text("\$40"),
//                       ),
//                     )
//                   ],
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         room['title'],
//                         style: TextStyle(
//                             fontSize: 18.0, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: 5.0,
//                       ),
//                       Text("Bouddha, Kathmandu"),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Icon(
//                             Icons.star,
//                             color: Colors.green,
//                           ),
//                           Icon(
//                             Icons.star,
//                             color: Colors.green,
//                           ),
//                           Icon(
//                             Icons.star,
//                             color: Colors.green,
//                           ),
//                           Icon(
//                             Icons.star,
//                             color: Colors.green,
//                           ),
//                           Icon(
//                             Icons.star,
//                             color: Colors.green,
//                           ),
//                           SizedBox(
//                             width: 5.0,
//                           ),
//                           Text(
//                             "(220 reviews)",
//                             style: TextStyle(color: Colors.grey),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Category extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final Color backgroundColor;

//   const Category(
//       {Key key,
//       @required this.icon,
//       @required this.title,
//       this.backgroundColor})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       child: Container(
//         decoration: BoxDecoration(
//             color: backgroundColor,
//             borderRadius: BorderRadius.all(Radius.circular(5.0))),
//         margin: EdgeInsets.symmetric(vertical: 10.0),
//         padding: EdgeInsets.all(10.0),
//         width: 100,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Icon(
//               icon,
//               color: Colors.white,
//             ),
//             SizedBox(
//               height: 5.0,
//             ),
//             Text(title, style: TextStyle(color: Colors.white))
//           ],
//         ),
//       ),
//     );
//   }
// }
