import 'dart:convert';

class EditCityModel {
    String status;
    int statusCode;
    List<CityList> data;

    EditCityModel({
        this.status,
        this.statusCode,
        this.data,
    });

    factory EditCityModel.fromJson(Map<String, dynamic> json) => EditCityModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<CityList>.from(json["data"].map((x) => CityList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class CityList {
    int id;
    String name;
    StateCode stateCode;
    CountryCode countryCode;
    int flag;
    String latitude;
    String longitude;
    String wikiDataId;
    int stateId;
    int countryId;
    DateTime createdAt;
    DateTime updatedAt;

    CityList({
        this.id,
        this.name,
        this.stateCode,
        this.countryCode,
        this.flag,
        this.latitude,
        this.longitude,
        this.wikiDataId,
        this.stateId,
        this.countryId,
        this.createdAt,
        this.updatedAt,
    });

    factory CityList.fromJson(Map<String, dynamic> json) => CityList(
        id: json["id"],
        name: json["name"],
        stateCode: stateCodeValues.map[json["state_code"]],
        countryCode: countryCodeValues.map[json["country_code"]],
        flag: json["flag"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        wikiDataId: json["wikiDataId"],
        stateId: json["state_id"],
        countryId: json["country_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_code": stateCodeValues.reverse[stateCode],
        "country_code": countryCodeValues.reverse[countryCode],
        "flag": flag,
        "latitude": latitude,
        "longitude": longitude,
        "wikiDataId": wikiDataId,
        "state_id": stateId,
        "country_id": countryId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

enum CountryCode { ZA }

final countryCodeValues = EnumValues({
    "ZA": CountryCode.ZA
});

enum StateCode { FS }

final stateCodeValues = EnumValues({
    "FS": StateCode.FS
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}