import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/transaction_map_model.dart';
import 'package:http/http.dart' as http;

abstract class ITransactionRepo {
  Future<String> addTransaction(String transaction);
  Future<TransactionMapModel> detailTransactionMap(String transactionID);
  Future<bool> updateTransaction(String transaction);
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

    if (response.statusCode == 201) {
      String jSonData = response.body;
      var decodeData = jsonDecode(jSonData);
      transactionID = decodeData["transactionId"];
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

      List<SymptomTempModel> listSymptom =
          (transactionJson['symptomDetails'] as List)
              .map((data) => SymptomTempModel.fromJson(data))
              .toList();

      String locationTemp = transactionJson['location'];
      List<String> locationPositionTemp = locationTemp.split(",");
      for (var item in locationPositionTemp) {
        List<String> positionTemp = item.split(":");
        if (positionTemp[0].endsWith("latitude"))
          latitude = positionTemp[1].trim();
        else
          longitude = positionTemp[1].trim();
      }

      String url =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyDFd7ZNm2BL2JREvk32NZJ0wHzUn2fjw4A';
      http.Response responseMap = await http.get(url);
      if (responseMap.statusCode == 200) {
        String jSonData = responseMap.body;
        var decodeData = jsonDecode(jSonData);
        placeName = decodeData["results"][0]["formatted_address"];
      } else {}

      doctorName = transactionJson["doctor"]["profile"]["fullName"];
      doctorImage = transactionJson["doctor"]["profile"]["image"];
      doctorDegree = transactionJson["doctor"]["degree"];
      doctorSpecialty = transactionJson["doctor"]["specialty"]["name"];
      transactionID = transactionJson["transactionId"];
      doctorId = transactionJson["doctorId"];
      patientId = transactionJson["patientId"];
      location = locationTemp;
      estimateTime = transactionJson["estimatedTime"];
      examId = transactionJson["examId"];
      transactionNote = transactionJson["note"];
      serviceName = transactionJson['service']['serviceName'];
      servicePrice = transactionJson['service']['servicePrice'];

      transactionMapModel = TransactionMapModel(
        doctorDegree: doctorDegree,
        doctorImage: doctorImage,
        doctorName: doctorName,
        doctorSpecialty: doctorSpecialty,
        latitude: double.parse(latitude),
        placeName: placeName,
        longitude: double.parse(longitude),
        patientSymptom: listSymptom,
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
}
