import 'package:drFamily_app/model/transaction/transaction_model.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/rating_vm/rating_base_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RatingBaseScreen extends StatelessWidget {
  final TransactionModel transactionModel;
  RatingBaseScreen({@required this.transactionModel});
  @override
  Widget build(BuildContext context) {
    return BaseView<RatingBaseViewModel>(builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.clear, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image(
                  image: AssetImage('assets/images/patient.png'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Text(
                      'Please let us know how we can improve our service, or something you like most.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  model.text,
                  style: TextStyle(fontSize: 20),
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar.builder(
                    initialRating: model.rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    glowColor: Colors.amber,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      model.changeRating(rating);
                    },
                  ),
                ],
              ),
              Divider(
                thickness: 1,
                endIndent: 50,
                indent: 50,
              ),
              // Text(model.textHint),

              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        model.other = value;
                      },
                      decoration: InputDecoration(hintText: 'Note (Optional)'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(20),
          child: model.isLoading
              ? FloatingActionButton.extended(
                  label:
                      CircularProgressIndicator(backgroundColor: Colors.white))
              : FloatingActionButton.extended(
                  onPressed: () async {
                    bool isSucces = await model.rateService(transactionModel);
                    if (isSucces) {
                      Fluttertoast.showToast(
                        msg: "Send feedback success",
                        textColor: Colors.green,
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.white,
                        gravity: ToastGravity.CENTER,
                      );
                      Navigator.of(context).pop(isSucces);
                    } else {
                      Fluttertoast.showToast(
                        msg: "Send feedback faild",
                        textColor: Colors.red,
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.white,
                        gravity: ToastGravity.CENTER,
                      );
                    }
                  },
                  label: const Text('Rate'),
                  icon: const Icon(Icons.thumb_up),
                  backgroundColor: Colors.blue,
                ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}
