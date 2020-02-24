import 'dart:convert';

class GetTableListModel {
  String status;
  int statusCode;
  List<GetTableList> data;

  GetTableListModel({
    this.status,
    this.statusCode,
    this.data,
  });

  factory GetTableListModel.fromJson(Map<String, dynamic> json) =>
      GetTableListModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<GetTableList>.from(
            json["data"].map((x) => GetTableList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetTableList {
  int id;
  String tableName;
  int restId;
  DateTime createdAt;
  DateTime updatedAt;

  GetTableList({
    this.id,
    this.tableName,
    this.restId,
    this.createdAt,
    this.updatedAt,
  });

  factory GetTableList.fromJson(Map<String, dynamic> json) => GetTableList(
        id: json["id"],
        tableName: json["table_name"],
        restId: json["rest_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "table_name": tableName,
        "rest_id": restId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
