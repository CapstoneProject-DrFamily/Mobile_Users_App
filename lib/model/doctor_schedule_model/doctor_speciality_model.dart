class DoctorSpecialtyModel {
  int specialtyId;
  String name, image, description;

  DoctorSpecialtyModel({
    this.specialtyId,
    this.name,
    this.image,
    this.description,
  });

  factory DoctorSpecialtyModel.fromJson(Map<String, dynamic> json) {
    return DoctorSpecialtyModel(
      specialtyId: json['specialtyId'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "specialtyId": this.specialtyId,
        "name": this.name,
        "image": this.image,
        "description": this.description,
      };
}
