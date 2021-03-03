import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/home/landing_model.dart';

abstract class ILangdingRepo {
  Future<LandingModel> getPatientProfile(String profileID);
}

class LangdingRepo extends ILangdingRepo {
  @override
  Future<LandingModel> getPatientProfile(String profileID) async {
    String urlAPI = APIHelper.GET_PROFILE_BY_ID_API + profileID;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    print("Status: " + response.statusCode.toString());

    LandingModel landingModel;

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      landingModel = LandingModel.fromJson(map);
      return landingModel;
    } else
      return null;
  }
}
