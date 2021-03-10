import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/specialty_model.dart';
import 'package:http/http.dart' as http;

abstract class ISpecialtyRepo {
  Future<List<SpecialtyModel>> getAllSpecialty();
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
}
