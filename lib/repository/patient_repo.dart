import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/dependent_model.dart';
import 'package:http/http.dart' as http;

abstract class IPatientRepo {
  Future<List<DependentModel>> getDependent(int accountID);
  Future<String> getPatientLocation(int patientId);
  Future<String> getPatientName(int patientId);
}

class PatientRepo extends IPatientRepo {
  @override
  Future<List<DependentModel>> getDependent(int accountID) async {
    String urlAPI = APIHelper.URI_PREFIX_API;
    print("in" + accountID.toString());
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var uri = Uri.http(urlAPI, "/api/v1/Patients/$accountID/Dependents");
    var response = await http.get(uri, headers: header);
    print(response.statusCode);

    List<DependentModel> listDependent;

    if (response.statusCode == 200) {
      listDependent = (json.decode(response.body) as List)
          .map((data) => DependentModel.fromJson(data))
          .toList();
      return listDependent;
    } else
      return null;
  }

  @override
  Future<String> getPatientLocation(int patientId) async {
    String urlAPI = APIHelper.PATIENT_API + '/$patientId';
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var response = await http.get(urlAPI, headers: header);
    print(response.statusCode);

    if (response.statusCode == 200) {
      String location = json.decode(response.body)['location'];
      return location;
    } else
      return null;
  }

  @override
  Future<String> getPatientName(int patientId) async {
    String urlAPI = APIHelper.PATIENT_API + '/$patientId';
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var response = await http.get(urlAPI, headers: header);
    print(response.statusCode);

    if (response.statusCode == 200) {
      String name = json.decode(response.body)['patientNavigation']['fullName'];
      return name;
    } else
      return null;
  }
}
