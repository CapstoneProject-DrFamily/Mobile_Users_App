import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/sign_in/user_model.dart';
import 'package:http/http.dart' as http;

abstract class ISignInRepo {
  Future<UserModel> getLoginUser(String userName, String role);
}

class SignInRepo extends ISignInRepo {
  @override
  Future<UserModel> getLoginUser(String userName, String role) async {
    String apiSignIn = APIHelper.LOGIN_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    UserModel loginModel = new UserModel(userName: userName, role: role);

    String loginJson = jsonEncode(loginModel.toJson());

    http.Response response =
        await http.post(apiSignIn, headers: header, body: loginJson);
    if (response.statusCode == 200) {
      Map<String, dynamic> userSampleInfo = jsonDecode(response.body);
      loginModel = UserModel.fromJson(userSampleInfo);
      return loginModel;
    } else {
      return null;
    }
  }
}
