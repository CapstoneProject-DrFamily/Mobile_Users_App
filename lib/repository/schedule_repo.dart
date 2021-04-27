import 'dart:convert';
import 'dart:io';
import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/doctor_information_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/doctor_speciality_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/schedule_model.dart';
import 'package:drFamily_app/model/patient_schedule_model/patient_schedule_model.dart';
import 'package:drFamily_app/model/setting/profile_model.dart';
import 'package:drFamily_app/model/transaction/service_model.dart';
import 'package:drFamily_app/model/transaction/transaction_model.dart';
import 'package:http/http.dart' as http;

abstract class IScheduleRepo {
  Future<bool> updateSchedule(ScheduleModel schedule);
  Future<bool> updateSchedules(String scheduleUpdateJson);
  Future<List<PatientScheduleModel>> getListScheduleByPatientIdUpComing(
      int patientId);
  Future<ScheduleModel> getSchedule(int scheduleId);
}

class ScheduleRepo extends IScheduleRepo {
  @override
  Future<bool> updateSchedule(ScheduleModel schedule) async {
    String urlAPI = APIHelper.SCHEDULE_API;

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    print("json ${schedule.toJson()}");

    var response = await http.put(urlAPI,
        headers: header, body: jsonEncode(schedule.toJson()));
    print("update schedule status ${response.statusCode}");
    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }

  @override
  Future<List<PatientScheduleModel>> getListScheduleByPatientIdUpComing(
      int patientId) async {
    List<PatientScheduleModel> list = [];
    String urlAPI = APIHelper.SCHEDULE_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var response = await http.get(
      urlAPI + "/patients/$patientId/Upcoming",
      headers: header,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      for (int i = 0; i < data['schedules'].length; i++) {
        DoctorInformationModel doctor =
            DoctorInformationModel.fromJson(data['schedules'][i]['doctor']);
        print(doctor);
        ProfileModel profile = ProfileModel.fromJson(
            data['schedules'][i]['doctor']['doctorNavigation']);
        print(profile);
        DoctorSpecialtyModel speciality = DoctorSpecialtyModel.fromJson(
            data['schedules'][i]['doctor']['specialty']);
        print(speciality);

        ServiceModel service = ServiceModel.fromJson(
            data['schedules'][i]['transactions'][0]['service']);
        print(service);

        ScheduleModel schedule = ScheduleModel.fromJson(data['schedules'][i]);

        print(schedule);

        TransactionModel transaction =
            TransactionModel.fromJson(data['schedules'][i]['transactions'][0]);

        print(transaction);
        PatientScheduleModel model = PatientScheduleModel(
            doctor: doctor,
            profile: profile,
            service: service,
            schedule: schedule,
            specialty: speciality,
            transaction: transaction);

        list.add(model);
      }
    }
    return list;
  }

  @override
  Future<ScheduleModel> getSchedule(int scheduleId) async {
    ScheduleModel schedule;

    String urlAPI = APIHelper.SCHEDULE_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var response = await http.get(
      urlAPI + "/$scheduleId",
      headers: header,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      schedule = ScheduleModel.fromJson(data);
    }

    return schedule;
  }

  @override
  Future<bool> updateSchedules(String scheduleUpdateJson) async {
    bool isSuccess = false;
    String urlAPI = APIHelper.SCHEDULE_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response =
        await http.put(urlAPI, headers: header, body: scheduleUpdateJson);

    if (response.statusCode == 200) {
      isSuccess = true;
    }

    return isSuccess;
  }
}
