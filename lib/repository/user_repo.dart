import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/sign_up/user_update_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IUserRepo {
  Future<bool> updateUser(String notiToken);
}

class UserRepo extends IUserRepo {
  @override
  Future<bool> updateUser(String notiToken) async {
    String urlAPI = APIHelper.UPDATE_USER_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String phone = sharedPreferences.getString('usPhone');
    if (phone[0].endsWith('0')) phone = phone.substring(1, phone.length);
    phone = "84" + phone;
    int accountId = sharedPreferences.getInt('usAccountID');

    UserUpdateModel _userUpdateModel = new UserUpdateModel(
        disable: 0,
        updBy: phone,
        updDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        accountId: accountId,
        username: phone,
        password: null,
        roleId: 2,
        waiting: 0,
        notiToken: notiToken);
    String updateUserJson = jsonEncode(_userUpdateModel.toJson());
    print("UpdUserJson: " + updateUserJson);

    var response =
        await http.put(urlAPI, headers: header, body: updateUserJson);

    print("Status code: " + response.statusCode.toString());

    bool isUpdated = true;
    if (response.statusCode == 200) {
      return isUpdated;
    } else {
      isUpdated = false;
      return isUpdated;
    }
  }
}
