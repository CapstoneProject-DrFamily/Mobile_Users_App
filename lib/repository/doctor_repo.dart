import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/doctor_detail_model.dart';
import 'package:http/http.dart' as http;

abstract class IDoctorRepo {
  Future<DoctorDetailModel> getDoctor(int doctorId);
  Future<int> getDoctorPhoneNum(int doctorId);
}

class DoctorRepo extends IDoctorRepo {
  @override
  Future<DoctorDetailModel> getDoctor(int doctorId) async {
    print("in API Doctor");
    String urlAPI = APIHelper.URI_PREFIX_API;
    print("in " + doctorId.toString());
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var uri = Uri.http(urlAPI, "/api/v1/Doctors/$doctorId");
    var response = await http.get(uri, headers: header);
    print(response.statusCode);

    DoctorDetailModel doctorDetail;

    if (response.statusCode == 200) {
      Map<String, dynamic> sc = json.decode(response.body);
      doctorDetail = DoctorDetailModel.fromJson(sc);
      return doctorDetail;
    } else
      return null;
  }

  @override
  Future<int> getDoctorPhoneNum(int doctorId) async {
    String urlAPI = APIHelper.URI_PREFIX_API;
    print("in " + doctorId.toString());
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var uri = Uri.http(urlAPI, "/api/v1/Doctors/$doctorId");
    var response = await http.get(uri, headers: header);
    print(response.statusCode);

    if (response.statusCode == 200) {
      Map<String, dynamic> sc = json.decode(response.body);
      var doctorPhone = sc['profile']['users'][0]['username'];
      return int.parse(doctorPhone);
    } else
      return null;
  }
}
