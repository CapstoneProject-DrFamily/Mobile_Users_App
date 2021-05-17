import 'dart:convert';
import 'dart:io';
import 'package:drFamily_app/model/setting/health_record_model.dart';
import 'package:http/http.dart' as http;
import 'package:drFamily_app/Helper/api_helper.dart';

abstract class IHealthRecordRepo {
  Future<HealthRecordModel> getCurrentHealthRecordByID(
      int patientID, bool isOldRecord);
  Future<List<HealthRecordModel>> getListOldHealthRecord(
      int patientID, bool isOldRecord);
  Future<HealthRecordModel> getHealthRecordByID(int healthRecordID);
  Future<bool> storedOldHealthRecord(int oldHealthRecordID);
  Future<bool> createNewHealthRecord(String createNewHealthRecordJson);
}

class HealthRecordRepo extends IHealthRecordRepo {
  @override
  Future<HealthRecordModel> getCurrentHealthRecordByID(
      int patientID, bool isOldRecord) async {
    String urlAPI = APIHelper.GET_HEALTHRECORD_BY_ID_API +
        'patientId=' +
        patientID.toString() +
        '&isOldRecord=' +
        isOldRecord.toString();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    print("Status Heal: " + response.statusCode.toString());
    print("Json Health: " + response.body);

    List<HealthRecordModel> listHealthRecord;

    HealthRecordModel healthRecordModel;
    if (response.statusCode == 200) {
      listHealthRecord = (json.decode(response.body) as List)
          .map((data) => HealthRecordModel.fromJson(data))
          .toList();
      healthRecordModel = listHealthRecord.first;
      return healthRecordModel;
    } else {
      return null;
    }
  }

  @override
  Future<List<HealthRecordModel>> getListOldHealthRecord(
      int patientID, bool isOldRecord) async {
    String urlAPI = APIHelper.GET_HEALTHRECORD_BY_ID_API +
        'patientId=' +
        patientID.toString() +
        '&isOldRecord=' +
        isOldRecord.toString();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    print("Status listOldPHR: " + response.statusCode.toString());
    print("listOldPHR: " + response.body);

    List<HealthRecordModel> listOldHealthRecord;
    if (response.statusCode == 200) {
      listOldHealthRecord = (json.decode(response.body) as List)
          .map((data) => HealthRecordModel.fromJson(data))
          .toList();
      // List<DateTime> newListOldHealthRecord = [];
      // DateFormat format = DateFormat("dd-MM-yyyy");

      // for (int i = 0; i < listOldHealthRecord.length; i++) {
      //   newListOldHealthRecord.add(format.parse(listOldHealthRecord[i]['insDatetime']));
      // }
      listOldHealthRecord
          .sort((a, b) => b.insDatetime.compareTo(a.insDatetime));
      return listOldHealthRecord;
    } else {
      return null;
    }
  }

  @override
  Future<HealthRecordModel> getHealthRecordByID(int healthRecordID) async {
    String urlAPI =
        APIHelper.HEALTHRECORD_API + "/" + healthRecordID.toString();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    print("Status getHealthRecordByID: " + response.statusCode.toString());
    print("Body getHealthRecordByID: " + response.body);

    HealthRecordModel healthRecordModel;
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      healthRecordModel = HealthRecordModel.fromJson(map);
      return healthRecordModel;
    } else {
      return null;
    }
  }

  @override
  Future<bool> storedOldHealthRecord(int oldHealthRecordID) async {
    String urlAPI =
        APIHelper.HEALTHRECORD_API + "/" + oldHealthRecordID.toString();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.delete(urlAPI, headers: header);
    print("Status storedOldHealthRecord: " + response.statusCode.toString());

    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> createNewHealthRecord(String createNewHealthRecordJson) async {
    String urlAPI = APIHelper.HEALTHRECORD_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.post(urlAPI,
        headers: header, body: createNewHealthRecordJson);
    print("Status updateHealthRecord: " + response.statusCode.toString());

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
