import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/global_variable.dart';
import 'package:drFamily_app/model/feedback_model.dart';
import 'package:drFamily_app/model/setting/profile_model.dart';
import 'package:drFamily_app/model/transaction/examination_form_model.dart';
import 'package:drFamily_app/model/transaction/service_model.dart';
import 'package:drFamily_app/model/transaction/transaction_model.dart';
import 'package:drFamily_app/model/transaction_history_model.dart';
import 'package:drFamily_app/model/transaction_map_model.dart';
import 'package:http/http.dart' as http;

abstract class ITransactionRepo {
  Future<String> addTransaction(String transaction);
  Future<TransactionMapModel> detailTransactionMap(String transactionID);
  Future<bool> updateTransaction(String transaction);
  Future<List<TransactionHistoryModel>> getListTransactionHistory(
      String patientId, int status);
  Future<TransactionModel> getTransaction(String transactionId);

  Future<List<dynamic>> getTransactionDetail(String transactionId);
}

class TransactionRepo extends ITransactionRepo {
  @override
  Future<String> addTransaction(String transaction) async {
    String transactionID;
    String urlAPI = APIHelper.TRANSACTION_API;

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response =
        await http.post(urlAPI, headers: header, body: transaction);

    print(response.statusCode);

    print(response.body);
    if (response.statusCode == 201) {
      String jSonData = response.body;
      var decodeData = jsonDecode(jSonData);
      transactionID = decodeData["id"];
      return transactionID;
    } else
      return null;
  }

  @override
  Future<TransactionMapModel> detailTransactionMap(String transactionID) async {
    String urlAPI = APIHelper.URI_PREFIX_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var uri = Uri.http(urlAPI, "/api/v1/Transactions/$transactionID");
    var response = await http.get(uri, headers: header);

    TransactionMapModel transactionMapModel;

    if (response.statusCode == 200) {
      String doctorName = "";
      String doctorImage = "";
      String transactionNote = "";
      String doctorDegree = "";
      String doctorSpecialty = "";
      String latitude = "";
      String longitude = "";
      String placeName = "";
      String location = "";
      int doctorId = 0;
      int patientId = 0;
      String estimateTime = "";
      int examId = 0;
      String serviceName = "";
      double servicePrice = 0;

      Map<String, dynamic> transactionJson = jsonDecode(response.body);

      // List<SymptomTempModel> listSymptom =
      //     (transactionJson['symptomDetails'] as List)
      //         .map((data) => SymptomTempModel.fromJson(data))
      //         .toList();

      String locationTemp = transactionJson['location'];

      longitude = locationTemp.split(',')[1].split(':')[1].split(';')[0];

      latitude = locationTemp.split(',')[0].split(':')[1];

      String url =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GoogleKey';
      http.Response responseMap = await http.get(url);
      if (responseMap.statusCode == 200) {
        String jSonData = responseMap.body;
        var decodeData = jsonDecode(jSonData);
        placeName = decodeData["results"][0]["formatted_address"];
      } else {}

      doctorName = transactionJson["doctor"]["fullname"];
      doctorImage = transactionJson["doctor"]["image"];
      doctorDegree = transactionJson["doctor"]["degree"];
      doctorSpecialty = transactionJson["doctor"]["specialty"]["name"];
      transactionID = transactionJson["id"];
      doctorId = transactionJson["doctorId"];
      patientId = transactionJson["patientId"];
      location = locationTemp;
      estimateTime = transactionJson["estimatedTime"];
      examId = transactionJson["examId"];
      transactionNote = transactionJson["note"];
      serviceName = transactionJson['service']['name'];
      servicePrice = transactionJson['service']['price'];

      transactionMapModel = TransactionMapModel(
        doctorDegree: doctorDegree,
        doctorImage: doctorImage,
        doctorName: doctorName,
        doctorSpecialty: doctorSpecialty,
        latitude: double.parse(latitude),
        placeName: placeName,
        longitude: double.parse(longitude),
        // patientSymptom: listSymptom,
        transactionNote: transactionNote,
        doctorId: doctorId,
        location: location,
        patientId: patientId,
        estimateTime: estimateTime,
        examId: examId,
        transactionId: transactionID,
        serviceName: serviceName,
        servicePrice: servicePrice,
      );
      return transactionMapModel;
    } else
      return null;
  }

  @override
  Future<bool> updateTransaction(String transaction) async {
    String urlAPI = APIHelper.TRANSACTION_API;

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response =
        await http.put(urlAPI, headers: header, body: transaction);

    print(response.statusCode);

    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }

  @override
  Future<List<TransactionHistoryModel>> getListTransactionHistory(
      String patientId, int status) async {
    String urlAPI = APIHelper.TRANSACTION_PATIENT_API +
        patientId +
        "?status=" +
        status.toString();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    print('patient ID : $patientId');
    List<TransactionHistoryModel> listTransactionHistoryModel;

    var response = await http.get(urlAPI, headers: header);
    if (response.statusCode == 200) {
      listTransactionHistoryModel = (json.decode(response.body) as List)
          .map((data) => TransactionHistoryModel.fromJson(data))
          .toList();
      if (listTransactionHistoryModel.isEmpty)
        return null;
      else
        return listTransactionHistoryModel;
    } else
      return null;
  }

  @override
  Future<List<dynamic>> getTransactionDetail(String transactionId) async {
    List<dynamic> list = [];
    String urlAPI = APIHelper.TRANSACTION_API + "/" + transactionId.trim();
    print('transactionID $transactionId');

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var response = await http.get(urlAPI, headers: header);

    print("status ${response.statusCode}");

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print("data $data");
      TransactionModel transaction = TransactionModel.fromJson(data);
      ProfileModel profileDoctor = ProfileModel.fromJson(data['doctor']);
      String doctorSpeciality = data['doctor']['specialty']['name'];

      ServiceModel service = ServiceModel.fromJson(data['service']);
      ExaminationHistoryModel examination;
      if (data['examinationHistory'] != null) {
        examination =
            ExaminationHistoryModel.fromJson(data['examinationHistory']);
      } else {
        examination = ExaminationHistoryModel();
      }

      // FEEDBACK
      FeedbackModel feedback;
      urlAPI = APIHelper.FEEDBACK_API;
      response = await http.get(urlAPI + "/$transactionId", headers: header);
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        feedback = FeedbackModel.fromJson(data);
      }

      print(transaction);
      print(profileDoctor);
      print(doctorSpeciality);
      print(service);
      print(examination);
      print(feedback);

      list.add(transaction);
      list.add(profileDoctor);
      list.add(doctorSpeciality);
      list.add(service);
      list.add(examination);
      list.add(feedback);
    }

    return list;
  }

  @override
  Future<TransactionModel> getTransaction(String transactionId) async {
    TransactionModel transaction;
    String urlAPI = APIHelper.TRANSACTION_API + "/" + transactionId.trim();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var response = await http.get(urlAPI, headers: header);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      transaction = TransactionModel.fromJson(data);
    }
    return transaction;
  }
}
