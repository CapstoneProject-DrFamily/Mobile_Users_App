import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:http/http.dart' as http;

abstract class ISignUpRepo {
  Future<bool> createProfile(String addProfileJson);
}

class SignUpRepo extends ISignUpRepo {
  int profileId;

  @override
  Future<bool> createProfile(String addProfileJson) async {
    String urlAPI = APIHelper.CREATE_PROFILE_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response =
        await http.post(urlAPI, headers: header, body: addProfileJson);
    print("Status code: " + response.statusCode.toString());
    bool isCreated = true;

    if (response.statusCode == 201) {
      String jSonData = response.body;
      var decodeData = jsonDecode(jSonData);
      profileId = decodeData["profileId"];

      print("ProfileId: " + profileId.toString());
      return isCreated;
    } else {
      isCreated = false;
      return isCreated;
    }
  }
}
