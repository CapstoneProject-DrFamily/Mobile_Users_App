import 'package:drFamily_app/model/service_specialty_model.dart';

class SpecialtyServiceModel {
  final int specialtyId;
  final String name, image, description;
  final List<ServiceSpecialtyModel> listService;

  SpecialtyServiceModel(
      {this.description,
      this.image,
      this.listService,
      this.name,
      this.specialtyId});

  factory SpecialtyServiceModel.fromJson(Map<String, dynamic> json) {
    return SpecialtyServiceModel(
      specialtyId: json['specialtyId'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      listService: json['services'] as List,
    );
  }
}
