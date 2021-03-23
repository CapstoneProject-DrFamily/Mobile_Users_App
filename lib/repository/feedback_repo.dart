import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/feedback_model.dart';
import 'package:http/http.dart' as http;

abstract class IFeedbackRepo {
  Future<bool> createFeedback(FeedbackModel feedback);
}

class FeedbackRepo extends IFeedbackRepo {
  @override
  Future<bool> createFeedback(FeedbackModel feedback) async {
    bool isSuccess = false;
    String urlAPI = APIHelper.FEEDBACK_API;

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.post(urlAPI,
        headers: header, body: jsonEncode(feedback.toJson()));
    if (response.statusCode == 201) {
      isSuccess = true;
    }

    return isSuccess;
  }
}
