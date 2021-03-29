import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/doctor_detail_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/doctor_schedule_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/doctor_speciality_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/schedule_model.dart';
import 'package:drFamily_app/model/setting/profile_model.dart';
import 'package:drFamily_app/model/specialty_model.dart';
import 'package:http/http.dart' as http;

abstract class IDoctorRepo {
  Future<DoctorDetailModel> getDoctor(int doctorId);
  Future<int> getDoctorPhoneNum(int doctorId);
  Future<List<DoctorScheduleModel>> getDoctorsBySpeciality(int specialityId);
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
      print('model: $doctorDetail');
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
      var doctorPhone = sc['doctorNavigation']['account']['username'];
      return int.parse(doctorPhone);
    } else
      return null;
  }

  @override
  Future<List<DoctorScheduleModel>> getDoctorsBySpeciality(
      int specialityId) async {
    List<DoctorScheduleModel> listDoctor = [];
    String urlAPI = APIHelper.URI_PREFIX_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var uri = Uri.http(urlAPI, "/api/v1/Doctors/specialties/$specialityId");

    var response = await http.get(uri, headers: header);
    Map<String, dynamic> data = json.decode(response.body);

    for (int i = 0; i < data['doctors'].length; i++) {
      DoctorSpecialtyModel speciality =
          DoctorSpecialtyModel.fromJson(data['doctors'][i]['specialty']);
      DoctorDetailModel doctorDetailModel =
          DoctorDetailModel.fromJson(data['doctors'][i]);
      ProfileModel profile =
          ProfileModel.fromJson(data['doctors'][i]['doctorNavigation']);

      List<ScheduleModel> listSchedule = [];
      for (int k = 0; k < data['doctors'][i]['schedules'].length; k++) {
        ScheduleModel schedule =
            ScheduleModel.fromJson(data['doctors'][i]['schedules'][k]);

        listSchedule.add(schedule);
      }
      DoctorScheduleModel model = DoctorScheduleModel(
          doctorDetail: doctorDetailModel,
          profile: profile,
          specialty: speciality,
          schedules: listSchedule);
      listDoctor.add(model);
    }

    return listDoctor;
  }
}
