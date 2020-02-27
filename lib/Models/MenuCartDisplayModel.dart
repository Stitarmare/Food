// import 'dart:convert';

// MenuCartDisplayModel menuCartDisplayModelFromJson(String str) => MenuCartDisplayModel.fromJson(json.decode(str));

// String menuCartDisplayModelToJson(MenuCartDisplayModel data) => json.encode(data.toJson());

// class MenuCartDisplayModel {
//     String status;
//     int statusCode;
//     List<MenuCartList> data;
//     int grandTotal;
//     String colourCode;

//     MenuCartDisplayModel({
//         this.status,
//         this.statusCode,
//         this.data,
//         this.grandTotal,
//         this.colourCode,
//     });

//     factory MenuCartDisplayModel.fromJson(Map<String, dynamic> json) => MenuCartDisplayModel(
//         status: json["status"],
//         statusCode: json["status_code"],
//         data: List<MenuCartList>.from(json["data"].map((x) => MenuCartList.fromJson(x))),
//         grandTotal: json["grandTotal"],
//         colourCode: json["colour_code"],
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "status_code": statusCode,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "grandTotal": grandTotal,
//         "colour_code": colourCode,
//     };
// }

// class MenuCartList {
//     int id;
//     int quantity;
//     String preparationTime;
//     int itemId;
//     dynamic itemSizePriceId;
//     int tableId;
//     String price;
//     int userId;
//     int restId;
//     DateTime createdAt;
//     DateTime updatedAt;
//     dynamic sizePrice;
//     int totalAmount;
//     Item items;
//     List<dynamic> cartExtraItems;

//     MenuCartList({
//         this.id,
//         this.quantity,
//         this.preparationTime,
//         this.itemId,
//         this.itemSizePriceId,
//         this.tableId,
//         this.price,
//         this.userId,
//         this.restId,
//         this.createdAt,
//         this.updatedAt,
//         this.sizePrice,
//         this.totalAmount,
//         this.items,
//         this.cartExtraItems,
//     });

//     factory MenuCartList.fromJson(Map<String, dynamic> json) => MenuCartList(
//         id: json["id"],
//         quantity: json["quantity"],
//         preparationTime: json["preparation_time"],
//         itemId: json["item_id"],
//         itemSizePriceId: json["item_size_price_id"],
//         tableId: json["table_id"],
//         price: json["price"],
//         userId: json["user_id"],
//         restId: json["rest_id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         sizePrice: json["size_price"],
//         totalAmount: json["totalAmount"],
//        items: Item.fromJson(json["items"]),
//         cartExtraItems: List<dynamic>.from(json["cart_extra_items"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "quantity": quantity,
//         "preparation_time": preparationTime,
//         "item_id": itemId,
//         "item_size_price_id": itemSizePriceId,
//         "table_id": tableId,
//         "price": price,
//         "user_id": userId,
//         "rest_id": restId,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "size_price": sizePrice,
//         "totalAmount": totalAmount,
//        "items": items.toJson(),
//         "cart_extra_items": List<dynamic>.from(cartExtraItems.map((x) => x)),
//     };
// }

// class Item {
//     int id;
//     String itemName;
//     String price;
//     String itemDescription;
//     int workstationId;
//     int restId;
//     String menuType;
//     String availability;
//     String defaultPreparationTime;
//     String itemCode;
//     String itemImage;
//     DateTime createdAt;
//     DateTime updatedAt;

//     Item({
//         this.id,
//         this.itemName,
//         this.price,
//         this.itemDescription,
//         this.workstationId,
//         this.restId,
//         this.menuType,
//         this.availability,
//         this.defaultPreparationTime,
//         this.itemCode,
//         this.itemImage,
//         this.createdAt,
//         this.updatedAt,
//     });

//     factory Item.fromJson(Map<String, dynamic> json)=> Item(
//         id: json["id"],
//         itemName: json["item_name"],
//         price: json["price"],
//         itemDescription: json["item_description"],
//         workstationId: json["workstation_id"],
//         restId: json["rest_id"],
//         menuType: json["menu_type"],
//         availability: json["availability"],
//         defaultPreparationTime: json["default_preparation_time"],
//         itemCode: json["item_code"],
//         itemImage: json["item_image"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "item_name": itemName,
//         "price": price,
//         "item_description": itemDescription,
//         "workstation_id": workstationId,
//         "rest_id": restId,
//         "menu_type": menuType,
//         "availability": availability,
//         "default_preparation_time": defaultPreparationTime,
//         "item_code": itemCode,
//         "item_image": itemImage,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//     };
// }
import 'dart:convert';

MenuCartDisplayModel menuCartDisplayModelFromJson(String str) =>
    MenuCartDisplayModel.fromJson(json.decode(str));

String menuCartDisplayModelToJson(MenuCartDisplayModel data) =>
    json.encode(data.toJson());

class MenuCartDisplayModel {
  String status;
  int statusCode;
  List<MenuCartList> data;
  int cartCount;
  int grandTotal;
  String colourCode;

  MenuCartDisplayModel({
    this.status,
    this.statusCode,
    this.data,
    this.cartCount,
    this.grandTotal,
    this.colourCode,
  });

  factory MenuCartDisplayModel.fromJson(Map<String, dynamic> json) =>
      MenuCartDisplayModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<MenuCartList>.from(
            json["data"].map((x) => MenuCartList.fromJson(x))),
        cartCount: json["cartCount"],
        grandTotal: json["grandTotal"],
        colourCode: json["colour_code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "cartCount": cartCount, 
        "grandTotal": grandTotal,
        "colour_code": colourCode,
      };
}

class MenuCartList {
  int id;
  int quantity;
  String preparationTime;
  int itemId;
  dynamic itemSizePriceId;
  int tableId;
  String price;
  int userId;
  int restId;
  String createdAt;
  String updatedAt;
  dynamic sizePrice;
  int totalAmount;
  Item items;
  // List<dynamic> cartExtraItems;
  List<CartExtraItems> cartExtraItems;

  MenuCartList({
    this.id,
    this.quantity,
    this.preparationTime,
    this.itemId,
    this.itemSizePriceId,
    this.tableId,
    this.price,
    this.userId,
    this.restId,
    this.createdAt,
    this.updatedAt,
    this.sizePrice,
    this.totalAmount,
    this.items,
    this.cartExtraItems,
  });

  // factory MenuCartList.fromJson(Map<String, dynamic> json) => MenuCartList(
  //       id: json["id"],
  //       quantity: json["quantity"],
  //       preparationTime: json["preparation_time"],
  //       itemId: json["item_id"],
  //       itemSizePriceId: json["item_size_price_id"],
  //       tableId: json["table_id"],
  //       price: json["price"],
  //       userId: json["user_id"],
  //       restId: json["rest_id"],
  //       createdAt: DateTime.parse(json["created_at"]),
  //       updatedAt: DateTime.parse(json["updated_at"]),
  //       sizePrice: json["size_price"],
  //       totalAmount: json["totalAmount"],
  //       items: Item.fromJson(json["items"]),
  //       cartExtraItems:
  //           List<CartExtraItems>.from(json["cart_extra_items"].map((x) => x)),
  //     );

  MenuCartList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    preparationTime = json['preparation_time'];
    itemId = json['item_id'];
    itemSizePriceId = json['item_size_price_id'];
    tableId = json['table_id'];
    price = json['price'];
    userId = json['user_id'];
    restId = json['rest_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sizePrice = json['size_price'];
    totalAmount = json['totalAmount'];
    items = json['items'] != null ? new Item.fromJson(json['items']) : null;
    if (json['cart_extra_items'] != null) {
      cartExtraItems = new List<CartExtraItems>();
      json['cart_extra_items'].forEach((v) {
        cartExtraItems.add(new CartExtraItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "preparation_time": preparationTime,
        "item_id": itemId,
        "item_size_price_id": itemSizePriceId,
        "table_id": tableId,
        "price": price,
        "user_id": userId,
        "rest_id": restId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "size_price": sizePrice,
        "totalAmount": totalAmount,
        "items": items.toJson(),
        "cart_extra_items": List<dynamic>.from(cartExtraItems.map((x) => x)),
      };
}

class Item {
  int id;
  String itemName;
  String price;
  String itemDescription;
  int workstationId;
  int restId;
  String menuType;
  String availability;
  String defaultPreparationTime;
  String itemCode;
  String itemImage;
  DateTime createdAt;
  DateTime updatedAt;

  Item({
    this.id,
    this.itemName,
    this.price,
    this.itemDescription,
    this.workstationId,
    this.restId,
    this.menuType,
    this.availability,
    this.defaultPreparationTime,
    this.itemCode,
    this.itemImage,
    this.createdAt,
    this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        itemName: json["item_name"],
        price: json["price"],
        itemDescription: json["item_description"],
        workstationId: json["workstation_id"],
        restId: json["rest_id"],
        menuType: json["menu_type"],
        availability: json["availability"],
        defaultPreparationTime: json["default_preparation_time"],
        itemCode: json["item_code"],
        itemImage: json["item_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "price": price,
        "item_description": itemDescription,
        "workstation_id": workstationId,
        "rest_id": restId,
        "menu_type": menuType,
        "availability": availability,
        "default_preparation_time": defaultPreparationTime,
        "item_code": itemCode,
        "item_image": itemImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class CartExtraItems {
  int id;
  int cartId;
  int itemId;
  int extraId;
  int spreadId;
  int switchId;
  int orderListId;
  String createdAt;
  String updatedAt;
  String switchOption;
  String price;

  CartExtraItems(
      {this.id,
      this.cartId,
      this.itemId,
      this.extraId,
      this.spreadId,
      this.switchId,
      this.orderListId,
      this.createdAt,
      this.updatedAt,
      this.switchOption,
      this.price});

  CartExtraItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    itemId = json['item_id'];
    extraId = json['extra_id'];
    spreadId = json['spread_id'];
    switchId = json['switch_id'];
    orderListId = json['order_list_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    switchOption = json['switch_option'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cart_id'] = this.cartId;
    data['item_id'] = this.itemId;
    data['extra_id'] = this.extraId;
    data['spread_id'] = this.spreadId;
    data['switch_id'] = this.switchId;
    data['order_list_id'] = this.orderListId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['switch_option'] = this.switchOption;
    data['price'] = this.price;
    return data;
  }
}
