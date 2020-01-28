
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/widgets/ExpandedTextWidgets.dart';

class HotelInfoView extends StatefulWidget {
  HotelInfoView({Key key}) : super(key: key);

  _HotelInfoViewState createState() => _HotelInfoViewState();
}

class _HotelInfoViewState extends State<HotelInfoView> {
  bool isExpanded = false;
  List<MenuCategoryButton> menuOptionItem = [
    MenuCategoryButton(title: "Sea Food", id: 1, isSelected: false),
    MenuCategoryButton(title: "Arabic", id: 2, isSelected: false),
    MenuCategoryButton(title: "Indian", id: 3, isSelected: false),
    MenuCategoryButton(title: "Chinese", id: 4, isSelected: false),
  ];
  bool isRestaurantViewed = true;
  bool isReview = false;
  var _current;
  final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
  'https://cdn.zeplin.io/5dfb22e292f6309743a8ab68/assets/7B28074D-A1D5-4B3F-8685-F3647C459940.png'
];
  @override
  Widget build(BuildContext context) {
  
    List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }
    Widget image_carousel = new Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(color: Colors.red),
                      height: Constants.getSafeAreaHeight(context) * 0.35,
                      width: Constants.getScreenWidth(context),
                      child: CarouselSlider(
                        autoPlay: true,
                        autoPlayAnimationDuration: Duration(microseconds: 100),
                        onPageChanged: (index) {
                          setState(() {
                            _current = index;
                          });
                        },
                        viewportFraction: 1.0,
                        aspectRatio: 16 / 9,
                        height: Constants.getSafeAreaHeight(context) * 0.35,
                        items: imgList.map((src) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  height: Constants.getSafeAreaHeight(context) *
                                      0.35,
                                  width: Constants.getScreenWidth(context),
                                  decoration:
                                      BoxDecoration(color: Colors.amber),
                                  child: Image.network(
                                    src,
                                    fit: BoxFit.cover,
                                    ));
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Positioned(
                      top: (Constants.getSafeAreaHeight(context) * 0.25),
                      right: Constants.getScreenWidth(context)/2.3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: map<Widget>(
                          imgList,
                          (index, url) {
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == index
                                      ? Colors.white
                                      : Color.fromRGBO(255, 255, 255, 0.2)),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
                
    Widget hotelInfo = new Container(
        height: MediaQuery.of(context).size.height * 0.68 + 23,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    'WIMPY',
                    style: TextStyle(
                        color: greytheme700,
                        // color: Colors.red,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Via in Arcione 115, 00187 Rome Italy',
                          style: TextStyle(
                            color: greytheme100,
                            fontSize: 14,
                            fontFamily: 'gotham',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: FlatButton(
                          child: ClipOval(
                            child: Image.asset(
                                'lib/assets/images/WaiterHotelNextBtn/next(2).png'),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ]),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 20),
                  height: 20,
                  child: new ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: menuOptionItem.length,
                    itemBuilder: (BuildContext context, int index) {
                      return menuButton(menuOptionItem[index]);
                    },
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 39,
                      height: 18,
                      // color: Colors.black,
                      decoration: BoxDecoration(
                          color: greytheme700,
                          borderRadius: BorderRadius.all(Radius.circular(4))),

                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Icon(
                              Icons.star,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4, top: 2, bottom: 2),
                            child: Text(
                              '4.5',
                              style: TextStyle(
                                  fontFamily: 'gotham',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      '(2000+ Reviews)',
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'gotham',
                          color: greytheme100),
                    )
                  ],
                ),
                SizedBox(
                  height: 17,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 33,
                      width: 157,
                      decoration: BoxDecoration(
                          color: redtheme,
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                              width: 32.5,
                              child: Padding(
                                padding: EdgeInsets.only(),
                                child: Icon(
                                  Icons.phone,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              )),
                          // Divider(thickness: 5,color: Colors.white,),
                          VerticalDivider(
                            thickness: 2,
                            width: 1,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 7, top: 6, bottom: 5, left: 7),
                            child: Text(
                              '+61 9876 5432',
                              style: TextStyle(
                                  fontFamily: 'gotham',
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 22,
                ),
                customTabbar()
              
              ]),
        )

       
        );
    return Scaffold(
      body: Container(
          // height: Constants.getSafeAreaHeight(context) * 0.35,
          //             width: Constants.getScreenWidth(context),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.passthrough,
          alignment: AlignmentDirectional.topStart,
          // fit: StackFit.expand,
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: image_carousel
              ),
            Positioned(
              left: 6.0,
              top: 21.0,
              child: FlatButton(
                child:
                    Image.asset('assets/BackButtonIcon/Path1621.png'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
              top: Constants.getSafeAreaHeight(context) * 0.3,
              left: 0,
              child: Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0))),
                height: Constants.getSafeAreaHeight(context) * 0.7,
                width: Constants.getScreenWidth(context),
                child: hotelInfo,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget menuButton(MenuCategoryButton item) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: RaisedButton(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            item.title,
            style: TextStyle(
              fontFamily: 'gotham',
              fontSize: 10,
              color: greytheme1000,
            ),
          ),
        ),
        color: greytheme1100,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              3.0,
            ),
            side: BorderSide(
              color: greytheme1100,
            )),
        onPressed: () {},
      ),

      // ),
    );
  }

  Widget RestaurantInfoList (BuildContext context) {
    return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10, top: 12),
          child: Text(
            'Opening Hours',
            style: TextStyle(
                fontFamily: 'gotham',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: greytheme700),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
            // height: 150,
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: 30.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: Text(
                                'Monday',
                                style: TextStyle(
                                    fontSize: 12, color: greytheme1000),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 120,
                              ),
                              flex: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 24),
                              child: Text('08:00 am - 10:00 pm',
                                  style: TextStyle(
                                      fontSize: 12, color: greytheme1000)),
                            ),
                          ],
                        ),
                        Divider(
                          height: 2,
                          color: Colors.grey,
                          indent: 20.0,
                          endIndent: 20.0,
                        )
                      ],
                    ));
              },
            ))
      ],
    ),
  );
  }

  Widget ReviewList (BuildContext context) {
    return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // widget(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, top: 12),
              child: Text(
                'Reviews',
                style: TextStyle(
                    fontFamily: 'gotham',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: greytheme700),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 120,
              ),
              flex: 2,
            ),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(top: 12, right: 20),
                child: Text('Write Review',
                    style: TextStyle(
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: redtheme,
                        decoration: TextDecoration.underline,
                        decorationThickness: 5.0
                        // decorationStyle: TextDecorationStyle.solid,
                        )),
              ),
            ),
          ],
        ),
        // ),
        SizedBox(
          height: 10,
        ),
        Container(
           height: MediaQuery.of(context).size.height * 0.35,
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    // height: 105,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                                Align(
                                  alignment: Alignment.topLeft,
                                 child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 18, top: 10
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/ProfileImage/MaskGroup15.png',
                                        height: 45,
                                        width: 45,
                                      ),
                                    )),
                                ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18,top: 16.5),
                                    child: Text('George Thomas',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: greytheme1000,
                                            fontFamily: 'gotham',
                                            fontWeight: FontWeight.w700)),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 18, top: 8),
                                    child: Container(
                                      width: 39,
                                      height: 18,
                                      // color: Colors.black,
                                      decoration: BoxDecoration(
                                          color: greytheme700,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),

                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 4),
                                            child: Icon(
                                              Icons.star,
                                              size: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, top: 2, bottom: 2),
                                            child: Text(
                                              '4.5',
                                              style: TextStyle(
                                                  fontFamily: 'gotham',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  Container(
                                     width:
                                        MediaQuery.of(context).size.width * 0.8,
                                      child:
                                      Padding(
                                        padding: const EdgeInsets.only(left: 18,top: 10),
                                        child: ExpandableText(
                                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Lorem Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem.',
                                            // maxLines: 5,)
                                         ),
                                      )
                                          ),
                                          SizedBox(height: 10,)
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 2,
                          color: Colors.grey,
                          indent: 20.0,
                          endIndent: 20.0,
                        )
                      ],
                    ));
              },
            ))
      ],
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
                        'Restaurants Info',
                        style: TextStyle(fontFamily: 'gotham', fontSize: 15),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Review',
                        style: TextStyle(
                          fontFamily: 'gotham',
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: redtheme, width: 2),
                      insets: EdgeInsets.symmetric(horizontal: 30)),
                  labelColor: redtheme,
                  unselectedLabelColor: greytheme1000,
                  onTap: (index) {
                    switch (index) {
                      case 0:
                        print('Restaurants Info');
                        setState(() {
                          isRestaurantViewed = true;
                          isReview = false;
                        });

                        break;
                      case 1:
                        print('Review');
                        setState(() {
                          isRestaurantViewed = false;
                          isReview = true;
                        });
                        break;
                    }
                  }),
            ),
          ),
          isRestaurantViewed
              ? Center(child: Container(child: RestaurantInfoList(context)))
              : Center(child: Container(child: ReviewList(context))),
        ],
      ),
    );
  }
}

class MenuCategoryButton {
  String title;
  bool isSelected;
  int id;
  MenuCategoryButton({this.title, this.isSelected, this.id});
}
