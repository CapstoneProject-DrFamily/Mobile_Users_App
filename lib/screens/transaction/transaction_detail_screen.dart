import 'package:drFamily_app/Helper/common.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/transaction_vm/transaction_base_view_model.dart';
import 'package:drFamily_app/view_model/transaction_vm/transaction_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionBaseViewModel model;
  TransactionDetailScreen({@required this.model});
  @override
  Widget build(BuildContext context) {
    return BaseView<TransactionDetailViewModel>(
        builder: (context, child, model) {
      return Scaffold(body: FutureBuilder(builder: (contextC, snapshop) {
        return SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                (this.model.transaction.status == 4)
                    ? Container()
                    : Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Feedback',
                                  style: TextStyle(
                                    color: Color(0xff0d47a1),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: this.model.feedback != null
                                    ? this.model.feedback.ratingPoint
                                    : 0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                glowColor: Colors.amber,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  // model.changeRating(rating);
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              this.model.buildWidget(context),
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
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Doctor',
                        style: TextStyle(
                          color: Color(0xff0d47a1),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                            NetworkImage(this.model.profileDoctor.image),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              this.model.profileDoctor.fullName,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                  size: 24.0,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(this.model.profileDoctor.phone),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 60,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 1,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Chip(
                                            label: Text(
                                                this.model.doctorSpeciality),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  indent: 50,
                  endIndent: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Service Info',
                        style: TextStyle(
                          color: Color(0xff0d47a1),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Name'),
                            Text(this.model.service.serviceName)
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Price'),
                            Text(Common.convertPrice(
                                this.model.service.servicePrice))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  indent: 50,
                  endIndent: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Note',
                        style: TextStyle(
                          color: Color(0xff0d47a1),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 30, right: 30, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(this.model.transaction.note == "Nothing"
                          ? ""
                          : this.model.transaction.note),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }));
    });
  }
}
