import 'package:flutter/material.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';

class MyOrders extends StatefulWidget {
  MyOrders({Key key}) : super(key: key);
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  ScrollController _controller = ScrollController();
  bool isCurrentOrders = true;
  bool isBookingHistory = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          title: Text(
            "Your Orders",
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'gotham',
                fontWeight: FontWeight.w500,
                color: greytheme1200),
          ),
        ),
        body: customTabbar(),
      ),
    );
  }

  Widget customTabbar() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          Card(
            borderOnForeground: true,
            elevation: 5.0,
            child: Container(
              constraints: BoxConstraints.expand(height: 40),
              child: TabBar(
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        'Current Orders',
                        style: TextStyle(fontFamily: 'gotham', fontSize: 15),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Booking History',
                        style: TextStyle(
                          fontFamily: 'gotham',
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      insets: EdgeInsets.symmetric(horizontal: 30)),
                  labelColor: Colors.red,
                  unselectedLabelColor: greytheme1000,
                  onTap: (index) {
                    switch (index) {
                      case 0:
                        print('Restaurants Info');
                        setState(() {
                          isCurrentOrders = true;
                          isBookingHistory = false;
                        });

                        break;
                      case 1:
                        print('Review');
                        setState(() {
                          isCurrentOrders = false;
                          isBookingHistory = true;
                        });
                        break;
                    }
                  }),
            ),
          ),
          isCurrentOrders
              ? Center(child: Container(child: _currentOrders(context)))
              : Center(child: Container(child: _bookingHistoryList(context))),
        ],
      ),
    );
  }

  Widget _currentOrders(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.70,
        child: ListView.builder(
          itemCount: 8,
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(4),
              ),
              elevation: 5,
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // ListTile(leading:ClipRect(child: Image.asset('assets/HotelImages/Image12.png',width: 30,height: 40,),clipBehavior: Clip.hardEdge,),
                  // // Container(
                  // //   height: 40,
                  // //   width: 40,
                  // //   decoration: BoxDecoration(borderRadius:new BorderRadius.circular(15)),
                  // //   child: Image.asset('assets/HotelImages/Image12.png'),
                  // // ),
                  // title: Text('Daawat',style: TextStyle(
                  //   fontSize: 18,
                  //   letterSpacing: 0.32,
                  //   color: greytheme700,
                  //   fontWeight: FontWeight.w500
                  // ),),
                  // subtitle: Text('Airoli, Navi Mumbai',style: TextStyle(
                  //   fontSize: 14,
                  //   letterSpacing: 0.24,
                  //   color:greytheme1200,
                  // ),),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.only(left: 15, top: 8),
                        //  decoration: BoxDecoration(shape:BoxShape.rectangle,borderRadius: new BorderRadius.all(Radius.circular(15)),),
                        // decoration: BoxDecoration(borderRadius:new BorderRadius.circular(15)),
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/HotelImages/Image12.png',
                            fit: BoxFit.fill,
                          ),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Daawat',
                              style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 0.32,
                                  color: greytheme700,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Airoli, Navi Mumbai',
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 0.24,
                                color: greytheme1000,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 15),
                    child: Text(
                      'ITEMS',
                      style: TextStyle(
                        fontSize: 14,
                        //letterSpacing: 0.24,
                        color: greytheme1000,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '1 × Chicken Biryani',
                      style: TextStyle(
                        fontSize: 16,
                        //letterSpacing: 0.24,
                        fontWeight: FontWeight.w500,
                        color: greytheme700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      'ORDERED ON ',
                      style: TextStyle(
                        fontSize: 14,
                        //letterSpacing: 0.24,
                        color: greytheme1000,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '06 Feb 2020 at 12:05 PM',
                      style: TextStyle(
                        fontSize: 16,
                        //letterSpacing: 0.24,
                        fontWeight: FontWeight.w500,
                        color: greytheme700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      'ORDERED TYPE',
                      style: TextStyle(
                        fontSize: 14,
                        //letterSpacing: 0.24,
                        color: greytheme1000,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Dine-in',
                      style: TextStyle(
                        fontSize: 16,
                        //letterSpacing: 0.24,
                        fontWeight: FontWeight.w500,
                        color: greytheme700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      'TOTAL AMOUNT',
                      style: TextStyle(
                        fontSize: 14,
                        //letterSpacing: 0.24,
                        color: greytheme1000,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '₹186.35',
                      style: TextStyle(
                        fontSize: 16,
                        //letterSpacing: 0.24,
                        fontWeight: FontWeight.w500,
                        color: greytheme700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
                    child: Text(
                      'Status : Preparing',
                      style: TextStyle(color: greytheme400, fontSize: 18),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  Widget _bookingHistoryList(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.70,
        child: ListView.builder(
          itemCount: 8,
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(4),
              ),
              elevation: 5,
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // ListTile(leading:ClipRect(child: Image.asset('assets/HotelImages/Image12.png',width: 30,height: 40,),clipBehavior: Clip.hardEdge,),
                  // // Container(
                  // //   height: 40,
                  // //   width: 40,
                  // //   decoration: BoxDecoration(borderRadius:new BorderRadius.circular(15)),
                  // //   child: Image.asset('assets/HotelImages/Image12.png'),
                  // // ),
                  // title: Text('Daawat',style: TextStyle(
                  //   fontSize: 18,
                  //   letterSpacing: 0.32,
                  //   color: greytheme700,
                  //   fontWeight: FontWeight.w500
                  // ),),
                  // subtitle: Text('Airoli, Navi Mumbai',style: TextStyle(
                  //   fontSize: 14,
                  //   letterSpacing: 0.24,
                  //   color:greytheme1200,
                  // ),),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.only(left: 15, top: 8),
                        //  decoration: BoxDecoration(shape:BoxShape.rectangle,borderRadius: new BorderRadius.all(Radius.circular(15)),),
                        // decoration: BoxDecoration(borderRadius:new BorderRadius.circular(15)),
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/HotelImages/Image12.png',
                            fit: BoxFit.fill,
                          ),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Daawat',
                              style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 0.32,
                                  color: greytheme700,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Airoli, Navi Mumbai',
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 0.24,
                                color: greytheme1000,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 15),
                    child: Text(
                      'ITEMS',
                      style: TextStyle(
                        fontSize: 14,
                        //letterSpacing: 0.24,
                        color: greytheme1000,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '1 × Chicken Biryani',
                      style: TextStyle(
                        fontSize: 16,
                        //letterSpacing: 0.24,
                        fontWeight: FontWeight.w500,
                        color: greytheme700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      'ORDERED ON ',
                      style: TextStyle(
                        fontSize: 14,
                        //letterSpacing: 0.24,
                        color: greytheme1000,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '06 Feb 2020 at 12:05 PM',
                      style: TextStyle(
                        fontSize: 16,
                        //letterSpacing: 0.24,
                        fontWeight: FontWeight.w500,
                        color: greytheme700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      'ORDERED TYPE',
                      style: TextStyle(
                        fontSize: 14,
                        //letterSpacing: 0.24,
                        color: greytheme1000,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Dine-in',
                      style: TextStyle(
                        fontSize: 16,
                        //letterSpacing: 0.24,
                        fontWeight: FontWeight.w500,
                        color: greytheme700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      'TOTAL AMOUNT',
                      style: TextStyle(
                        fontSize: 14,
                        //letterSpacing: 0.24,
                        color: greytheme1000,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '₹186.35',
                      style: TextStyle(
                        fontSize: 16,
                        //letterSpacing: 0.24,
                        fontWeight: FontWeight.w500,
                        color: greytheme700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      ClipOval(
                        child: Container(
                          height: 10,
                          width: 10,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Confirmed',
                        style: TextStyle(color: greytheme400, fontSize: 18),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: GestureDetector(
                          onTap: () {
                            print("object");
                          },
                          child: Text('Repeat Order'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            );
          },
        ));
  }

  // Widget getOrderList() {
  //   return
  // }

}
