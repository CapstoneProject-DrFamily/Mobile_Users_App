import 'dart:convert';

import 'package:drFamily_app/model/doctor_schedule_model/schedule_model.dart';
import 'package:drFamily_app/model/transaction/transaction_model.dart';
import 'package:drFamily_app/repository/schedule_repo.dart';
import 'package:drFamily_app/repository/transaction_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/view_model/schedule_vm/appointment_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReasonAppointmentViewModel extends BaseModel {
  String note = "";
  final ITransactionRepo _transactionRepo = TransactionRepo();
  final IScheduleRepo _scheduleRepo = ScheduleRepo();
  bool isLoading = false;

  Future<bool> bookingDoctor(AppointmentViewModel model) async {
    bool booking = false;
    isLoading = true;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String transaction;
    int patientid = prefs.getInt('usPatientID');

    print('patientId $patientid');

    transaction = jsonEncode({
      "doctorId": model.doctorScheduleModel.doctorDetail.doctorId,
      "patientId": prefs.getInt('usPatientID'),
      "status": 0,
      "location": prefs.getString('usLocation'),
      "note": this.note.isEmpty ? "Nothing" : this.note,
      "serviceId": prefs.getInt('usServiceID'),
    });

    // String transactionId = await _transactionRepo.addTransaction(transaction);
    String transactionId = 'TS-e81af94f-3b07-49ea-9f78-fcffd9d3074b';

    // check if cannot create transaction
    if (transactionId == null) {
      return booking;
    }

    TransactionModel transactionModel =
        await _transactionRepo.getTransaction(transactionId);

    // check if get transaction success
    if (transactionModel == null) {
      return booking;
    }

    print("Start: " + transactionModel.dateStart);

    String appointmentTime;
    model.schedules.forEach((key, value) {
      for (int i = 0; i < value.length; i++) {
        if (value[i].scheduleId == model.selectedValue) {
          appointmentTime = value[i].appointmentTime;
          break;
        }
      }
    });

    print("Appointment time :" + appointmentTime);

    ScheduleModel schedule = ScheduleModel(
        appointmentTime: appointmentTime,
        doctorId: model.doctorScheduleModel.doctorDetail.doctorId,
        updBy: prefs.getString('usFullName'),
        scheduleId: model.selectedValue,
        status: true,
        updDatetime: transactionModel.dateStart);

    bool isSuccess = await _scheduleRepo.updateSchedule(schedule);
    if (isSuccess) {
      booking = true;
    }
    isLoading = false;
    notifyListeners();
    return booking;
  }
}
