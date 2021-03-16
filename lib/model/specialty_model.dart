class SpecialtyModel {
  int specialtyId, serviceId;
  String specialtyImage, specialtyTitle, specialtyDes;
  double servicePrice;

  SpecialtyModel(
      {this.specialtyId,
      this.specialtyImage,
      this.specialtyTitle,
      this.specialtyDes,
      this.serviceId,
      this.servicePrice});

  factory SpecialtyModel.fromJson(Map<String, dynamic> json) {
    return SpecialtyModel(
      specialtyId: json['specialtyId'] as int,
      specialtyImage: json['image'] as String,
      specialtyTitle: json['name'] as String,
      specialtyDes: json['description'] as String,
      serviceId: json['services'][0]['serviceId'] as int,
      servicePrice: json['services'][0]['servicePrice'] as double,
    );
  }
}
