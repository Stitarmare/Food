import 'dart:convert';

RestaurantItemsModel restaurantItemsModelFromJson(String str) => RestaurantItemsModel.fromJson(json.decode(str));

String restaurantItemsModelToJson(RestaurantItemsModel data) => json.encode(data.toJson());

class RestaurantItemsModel {
    String status;
    int statusCode;
    int page;
    int totalPages;
    List<RestaurantMenuItem> data;
    String colourCode;
    String currencySymbol;
    String restImage;

    RestaurantItemsModel({
        this.status,
        this.statusCode,
        this.page,
        this.totalPages,
        this.data,
        this.colourCode,
        this.currencySymbol,
        this.restImage,
    });

    factory RestaurantItemsModel.fromJson(Map<String, dynamic> json) => RestaurantItemsModel(
        status: json["status"],
        statusCode: json["status_code"],
        page: json["page"],
        totalPages: json["totalPages"],
        data: List<RestaurantMenuItem>.from(json["data"].map((x) => RestaurantMenuItem.fromJson(x))),
        colourCode: json["colour_code"],
        currencySymbol: json["currency_symbol"],
        restImage: json["rest_image"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "page": page,
        "totalPages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "colour_code": colourCode,
        "currency_symbol": currencySymbol,
        "rest_image": restImage,
    };
}

class RestaurantMenuItem {
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
    DateTime createdAt;
    DateTime updatedAt;
    List<dynamic> sizePrizes;
    int restId;

    RestaurantMenuItem({
        this.id,
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
        this.updatedAt,
        this.sizePrizes,
        this.restId,
    });

    factory RestaurantMenuItem.fromJson(Map<String, dynamic> json) => RestaurantMenuItem(
        id: json["id"],
        itemName: json["item_name"],
        price: json["price"],
        itemDescription: json["item_description"],
        menuType: json["menu_type"],
        extrasrequired: json["extrasrequired"],
        spreadsrequired: json["spreadsrequired"],
        switchesrequired: json["switchesrequired"],
        defaultPreparationTime: json["default_preparation_time"],
        itemCode: json["item_code"],
        itemImage: json["item_image"],
        workstationId: json["workstation_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sizePrizes: List<dynamic>.from(json["size_prizes"].map((x) => x)),
        restId: json["rest_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "price": price,
        "item_description": itemDescription,
        "menu_type": menuType,
        "extrasrequired": extrasrequired,
        "spreadsrequired": spreadsrequired,
        "switchesrequired": switchesrequired,
        "default_preparation_time": defaultPreparationTime,
        "item_code": itemCode,
        "item_image": itemImage,
        "workstation_id": workstationId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "size_prizes": List<dynamic>.from(sizePrizes.map((x) => x)),
        "rest_id": restId,
    };
}
