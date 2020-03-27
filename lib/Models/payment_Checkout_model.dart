import 'dart:convert';

PaymentCheckoutModel paymentCheckoutModelFromJson(String str) =>
    PaymentCheckoutModel.fromJson(json.decode(str));

String paymentCheckoutModelToJson(PaymentCheckoutModel data) =>
    json.encode(data.toJson());

class PaymentCheckoutModel {
  String status;
  int statusCode;
  Data data;
  String transactionId;

  PaymentCheckoutModel({
    this.status,
    this.statusCode,
    this.data,
    this.transactionId,
  });

  factory PaymentCheckoutModel.fromJson(Map<String, dynamic> json) =>
      PaymentCheckoutModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: Data.fromJson(json["data"]),
        transactionId: json["transaction_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": data.toJson(),
        "transaction_id": transactionId,
      };
}

class Data {
  String id;
  String paymentType;
  String paymentBrand;
  String amount;
  String currency;
  String descriptor;
  Result result;
  Cards card;
  Customer customer;
  CustomParameters customParameters;
  String buildNumber;
  String timestamp;
  String ndc;

  Data({
    this.id,
    this.paymentType,
    this.paymentBrand,
    this.amount,
    this.currency,
    this.descriptor,
    this.result,
    this.card,
    this.customer,
    this.customParameters,
    this.buildNumber,
    this.timestamp,
    this.ndc,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        paymentType: json["paymentType"],
        paymentBrand: json["paymentBrand"],
        amount: json["amount"],
        currency: json["currency"],
        descriptor: json["descriptor"],
        result: Result.fromJson(json["result"]),
        card: Cards.fromJson(json["card"]),
        customer: Customer.fromJson(json["customer"]),
        customParameters: CustomParameters.fromJson(json["customParameters"]),
        buildNumber: json["buildNumber"],
        timestamp: json["timestamp"],
        ndc: json["ndc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "paymentType": paymentType,
        "paymentBrand": paymentBrand,
        "amount": amount,
        "currency": currency,
        "descriptor": descriptor,
        "result": result.toJson(),
        "card": card.toJson(),
        "customer": customer.toJson(),
        "customParameters": customParameters.toJson(),
        "buildNumber": buildNumber,
        "timestamp": timestamp,
        "ndc": ndc,
      };
}

class Cards {
  String bin;
  String binCountry;
  String last4Digits;
  String expiryMonth;
  String expiryYear;

  Cards({
    this.bin,
    this.binCountry,
    this.last4Digits,
    this.expiryMonth,
    this.expiryYear,
  });

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
        bin: json["bin"],
        binCountry: json["binCountry"],
        last4Digits: json["last4Digits"],
        expiryMonth: json["expiryMonth"],
        expiryYear: json["expiryYear"],
      );

  Map<String, dynamic> toJson() => {
        "bin": bin,
        "binCountry": binCountry,
        "last4Digits": last4Digits,
        "expiryMonth": expiryMonth,
        "expiryYear": expiryYear,
      };
}

class CustomParameters {
  String shopperEndToEndIdentity;
  String ctpeDescriptorTemplate;

  CustomParameters({
    this.shopperEndToEndIdentity,
    this.ctpeDescriptorTemplate,
  });

  factory CustomParameters.fromJson(Map<String, dynamic> json) =>
      CustomParameters(
        shopperEndToEndIdentity: json["SHOPPER_EndToEndIdentity"],
        ctpeDescriptorTemplate: json["CTPE_DESCRIPTOR_TEMPLATE"],
      );

  Map<String, dynamic> toJson() => {
        "SHOPPER_EndToEndIdentity": shopperEndToEndIdentity,
        "CTPE_DESCRIPTOR_TEMPLATE": ctpeDescriptorTemplate,
      };
}

class Customer {
  String ip;
  String ipCountry;

  Customer({
    this.ip,
    this.ipCountry,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        ip: json["ip"],
        ipCountry: json["ipCountry"],
      );

  Map<String, dynamic> toJson() => {
        "ip": ip,
        "ipCountry": ipCountry,
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
