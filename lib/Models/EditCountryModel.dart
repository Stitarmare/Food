import 'dart:convert';

// Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

// String welcomeToJson(Welcome data) => json.encode(data.toJson());

class EditCountryModel {
    String status;
    int statusCode;
    Data data;

    EditCountryModel({
        this.status,
        this.statusCode,
        this.data,
    });

    factory EditCountryModel.fromJson(Map<String, dynamic> json) => EditCountryModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    String name;

    Data({
        this.id,
        this.name,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}