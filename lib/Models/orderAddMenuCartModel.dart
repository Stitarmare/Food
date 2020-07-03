class OrderAddMenuModel {
  String status;
  int statusCode;
  String message;
  OrderAddMenuData data;
  String totalAmount;
  String colourCode;

  OrderAddMenuModel(
      {this.status,
      this.statusCode,
      this.message,
      this.data,
      this.totalAmount,
      this.colourCode});

  OrderAddMenuModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null
        ? new OrderAddMenuData.fromJson(json['data'])
        : null;
    totalAmount = json['totalAmount'];
    colourCode = json['colour_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['totalAmount'] = this.totalAmount;
    data['colour_code'] = this.colourCode;
    return data;
  }
}

class OrderAddMenuData {
  int userId;
  int restId;
  int tableId;
  int itemId;
  int quantity;
  String preparationTime;
  String preparationNote;
  int workstationId;
  String price;
  String updatedAt;
  String createdAt;
  int id;

  OrderAddMenuData(
      {this.userId,
      this.restId,
      this.tableId,
      this.itemId,
      this.quantity,
      this.preparationTime,
      this.preparationNote,
      this.workstationId,
      this.price,
      this.updatedAt,
      this.createdAt,
      this.id});

  OrderAddMenuData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    restId = json['rest_id'];
    tableId = json['table_id'];
    itemId = json['item_id'];
    quantity = json['quantity'];
    preparationTime = json['preparation_time'];
    preparationNote = json['preparation_note'];
    workstationId = json['workstation_id'];
    price = json['price'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['rest_id'] = this.restId;
    data['table_id'] = this.tableId;
    data['item_id'] = this.itemId;
    data['quantity'] = this.quantity;
    data['preparation_time'] = this.preparationTime;
    data['preparation_note'] = this.preparationNote;
    data['workstation_id'] = this.workstationId;
    data['price'] = this.price;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
