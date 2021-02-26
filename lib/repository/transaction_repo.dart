import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:http/http.dart' as http;

abstract class ITransactionRepo {
  Future<String> addTransaction(String transaction);
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
}
