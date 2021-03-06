import 'dart:convert';
import 'dart:io';
import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:http/http.dart' as http;

abstract class IAppConfigRepo {
  Future<List<dynamic>> appConfigListRelationShip();
  Future<String> getPolicy();
  Future<int> getDistance();
  Future<int> getTimeNoty();
}

class AppConfigRepo extends IAppConfigRepo {
  @override
  Future<String> getPolicy() async {
    String urlAPI = APIHelper.APP_CONFIG;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['policy'];
    } else
      return null;
  }

  @override
  Future<List<dynamic>> appConfigListRelationShip() async {
    String urlAPI = APIHelper.APP_CONFIG;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);

    if (response.statusCode == 200) {
      List<dynamic> relationShips = json.decode(response.body)['relationShips'];
      print("relationShip $relationShips");
      return relationShips;
    } else {
      return null;
    }
  }

  @override
  Future<int> getDistance() async {
    String urlAPI = APIHelper.APP_CONFIG;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    print("statuscode ${response.statusCode}");
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      return data['distances'][0];
    } else
      return null;
  }

  @override
  Future<int> getTimeNoty() async {
    String urlAPI = APIHelper.APP_CONFIG_DOCTOR;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['appointmentNotifyTime'];
    } else
      return null;
  }
}
