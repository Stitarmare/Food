// // To parse this JSON data, do
// //
// //     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

// import 'dart:convert';

// OrderDetailsModel orderDetailsModelFromJson(String str) =>
//     OrderDetailsModel.fromJson(json.decode(str));

// String orderDetailsModelToJson(OrderDetailsModel data) =>
//     json.encode(data.toJson());

// class OrderDetailsModel {
//   String status;
//   int statusCode;
//   dynamic tableId;
//   List<OrderDetailList> data;
//   int cartCount;
//   int grandTotal;
//   String colourCode;

//   OrderDetailsModel({
//     this.status,
//     this.statusCode,
//     this.tableId,
//     this.data,
//     this.cartCount,
//     this.grandTotal,
//     this.colourCode,
//   });

//   factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
//       OrderDetailsModel(
//         status: json["status"],
//         statusCode: json["status_code"],
//         tableId: json["table_id"],
//         data: List<OrderDetailList>.from(
//             json["data"].map((x) => OrderDetailList.fromJson(x))),
//         cartCount: json["cartCount"],
//         grandTotal: json["grandTotal"],
//         colourCode: json["colour_code"],
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "status_code": statusCode,
//         "table_id": tableId,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "cartCount": cartCount,
//         "grandTotal": grandTotal,
//         "colour_code": colourCode,
//       };
// }

// class OrderDetailList {
//   int id;
//   int quantity;
//   String preparationTime;
//   int itemId;
//   dynamic itemSizePriceId;
//   int tableId;
//   String price;
//   int userId;
//   int restId;
//   DateTime createdAt;
//   DateTime updatedAt;
//   dynamic sizePrice;
//   int totalAmount;
//   Items items;
//   List<CartExtraItem> cartExtraItems;

//   OrderDetailList({
//     this.id,
//     this.quantity,
//     this.preparationTime,
//     this.itemId,
//     this.itemSizePriceId,
//     this.tableId,
//     this.price,
//     this.userId,
//     this.restId,
//     this.createdAt,
//     this.updatedAt,
//     this.sizePrice,
//     this.totalAmount,
//     this.items,
//     this.cartExtraItems,
//   });

//   factory OrderDetailList.fromJson(Map<String, dynamic> json) =>
//       OrderDetailList(
//         id: json["id"],
//         quantity: json["quantity"],
//         preparationTime: json["preparation_time"],
//         itemId: json["item_id"],
//         itemSizePriceId: json["item_size_price_id"],
//         tableId: json["table_id"] == null ? null : json["table_id"],
//         price: json["price"] == null ? null : json["price"],
//         userId: json["user_id"],
//         restId: json["rest_id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         sizePrice: json["size_price"],
//         totalAmount: json["totalAmount"],
//         items: Items.fromJson(json["items"]),
//         cartExtraItems: List<CartExtraItem>.from(
//             json["cart_extra_items"].map((x) => CartExtraItem.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "quantity": quantity,
//         "preparation_time": preparationTime,
//         "item_id": itemId,
//         "item_size_price_id": itemSizePriceId,
//         "table_id": tableId == null ? null : tableId,
//         "price": price == null ? null : price,
//         "user_id": userId,
//         "rest_id": restId,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "size_price": sizePrice,
//         "totalAmount": totalAmount,
//         "items": items.toJson(),
//         "cart_extra_items":
//             List<dynamic>.from(cartExtraItems.map((x) => x.toJson())),
//       };
// }

// class CartExtraItem {
//   int id;
//   int cartId;
//   int itemId;
//   int extraId;
//   dynamic spreadId;
//   dynamic switchId;
//   dynamic orderListId;
//   DateTime createdAt;
//   DateTime updatedAt;
//   dynamic switchOption;
//   String price;
//   List<Extra> extras;
//   List<dynamic> spreads;
//   List<dynamic> switches;

//   CartExtraItem({
//     this.id,
//     this.cartId,
//     this.itemId,
//     this.extraId,
//     this.spreadId,
//     this.switchId,
//     this.orderListId,
//     this.createdAt,
//     this.updatedAt,
//     this.switchOption,
//     this.price,
//     this.extras,
//     this.spreads,
//     this.switches,
//   });

//   factory CartExtraItem.fromJson(Map<String, dynamic> json) => CartExtraItem(
//         id: json["id"],
//         cartId: json["cart_id"],
//         itemId: json["item_id"],
//         extraId: json["extra_id"],
//         spreadId: json["spread_id"],
//         switchId: json["switch_id"],
//         orderListId: json["order_list_id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         switchOption: json["switch_option"],
//         price: json["price"],
//         extras: List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x))),
//         spreads: List<dynamic>.from(json["spreads"].map((x) => x)),
//         switches: List<dynamic>.from(json["switches"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "cart_id": cartId,
//         "item_id": itemId,
//         "extra_id": extraId,
//         "spread_id": spreadId,
//         "switch_id": switchId,
//         "order_list_id": orderListId,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "switch_option": switchOption,
//         "price": price,
//         "extras": List<dynamic>.from(extras.map((x) => x.toJson())),
//         "spreads": List<dynamic>.from(spreads.map((x) => x)),
//         "switches": List<dynamic>.from(switches.map((x) => x)),
//       };
// }

// class Extra {
//   int id;
//   String name;
//   String price;
//   int restId;
//   String status;
//   DateTime createdAt;
//   DateTime updatedAt;

//   Extra({
//     this.id,
//     this.name,
//     this.price,
//     this.restId,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Extra.fromJson(Map<String, dynamic> json) => Extra(
//         id: json["id"],
//         name: json["name"],
//         price: json["price"],
//         restId: json["rest_id"],
//         status: json["status"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "price": price,
//         "rest_id": restId,
//         "status": status,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }

// class Items {
//   int id;
//   String itemName;
//   String price;
//   String itemDescription;
//   int workstationId;
//   int restId;
//   String menuType;
//   String availability;
//   String defaultPreparationTime;
//   String itemCode;
//   String itemImage;
//   DateTime createdAt;
//   DateTime updatedAt;
//   List<SizePrize> sizePrizes;

//   Items({
//     this.id,
//     this.itemName,
//     this.price,
//     this.itemDescription,
//     this.workstationId,
//     this.restId,
//     this.menuType,
//     this.availability,
//     this.defaultPreparationTime,
//     this.itemCode,
//     this.itemImage,
//     this.createdAt,
//     this.updatedAt,
//     this.sizePrizes,
//   });

//   factory Items.fromJson(Map<String, dynamic> json) => Items(
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
//         sizePrizes: json["size_prizes"] == null
//             ? null
//             : List<SizePrize>.from(
//                 json["size_prizes"].map((x) => SizePrize.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
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
//         "size_prizes": sizePrizes == null
//             ? null
//             : List<dynamic>.from(sizePrizes.map((x) => x.toJson())),
//       };
// }

// class SizePrize {
//   int id;
//   int itemId;
//   String price;
//   String size;
//   String status;
//   dynamic createdAt;
//   dynamic updatedAt;

//   SizePrize({
//     this.id,
//     this.itemId,
//     this.price,
//     this.size,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory SizePrize.fromJson(Map<String, dynamic> json) => SizePrize(
//         id: json["id"],
//         itemId: json["item_id"],
//         price: json["price"],
//         size: json["size"],
//         status: json["status"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "item_id": itemId,
//         "price": price,
//         "size": size,
//         "status": status,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//       };
// }
// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
    String status;
    int statusCode;
    Data data;
    int grandTotal;

    OrderDetailsModel({
        this.status,
        this.statusCode,
        this.data,
        this.grandTotal,
    });

    factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: Data.fromJson(json["data"]),
        grandTotal: json["grandTotal"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": data.toJson(),
        "grandTotal": grandTotal,
    };
}

class Data {
    int id;
    String orderType;
    int tableId;
    int userId;
    dynamic additionalComments;
    int restId;
    String orderNumber;
    String status;
    String totalAmount;
    DateTime createdAt;
    DateTime updatedAt;
    List<ListElements> list;
    List<dynamic> invitation;

    Data({
        this.id,
        this.orderType,
        this.tableId,
        this.userId,
        this.additionalComments,
        this.restId,
        this.orderNumber,
        this.status,
        this.totalAmount,
        this.createdAt,
        this.updatedAt,
        this.list,
        this.invitation,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        orderType: json["order_type"],
        tableId: json["table_id"],
        userId: json["user_id"],
        additionalComments: json["additional_comments"],
        restId: json["rest_id"],
        orderNumber: json["order_number"],
        status: json["status"],
        totalAmount: json["total_amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        list: List<ListElements>.from(json["list"].map((x) => ListElements.fromJson(x))),
        invitation: List<dynamic>.from(json["invitation"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_type": orderType,
        "table_id": tableId,
        "user_id": userId,
        "additional_comments": additionalComments,
        "rest_id": restId,
        "order_number": orderNumber,
        "status": status,
        "total_amount": totalAmount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "invitation": List<dynamic>.from(invitation.map((x) => x)),
    };
}

class ListElements {
    int id;
    int quantity;
    String preparationTime;
    int itemId;
    dynamic itemSizePriceId;
    int tableId;
    int orderId;
    int userId;
    int restId;
    dynamic price;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic sizePrice;
    List<CartExtra> cartExtras;
    Items items;

    ListElements({
        this.id,
        this.quantity,
        this.preparationTime,
        this.itemId,
        this.itemSizePriceId,
        this.tableId,
        this.orderId,
        this.userId,
        this.restId,
        this.price,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.sizePrice,
        this.cartExtras,
        this.items,
    });

    factory ListElements.fromJson(Map<String, dynamic> json) => ListElements(
        id: json["id"],
        quantity: json["quantity"],
        preparationTime: json["preparation_time"],
        itemId: json["item_id"],
        itemSizePriceId: json["item_size_price_id"],
        tableId: json["table_id"],
        orderId: json["order_id"],
        userId: json["user_id"],
        restId: json["rest_id"],
        price: json["price"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sizePrice: json["size_price"],
        cartExtras: List<CartExtra>.from(json["cart_extras"].map((x) => CartExtra.fromJson(x))),
        items: Items.fromJson(json["items"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "preparation_time": preparationTime,
        "item_id": itemId,
        "item_size_price_id": itemSizePriceId,
        "table_id": tableId,
        "order_id": orderId,
        "user_id": userId,
        "rest_id": restId,
        "price": price,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "size_price": sizePrice,
        "cart_extras": List<dynamic>.from(cartExtras.map((x) => x.toJson())),
        "items": items.toJson(),
    };
}

class CartExtra {
    int id;
    dynamic cartId;
    int itemId;
    dynamic extraId;
    int spreadId;
    dynamic switchId;
    int orderListId;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic switchOption;
    String price;

    CartExtra({
        this.id,
        this.cartId,
        this.itemId,
        this.extraId,
        this.spreadId,
        this.switchId,
        this.orderListId,
        this.createdAt,
        this.updatedAt,
        this.switchOption,
        this.price,
    });

    factory CartExtra.fromJson(Map<String, dynamic> json) => CartExtra(
        id: json["id"],
        cartId: json["cart_id"],
        itemId: json["item_id"],
        extraId: json["extra_id"],
        spreadId: json["spread_id"],
        switchId: json["switch_id"],
        orderListId: json["order_list_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        switchOption: json["switch_option"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cart_id": cartId,
        "item_id": itemId,
        "extra_id": extraId,
        "spread_id": spreadId,
        "switch_id": switchId,
        "order_list_id": orderListId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "switch_option": switchOption,
        "price": price,
    };
}

class Items {
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

    Items({
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

    factory Items.fromJson(Map<String, dynamic> json) => Items(
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
