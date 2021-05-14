import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/service_specialty_model.dart';
import 'package:drFamily_app/model/specialty_model.dart';
import 'package:drFamily_app/model/specialty_service_model.dart';
import 'package:http/http.dart' as http;

abstract class ISpecialtyRepo {
  Future<List<SpecialtyModel>> getAllSpecialty();
  Future<List<SpecialtyServiceModel>> getAll();
}

class SpecialtyRepo extends ISpecialtyRepo {
  @override
  Future<List<SpecialtyModel>> getAllSpecialty() async {
    String urlAPI = APIHelper.SPECIALTY_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);

    List<SpecialtyModel> listSpecialty;

    print(response.statusCode);

    if (response.statusCode == 200) {
      listSpecialty = (json.decode(response.body) as List)
          .map((data) => SpecialtyModel.fromJson(data))
          .toList();
      return listSpecialty;
    } else
      return null;
  }

  @override
  Future<List<SpecialtyServiceModel>> getAll() async {
    String urlAPI = APIHelper.SPECIALTY_API;

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);

    List<SpecialtyServiceModel> listSpecialty = [];

    print(response.statusCode);

    if (response.statusCode == 200) {
      var list = (json.decode(response.body) as List);
      for (int i = 0; i < list.length; i++) {
        var specialtyId = list[i]['id'];
        var name = list[i]['name'];
        var image = list[i]['image'];
        var description = list[i]['description'];
        List<ServiceSpecialtyModel> services = (list[i]['services'] as List)
            .map((data) => ServiceSpecialtyModel.fromJson(data))
            .toList();
        SpecialtyServiceModel model = SpecialtyServiceModel(
            name: name,
            description: description,
            image: image,
            listService: services,
            specialtyId: specialtyId);
        listSpecialty.add(model);
      }
      return listSpecialty;
    } else
      return null;
  }
}
