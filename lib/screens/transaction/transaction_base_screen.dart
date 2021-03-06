import 'package:drFamily_app/Helper/common.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/screens/transaction/transaction_detail_screen.dart';
import 'package:drFamily_app/screens/transaction/transaction_form_screen.dart';
import 'package:drFamily_app/screens/transaction/transaction_prescription_screen.dart';
import 'package:drFamily_app/view_model/transaction_vm/transaction_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionBaseScreen extends StatelessWidget {
  final String transactionId;
  TransactionBaseScreen({@required this.transactionId});
  @override
  Widget build(BuildContext context) {
    return BaseView<TransactionBaseViewModel>(builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Color(0xff0d47a1)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Record Detail',
            style: TextStyle(color: Color(0xff0d47a1)),
          ),
        ),
        body: FutureBuilder(
          future: model.fetchData(transactionId),
          builder: (context, snapshot) {
            if (model.init) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else
              return Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('ID:'),
                        ),
                        Flexible(
                          child: Chip(
                            label: Text(transactionId),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, right: 8, left: 20),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    child: Image.asset(
                                      'assets/images/logo_app_user.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, right: 8),
                                  child: Text('FD System'),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: (model.transaction.status == 3)
                                    ? Border.all(color: Colors.green)
                                    : Border.all(color: Colors.red),
                              ),
                              child: (model.transaction.status == 3)
                                  ? Text(
                                      "Done",
                                      style: GoogleFonts.varelaRound(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13,
                                        color: Colors.green,
                                      ),
                                    )
                                  : (model.transaction.status == 4)
                                      ? Text(
                                          "Cancel",
                                          style: GoogleFonts.varelaRound(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13,
                                            color: Colors.red,
                                          ),
                                        )
                                      : Text(
                                          "UnPaid",
                                          style: GoogleFonts.varelaRound(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13,
                                            color: Colors.orange,
                                          ),
                                        ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, right: 20, left: 8),
                                child: Text(
                                  Common.convertDate(
                                      model.transaction.dateStart),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Icon(Icons.keyboard_arrow_down),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, right: 20, left: 8),
                                  child: Text(
                                    Common.convertDate(
                                        model.transaction.dateEnd),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      indent: 50,
                      endIndent: 50,
                    ),
                    Expanded(
                      child: Container(
                        child: DefaultTabController(
                            length: 3,
                            child: Scaffold(
                              appBar: AppBar(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                centerTitle: true,
                                title: Text('Addtional Information',
                                    style: TextStyle(color: Color(0xff0d47a1))),
                                bottom: TabBar(
                                  labelColor: Color(0xff0d47a1),
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  indicatorColor: Color(0xff0d47a1),
                                  unselectedLabelColor: Colors.grey,
                                  tabs: [
                                    Tab(
                                      text: 'Service',
                                    ),
                                    Tab(
                                      text: 'Form',
                                    ),
                                    Tab(
                                      text: 'Prescription',
                                    ),
                                  ],
                                ),
                              ),
                              body: TabBarView(
                                children: [
                                  TransactionDetailScreen(
                                    model: model,
                                  ),
                                  TransactionFormScreen(
                                    model: model,
                                  ),
                                  TransactionPrescriptionScreen(
                                      transactionId: transactionId),
                                ],
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              );
          },
        ),
      );
    });
  }
}
