import 'dart:convert';
import 'dart:io';
import 'package:drFamily_app/model/setting/health_record_model.dart';
import 'package:http/http.dart' as http;
import 'package:drFamily_app/Helper/api_helper.dart';

abstract class IHealthRecordRepo {
  Future<HealthRecordModel> getHealthRecordByID(int healthRecordID);
  Future<bool> updateHealthRecord(String updateHealthRecordJson);
}

class HealthRecordRepo extends IHealthRecordRepo {
  @override
  Future<HealthRecordModel> getHealthRecordByID(int healthRecordID) async {
    String urlAPI =
        APIHelper.GET_HEALTHRECORD_BY_ID_API + healthRecordID.toString();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    print("Status Heal: " + response.statusCode.toString());
    print("Json Health: " + response.body);

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
  Future<bool> updateHealthRecord(String updateHealthRecordJson) async {
    String urlAPI = APIHelper.UPDATE_HEALTHRECORD_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response =
        await http.put(urlAPI, headers: header, body: updateHealthRecordJson);
    print("Status updateHealthRecord: " + response.statusCode.toString());

    bool isUpdated = true;
    if (response.statusCode == 200) {
      return isUpdated;
    } else {
      isUpdated = false;
      return isUpdated;
    }
  }
}
