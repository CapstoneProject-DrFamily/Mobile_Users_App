import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/medicine_model.dart';
import 'package:drFamily_app/model/prescription_model.dart';
import 'package:http/http.dart' as http;

abstract class IPrescriptionRepo {
  Future<List<PrescriptionModel>> getPrescriptionDetail(String prescriptionId);
}

class PrescriptionRepo extends IPrescriptionRepo {
  @override
  Future<List<PrescriptionModel>> getPrescriptionDetail(
      String prescriptionId) async {
    List<PrescriptionModel> list = [];

    String urlAPI = APIHelper.PRESCRIPTION_API;

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI + "/$prescriptionId", headers: header);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      for (int i = 0; i < data['prescriptionDetails'].length; i++) {
        PrescriptionModel prescription =
            PrescriptionModel.fromJson(data['prescriptionDetails'][i]);
        MedicineModel medicine =
            MedicineModel.fromJson(data['prescriptionDetails'][i]['medicine']);
        prescription.medicine = medicine;
        list.add(prescription);
      }
    }

    return list;
  }
}
