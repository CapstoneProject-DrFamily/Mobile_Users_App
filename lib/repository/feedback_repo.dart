import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/feedback_model.dart';
import 'package:http/http.dart' as http;

abstract class IFeedbackRepo {
  Future<bool> createFeedback(FeedbackModel feedback);

  Future<List<dynamic>> getListFeedback(
      int doctorId, int pageIndex, int pageSize);
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

  @override
  Future<List<dynamic>> getListFeedback(
      int doctorId, int pageIndex, int pageSize) async {
    List<dynamic> result = [];

    List<FeedbackModel> listFeedback = [];
    String urlAPI = APIHelper.FEEDBACK_API;

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    urlAPI = urlAPI +
        "/paging/Doctors?PageIndex=$pageIndex&PageSize=$pageSize&SearchValue=$doctorId";

    var response = await http.get(urlAPI, headers: header);

    print("response : " + response.statusCode.toString());

    Map<String, dynamic> data = json.decode(response.body);
    for (int i = 0; i < data['feedbacks'].length; i++) {
      FeedbackModel model = FeedbackModel.fromJson(data['feedbacks'][i]);
      listFeedback.add(model);
    }
    print('feedback length :' + listFeedback.length.toString());
    result.add(listFeedback);
    result.add(data['hasNextPage']);

    return result;
  }
}
