// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);


class FaqModel {
    FaqModel({
        this.status,
        this.statusCode,
        this.data,
    });

    String status;
    int statusCode;
    List<FaqModelDatum> data;

    factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<FaqModelDatum>.from(json["data"].map((x) => FaqModelDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class FaqModelDatum {
    FaqModelDatum({
        this.title,
        this.data,
    });

    String title;
    List<DatumDatum> data;

    factory FaqModelDatum.fromJson(Map<String, dynamic> json) => FaqModelDatum(
        title: json["title"],
        data: List<DatumDatum>.from(json["data"].map((x) => DatumDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DatumDatum {
    DatumDatum({
        this.que,
        this.ans,
    });

    String que;
    String ans;
    bool isSelected = false;

    factory DatumDatum.fromJson(Map<String, dynamic> json) => DatumDatum(
        que: json["Que"],
        ans: json["Ans"],
    );

    Map<String, dynamic> toJson() => {
        "Que": que,
        "Ans": ans,
    };
}
