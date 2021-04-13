import 'dart:convert';
import 'dart:io';
import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:http/http.dart' as http;

abstract class IAppConfigRepo {
  Future<List<dynamic>> appConfigListRelationShip();
}

class AppConfigRepo extends IAppConfigRepo {
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
}