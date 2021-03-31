import 'dart:convert';
import 'dart:io';
import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/doctor_detail_model.dart';
import 'package:drFamily_app/model/doctor_information_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/doctor_speciality_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/schedule_model.dart';
import 'package:drFamily_app/model/patient_schedule_model/patient_schedule_model.dart';
import 'package:drFamily_app/model/setting/profile_model.dart';
import 'package:drFamily_app/model/specialty_model.dart';
import 'package:drFamily_app/model/transaction/service_model.dart';
import 'package:drFamily_app/model/transaction/transaction_model.dart';
import 'package:http/http.dart' as http;

abstract class IScheduleRepo {
  Future<bool> updateSchedule(ScheduleModel schedule);
  Future<List<PatientScheduleModel>> getListScheduleByPatientId(int patientId);
}

class ScheduleRepo extends IScheduleRepo {
  @override
  Future<bool> updateSchedule(ScheduleModel schedule) async {
    String urlAPI = APIHelper.SCHEDULE_API;

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.put(urlAPI,
        headers: header, body: jsonEncode(schedule.toJson()));

    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }

  @override
  Future<List<PatientScheduleModel>> getListScheduleByPatientId(
      int patientId) async {
    List<PatientScheduleModel> list = [];
    String urlAPI = APIHelper.SCHEDULE_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var response = await http.get(
      urlAPI + "/patients/$patientId",
      headers: header,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      for (int i = 0; i < data['schedules'].length; i++) {
        DoctorInformationModel doctor =
            DoctorInformationModel.fromJson(data['schedules'][i]['doctor']);
        ProfileModel profile = ProfileModel.fromJson(
            data['schedules'][i]['doctor']['doctorNavigation']);
        DoctorSpecialtyModel speciality = DoctorSpecialtyModel.fromJson(
            data['schedules'][i]['doctor']['specialty']);
        ServiceModel service = ServiceModel.fromJson(
            data['schedules'][i]['scheduleNavigation']['service']);
        ScheduleModel schedule = ScheduleModel.fromJson(data['schedules'][i]);

        TransactionModel transaction = TransactionModel.fromJson(
            data['schedules'][i]['scheduleNavigation']);
        // print(doctor.toJson());
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
}
