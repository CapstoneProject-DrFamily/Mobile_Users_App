import 'package:drFamily_app/screens/payment.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/checkout_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:drFamily_app/widgets/common/fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class CheckOutScreen extends StatelessWidget {
  final String transactionId;
  CheckOutScreen({@required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Payment",
            style: TextStyle(
              fontFamily: AVENIR,
              fontSize: 20,
              color: Colors.black,
            )),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: BaseView<CheckOutViewModel>(
        builder: (context, child, model) {
          return FutureBuilder(
            future: model.getCheckoutInfo(transactionId),
            builder: (context, snapshot) {
              return model.isLoading
                  ? Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    )
                  : Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                              top: 20.0,
                              left: 30.0,
                              bottom: 10.0,
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "PAYMENT METHOD",
                                style: TextStyle(
                                  fontFamily: AVENIR,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 80,
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 60,
                                  width: 60,
                                  margin: const EdgeInsets.only(
                                    left: 15.0,
                                    right: 20.0,
                                  ),
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage(PAYPAL_ICON),
                                      fit: BoxFit.fill,
                                    ),
                                    border: Border.all(),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Paypal wallet",
                                    style: TextStyle(
                                      fontFamily: AVENIR,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 20.0,
                              left: 30.0,
                              bottom: 10.0,
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "INVOICE DETAIL",
                                style: TextStyle(
                                  fontFamily: AVENIR,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          _invoiceDetail(context, model),
                          SizedBox(
                            height: 30.0,
                          ),
                          _buildContinuteButton(context, model),
                        ],
                      ),
                    );
            },
          );
        },
      ),
    );
  }

  Container _invoiceDetail(BuildContext context, CheckOutViewModel model) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: Text(
                    "Date ",
                    style: TextStyle(
                      fontFamily: AVENIR,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(
                    right: 20.0,
                  ),
                  child: Text(
                    formatDate(
                        DateTime.parse(model.date), [dd, '-', mm, '-', yyyy]),
                    style: TextStyle(
                      fontFamily: AVENIR,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: Text(
                    "Service ",
                    style: TextStyle(
                      fontFamily: AVENIR,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(
                    right: 20.0,
                  ),
                  child: Text(
                    model.service,
                    style: TextStyle(
                      fontFamily: AVENIR,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: Text(
                    "Patient ",
                    style: TextStyle(
                      fontFamily: AVENIR,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(
                    right: 20.0,
                  ),
                  child: Text(
                    model.patientName,
                    style: TextStyle(
                      fontFamily: AVENIR,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: Text(
                    "Phone ",
                    style: TextStyle(
                      fontFamily: AVENIR,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(
                    right: 20.0,
                  ),
                  child: Text(
                    model.phone,
                    style: TextStyle(
                      fontFamily: AVENIR,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(
              25.0,
              20.0,
              30.0,
              10.0,
            ),
            child: Divider(
              color: Colors.black,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: Text(
                    "Total (VND) ",
                    style: TextStyle(
                      fontFamily: AVENIR,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(
                    right: 20.0,
                  ),
                  child: Text(
                    NumberFormat.currency(locale: 'vi').format(model.price),
                    style: TextStyle(
                      fontFamily: AVENIR,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: Text(
                    "Total (USD) ",
                    style: TextStyle(
                      fontFamily: AVENIR,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(
                    right: 20.0,
                  ),
                  child: Text(
                    model.priceUSD.toString() + ' USD',
                    style: TextStyle(
                      fontFamily: AVENIR,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                ),
                child: Text(
                  'Exchange rate: 1 USD = ' +
                      model.currency.toString() +
                      ' VND',
                  style: TextStyle(
                    fontFamily: AVENIR,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  GestureDetector _buildContinuteButton(
      BuildContext context, CheckOutViewModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => PaymentPayPalScreen(
              transactionId: transactionId,
              name: model.service,
              price: model.priceUSD,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.blue[400],
          ),
          child: Center(
            child: Text(
              "Check out",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
