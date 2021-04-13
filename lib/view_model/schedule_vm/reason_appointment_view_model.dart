import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:drFamily_app/model/doctor_schedule_model/doctor_schedule_model.dart';
import 'package:drFamily_app/model/doctor_schedule_model/schedule_model.dart';
import 'package:drFamily_app/model/transaction/transaction_model.dart';
import 'package:drFamily_app/repository/notify_repo.dart';
import 'package:drFamily_app/repository/schedule_repo.dart';
import 'package:drFamily_app/repository/transaction_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReasonAppointmentViewModel extends BaseModel {
  final INotifyRepo notifyRepo = NotifyRepo();
  String note = "";
  final ITransactionRepo _transactionRepo = TransactionRepo();
  final IScheduleRepo _scheduleRepo = ScheduleRepo();
  bool isLoading = false;

  Future<bool> bookingDoctor(
      String selectedValue,
      Map<String, List<ScheduleModel>> schedules,
      DoctorScheduleModel doctorScheduleModel,
      BuildContext context) async {
    bool booking = false;
    isLoading = true;
    notifyListeners();
    waitDialog(context, message: "Setting up schedule...");

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int patientid = prefs.getInt('usPatientID');
    print(patientid);
    TransactionModel transactionModel =
        await _transactionRepo.getTransaction(selectedValue);

    // check if get transaction success
    if (transactionModel == null) {
      return booking;
    }

    // update transaction
    transactionModel.patientId = patientid;
    transactionModel.location = prefs.getString("usLocation");
    transactionModel.note = this.note.isEmpty ? "Nothing" : this.note;

    String data = jsonEncode(transactionModel.toJson());
    print('transaction $data');
    bool isUpdated = await _transactionRepo.updateTransaction(data);

    if (!isUpdated) {
      return booking;
    }

    String appointmentTime;
    schedules.forEach((key, value) {
      for (int i = 0; i < value.length; i++) {
        if (value[i].scheduleId == selectedValue) {
          appointmentTime = value[i].appointmentTime;
          break;
        }
      }
    });

    print("Appointment time :" + appointmentTime);
    String formattedDate =
        DateFormat('dd-MM-yyyy HH:mm:').format(DateTime.parse(appointmentTime));

    ScheduleModel schedule = ScheduleModel(
        appointmentTime: appointmentTime,
        doctorId: doctorScheduleModel.doctorDetail.doctorId,
        updBy: prefs.getString('usPatientName'),
        scheduleId: selectedValue,
        status: true,
        updDatetime: transactionModel.dateStart);

    print('Schedule $schedule');

    bool isSuccess = await _scheduleRepo.updateSchedule(schedule);
    print("isSucces $isSuccess");
    if (isSuccess) {
      notifyRepo.bookScheduleDoctor(doctorScheduleModel.notiToken,
          prefs.getString('usPatientName'), formattedDate);
      booking = true;
    }
    return booking;
  }
}
