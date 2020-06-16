class GetDeliveryChargeModel {
  String status;
  String message;
  DeliveryData data;

  GetDeliveryChargeModel({this.status, this.message, this.data});

  GetDeliveryChargeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? new DeliveryData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DeliveryData {
  int distance;
  int deliveryCharge;

  DeliveryData({this.distance, this.deliveryCharge});

  DeliveryData.fromJson(Map<String, dynamic> json) {
    distance = json['distance'];
    deliveryCharge = json['delivery_charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance;
    data['delivery_charge'] = this.deliveryCharge;
    return data;
  }
}
