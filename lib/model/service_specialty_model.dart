class ServiceSpecialtyModel {
  final int serviceId, specialtyId;
  final String serviceName, serviceDescription, serviceImage;
  final double servicePrice;
  final bool disabled, isDefault;

  ServiceSpecialtyModel(
      {this.disabled,
      this.serviceDescription,
      this.serviceId,
      this.serviceName,
      this.servicePrice,
      this.specialtyId,
      this.serviceImage,
      this.isDefault});

  factory ServiceSpecialtyModel.fromJson(Map<String, dynamic> json) {
    return ServiceSpecialtyModel(
      serviceId: json['id'] as int,
      serviceName: json['name'] as String,
      serviceDescription: json['description'] as String,
      serviceImage: json['image'] as String,
      specialtyId: json['specialtyId'] as int,
      servicePrice: json['price'] as double,
      disabled: json['disabled'] as bool,
      isDefault: json['isDefault'] as bool,
    );
  }
}
