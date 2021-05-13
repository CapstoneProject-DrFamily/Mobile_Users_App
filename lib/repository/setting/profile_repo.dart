import 'dart:convert';
import 'dart:io';
import 'package:drFamily_app/model/setting/addition_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/setting/profile_model.dart';

abstract class IProfileRepo {
  Future<ProfileModel> getBasicInfo(String profileID);
  Future<AdditionInfoModel> getAdditionInfo(String patientID);
  Future<bool> updateBasicInfo(String updateBasicInfoJson);
  Future<bool> updateAdditionInfo(String updateAdditionInfoJson);
  Future<int> getPatientId(String profileID);
}

class ProfileRepo extends IProfileRepo {
  @override
  Future<ProfileModel> getBasicInfo(String profileID) async {
    String urlAPI = APIHelper.GET_PATIENT_BY_ID_API + profileID;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    print("Status: " + response.statusCode.toString());

    print("Json: " + response.body);
    ProfileModel profileModel;

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      profileModel = ProfileModel.fromJson(map);
      profileModel.additionInfoModel = AdditionInfoModel.fromJson(map);
      return profileModel;
    } else
      return null;
  }

  @override
  Future<AdditionInfoModel> getAdditionInfo(String patientID) async {
    String urlAPI = APIHelper.PATIENT_BY_ID_API + patientID;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    print("Status: " + response.statusCode.toString());

    print("Json: " + response.body);
    AdditionInfoModel additionInfoModel;

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      additionInfoModel = AdditionInfoModel.fromJson(map);
      return additionInfoModel;
    } else
      return null;
  }

  @override
  Future<bool> updateBasicInfo(String updateBasicInfoJson) async {
    String urlAPI = APIHelper.UPDATE_PROFILE_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response =
        await http.put(urlAPI, headers: header, body: updateBasicInfoJson);
    print("Status updateBasic: " + response.statusCode.toString());

    bool isUpdated = true;
    if (response.statusCode == 200) {
      return isUpdated;
    } else {
      isUpdated = false;
      return isUpdated;
    }
  }

  @override
  Future<bool> updateAdditionInfo(String updateAdditionInfoJson) async {
    String urlAPI = APIHelper.PATIENT_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response =
        await http.put(urlAPI, headers: header, body: updateAdditionInfoJson);
    print("Status additionInfo: " + response.statusCode.toString());

    bool isUpdated = true;
    if (response.statusCode == 200) {
      return isUpdated;
    } else {
      isUpdated = false;
      return isUpdated;
    }
  }

  @override
  Future<int> getPatientId(String profileID) async {
    String urlAPI = APIHelper.GET_PROFILE_BY_ID_API + profileID;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      int patientID = map['patient']['patientId'];

      return patientID;
    } else
      return null;
  }
}
