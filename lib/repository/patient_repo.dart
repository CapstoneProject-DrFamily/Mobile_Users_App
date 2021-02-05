import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/dependent_model.dart';
import 'package:http/http.dart' as http;

abstract class IPatientRepo {
  Future<List<DependentModel>> getDependent(int accountID);
}

class PatientRepo extends IPatientRepo {
  @override
  Future<List<DependentModel>> getDependent(int accountID) async {
    String urlAPI = APIHelper.URI_PREFIX_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var uri = Uri.http(urlAPI, "/api/Patients/$accountID/Depdent");
    var response = await http.get(uri, headers: header);

    List<DependentModel> listDependent;

    if (response.statusCode == 200) {
      listDependent = (json.decode(response.body) as List)
          .map((data) => DependentModel.fromJson(data))
          .toList();
      return listDependent;
    } else
      return null;
  }
}
