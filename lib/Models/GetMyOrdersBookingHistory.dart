// import 'dart:convert';

// GetMyOrdersBookingHistory getMyOrdersBookingHistoryFromJson(String str) =>
//     GetMyOrdersBookingHistory.fromJson(json.decode(str));

// String getMyOrdersBookingHistoryToJson(GetMyOrdersBookingHistory data) =>
//     json.encode(data.toJson());

// class GetMyOrdersBookingHistory {
//   String status;
//   int statusCode;
//   List<GetMyOrderBookingHistoryList> data;

//   GetMyOrdersBookingHistory({
//     this.status,
//     this.statusCode,
//     this.data,
//   });

//   factory GetMyOrdersBookingHistory.fromJson(Map<String, dynamic> json) =>
//       GetMyOrdersBookingHistory(
//         status: json["status"],
//         statusCode: json["status_code"],
//         data: List<GetMyOrderBookingHistoryList>.from(
//             json["data"].map((x) => GetMyOrderBookingHistoryList.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "status_code": statusCode,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class GetMyOrderBookingHistoryList {
//   int id;
//   String orderType;
//   int tableId;
//   int userId;
//   dynamic additionalComments;
//   int restId;
//   String status;
//   String totalAmount;
//   String splitAmount;
//   dynamic timeToPickupOrder;
//   dynamic waiterId;
//   String createdAt;
//   String updatedAt;
//   String orderNumber;
//   bool isRunning;
//   Restaurant restaurant;
//   List<GetMyOrderBookingList> list;

//   GetMyOrderBookingHistoryList({
//     this.id,
//     this.orderType,
//     this.tableId,
//     this.userId,
//     this.additionalComments,
//     this.restId,
//     this.status,
//     this.totalAmount,
//     this.timeToPickupOrder,
//     this.waiterId,
//     this.splitAmount,
//     this.createdAt,
//     this.updatedAt,
//     this.orderNumber,
//     this.isRunning,
//     this.restaurant,
//     this.list,
//   });

//   factory GetMyOrderBookingHistoryList.fromJson(Map<String, dynamic> json) =>
//       GetMyOrderBookingHistoryList(
//         id: json["id"],
//         orderType: json["order_type"],
//         tableId: json["table_id"],
//         userId: json["user_id"],
//         additionalComments: json["additional_comments"],
//         restId: json["rest_id"],
//         status: json["status"],
//         totalAmount: json["total_amount"],
//         splitAmount: json["split_amount"],
//         timeToPickupOrder: json["time_to_pickup_order"],
//         waiterId: json["waiter_id"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         orderNumber: json["order_number"],
//         isRunning: json["is_running"],
//         restaurant: Restaurant.fromJson(json["restaurant"]),
//         list: List<GetMyOrderBookingList>.from(
//             json["list"].map((x) => GetMyOrderBookingList.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "order_type": orderType,
//         "table_id": tableId,
//         "user_id": userId,
//         "additional_comments": additionalComments,
//         "rest_id": restId,
//         "status": status,
//         "total_amount": totalAmount,
//         "split_amount": splitAmount,
//         "time_to_pickup_order": timeToPickupOrder,
//         "waiter_id": waiterId,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "order_number": orderNumber,
//         "is_running": isRunning,
//         "restaurant": restaurant.toJson(),
//         "list": List<dynamic>.from(list.map((x) => x.toJson())),
//       };
// }

// class GetMyOrderBookingList {
//   int id;
//   int quantity;
//   String preparationTime;
//   int itemId;
//   dynamic itemSizePriceId;
//   int tableId;
//   int orderId;
//   int userId;
//   int restId;
//   dynamic waiterId;
//   String price;
//   String status;
//   dynamic sizePrice;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Items items;

//   GetMyOrderBookingList({
//     this.id,
//     this.quantity,
//     this.preparationTime,
//     this.itemId,
//     this.itemSizePriceId,
//     this.tableId,
//     this.orderId,
//     this.userId,
//     this.restId,
//     this.waiterId,
//     this.price,
//     this.status,
//     this.sizePrice,
//     this.createdAt,
//     this.updatedAt,
//     this.items,
//   });

//   factory GetMyOrderBookingList.fromJson(Map<String, dynamic> json) =>
//       GetMyOrderBookingList(
//         id: json["id"],
//         quantity: json["quantity"],
//         preparationTime: json["preparation_time"],
//         itemId: json["item_id"],
//         itemSizePriceId: json["item_size_price_id"],
//         tableId: json["table_id"],
//         orderId: json["order_id"],
//         userId: json["user_id"],
//         restId: json["rest_id"],
//         waiterId: json["waiter_id"],
//         price: json["price"] == null ? null : json["price"],
//         status: json["status"],
//         sizePrice: json["size_price"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         items: Items.fromJson(json["items"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "quantity": quantity,
//         "preparation_time": preparationTime,
//         "item_id": itemId,
//         "item_size_price_id": itemSizePriceId,
//         "table_id": tableId,
//         "order_id": orderId,
//         "user_id": userId,
//         "rest_id": restId,
//         "waiter_id": waiterId,
//         "price": price == null ? null : price,
//         "status": status,
//         "size_price": sizePrice,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "items": items.toJson(),
//       };
// }

// class Items {
//   int id;
//   String itemName;
//   String price;
//   String itemDescription;
//   String menuType;
//   String defaultPreparationTime;
//   String itemCode;
//   String itemImage;
//   int workstationId;
//   DateTime createdAt;
//   DateTime updatedAt;

//   Items({
//     this.id,
//     this.itemName,
//     this.price,
//     this.itemDescription,
//     this.menuType,
//     this.defaultPreparationTime,
//     this.itemCode,
//     this.itemImage,
//     this.workstationId,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Items.fromJson(Map<String, dynamic> json) => Items(
//         id: json["id"],
//         itemName: json["item_name"],
//         price: json["price"],
//         itemDescription: json["item_description"],
//         menuType: json["menu_type"],
//         defaultPreparationTime: json["default_preparation_time"],
//         itemCode: json["item_code"],
//         itemImage: json["item_image"],
//         workstationId: json["workstation_id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "item_name": itemName,
//         "price": price,
//         "item_description": itemDescription,
//         "menu_type": menuType,
//         "default_preparation_time": defaultPreparationTime,
//         "item_code": itemCode,
//         "item_image": itemImage,
//         "workstation_id": workstationId,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }

// class Restaurant {
//   int id;
//   String restName;
//   String addressLine1;
//   dynamic addressLine2;
//   dynamic addressLine3;
//   String coverImage;

//   Restaurant({
//     this.id,
//     this.restName,
//     this.addressLine1,
//     this.addressLine2,
//     this.addressLine3,
//     this.coverImage,
//   });

//   factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
//         id: json["id"],
//         restName: json["rest_name"],
//         addressLine1: json["address_line_1"],
//         addressLine2: json["address_line_2"],
//         addressLine3: json["address_line_3"],
//         coverImage: json["cover_image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "rest_name": restName,
//         "address_line_1": addressLine1,
//         "address_line_2": addressLine2,
//         "address_line_3": addressLine3,
//         "cover_image": coverImage,
//       };
// }

// <-------------new model below------------------------->

class GetMyOrdersBookingHistory {
  String status;
  int statusCode;
  List<GetMyOrderBookingHistoryList> data;
  // GetMyOrderBookingHistoryList data;

  GetMyOrdersBookingHistory({this.status, this.statusCode, this.data});

  GetMyOrdersBookingHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = new List<GetMyOrderBookingHistoryList>();
      json['data'].forEach((v) {
        data.add(new GetMyOrderBookingHistoryList.fromJson(v));
      });
    }
    // data = json['data'] != null
    //     ? new GetMyOrderBookingHistoryList.fromJson(json['data'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    // if (this.data != null) {
    //   data['data'] = this.data.toJson();
    // }
    return data;
  }
}

class GetMyOrderBookingHistoryList {
  int id;
  String orderType;
  int tableId;
  int userId;
  Null additionalComments;
  int restId;
  String status;
  String cancellationReason;
  String totalAmount;
  String deliveryCharge;
  int splitType;
  String splitAmount;
  Null timeToPickupOrder;
  int waiterId;
  String createdAt;
  String updatedAt;
  String orderNumber;
  bool isRunning;
  Restaurant restaurant;
  List<GetMyOrderBookingList> list;
  List<Splitbilltransactions> splitbilltransactions;
  List<Null> invitation;

  GetMyOrderBookingHistoryList(
      {this.id,
      this.orderType,
      this.tableId,
      this.userId,
      this.additionalComments,
      this.restId,
      this.status,
      this.deliveryCharge,
      this.cancellationReason,
      this.totalAmount,
      this.splitType,
      this.splitAmount,
      this.timeToPickupOrder,
      this.waiterId,
      this.createdAt,
      this.updatedAt,
      this.orderNumber,
      this.isRunning,
      this.restaurant,
      this.list,
      this.splitbilltransactions,
      this.invitation});

  GetMyOrderBookingHistoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderType = json['order_type'];
    tableId = json['table_id'];
    userId = json['user_id'];
    additionalComments = json['additional_comments'];
    restId = json['rest_id'];
    status = json['status'];
    cancellationReason = json['cancellation_reason'];
    totalAmount = json['total_amount'];
    splitType = json['split_type'];
    splitAmount = json['split_amount'];
    timeToPickupOrder = json['time_to_pickup_order'];
    waiterId = json['waiter_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderNumber = json['order_number'];
    isRunning = json['is_running'];
    deliveryCharge = json['delivery_charge'];
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
    if (json['list'] != null) {
      list = new List<GetMyOrderBookingList>();
      json['list'].forEach((v) {
        list.add(new GetMyOrderBookingList.fromJson(v));
      });
    }
    if (json['splitbilltransactions'] != null) {
      splitbilltransactions = new List<Splitbilltransactions>();
      json['splitbilltransactions'].forEach((v) {
        splitbilltransactions.add(new Splitbilltransactions.fromJson(v));
      });
    }
    // if (json['invitation'] != null) {
    //   invitation = new List<Null>();
    //   json['invitation'].forEach((v) {
    //     invitation.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_type'] = this.orderType;
    data['table_id'] = this.tableId;
    data['user_id'] = this.userId;
    data['additional_comments'] = this.additionalComments;
    data['rest_id'] = this.restId;
    data['status'] = this.status;
    data['cancellation_reason'] = this.cancellationReason;
    data['total_amount'] = this.totalAmount;
    data['split_type'] = this.splitType;
    data['split_amount'] = this.splitAmount;
    data['time_to_pickup_order'] = this.timeToPickupOrder;
    data['waiter_id'] = this.waiterId;
    data['delivery_charge'] = this.deliveryCharge;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['order_number'] = this.orderNumber;
    data['is_running'] = this.isRunning;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.toJson();
    }
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    if (this.splitbilltransactions != null) {
      data['splitbilltransactions'] =
          this.splitbilltransactions.map((v) => v.toJson()).toList();
    }
    // if (this.invitation != null) {
    //   data['invitation'] = this.invitation.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Restaurant {
  int id;
  String restName;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String coverImage;

  Restaurant(
      {this.id,
      this.restName,
      this.addressLine1,
      this.addressLine2,
      this.addressLine3,
      this.coverImage});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restName = json['rest_name'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    addressLine3 = json['address_line_3'];
    coverImage = json['cover_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rest_name'] = this.restName;
    data['address_line_1'] = this.addressLine1;
    data['address_line_2'] = this.addressLine2;
    data['address_line_3'] = this.addressLine3;
    data['cover_image'] = this.coverImage;
    return data;
  }
}

class GetMyOrderBookingList {
  int id;
  int quantity;
  int qty;
  String totalAmount;
  String preparationTime;
  String preparationNote;
  int itemId;
  int itemSizePriceId;
  int tableId;
  int orderId;
  int userId;
  int restId;
  int workstationId;
  int waiterId;
  String price;
  String status;
  String sizePrice;
  String createdAt;
  String updatedAt;
  Items items;

  GetMyOrderBookingList(
      {this.id,
      this.quantity,
      this.qty,
      this.preparationTime,
      this.preparationNote,
      this.itemId,
      this.itemSizePriceId,
      this.tableId,
      this.orderId,
      this.userId,
      this.restId,
      this.workstationId,
      this.waiterId,
      this.price,
      this.status,
      this.sizePrice,
      this.createdAt,
      this.updatedAt,
      this.totalAmount,
      this.items});

  GetMyOrderBookingList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    qty = json['qty'];
    totalAmount = json['totalAmount'];
    preparationTime = json['preparation_time'];
    preparationNote = json['preparation_note'];
    itemId = json['item_id'];
    itemSizePriceId = json['item_size_price_id'];
    tableId = json['table_id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    restId = json['rest_id'];
    workstationId = json['workstation_id'];
    waiterId = json['waiter_id'];
    price = json['price'];
    status = json['status'];
    sizePrice = json['size_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    items = json['items'] != null ? new Items.fromJson(json['items']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['qty'] = this.qty;
    data['preparation_time'] = this.preparationTime;
    data['preparation_note'] = this.preparationNote;
    data['item_id'] = this.itemId;
    data['item_size_price_id'] = this.itemSizePriceId;
    data['table_id'] = this.tableId;
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['rest_id'] = this.restId;
    data['workstation_id'] = this.workstationId;
    data['waiter_id'] = this.waiterId;
    data['price'] = this.price;
    data['status'] = this.status;
    data['totalAmount'] = this.totalAmount;
    data['size_price'] = this.sizePrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.items != null) {
      data['items'] = this.items.toJson();
    }
    return data;
  }
}

class Items {
  int id;
  String itemName;
  String price;
  String itemDescription;
  String menuType;
  String extrasrequired;
  String spreadsrequired;
  String switchesrequired;
  String defaultPreparationTime;
  String itemCode;
  String itemImage;
  int workstationId;
  String createdAt;
  String updatedAt;

  Items(
      {this.id,
      this.itemName,
      this.price,
      this.itemDescription,
      this.menuType,
      this.extrasrequired,
      this.spreadsrequired,
      this.switchesrequired,
      this.defaultPreparationTime,
      this.itemCode,
      this.itemImage,
      this.workstationId,
      this.createdAt,
      this.updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    price = json['price'];
    itemDescription = json['item_description'];
    menuType = json['menu_type'];
    extrasrequired = json['extrasrequired'];
    spreadsrequired = json['spreadsrequired'];
    switchesrequired = json['switchesrequired'];
    defaultPreparationTime = json['default_preparation_time'];
    itemCode = json['item_code'];
    itemImage = json['item_image'];
    workstationId = json['workstation_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_name'] = this.itemName;
    data['price'] = this.price;
    data['item_description'] = this.itemDescription;
    data['menu_type'] = this.menuType;
    data['extrasrequired'] = this.extrasrequired;
    data['spreadsrequired'] = this.spreadsrequired;
    data['switchesrequired'] = this.switchesrequired;
    data['default_preparation_time'] = this.defaultPreparationTime;
    data['item_code'] = this.itemCode;
    data['item_image'] = this.itemImage;
    data['workstation_id'] = this.workstationId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Splitbilltransactions {
  int id;
  String amount;
  String paystatus;
  int orderId;
  int restId;
  int userId;
  String createdAt;
  String updatedAt;

  Splitbilltransactions(
      {this.id,
      this.amount,
      this.paystatus,
      this.orderId,
      this.restId,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Splitbilltransactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    paystatus = json['paystatus'];
    orderId = json['order_id'];
    restId = json['rest_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['paystatus'] = this.paystatus;
    data['order_id'] = this.orderId;
    data['rest_id'] = this.restId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
