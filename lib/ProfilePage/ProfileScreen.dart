import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.2),
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Center(child: Image.asset('assets/BlurImage/Group1612.png',fit: BoxFit.fill,width:MediaQuery.of(context).size.width,)),
                Container(
                  //color: Colors.blueAccent,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 34, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 25,),
                        Text(
                          "My Profile",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width / 2.5,
                  top: MediaQuery.of(context).size.height / 6.8,
                  child: ClipOval(
                    //radius: 50,
                    // child: Card(
                    //   elevation: 10,
                      child: Image.asset('assets/ProfileImage/MaskGroup15.png',fit: BoxFit.cover,width: 82.5,height: 82.5,),
                    // ),
                  ),
                ),
              ],
            ),
          ),
          body: Center(),
        // appBar: AppBar(
        //   title: Text('My Profile'),
        //   backgroundColor: Colors.transparent,
        // ),
        //body: SingleChildScrollView(child: _getMainView()),
      ),
    );
  }
}

// Widget _getMainView() {
//   return Container(
//       child: Stack(
//     children: <Widget>[
//       Image.asset('assets/BlurImage/Group1612.png'),
//       Positioned(
//         child: Text(
//           'My Profile',
//           style: TextStyle(color: Colors.white),
//         ),
//         left: 12,
//         top: 10,
//       ),
//       Positioned(
//         child: ClipOval(
//           child: Image.asset('assets/ProfileImage/MaskGroup15.png'),
//         ),
//         left: 20,
//       ),
//     ],
//   ));
// }
