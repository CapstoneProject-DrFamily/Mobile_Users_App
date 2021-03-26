import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/doctor_schedule_model/schedule_model.dart';
import 'package:http/http.dart' as http;

abstract class IScheduleRepo {
  Future<bool> updateSchedule(ScheduleModel schedule);
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
}
