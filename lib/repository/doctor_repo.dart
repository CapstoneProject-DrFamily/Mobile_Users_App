import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/doctor_detail_model.dart';
import 'package:drFamily_app/model/doctor_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/doctor_schedule_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/doctor_speciality_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/schedule_model.dart';
import 'package:drFamily_app/model/setting/profile_model.dart';
import 'package:http/http.dart' as http;

abstract class IDoctorRepo {
  Future<DoctorDetailModel> getDoctor(int doctorId);
  Future<int> getDoctorPhoneNum(int doctorId);
  Future<String> getNotiToken(int doctorId);
  Future<List<DoctorScheduleModel>> getDoctorsBySpeciality(int specialityId);
  Future<List<DoctorScheduleModel>> getListOldBookAppointment(
      int accountId, int pageIndex, int pageSize, int searchValue);
  Future<List<DoctorModel>> getListOldFindDoctor(
      int accountId, int specialtyId);
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
      var doctorPhone = sc['idNavigation']['username'];
      return int.parse(doctorPhone);
    } else
      return null;
  }

  @override
  Future<List<DoctorScheduleModel>> getDoctorsBySpeciality(
      int specialityId) async {
    List<DoctorScheduleModel> listDoctor = [];
    String urlAPI = APIHelper.DOCTOR_SPECIALTY + '$specialityId?PageSize=50';
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    print("status ${response.statusCode}");
    Map<String, dynamic> data = json.decode(response.body);

    for (int i = 0; i < data['doctors'].length; i++) {
      DoctorSpecialtyModel speciality =
          DoctorSpecialtyModel.fromJson(data['doctors'][i]['specialty']);
      print(speciality);
      DoctorDetailModel doctorDetailModel =
          DoctorDetailModel.fromJson(data['doctors'][i]);
      print(doctorDetailModel);
      ProfileModel profile = ProfileModel.fromJson(data['doctors'][i]);
      print(profile);
      List<ScheduleModel> listSchedule = [];
      for (int k = 0; k < data['doctors'][i]['schedules'].length; k++) {
        print(data['doctors'][i]['schedules'][k]);

        ScheduleModel schedule =
            ScheduleModel.fromJson(data['doctors'][i]['schedules'][k]);

        listSchedule.add(schedule);
      }

      String notiToken = data['doctors'][i]['idNavigation']['notiToken'];

      print('notitoken $notiToken');

      DoctorScheduleModel model = DoctorScheduleModel(
          doctorDetail: doctorDetailModel,
          profile: profile,
          specialty: speciality,
          schedules: listSchedule,
          notiToken: notiToken);

      if (listSchedule.isEmpty) {
      } else {
        listDoctor.add(model);
      }
    }

    return listDoctor;
  }

  @override
  Future<String> getNotiToken(int doctorId) async {
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
      var notiToken = sc['idNavigation']['notiToken'];
      return notiToken;
    } else
      return null;
  }

  @override
  Future<List<DoctorModel>> getListOldFindDoctor(
      int accountId, int specialtyId) async {
    List<DoctorModel> listOldDoctor = [];
    String urlAPI = APIHelper.DOCTOR_OLD_FIND +
        '?accountId=$accountId&specialtyId=$specialtyId';
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    print("status ${response.statusCode}");

    if (response.statusCode == 200) {
      listOldDoctor = (json.decode(response.body) as List)
          .map((data) => DoctorModel.fromJson(data))
          .toList();
      if (listOldDoctor.isEmpty) listOldDoctor = null;
      return listOldDoctor;
    } else
      return null;
  }

  @override
  Future<List<DoctorScheduleModel>> getListOldBookAppointment(
      int accountId, int pageIndex, int pageSize, int searchValue) async {
    List<DoctorScheduleModel> listDoctor = [];
    String urlAPI = APIHelper.DOCTOR_OLD_APPOINTMENT +
        '?accountId=$accountId&PageIndex=$pageIndex&PageSize=$pageSize&SearchValue=$searchValue';
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    print("status ${response.statusCode}");
    Map<String, dynamic> data = json.decode(response.body);

    for (int i = 0; i < data['doctors'].length; i++) {
      DoctorSpecialtyModel speciality =
          DoctorSpecialtyModel.fromJson(data['doctors'][i]['specialty']);
      print(speciality);
      DoctorDetailModel doctorDetailModel =
          DoctorDetailModel.fromJson(data['doctors'][i]);
      print(doctorDetailModel);
      ProfileModel profile = ProfileModel.fromJson(data['doctors'][i]);
      print(profile);
      List<ScheduleModel> listSchedule = [];
      for (int k = 0; k < data['doctors'][i]['schedules'].length; k++) {
        print(data['doctors'][i]['schedules'][k]);

        ScheduleModel schedule =
            ScheduleModel.fromJson(data['doctors'][i]['schedules'][k]);

        listSchedule.add(schedule);
      }

      String notiToken = data['doctors'][i]['idNavigation']['notiToken'];

      print('notitoken $notiToken');

      DoctorScheduleModel model = DoctorScheduleModel(
          doctorDetail: doctorDetailModel,
          profile: profile,
          specialty: speciality,
          schedules: listSchedule,
          notiToken: notiToken);

      if (listSchedule.isEmpty) {
      } else {
        listDoctor.add(model);
      }
    }

    return listDoctor;
  }
}
