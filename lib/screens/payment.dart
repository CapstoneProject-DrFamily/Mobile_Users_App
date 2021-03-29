import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/screens/transaction/transaction_base_screen.dart';
import 'package:drFamily_app/view_model/payment_vm/payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPayPalScreen extends StatelessWidget {
  final String transactionId;
  final String name;
  final double price;

  PaymentPayPalScreen({@required this.transactionId, this.name, this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: BaseView<PaymentViewModel>(
        builder: (contex, child, model) {
          return FutureBuilder(
            future: model.getData(transactionId, name, price),
            builder: (context, snapshot) {
              return model.checkoutUrl != null
                  ? WebView(
                      initialUrl: model.checkoutUrl,
                      javascriptMode: JavascriptMode.unrestricted,
                      navigationDelegate: (NavigationRequest request) {
                        model.excute(context, request);
                        return NavigationDecision.navigate;
                        // if (request.url.contains(model.returnURL)) {
                        //   final uri = Uri.parse(request.url);
                        //   final payerID = uri.queryParameters['PayerID'];
                        //   if (payerID != null) {
                        //     model.paypalServicesRepo
                        //         .executePayment(model.executeUrl, payerID,
                        //             model.accessToken)
                        //         .then((id) {
                        //       print(model.executeUrl);
                        //       Navigator.of(context).pop();
                        //       Navigator.of(context).pushReplacement(
                        //         MaterialPageRoute(
                        //           builder: (BuildContext context) =>
                        //               TransactionBaseScreen(
                        //                   transactionId: transactionId),
                        //         ),
                        //       );
                        //       Fluttertoast.showToast(
                        //         msg: "Payment success",
                        //         textColor: Colors.red,
                        //         toastLength: Toast.LENGTH_SHORT,
                        //         backgroundColor: Colors.white,
                        //         gravity: ToastGravity.CENTER,
                        //       );
                        //     });
                        //   } else {
                        //     Navigator.of(context).pop();
                        //   }
                        //   Navigator.of(context).pop();
                        // }
                        // if (request.url.contains(model.cancelURL)) {
                        //   Navigator.of(context).pop();
                        // }
                        // return NavigationDecision.navigate;
                      },
                    )
                  : Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    );
            },
          );
        },
      ),
    );
  }
}
