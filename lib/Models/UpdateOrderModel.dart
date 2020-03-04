

import 'package:foodzi/Models/AddMenuToCartModel.dart';

//import 'MenuCartDisplayModel.dart';

class UpdateOrderModel {
    int orderId;
    Item items;

    UpdateOrderModel({
        this.orderId,
        this.items,
    });

    factory UpdateOrderModel.fromJson(Map<String, dynamic> json) => UpdateOrderModel(
        orderId: json["order_id"],
        items: Item.fromJson(json["items"]),
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "items": items.toJson(),
    };
}

