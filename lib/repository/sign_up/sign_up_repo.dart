import 'dart:convert';
import 'dart:io';
import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/sign_up/health_record_create_model.dart';
import 'package:drFamily_app/model/sign_up/user_update_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ISignUpRepo {
  Future<bool> updateUser();
  Future<bool> createPatient(String location);
  Future<bool> createHealthRecord();
}

class SignUpRepo extends ISignUpRepo {
  UserUpdateModel _userUpdateModel;
  HealthRecordModel _healthRecordModel;
  // PatientCreateModel _patientCreateModel;
  // SignUpModel _signUpModel;
  int profileId, accountId, patientId, healthRecordId;
  String phone, formatPhone;

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
        waiting: 0);

    var data = {
      'userModel': {
        "disable": 0,
        "updBy": phone,
        "updDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
        "accountId": accountId,
        "username": phone,
        "password": null,
        "roleId": 2,
        "waiting": 0
      }
    };
    print("userModel: " + jsonEncode(data));

    var response =
        await http.put(urlAPI, headers: header, body: jsonEncode(data));

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
  Future<bool> createPatient(String createPatientJson) async {
    String urlAPI = APIHelper.PATIENT_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    // _patientCreateModel = new PatientCreateModel(
    //   patientId: profileId,
    //   height: 0,
    //   weight: 0,
    //   bloodType: null,
    //   relationship: "Owner",
    //   location: location,
    // );
    // String createPatientJson = jsonEncode(_patientCreateModel.toJson());
    // print("CreatePatientJson: " + createPatientJson);

    var response =
        await http.post(urlAPI, headers: header, body: createPatientJson);
    print("Status code createPatient: " + response.statusCode.toString());

    bool isCreated = true;
    if (response.statusCode == 201) {
      String jSonData = response.body;
      var decodeData = jsonDecode(jSonData);
      patientId = decodeData["id"];
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setInt("usPatientID", patientId);
      return isCreated;
    } else {
      isCreated = false;
      return isCreated;
    }
  }

  @override
  Future<bool> createHealthRecord() async {
    String urlAPI = APIHelper.HEALTHRECORD_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    _healthRecordModel = new HealthRecordModel(
        patientID: patientId,
        insBy: "Owner",
        insDatetime: DateTime.now().toString(),
        disable: 0);

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
}
