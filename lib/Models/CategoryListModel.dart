import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) =>
    CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) =>
    json.encode(data.toJson());

class CategoryListModel {
  String status;
  int statusCode;
  List<CategoryItems> data;
  int allCount;

  CategoryListModel({
    this.status,
    this.statusCode,
    this.data,
    this.allCount,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic> json) =>
      CategoryListModel(
          status: json["status"],
          statusCode: json["status_code"],
          data: List<CategoryItems>.from(
              json["data"].map((x) => CategoryItems.fromJson(x))),
          allCount: json["all_count"]);

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "all_count": allCount
      };
}

class CategoryItems {
  int id;
  int workstationId;
  String name;
  int restId;
  DateTime createdAt;
  DateTime updatedAt;
  int menuCount;
  List<Item> items;

  CategoryItems({
    this.id,
    this.workstationId,
    this.name,
    this.restId,
    this.createdAt,
    this.updatedAt,
    this.menuCount,
    this.items,
  });

  factory CategoryItems.fromJson(Map<String, dynamic> json) => CategoryItems(
        id: json["id"],
        workstationId: json["workstation_id"],
        name: json["name"],
        restId: json["rest_id"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["created_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        menuCount: json["menu_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workstation_id": workstationId,
        "name": name,
        "rest_id": restId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "menu_count": menuCount,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
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
  Pivot pivot;

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
    this.pivot,
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
        pivot: Pivot.fromJson(json["pivot"]),
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
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  int categoryId;
  int itemId;

  Pivot({
    this.categoryId,
    this.itemId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        categoryId: json["category_id"],
        itemId: json["item_id"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "item_id": itemId,
      };
}
