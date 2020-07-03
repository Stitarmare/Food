import 'package:foodzi/Models/AddMenuToCartModel.dart';

class UpdateOrderModel {
  int restId;
  int orderId;
  int userId;
  List<Item> items;

  UpdateOrderModel({
    this.restId,
    this.orderId,
    this.userId,
    this.items,
  });

  factory UpdateOrderModel.fromJson(Map<String, dynamic> json) =>
      UpdateOrderModel(
        restId: json["rest_id"],
        orderId: json["order_id"],
        userId: json["user_id"],
        // items: Item.fromJson(json["items"]
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "rest_id": restId,
        "order_id": orderId,
        "user_id": userId,
        // "items": items.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson()))
      };
}
