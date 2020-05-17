class CategoryListModel {
  String status;
  int statusCode;
  List<CategoryItems> data;

  CategoryListModel({this.status, this.statusCode, this.data});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = new List<CategoryItems>();
      json['data'].forEach((v) {
        data.add(new CategoryItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryItems {
  int id;
  String restName;
  String addressLine1;
  Null addressLine2;
  Null addressLine3;
  String countryCode;
  String contactNumber;
  String coverImage;
  String logo;
  String currency;
  String latitude;
  String longitude;
  String openingTime;
  String closingTime;
  String colourCode;
  int countryId;
  int stateId;
  int cityId;
  int userId;
  Null submanagerId;
  String status;
  String selected;
  int createdBy;
  int updatedBy;
  Null deletedAt;
  String createdAt;
  String updatedAt;
  List<Category> category;

  CategoryItems(
      {this.id,
      this.restName,
      this.addressLine1,
      this.addressLine2,
      this.addressLine3,
      this.countryCode,
      this.contactNumber,
      this.coverImage,
      this.logo,
      this.currency,
      this.latitude,
      this.longitude,
      this.openingTime,
      this.closingTime,
      this.colourCode,
      this.countryId,
      this.stateId,
      this.cityId,
      this.userId,
      this.submanagerId,
      this.status,
      this.selected,
      this.createdBy,
      this.updatedBy,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.category});

  CategoryItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restName = json['rest_name'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    addressLine3 = json['address_line_3'];
    countryCode = json['country_code'];
    contactNumber = json['contact_number'];
    coverImage = json['cover_image'];
    logo = json['logo'];
    currency = json['currency'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    colourCode = json['colour_code'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    userId = json['user_id'];
    submanagerId = json['submanager_id'];
    status = json['status'];
    selected = json['selected'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['category'] != null) {
      category = new List<Category>();
      json['category'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rest_name'] = this.restName;
    data['address_line_1'] = this.addressLine1;
    data['address_line_2'] = this.addressLine2;
    data['address_line_3'] = this.addressLine3;
    data['country_code'] = this.countryCode;
    data['contact_number'] = this.contactNumber;
    data['cover_image'] = this.coverImage;
    data['logo'] = this.logo;
    data['currency'] = this.currency;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    data['colour_code'] = this.colourCode;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['user_id'] = this.userId;
    data['submanager_id'] = this.submanagerId;
    data['status'] = this.status;
    data['selected'] = this.selected;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int id;
  String name;
  String createdAt;
  String updatedAt;
  Pivot pivot;
  List<Subcategories> subcategories;

  Category(
      {this.id,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.pivot,
      this.subcategories});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    if (json['subcategories'] != null) {
      subcategories = new List<Subcategories>();
      json['subcategories'].forEach((v) {
        subcategories.add(new Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pivot {
  int restId;
  int categoryId;

  Pivot({this.restId, this.categoryId});

  Pivot.fromJson(Map<String, dynamic> json) {
    restId = json['rest_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rest_id'] = this.restId;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class Subcategories {
  int id;
  String name;
  String createdAt;
  String updatedAt;
  Pivot pivot;

  Subcategories(
      {this.id, this.name, this.createdAt, this.updatedAt, this.pivot});

  Subcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class SubCategoryPivot {
  int categoryId;
  int subcategoryId;

  SubCategoryPivot({this.categoryId, this.subcategoryId});

  SubCategoryPivot.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    return data;
  }
}

// import 'dart:convert';

// CategoryListModel categoryListModelFromJson(String str) =>
//     CategoryListModel.fromJson(json.decode(str));

// String categoryListModelToJson(CategoryListModel data) =>
//     json.encode(data.toJson());

// class CategoryListModel {
//   String status;
//   int statusCode;
//   List<CategoryItems> data;
//   int allCount;

//   CategoryListModel({
//     this.status,
//     this.statusCode,
//     this.data,
//     this.allCount,
//   });

//   factory CategoryListModel.fromJson(Map<String, dynamic> json) =>
//       CategoryListModel(
//           status: json["status"],
//           statusCode: json["status_code"],
//           data: List<CategoryItems>.from(
//               json["data"].map((x) => CategoryItems.fromJson(x))),
//           allCount: json["all_count"]);

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "status_code": statusCode,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "all_count": allCount
//       };
// }

// class CategoryItems {
//   int id;
//   int workstationId;
//   String name;
//   int restId;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int menuCount;
//   List<Item> items;

//   CategoryItems({
//     this.id,
//     this.workstationId,
//     this.name,
//     this.restId,
//     this.createdAt,
//     this.updatedAt,
//     this.menuCount,
//     this.items,
//   });

//   factory CategoryItems.fromJson(Map<String, dynamic> json) => CategoryItems(
//         id: json["id"],
//         workstationId: json["workstation_id"],
//         name: json["name"],
//         restId: json["rest_id"],
//         createdAt: json["created_at"] != null
//             ? DateTime.parse(json["created_at"])
//             : null,
//         updatedAt: json["created_at"] != null
//             ? DateTime.parse(json["updated_at"])
//             : null,
//         menuCount: json["menu_count"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "workstation_id": workstationId,
//         "name": name,
//         "rest_id": restId,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "menu_count": menuCount,
//         "items": List<dynamic>.from(items.map((x) => x.toJson())),
//       };
// }

// class Item {
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
//   Pivot pivot;

//   Item({
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
//     this.pivot,
//   });

//   factory Item.fromJson(Map<String, dynamic> json) => Item(
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
//         pivot: Pivot.fromJson(json["pivot"]),
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
//         "pivot": pivot.toJson(),
//       };
// }

// class Pivot {
//   int categoryId;
//   int itemId;

//   Pivot({
//     this.categoryId,
//     this.itemId,
//   });

//   factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
//         categoryId: json["category_id"],
//         itemId: json["item_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "category_id": categoryId,
//         "item_id": itemId,
//       };
// }
