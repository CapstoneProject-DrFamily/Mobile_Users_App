import 'dart:convert';
import 'dart:io';
import 'package:drFamily_app/model/sign_up/health_record_create_model.dart';
import 'package:drFamily_app/model/sign_up/patient_create_model.dart';
import 'package:http/http.dart' as http;
import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/dependent_model.dart';

abstract class IDependentRepo {
  Future<List<DependentModel>> getListDependent(int accountID);
  Future<bool> deleteDependent(int patientID);
  Future<bool> createDependentProfile(String createDependentProfileJson);
  Future<bool> createHealthRecord();
  Future<bool> createPatient(String relationship, String location);
}

class DependentRepo extends IDependentRepo {
  HealthRecordModel _healthRecordModel;
  PatientCreateModel _patientCreateModel;
  int profileId, healthRecordId;
  String phone, formatPhone;

  @override
  Future<List<DependentModel>> getListDependent(int accountID) async {
    String urlAPI =
        APIHelper.GET_DEPENDENT_API + accountID.toString() + "/Dependents";
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    print("Status: " + response.statusCode.toString());

    List<DependentModel> listDependent;

    if (response.statusCode == 200) {
      listDependent = (json.decode(response.body) as List)
          .map((data) => DependentModel.fromJson(data))
          .toList();
      listDependent.removeAt(0);
      return listDependent;
    } else
      return null;
  }

  @override
  Future<bool> deleteDependent(int patientID) async {
    print("patientID: " + patientID.toString());
    String urlAPI = APIHelper.DELETE_DEPENDENT_API + patientID.toString();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.delete(urlAPI, headers: header);
    print("Status: " + response.statusCode.toString());

    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> createDependentProfile(String createDependentProfileJson) async {
    String urlAPI = APIHelper.CREATE_PROFILE_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.post(urlAPI,
        headers: header, body: createDependentProfileJson);
    print("Status code: " + response.statusCode.toString());
    bool isCreated = true;

    if (response.statusCode == 201) {
      String jSonData = response.body;
      var decodeData = jsonDecode(jSonData);
      profileId = decodeData["profileId"];

      print("ProfileId: " + profileId.toString());
      return isCreated;
    } else {
      isCreated = false;
      return isCreated;
    }
  }

  @override
  Future<bool> createHealthRecord() async {
    String urlAPI = APIHelper.CREATE_HEALTHRECORD_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    _healthRecordModel = new HealthRecordModel(
        healthRecordID: profileId, insBy: null, insDatetime: null);

    String createHealthRecordJson = jsonEncode(_healthRecordModel.toJson());
    print("CreateHealthRecordJson: " + createHealthRecordJson);

    var response =
        await http.post(urlAPI, headers: header, body: createHealthRecordJson);
    print("Status code createHealthRecord: " + response.statusCode.toString());

    bool isCreated = true;
    if (response.statusCode == 201) {
      String jSonData = response.body;
      var decodeData = jsonDecode(jSonData);
      healthRecordId = decodeData["recordId"];

      print("RecordId: " + healthRecordId.toString());
      return isCreated;
    } else {
      isCreated = false;
      return isCreated;
    }
  }

  @override
  Future<bool> createPatient(String relationship, String location) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // int accountID = prefs.getInt("usAccountID");

    String urlAPI = APIHelper.CREATE_PATIENT_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    _patientCreateModel = new PatientCreateModel(
      patientId: profileId,
      height: 0,
      weight: 0,
      bloodType: null,
      relationship: relationship,
      location: location,
    );
    String createPatientJson = jsonEncode(_patientCreateModel.toJson());
    print("CreatePatientJson: " + createPatientJson);

    var response =
        await http.post(urlAPI, headers: header, body: createPatientJson);
    print("Status code createPatient: " + response.statusCode.toString());

    bool isCreated = true;
    if (response.statusCode == 201) {
      return isCreated;
    } else {
      isCreated = false;
      return isCreated;
    }
  }
}
