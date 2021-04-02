import 'dart:convert';
import 'dart:io';
import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/service_specialty_model.dart';
import 'package:http/http.dart' as http;

abstract class IServiceRepo {
  Future<ServiceSpecialtyModel> getSymptomService();
}

class ServiceRepo extends IServiceRepo {
  @override
  Future<ServiceSpecialtyModel> getSymptomService() async {
    String urlAPI = APIHelper.SERVICE_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);

    ServiceSpecialtyModel serviceModel;
    print(response.statusCode);

    if (response.statusCode == 200) {
      var listService = (json.decode(response.body) as List);

      for (int i = 0; i < listService.length; i++) {
        if (listService[i]['specialtyId'] == null) {
          serviceModel = ServiceSpecialtyModel.fromJson(listService[i]);
          print("serviceModel ${serviceModel.serviceName}");
          break;
        }
      }
      return serviceModel;
    } else
      return null;
  }
}
