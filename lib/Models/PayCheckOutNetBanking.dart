import 'dart:convert';

PaycheckoutNetbanking paycheckoutNetbankingFromJson(String str) =>
    PaycheckoutNetbanking.fromJson(json.decode(str));

String paycheckoutNetbankingToJson(PaycheckoutNetbanking data) =>
    json.encode(data.toJson());

class PaycheckoutNetbanking {
  String status;
  int statusCode;
  Data data;
  String encryptedCheckoutId;
  String url;

  PaycheckoutNetbanking({
    this.status,
    this.statusCode,
    this.data,
    this.encryptedCheckoutId,
    this.url,
  });

  factory PaycheckoutNetbanking.fromJson(Map<String, dynamic> json) =>
      PaycheckoutNetbanking(
        status: json["status"],
        statusCode: json["status_code"],
        data: Data.fromJson(json["data"]),
        encryptedCheckoutId: json["encrypted_checkout_id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": data.toJson(),
        "encrypted_checkout_id": encryptedCheckoutId,
        "url": url,
      };
}

class Data {
  Result result;
  String buildNumber;
  String timestamp;
  String ndc;
  String id;

  Data({
    this.result,
    this.buildNumber,
    this.timestamp,
    this.ndc,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: Result.fromJson(json["result"]),
        buildNumber: json["buildNumber"],
        timestamp: json["timestamp"],
        ndc: json["ndc"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
        "buildNumber": buildNumber,
        "timestamp": timestamp,
        "ndc": ndc,
        "id": id,
      };
}

class Result {
  String code;
  String description;

  Result({
    this.code,
    this.description,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
      };
}
