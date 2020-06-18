class GetDeliveryChargeModel {
  String status;
  int statusCode;
  DeliveryData data;
  GetDeliveryChargeModel({this.status, this.statusCode, this.data});
  GetDeliveryChargeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    data =
        json['data'] != null ? new DeliveryData.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DeliveryData {
  double distance;
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
