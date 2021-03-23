import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/transaction_vm/transaction_prescription_view_model.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class TransactionPrescriptionScreen extends StatelessWidget {
  final String transactionId;
  TransactionPrescriptionScreen({@required this.transactionId});
  @override
  Widget build(BuildContext context) {
    return BaseView<TransactionPrescriptionViewModel>(
        builder: (context, child, model) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildMedicineList(),
            ],
          ),
        ),
      );
    });
  }

  Container buildMedicineList() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Details',
                  style: TextStyle(
                    color: Color(0xff0d47a1),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xff0d47a1),
                          ),
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ExpandablePanel(
                            header: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Paracetamol',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            // collapsed: Text('See details'),
                            expanded: Center(
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Divider(
                                          thickness: 3,
                                          color: Colors.white,
                                          indent: 10,
                                          endIndent: 10,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(width: 10),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Morning',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: Text(
                                                  '5',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'spill',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(width: 10),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Noon',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: Text(
                                                  '5',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'spill',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(width: 10),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Afternoon',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: Text(
                                                  '5',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'spill',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: Colors.white,
                                          indent: 10,
                                          endIndent: 10,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(width: 10),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Total',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: Text(
                                                  '15',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'spill',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(width: 10),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Days',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: Text(
                                                  '7',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'days',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))),
                            tapHeaderToExpand: true,
                            hasIcon: true,
                            iconColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                );
              }),
        ],
      ),
    );
  }
}