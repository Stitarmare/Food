import 'dart:convert';

import 'package:foodzi/Models/MenuCartDisplayModel.dart';

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) =>
    json.encode(data.toJson());

class OrderDetailsModel {
  String status;
  int statusCode;
  OrderDetailData data;
  String grandTotal;
  String currencySymbol;

  OrderDetailsModel(
      {this.status,
      this.statusCode,
      this.data,
      this.grandTotal,
      this.currencySymbol});

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
          status: json["status"],
          statusCode: json["status_code"],
          data: OrderDetailData.fromJson(json["data"]),
          grandTotal: json["grandTotal"],
          currencySymbol: json["currency_symbol"]);

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": data.toJson(),
        "grandTotal": grandTotal,
        "currency_symbol": currencySymbol
      };
}

class OrderDetailData {
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
  String tableName;
  String invited;
  List<ListElements> list;
  List<dynamic> invitation;
  int splitType;
  String splitAmount;
  List<Splitbilltransactions> splitbilltransactions;

  OrderDetailData(
      {this.id,
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
      this.tableName,
      this.list,
      this.invitation,
      this.invited,
      this.splitType,
      this.splitAmount,
      this.splitbilltransactions});

  factory OrderDetailData.fromJson(Map<String, dynamic> json) =>
      OrderDetailData(
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
        tableName: json["table_name"],
        list: List<ListElements>.from(
            json["list"].map((x) => ListElements.fromJson(x))),
        invitation: List<dynamic>.from(json["invitation"].map((x) => x)),
        invited: json["invited"],
        splitType: json["split_type"],
        splitAmount: json["split_amount"],
        splitbilltransactions: List<Splitbilltransactions>.from(
            json["splitbilltransactions"]
                .map((x) => Splitbilltransactions.fromJson(x))),
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
        "table_name": tableName,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "invitation": List<dynamic>.from(invitation.map((x) => x)),
        "invited": invited
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
  String price;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic sizePrice;
  String totalAmount;
  Items items;
  List<CartExtraItem> cartExtras;

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
    this.totalAmount,
    this.items,
    this.cartExtras,
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
        totalAmount: json["totalAmount"],
        items: Items.fromJson(json["items"]),
        cartExtras: List<CartExtraItem>.from(
            json["cart_extras"].map((x) => CartExtraItem.fromJson(x))),
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
        "totalAmount": totalAmount,
        "items": items.toJson(),
        "cart_extras": List<dynamic>.from(cartExtras.map((x) => x.toJson())),
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

class Splitbilltransactions {
  int id;
  String amount;
  String paystatus;
  int orderId;
  int restId;
  int userId;

  Splitbilltransactions({
    this.id,
    this.amount,
    this.paystatus,
    this.orderId,
    this.restId,
    this.userId,
  });

  factory Splitbilltransactions.fromJson(Map<String, dynamic> json) =>
      Splitbilltransactions(
        id: json["id"],
        amount: json["amount"],
        paystatus: json["paystatus"],
        orderId: json["order_id"],
        restId: json["rest_id"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "paystatus": paystatus,
        "order_id": orderId,
        "rest_id": restId,
        "user_id": userId,
      };
}
