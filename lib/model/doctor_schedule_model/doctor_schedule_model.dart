import 'package:drFamily_app/model/doctor_detail_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/doctor_speciality_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/schedule_model.dart';
import 'package:drFamily_app/model/setting/profile_model.dart';
import 'package:drFamily_app/model/specialty_model.dart';

class DoctorScheduleModel {
  DoctorDetailModel doctorDetail;
  ProfileModel profile;
  DoctorSpecialtyModel specialty;
  List<ScheduleModel> schedules;
  DoctorScheduleModel(
      {this.doctorDetail, this.profile, this.specialty, this.schedules});
}
