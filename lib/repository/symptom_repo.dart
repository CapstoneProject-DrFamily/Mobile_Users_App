import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/home/find_doctor/symptom_model.dart';
import 'package:http/http.dart' as http;

abstract class ISymptomRepo {
  Future<List<SymptomModel>> getAllSymptom();
}

class SymptomRepo extends ISymptomRepo {
  @override
  Future<List<SymptomModel>> getAllSymptom() async {
    String urlAPI = APIHelper.SYMPTOM_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);

    List<SymptomModel> listSymptom;

    if (response.statusCode == 200) {
      listSymptom = (json.decode(response.body) as List)
          .map((data) => SymptomModel.fromJson(data))
          .toList();
      return listSymptom;
    } else
      return null;
  }
}
