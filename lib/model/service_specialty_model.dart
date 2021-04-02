class ServiceSpecialtyModel {
  final int serviceId, specialtyId;
  final String serviceName, serviceDescription, serviceImage;
  final double servicePrice;
  final bool disabled;

  ServiceSpecialtyModel(
      {this.disabled,
      this.serviceDescription,
      this.serviceId,
      this.serviceName,
      this.servicePrice,
      this.specialtyId,
      this.serviceImage});

  factory ServiceSpecialtyModel.fromJson(Map<String, dynamic> json) {
    return ServiceSpecialtyModel(
      serviceId: json['serviceId'] as int,
      serviceName: json['serviceName'] as String,
      serviceDescription: json['serviceDescription'] as String,
      serviceImage: json['image'] as String,
      specialtyId: json['specialtyId'] as int,
      servicePrice: json['servicePrice'] as double,
      disabled: json['disabled'] as bool,
    );
  }
}
