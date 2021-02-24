import 'dart:convert';
import 'dart:io';

import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:http/http.dart' as http;

abstract class ITransactionRepo {
  Future<int> addTransaction(String transaction);
}

class TransactionRepo extends ITransactionRepo {
  @override
  Future<int> addTransaction(String transaction) async {
    int transactionID;
    String urlAPI = APIHelper.TRANSACTION_API;

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response =
        await http.post(urlAPI, headers: header, body: transaction);

    print(response.statusCode);

    if (response.statusCode == 200) {
      String jSonData = response.body;
      var decodeData = jsonDecode(jSonData);
      transactionID = decodeData["transactionId"];
      return transactionID;
    } else
      return null;
  }
}
