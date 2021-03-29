import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http_auth/http_auth.dart';

abstract class IPaypalServicesRepo {
  Future<String> getAccessToken();
  Future<Map<String, String>> createPaypalPayment(transactions, accessToken);
  Future<String> executePayment(url, payerId, accessToken);
}

class PaypalServicesRepo extends IPaypalServicesRepo {
  String domain = "https://api.sandbox.paypal.com"; // for sandbox mode

  // change clientId and secret with your own, provided by paypal
  String clientId =
      'AYelw6ZEBy4zK7QYmOzr4imwKETBzZodJIdKeyrSTs5CxHGq_sJZgxmaSWU60Cy63_q7n53mbeDiXkEc';
  String secret =
      'ECP2HAEXbnqWmsYugGqc8qc2rSYU_vARvxgNZ9l5Slm39XYtyKIn7sEDd-uZrqPfkXSLDvCO19F2Y-Qp';

  // for getting the access token from Paypal
  @override
  Future<String> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client
          .post('$domain/v1/oauth2/token?grant_type=client_credentials');

      var status = response.statusCode;
      print("Status3: " + status.toString());

      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        print("getAccessToken: " + body["access_token"]);
        return body["access_token"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  @override
  Future<Map<String, String>> createPaypalPayment(
      transactions, accessToken) async {
    try {
      var response = await http.post("$domain/v1/payments/payment",
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      var status = response.statusCode;
      print("Status2: " + status.toString());

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        // print("createPaypalPayment: " + body["message"]);
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          print("approval_url: " + approvalUrl);
          print("executeUrl: " + executeUrl);
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return null;
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  @override
  Future<String> executePayment(url, payerId, accessToken) async {
    print("executeUrl: " + url);
    print("payerId: " + payerId);
    print("accessToken: " + accessToken);

    var resBody = {};
    resBody['payer_id'] = payerId;

    String str = jsonEncode(resBody);

    var response = await http.post(url, body: str, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + accessToken
    });

    var status = response.statusCode;
    print("Status: " + status.toString());

    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('200 ne');
      return body["id"];
    } else if (response.statusCode == 400) {
      print('$body');
    }
    return null;
  }
}
