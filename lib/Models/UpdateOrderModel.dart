

import 'package:foodzi/Models/AddMenuToCartModel.dart';

//import 'MenuCartDisplayModel.dart';

class UpdateOrderModel {
    int orderId;
    int userId;
    Item items;

    UpdateOrderModel({
        this.orderId,
        this.userId,
        this.items,
    });

    factory UpdateOrderModel.fromJson(Map<String, dynamic> json) => UpdateOrderModel(
        orderId: json["order_id"],
        userId:json["user_id"],
        items: Item.fromJson(json["items"]),
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "user_id" :userId,
        "items": items.toJson(),
    };
}

