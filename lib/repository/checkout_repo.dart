import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:drFamily_app/model/checkout_model.dart';

abstract class ICheckOutRepo {
  Future<CheckoutModel> getCheckOutInfo(String transactionId);
}

class CheckOutRepo extends ICheckOutRepo {
  @override
  Future<CheckoutModel> getCheckOutInfo(String transactionId) async {
    String urlAPI = APIHelper.GET_TRANSACTION_BY_ID_API + transactionId;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    print("Status: " + response.statusCode.toString());
    print("Body: " + response.body);

    CheckoutModel checkoutModel;

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      checkoutModel = CheckoutModel.fromJson(map);
      return checkoutModel;
    } else
      return null;
  }
}
