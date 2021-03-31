import 'package:drFamily_app/model/doctor_detail_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/doctor_speciality_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/schedule_model.dart';
import 'package:drFamily_app/model/setting/profile_model.dart';
import 'package:drFamily_app/model/transaction/service_model.dart';

class PatientScheduleModel {
  ScheduleModel schedule;
  DoctorDetailModel doctor;
  ProfileModel profile;
  DoctorSpecialtyModel specialty;
  ServiceModel service;

  PatientScheduleModel({
    this.schedule,
    this.doctor,
    this.profile,
    this.specialty,
    this.service,
  });
}
