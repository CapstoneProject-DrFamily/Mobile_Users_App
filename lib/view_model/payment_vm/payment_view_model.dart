import 'dart:convert';
import 'dart:core';
import 'package:drFamily_app/model/transaction/transaction_model.dart';
import 'package:drFamily_app/repository/paypal_services_repo.dart';
import 'package:drFamily_app/repository/transaction_repo.dart';
import 'package:drFamily_app/screens/share/base_model.dart';
import 'package:drFamily_app/screens/transaction/transaction_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentViewModel extends BaseModel {
  IPaypalServicesRepo paypalServicesRepo = PaypalServicesRepo();
  ITransactionRepo _transactionRepo = TransactionRepo();
  String checkoutUrl;
  String executeUrl;
  String accessToken;

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'https://junedr375.github.io/junedr375-payment/';
  String cancelURL = 'https://junedr375.github.io/junedr375-payment/error.html';

  String _transactionId;
  String _name;
  double _price;

  String get transactionId => _transactionId;
  String get name => _name;
  double get price => _price;

  bool init = true;
  bool _isLoading;
  bool get isLoading => _isLoading;

  Map<String, dynamic> getOrderParams() {
    List items = [
      {
        "name": _name,
        "quantity": 1,
        "price": _price,
        "currency": defaultCurrency["currency"]
      }
    ];

    // checkout invoice details
    String totalAmount = _price.toString();
    String subTotalAmount = _price.toString();
    String userFirstName = 'Juned';
    String userLastName = 'Raza';
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String addressCity = 'Delhi';
    String addressStreet = 'Abc road';
    String addressZipCode = '123456';
    String addressCountry = 'VietNam';
    String addressState = 'HoChiMinh';
    String addressPhoneNumber = '+84909784009';

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (isEnableShipping && isEnableAddress)
              "shipping_address": {
                "recipient_name": userFirstName + " " + userLastName,
                "line1": addressStreet,
                "line2": "",
                "city": addressCity,
                "country_code": addressCountry,
                "postal_code": addressZipCode,
                "phone": addressPhoneNumber,
                "state": addressState
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  TransactionModel transactionModel;

  getData(String transactionId, String name, double price) async {
    if (init) {
      _transactionId = transactionId;
      _name = name;
      _price = price;

      transactionModel = await _transactionRepo.getTransaction(transactionId);

      print(
          "transactionModel ${transactionModel.transactionId} - ${transactionModel.location} - ${transactionModel.estimatedTime}");

      Future.delayed(
        Duration.zero,
        () async {
          try {
            accessToken = await paypalServicesRepo.getAccessToken();

            final transactions = getOrderParams();
            print("transactions: " + transactions.toString());
            final res = await paypalServicesRepo.createPaypalPayment(
                transactions, accessToken);
            if (res != null) {
              checkoutUrl = res["approvalUrl"];
              executeUrl = res["executeUrl"];
              notifyListeners();
            }
          } catch (e) {
            print('exception: ' + e.toString());
            final snackBar = SnackBar(
              content: Text(e.toString()),
              duration: Duration(seconds: 10),
              action: SnackBarAction(
                label: 'Close',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );
          }
        },
      );
      this.init = false;
      notifyListeners();
    }
  }

  void excute(BuildContext context, NavigationRequest request) async {
    if (request.url.contains(returnURL)) {
      final uri = Uri.parse(request.url);
      print(uri);
      final payerID = uri.queryParameters['PayerID'];
      if (payerID != null) {
        await paypalServicesRepo
            .executePayment(executeUrl, payerID, accessToken)
            .then((id) async {
          TransactionModel updateTransactionModel = TransactionModel(
              transactionId: transactionModel.transactionId,
              doctorId: transactionModel.doctorId,
              patientId: transactionModel.patientId,
              estimatedTime: transactionModel.estimatedTime,
              location: transactionModel.location,
              note: transactionModel.note,
              status: 3);

          String transactionJson = jsonEncode(updateTransactionModel.toJson());

          await _transactionRepo.updateTransaction(transactionJson);
          Navigator.of(context).pop();
        });

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                TransactionBaseScreen(transactionId: _transactionId),
          ),
        );
        Fluttertoast.showToast(
          msg: "Payment success",
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          gravity: ToastGravity.CENTER,
        );
      } else {
        Navigator.of(context).pop();
      }
      // Navigator.of(context).pop();
    }
    if (request.url.contains(cancelURL)) {
      Navigator.of(context).pop();
    }
  }
}
