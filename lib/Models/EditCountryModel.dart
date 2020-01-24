// import 'dart:convert';

// // Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

// // String welcomeToJson(Welcome data) => json.encode(data.toJson());

// class EditCountryModel {
//     String status;
//     int statusCode;
//     List<CountryList> data;

//     EditCountryModel({
//         this.status,
//         this.statusCode,
//         this.data,
//     });

//     factory EditCountryModel.fromJson(Map<String, dynamic> json) => EditCountryModel(
//         status: json["status"],
//         statusCode: json["status_code"],
//         data: List<CountryList>.from(json["data"].map((x)=>CountryList.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "status_code": statusCode,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class CountryList {
//     int id;
//     String name;

//     CountryList({
//         this.id,
//         this.name,
//     });

//     factory CountryList.fromJson(Map<String, dynamic> json) => CountryList(
//         id: json["id"],
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//     };
// }
import 'dart:convert';

class EditCountryModel {
    String status;
    int statusCode;
    List<CountryList> data;

  EditCountryModel({
    this.status,
    this.statusCode,
    this.data,
  });

  factory EditCountryModel.fromJson(Map<String, dynamic> json) =>
      EditCountryModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<CountryList>.from(json["data"].map((x) => CountryList.fromJson(x))),
    );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class CountryList {
    int id;
    String name;

    CountryList({
        this.id,
        this.name,
    });

    factory CountryList.fromJson(Map<String, dynamic> json) => CountryList(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
