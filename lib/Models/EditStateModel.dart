import 'dart:convert';

class EditStateModel {
    String status;
    int statusCode;
    List<StateList> data;

    EditStateModel({
        this.status,
        this.statusCode,
        this.data,
    });

    factory EditStateModel.fromJson(Map<String, dynamic> json) => EditStateModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<StateList>.from(json["data"].map((x) => StateList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class StateList {
    int id;
    String name;
    String countryCode;
    String fipsCode;
    String iso2;
    int flag;
    String wikiDataId;
    int countryId;
    DateTime createdAt;
    DateTime updatedAt;

    StateList({
        this.id,
        this.name,
        this.countryCode,
        this.fipsCode,
        this.iso2,
        this.flag,
        this.wikiDataId,
        this.countryId,
        this.createdAt,
        this.updatedAt,
    });

    factory StateList.fromJson(Map<String, dynamic> json) => StateList(
        id: json["id"],
        name: json["name"],
        countryCode: json["country_code"],
        fipsCode: json["fips_code"],
        iso2: json["iso2"],
        flag: json["flag"],
        wikiDataId: json["wikiDataId"],
        countryId: json["country_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_code": countryCode,
        "fips_code": fipsCode,
        "iso2": iso2,
        "flag": flag,
        "wikiDataId": wikiDataId,
        "country_id": countryId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
