import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPage/AddItemPageView.dart';
import 'package:foodzi/MenuDropdownCategory/MenuItemDropDownContractor.dart';
import 'package:foodzi/MenuDropdownCategory/MenuItemDropDownPresenter.dart';
import 'package:foodzi/Models/CategoryListModel.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';
import 'package:foodzi/RestaurantPage/RestaurantContractor.dart';
import 'package:foodzi/RestaurantPage/RestaurantPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CategoriesSection extends StatefulWidget {
  int restId;

  String title;

  bool isFromOrder = false;

CategoriesSection({this.restId,this.isFromOrder,this.title});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoriesSectionState();
  }
}

class CategoriesSectionState extends State<CategoriesSection>
    implements RestaurantModelView,MenuDropdownModelView{
  RestaurantPresenter restaurantPresenter;
  int _selectedMenu = 0;
   List<RestaurantMenuItem> _restaurantList;

  int _selectedsubMenu = 0;
  bool isSelected = false;
  MenuTitles items;
 // List<ItemMenu> itemMenuList = [];
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
 // MenuListModel _menuListModel;
  ScrollController _controller = ScrollController();
  String currencySymbol = "R";
 List<Category> category = [];
  List<Subcategories> subcategories = [];
  List<Subcategories> subcategoriesList = [];
  
  List<CategoryItems> _categorydata = [
    // MenuTitles(title: 'STARTERS'),
    // MenuTitles(title: 'MAINS'),
    // MenuTitles(title: 'BURGER'),
    // MenuTitles(title: 'PIZZA'),
    // MenuTitles(title: 'PASTA'),
    // MenuTitles(title: 'DESSERTS'),
    // MenuTitles(title: 'DRINKS'),
  ];

  List<MenuTitles> _subcategorydata = [
    MenuTitles(title: 'Water'),
    MenuTitles(title: 'Wine'),
    MenuTitles(title: 'Beer'),
    MenuTitles(title: 'Soda'),
  //  MenuTitles(title: 'Hot Drinks'),
    // MenuTitles(title: 'Cold Drinks'),
  ];

  ProgressDialog progressDialog;

  int page = 1;

  RestaurantItemsModel restaurantItemsModel;

  MenuDropdpwnPresenter menudropdownPresenter;

  @override
  void initState() {
    // TODO: implement initState
  //  _menuListModel = MenuListModel();

    super.initState();
//isSelected = true;
    restaurantPresenter = RestaurantPresenter(this);
    restaurantPresenter.getMenuList(widget.restId, context);
     menudropdownPresenter = MenuDropdpwnPresenter(this);
    menudropdownPresenter.getMenuLCategory(widget.restId, context);
    _detectScrollPosition();
    if (widget.isFromOrder == null) {
      setState(() {
        widget.isFromOrder = false;
      });
    }
    // Preference.getPrefValue<String>("currencySym").then((value) {
    //   if (value != null) {
    //     Globle().currencySymbol = value;
    //     currencySymbol = Globle().currencySymbol;
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            FOODZI_LOGO_PATH,
            height: 60,
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.info), onPressed: null)
          ],
        ),
        body: SafeArea(
            child: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int section) {
                return Container(
                    //height: Constants.getScreenHeight(context) *0.26,
                    child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    getmainview(),
                    // _hoteLogoLayout(),
                    SizedBox(
                      // height: Constants.getScreenHeight(context) * 0.015,
                      height: 16,
                    ),
                    // getTableNumber(),
                  ],
                ));
              }, childCount: 1),
            ),
            //_menuOptionLayout(),
            // _menuTitleHoteTimeLayout(),
            _menuItemsLayout()
          ],
        ))

        //     Container(

        //     child: getmainview(),
        // ),

        );
  }

  Widget _menuItemsLayout() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: Constants.getScreenWidth(context) / 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 0.0,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  decoration: new BoxDecoration(
                    // color: Colors.white,
                    border: Border.all(color: Colors.white, width: 0),
                    borderRadius: new BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 9,
                       child: GestureDetector(
                         onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddItemPageView(
                        itemId: _restaurantList[index].id,
                        restId: _restaurantList[index].restId,
                        title: '${_restaurantList[index].itemName}',
                        description:
                            '${_restaurantList[index].itemDescription}',
                        restName: widget.title,
                        itemImage: '${_restaurantList[index].itemImage}',
                        isFromOrder: widget.isFromOrder,
                      ))),
                                                child: ClipRRect(
                           borderRadius: BorderRadius.circular(18.0),

                                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 100,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      "assets/PlaceholderFoodImage/MaskGroup55.png",
                                      fit: BoxFit.contain,
                                      width: double.infinity,
                                      height: 100,
                                    ),
                                    imageUrl: BaseUrl.getBaseUrlImages() +
                                        '${_restaurantList[index].itemImage}',
                                  ),
                         ),
                       ),
                        // child: ClipRRect(
                        //   borderRadius: BorderRadius.only(
                        //     topLeft: Radius.circular(10.0),
                        //     topRight: Radius.circular(10.0),
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(
                        //         right: 5.0, left: 5, top: 5),
                        //     child: Align(
                        //       alignment: Alignment.center,
                        //       heightFactor: 1,
                        //       child: CachedNetworkImage(
                        //         fit: BoxFit.contain,
                        //         width: double.infinity,
                        //         height: 100,
                        //         placeholder: (context, url) => Center(
                        //           child: CircularProgressIndicator(),
                        //         ),
                        //         errorWidget: (context, url, error) =>
                        //             Image.asset(
                        //           "assets/PlaceholderFoodImage/MaskGroup55.png",
                        //           fit: BoxFit.contain,
                        //           width: double.infinity,
                        //           height: 100,
                        //         ),
                        //         imageUrl: BaseUrl.getBaseUrlImages() +
                        //             '${itemMenuList[index].itemImage}',
                        //       ),

                        //       // Image.network(
                        //       //     // "https://static.vinepair.com/wp-content/uploads/2017/03/darts-int.jpg"),
                        //       //     BaseUrl.getBaseUrlImages() +
                        //       //         itemMenuList[index].itemImage),
                        //     ),
                        //   ),
                        // ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8, top: 5),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      // (itemMenuList[index].menuType == "veg")
                                      //     ? Expanded(
                                      //         // flex: 1,
                                      //         child: Image.asset(
                                      //           StringConstant.IMG_VEG_ICON,
                                      //           // 'lib/assets/images/VegIcon/Group1661.png',
                                      //           //color: greentheme,
                                      //           width: 14,
                                      //           height: 14,
                                      //         ),
                                      //       )
                                      //     : Expanded(
                                      //         flex: 1,
                                      //         child: Image.asset(
                                      //           StringConstant.IMG_VEG_ICON,
                                      //           // 'lib/assets/images/VegIcon/Group1661.png',
                                      //           color: redtheme,
                                      //           width: 14,
                                      //           height: 14,
                                      //         ),
                                      //       ),
                                      // SizedBox(
                                      //   width: 5,
                                      // ),

                                     // SizedBox(width: 20,),
                                      Expanded(
                                        flex: 9,
                                        child: Center(
                                          child: Text(
                                            _restaurantList[index].itemName != null
                                                ? StringUtils.capitalize(
                                                    "${_restaurantList[index].itemName}")
                                                : "",
                                            maxLines: 2,
                                            style: TextStyle(
                                              //  fontFamily: FontNames.gotham,
                                                fontSize: 13,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w600,
                                                color: greytheme700),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),

                                  Center(
                                child:  Text(
                                  (_restaurantList[index].sizePrizes.isEmpty)
                                      ? currencySymbol +
                                              ' ${_restaurantList[index].price}' ??
                                          ''
                                      : currencySymbol +
                                              " ${_restaurantList[index].sizePrizes[0].price}" ??
                                          "",
                                  // itemMenuList[index].price,
                                  style: TextStyle(
                                     // fontFamily: FontNames.gotham,
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w700,
                                      color: greytheme700),
                                ),
                              ),
                                  //  
                                ]),
                          )),
                      Container(
                        height: Constants.getScreenWidth(context) * 0.011,
                        // decoration: new BoxDecoration(
                        //   color: Colors.white,
                        //   border: Border(
                        //     top: BorderSide(
                        //       width: 0.2,
                        //     ),
                        //   ),
                        // ),
                        // child: Row(
                        //   children: <Widget>[
                        //     Container(
                        //       // decoration: new BoxDecoration(
                        //       //   //color: Colors.white,
                        //       //   border: Border(
                        //       //     top: BorderSide(
                        //       //       color: Colors.grey,
                        //       //       width: 0.7,
                        //       //     ),
                        //       //   ),
                        //       // ),
                        //       width: Constants.getScreenWidth(context) * 0.2,
                        //       child: Center(
                        //         child: Text(
                        //           (itemMenuList[index].sizePrizes.isEmpty)
                        //               ? currencySymbol +
                        //                       ' ${itemMenuList[index].price}' ??
                        //                   ''
                        //               : currencySymbol +
                        //                       " ${itemMenuList[index].sizePrizes[0].price}" ??
                        //                   "",
                        //           // itemMenuList[index].price,
                        //           style: TextStyle(
                        //               fontFamily: FontNames.gotham,
                        //               fontSize: 16,
                        //               fontStyle: FontStyle.normal,
                        //               fontWeight: FontWeight.w700,
                        //               color: greytheme700),
                        //         ),
                        //       ),
                        //     ),
                        //   ])
                        //     // Expanded(
                        //     //   child: GestureDetector(
                        //     //     onTap: () {
                        //     //       //   Navigator.pushNamed(
                        //     //       //       context, '/MenuItemOption',arguments:{"itemId":itemMenuList[index].id});
                        //     //       // Navigator.pushNamed(
                        //     //       //     context, "/MenuItemDetailOption",
                        //     //       //     arguments: {
                        //     //       //       "itemId": itemMenuList[index].id,
                        //     //       //       "tableId": widget.tableId,
                        //     //       //       "tableName": widget.tableName,
                        //     //       //       "orderId": widget.orderId,
                        //     //       //       "itemImage":
                        //     //       //           itemMenuList[index].itemImage
                        //     //       //       // "restId":widget.restId
                        //     //       //     });
                        //     //     },
                        //     //     child: Container(
                        //     //       decoration: BoxDecoration(
                        //     //           color: ((Globle().colorcode) != null)
                        //     //               ? getColorByHex((Globle().colorcode))
                        //     //               : Colors.red,
                        //     //           borderRadius: BorderRadius.only(
                        //     //             bottomRight: Radius.circular(9.0),
                        //     //           )),
                        //     //       width:
                        //     //           Constants.getScreenWidth(context) * 0.1,
                        //     //       child: Center(
                        //     //         child: Text(
                        //     //           "+ ADD",
                        //     //           style: TextStyle(
                        //     //               fontFamily: FontNames.gotham,
                        //     //               fontSize: 14,
                        //     //               fontStyle: FontStyle.normal,
                        //     //               fontWeight: FontWeight.w600,
                        //     //               color: Colors.white),
                        //     //         ),
                        //     //       ),
                        //     //     ),
                        //     //   ),
                        //     // )
                        //   ],
                        // ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }, childCount: _getint()),
    );
  }

   int _getint() {
    if (_restaurantList != null) {
      return _restaurantList.length;
    }
    return 0;
  }

  Widget getmainview() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Container(height: 40, child: mainMenus(items)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Center(child: Container(height: 40, child: submainMenus())),
          )
          //   Expanded(
          //     flex: 1,
          //     child: Container(
          //     height: 40,
          //     child:mainMenus() ,
          //   )),
          //  // SizedBox(height: 40,),
          //     Expanded(
          //       flex: 1,
          //       child: Container(
          //       height: 40,
          //       child : submainMenus(),
          //     ))
        ],
      ),
    );
  }

  _onSelected(index) {
    setState(() {
      _selectedMenu = index;
      isSelected = true;
      print(_selectedMenu);
    });
  }

  _onSelectedsubmenu(index) {
    setState(() {
      _selectedsubMenu = index;
      isSelected = true;
      print(_selectedsubMenu);
    });
  }

  _detectScrollPosition() {
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels == 0) {
          print("Top");
        } else {
          print("Bottom");
        }
      }
    });
  }

  Widget mainMenus(MenuTitles items) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _getMenucount(),
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.13,
            child:
                // Card(
                //   color: Colors.blue,
                //   child:
                Container(
              child: Column(
                children: <Widget>[
                  Center(
                      child: GestureDetector(
                          onTap: () async {
                            _onSelected(index);

                            // print(index.toString());
                            // await progressDialog.show();
                          },
                          child: Text(
                            category[index].name,
                            style: TextStyle(
                                color: _selectedMenu != null &&
                                        _selectedMenu == index
                                    ? Colors.orange
                                    : Colors.grey ,
                                fontSize: 10.0),
                          ))),
                  Divider(
                    thickness: 2,
                    color: _selectedMenu != null && _selectedMenu == index
                        ? Colors.orange 
                        : Colors.grey,
                  )
                ],
              ),
            ),
            // ),
          );
        });
  }

 int _getMenucount() {
    if (_categorydata != null) {
      for (int i = 0; i < _categorydata.length; i++) {
        category = _categorydata[i].category;
      }
      return category.length;
    }
    return 0;
  }

  int _getSubMenucount() {
    if (subcategoriesList != null) {
      return subcategoriesList.length;
    }
    return 0;
  }

  Widget submainMenus() {
    return Center(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _getSubMenucount(),
          itemBuilder: (context, index) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.12,
              child:
                  // Card(
                  //   color: Colors.blue,
                  //   child:
                  Container(
                child: Column(
                  children: <Widget>[
                    Center(
                        child: GestureDetector(
                          onTap: (){
                            _onSelectedsubmenu(index);

                          },
                                                  child: Text(
                      subcategories[index].name,
                      style: TextStyle(color: _selectedsubMenu!=null && _selectedsubMenu == index ? Colors.orange : Colors.grey, fontSize: 12.0),
                    ),
                        )),
                  ],
                ),
              ),
              // ),
            );
          }),
    );
  }

  @override
  Future<void> getMenuListfailed() async {
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }
    @override
  Future<void> getMenuListsuccess(List<RestaurantMenuItem> menulist,
      RestaurantItemsModel _restaurantItemsModel1) async {
    if (menulist.length == 0) {
      await progressDialog.hide();
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      return;
    }
    setState(() {
      if (_restaurantList == null) {
        _restaurantList = menulist;
        restaurantItemsModel = _restaurantItemsModel1;
      } else {
        _restaurantList.removeRange(0, (_restaurantList.length));
        _restaurantList.addAll(menulist);
        restaurantItemsModel = _restaurantItemsModel1;
      }

      page++;
    });
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }


  @override
  void notifyWaiterFailed() {
    // TODO: implement notifyWaiterFailed
  }

  @override
  void notifyWaiterSuccess() {
    // TODO: implement notifyWaiterSuccess
  }

 
  @override
  void getMenuLCategoryfailed() {}

  @override
  void getMenuLCategorysuccess([List<CategoryItems> categoryData]) {
    if (categoryData.length == 0) {
      return;
    }
    setState(() {
      if (_categorydata == null) {
        _categorydata = categoryData;
      } else {
        _categorydata.addAll(categoryData);
      }
    });

    if (categoryData[0].category[0].subcategories.length > 0) {
      setState(() {
        isSelected = true;
        subcategoriesList = categoryData[0].category[0].subcategories;
      });
    } else {
      setState(() {
        isSelected = false;
        subcategoriesList = [];
      });
    }
  }
//   @override
//   void menuListOnFailed() {
//     // TODO: implement menuListOnFailed
//   }

//   @override
//   void menuListOnSuccess(List<ItemMenu> list, MenuListModel menuListModel1) {
//     if (list.length == 0) {
//       Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
//       return;
//     }
//     setState(() {
//       if (itemMenuList == null) {
//         itemMenuList = list;
//         _menuListModel = menuListModel1;
//       } else {
//         itemMenuList.removeRange(0, (itemMenuList.length));
//         itemMenuList.addAll(list);
//         _menuListModel = menuListModel1;
//       }
//     });
//     Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
//   }

// //

 }

class MenuTitles {
  String title;
  bool isSelected;
  int id;
  MenuTitles({this.title, this.id, this.isSelected});
}

class MenuItemButton {
  String title;
  bool isSelected;
  int id;
  MenuItemButton({this.title, this.isSelected, this.id});
}
