class ServiceModel {
  int serviceId;
  double servicePrice;
  String serviceName, serviceDescription;
  bool isDefault;

  ServiceModel(
      {this.serviceId,
      this.servicePrice,
      this.serviceName,
      this.serviceDescription,
      isDefault});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
        serviceId: json['serviceId'] as int,
        servicePrice: json['servicePrice'] as double,
        serviceName: json['serviceName'] as String,
        serviceDescription: json['serviceDescription'] as String,
        isDefault: json['isDefault'] as bool);
  }

  Map<String, dynamic> toJson() => {
        "serviceId": serviceId,
        "servicePrice": servicePrice,
        "serviceName": serviceName,
        "serviceDescription": serviceDescription,
      };
}
