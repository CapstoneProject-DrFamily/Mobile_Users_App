import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/sign_up/health_record_create_model.dart';
import 'package:drFamily_app/model/sign_up/patient_create_model.dart';
import 'package:drFamily_app/model/sign_up/user_update_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ISignUpRepo {
  Future<bool> createProfile(String createProfileJson);
  Future<bool> updateUser();
  Future<bool> createHealthRecord();
  Future<bool> createPatient();
}

class SignUpRepo extends ISignUpRepo {
  UserUpdateModel _userUpdateModel;
  HealthRecordModel _healthRecordModel;
  PatientCreateModel _patientCreateModel;
  int profileId, accountId, healthRecordId;
  String phone, formatPhone;

  @override
  Future<bool> createProfile(String createProfileJson) async {
    String urlAPI = APIHelper.CREATE_PROFILE_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response =
        await http.post(urlAPI, headers: header, body: createProfileJson);
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
  Future<bool> updateUser() async {
    String urlAPI = APIHelper.UPDATE_USER_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setInt("usProfileID", profileId);
    phone = sharedPreferences.getString('usPhone');
    if (phone[0].endsWith('0')) phone = phone.substring(1, phone.length);
    phone = "84" + phone;
    accountId = sharedPreferences.getInt('usAccountID');

    _userUpdateModel = new UserUpdateModel(
        disable: 0,
        updBy: phone,
        updDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        accountId: accountId,
        username: phone,
        password: null,
        roleId: 2,
        profileId: profileId,
        waiting: 0);
    String updateUserJson = jsonEncode(_userUpdateModel.toJson());
    print("UpdUserJson: " + updateUserJson);

    var response =
        await http.put(urlAPI, headers: header, body: updateUserJson);

    print("Status code: " + response.statusCode.toString());

    bool isUpdated = true;
    if (response.statusCode == 200) {
      return isUpdated;
    } else {
      isUpdated = false;
      return isUpdated;
    }
  }

  @override
  Future<bool> createHealthRecord() async {
    String urlAPI = APIHelper.CREATE_HEALTHRECORD_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    _healthRecordModel = new HealthRecordModel(insBy: null, insDatetime: null);

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
  Future<bool> createPatient() async {
    String urlAPI = APIHelper.CREATE_PATIENT_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    _patientCreateModel = new PatientCreateModel(
        profileId: profileId,
        healthRecordId: healthRecordId,
        relationship: "Owner",
        accountId: accountId);
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
